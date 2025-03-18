CREATE TABLE `bm_batch_record` (
  `id` bigint NOT NULL COMMENT '主键id',
  `name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '记录名称',
  `category_id` bigint NOT NULL COMMENT '分类id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `index_name_delete` (`name`,`is_deleted`) USING BTREE COMMENT '唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='批记录信息'

CREATE TABLE `bm_batch_record_archive` (
  `id` bigint NOT NULL COMMENT '主键id',
  `archive_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'bm_batch_record_archive 批记录模板版本表的主键id',
  `path` varchar(1024) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'minio上传路径',
  `batch_template_info_id` bigint NOT NULL COMMENT '批记录模板id bm_batch_template_info表的主键id',
  `batch_template_version_id` bigint NOT NULL COMMENT '当前生成的批记录是由哪一个模板版本id生成的',
  `template_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板名称',
  `template_version` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板名称',
  `plan_id` bigint NOT NULL COMMENT '生产计划id',
  `batch_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批号',
  `product_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `instance_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核流实例id',
  `status` int NOT NULL COMMENT '状态 830401-编辑 830402-审批中 830403-生效 830404 - 作废',
  `archive_time` datetime NOT NULL COMMENT '归档时间（生成时间）',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `auditor_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核人id',
  `auditor_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核人名称',
  `auditor_login_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核人登录名称',
  `operator_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归档操作人ueseId',
  `operator_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归档操作人用户名称',
  `operator_login_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归档操作人登录名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='归档生成的批记录档案'

CREATE TABLE `bm_batch_record_archive_generate` (
  `id` bigint NOT NULL,
  `batch_template_version_id` bigint NOT NULL COMMENT '模板版本id bm_batch_template_version的主键id',
  `plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `complete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否生成完成',
  `delete_file_flag` tinyint DEFAULT NULL COMMENT '生成的文件是否在minio中否被删除',
  `batch_record_archive_id` bigint DEFAULT NULL COMMENT '若为重新生成，则此值为bm_batch_record_archive表中的id',
  `operate_type` int NOT NULL COMMENT '操作类型 830301-重新生成 830307-批记录生成 830308-自动生成',
  `user_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人',
  `path` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归档生成的path',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='归档生成的批记录的生成记录'

CREATE TABLE `bm_batch_record_archive_log` (
  `id` bigint NOT NULL COMMENT '主键id',
  `batch_record_archive_id` bigint NOT NULL COMMENT 'bm_batch_record_archive 批记录模板版本表的主键id',
  `path` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'minio上传路径',
  `operate_type` int NOT NULL COMMENT '操作类型 830301-重新生成 830302-上传 830303-下载 830304-提交审批 830305-审批完成 830306-作废 830307-批记录生成',
  `archive_time` datetime DEFAULT NULL COMMENT '档案生成的时间',
  `effective_time` datetime DEFAULT NULL COMMENT '档案生效时间',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `audit_result` tinyint DEFAULT NULL COMMENT '审核结果',
  `audit_opinion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核意见',
  `instance_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核流实例id',
  `element_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核节点名称',
  `operator_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人ueseId',
  `operator_login_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人登录名称',
  `operator_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人用户名称',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='归档生成的批记录的操作日志'

CREATE TABLE `bm_batch_record_category` (
  `id` bigint NOT NULL COMMENT '主键id',
  `name` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分类名称',
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `parent_id` bigint DEFAULT '0' COMMENT '上级id',
  `sort` bigint DEFAULT NULL COMMENT '排序号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  `del_flag` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC COMMENT='记录配置分类表'

CREATE TABLE `bm_batch_record_component` (
  `id` bigint NOT NULL COMMENT '主键id',
  `record_item_id` bigint NOT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '版本id',
  `record_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批记录版本号',
  `record_id` bigint DEFAULT NULL COMMENT '批记录id',
  `component_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件类型',
  `component_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件名称',
  `field_id` bigint DEFAULT NULL COMMENT '空格标识',
  `component_number` bigint DEFAULT NULL COMMENT '组件关联表格最大下标值',
  `formula_precision` bigint DEFAULT NULL COMMENT '精度',
  `component_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '公式详细内容',
  `is_result` tinyint DEFAULT NULL COMMENT '标记该组件是否是一个计算结果（0否1是，默认0）',
  `formula_id` bigint DEFAULT NULL COMMENT '公式id',
  `formula_field` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '公式实际参数字段JSON',
  `formula_expression` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公式表达式',
  `formula_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公式类型',
  `round_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修约公式code',
  `parent_id` bigint DEFAULT '0' COMMENT '父级id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  `used` tinyint(1) DEFAULT NULL COMMENT '是否使用',
  `date_type` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `formula_config` longtext COLLATE utf8mb4_general_ci COMMENT '公式额外配置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_record_item_version_field_id` (`record_item_id`,`record_version_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录组件表'

CREATE TABLE `bm_batch_record_component_detail` (
  `id` bigint NOT NULL COMMENT '主键id',
  `component_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '组件详细内容',
  `formula_field` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '公式实际参数字段JSON',
  `formula_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '公式额外配置',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录组件表'

CREATE TABLE `bm_batch_record_expression` (
  `record_id` bigint NOT NULL,
  `expression_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='记录与公式绑定关系'

CREATE TABLE `bm_batch_record_item` (
  `id` bigint NOT NULL COMMENT '主键id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_id` bigint NOT NULL COMMENT '业务id',
  `item_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传单个记录项指令集地址',
  `item_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '0:大纲内容false，1：页眉页脚内容true',
  `sort` int DEFAULT NULL COMMENT '排序字段',
  `file_content` mediumblob COMMENT '记录项内容',
  `file_path` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件路径',
  `max_number` int DEFAULT NULL COMMENT '文档最大下标',
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本号',
  `page_config` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '{"pattern":1}' COMMENT '文档配置',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录版本表id',
  `docx_header` longtext COLLATE utf8mb4_general_ci COMMENT '页眉',
  `docx_footer` longtext COLLATE utf8mb4_general_ci COMMENT '页脚',
  `first_different` tinyint(1) DEFAULT NULL COMMENT '首页不同',
  `page_number_style` int DEFAULT NULL COMMENT '页码样式',
  `page_starting_number` int DEFAULT NULL COMMENT '页码起始值',
  `odd_and_even_different` tinyint(1) DEFAULT NULL COMMENT '奇偶不同',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_record_item_id_version` (`item_id`,`record_version_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录项表'

CREATE TABLE `bm_batch_record_parse` (
  `id` bigint NOT NULL COMMENT '记录项id',
  `file_content` mediumblob COMMENT 'html字符串',
  `docx_header` longtext COLLATE utf8mb4_general_ci COMMENT '页眉',
  `docx_footer` longtext COLLATE utf8mb4_general_ci COMMENT '页脚',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录解析html表'

CREATE TABLE `bm_batch_record_product` (
  `id` bigint NOT NULL COMMENT '主键id',
  `record_id` bigint NOT NULL COMMENT '批记录id',
  `product_id` bigint NOT NULL COMMENT '产品id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录关联产品表'

CREATE TABLE `bm_batch_record_version` (
  `id` bigint NOT NULL COMMENT '主键id',
  `record_id` bigint NOT NULL COMMENT '记录管理表id',
  `version` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本号',
  `state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态：1：可编辑；2：审核；3：确定：4：作废',
  `instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程实例id',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '存放文件地址',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idex_record_id_version` (`record_id`,`version`) USING BTREE COMMENT '批记录id与版本号唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='记录版本表'

CREATE TABLE `bm_batch_release` (
  `id` bigint NOT NULL,
  `plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `product_id` bigint DEFAULT NULL COMMENT '成品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品名称',
  `process_id` bigint DEFAULT NULL COMMENT '关联工艺',
  `process_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联工艺名称',
  `process_version_id` bigint DEFAULT NULL COMMENT '工艺版本id',
  `process_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `audit_state` tinyint(1) DEFAULT NULL COMMENT '审核状态',
  `release_generated` tinyint(1) DEFAULT NULL COMMENT '是否已生成批签发',
  `approval_time` datetime DEFAULT NULL COMMENT '审核通过时间-作为批签发生成时间',
  `promoter_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成人',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `template_version_id` bigint DEFAULT NULL COMMENT '模板版本id',
  `template_version` int DEFAULT NULL COMMENT '模板版本',
  `process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程实例',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成的批签发excel文件路径',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发文件名',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传到服务器的文件url',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC

CREATE TABLE `bm_batch_release_history` (
  `id` bigint NOT NULL,
  `plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `product_id` bigint DEFAULT NULL COMMENT '成品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品名称',
  `process_id` bigint DEFAULT NULL COMMENT '关联工艺',
  `process_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联工艺名称',
  `process_version_id` bigint DEFAULT NULL COMMENT '工艺版本id',
  `process_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `audit_state` tinyint(1) DEFAULT NULL COMMENT '审核状态',
  `release_generated` tinyint(1) DEFAULT NULL COMMENT '是否已生成批签发',
  `approval_time` datetime DEFAULT NULL COMMENT '审核通过时间-作为批签发生成时间',
  `promoter_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成人',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `template_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `template_version_id` bigint DEFAULT NULL COMMENT '模板版本id',
  `template_version` int DEFAULT NULL COMMENT '模板版本',
  `process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程实例',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成的批签发excel文件路径',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发文件名',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传到服务器的文件url',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `business_key` bigint DEFAULT NULL COMMENT '流程查询key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC

CREATE TABLE `bm_batch_release_template` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `product_id` bigint DEFAULT NULL COMMENT '关联成品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联成品名称',
  `process_id` bigint DEFAULT NULL COMMENT '关联工艺id',
  `process_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联工艺名',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name_unique` (`name`,`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批签发模板'

CREATE TABLE `bm_batch_release_template_version` (
  `id` bigint NOT NULL,
  `template_id` bigint DEFAULT NULL COMMENT '关联模板id',
  `status` tinyint(1) DEFAULT NULL COMMENT '0:编辑中 1:启用中 2:已确认',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `version_number` int DEFAULT NULL COMMENT '版本号',
  `source_version` int DEFAULT NULL COMMENT '源版本号',
  `process_id` bigint DEFAULT NULL COMMENT '关联工艺id',
  `border_range` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '打印区域',
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'sheet配置',
  `sheet_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'sheet表格数据',
  `mark_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '标记哪些格子需要填充',
  `data_size` double DEFAULT NULL COMMENT '数据大小',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批签发模板版本'

CREATE TABLE `bm_batch_template_category` (
  `id` bigint NOT NULL COMMENT '主键id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分类名称',
  `parent_id` bigint NOT NULL COMMENT '父级分类id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批记录模板分类'

CREATE TABLE `bm_batch_template_info` (
  `id` bigint NOT NULL COMMENT '主键id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分类名称',
  `category_id` bigint NOT NULL COMMENT '分类id bm_batch_template_category表的主键id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批记录模板信息'

CREATE TABLE `bm_batch_template_info_process` (
  `batch_template_info_id` bigint NOT NULL COMMENT 'bm_batch_template_version 批记录模板版本表的主键id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  PRIMARY KEY (`batch_template_info_id`,`process_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批记录模板信息版本与工艺的绑定关系'

CREATE TABLE `bm_batch_template_operate_log` (
  `id` bigint NOT NULL COMMENT '主键id',
  `batch_template_version_id` bigint NOT NULL COMMENT 'bm_batch_template_version 批记录模板版本表的主键id',
  `path` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'minio上传路径',
  `operate_type` int NOT NULL COMMENT '操作类型 830101-新增 830102-上传 830103-删除 830104-确认 830105-作废 830106-生效',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `operator_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人ueseId',
  `operator_login_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人登录名称',
  `operator_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人用户名称',
  `operate_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批记录模板信息版本与工艺的绑定关系'

CREATE TABLE `bm_batch_template_version` (
  `id` bigint NOT NULL COMMENT '主键id',
  `version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本号',
  `path` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板上传到minio的路径',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板备注',
  `normal` tinyint DEFAULT NULL COMMENT '是否设为默认',
  `status` int NOT NULL COMMENT '状态  830201-编辑 830202-确认 830203-生效 830204-作废',
  `batch_template_info_id` bigint NOT NULL COMMENT '批记录模板id  bm_batch_template_info表的主键id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='批记录模板版本'

CREATE TABLE `bm_business_component_instance` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `procedure_step_config_id` bigint DEFAULT NULL COMMENT '组件配置id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id(用于确定生产计划)',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id(用于确定流程模型)',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '工序步骤id',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `process_version` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `copy_version` bigint DEFAULT NULL COMMENT '拷贝版本(默认0 用于确定移动端临时复制记录)',
  `component_id` bigint DEFAULT NULL COMMENT '组件id(用于确定组件类型)',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `component_config_json` longtext COLLATE utf8mb4_general_ci COMMENT '组件配置json',
  `component_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件类型',
  `component_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件名称',
  `batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='业务组件实例'

CREATE TABLE `bm_cargo_position` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `storage_id` bigint DEFAULT NULL COMMENT '所属区域 的id',
  `position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '暂存货位',
  `id_path` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '所属区域id路径 id逗号隔开',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货位编码',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `is_enable` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '启停',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1887766598425645057 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='货位信息'

CREATE TABLE `bm_charge_recycle` (
  `id` bigint NOT NULL,
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本呢id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_dataset` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `dataset_category_id` bigint DEFAULT NULL COMMENT '数据集分类id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集名称',
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集类型 POINT 批记录数据(数据点) LOT_RELEASE_LINK 批签发引用 DYNAMIC_REPORT 动态数据填报',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `dataset_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集key',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='数据集表'

CREATE TABLE `bm_dataset_category` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `parent_id` bigint DEFAULT NULL COMMENT '上级分类id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集名称',
  `id_path` text COLLATE utf8mb4_general_ci COMMENT '数据集分类id路径',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='数据集分类表'

CREATE TABLE `bm_dataset_point` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `dataset_id` bigint DEFAULT NULL COMMENT '数据集id',
  `dataset_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集key(暂时用流水号)',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据点名称',
  `dataset_point_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据点key(暂时用流水号)',
  `type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集类型 POINT 批记录数据(数据点) LOT_RELEASE_LINK 批签发引用 DYNAMIC_REPORT 动态数据填报',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '工步id',
  `field_id` bigint DEFAULT NULL COMMENT '字段id',
  `extra` text COLLATE utf8mb4_general_ci COMMENT '前端扩展字段(json)',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `component_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组件名称',
  `component_number` bigint DEFAULT NULL COMMENT '组件关联表格最大下标值',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_item_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '记录项名称',
  `lot_release_template_id` bigint DEFAULT NULL COMMENT '批签发模板id',
  `lot_release_version` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发版本',
  `link_area` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发引用参数范围(p15:s19)',
  `template_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发引用模版url',
  `dynamic_data_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '动态填报数据类型  NUMBER 数值 TEXT文本 DATE日期',
  `default_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '动态填报默认值',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='数据点表'

CREATE TABLE `bm_dataset_point_template_relation` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `template_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模版url',
  `placeholder` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '占位符',
  `key_size` int DEFAULT NULL COMMENT '索引数量',
  `dataset_point_keys` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据点索引json',
  `dataset_keys` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集索引json',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='模版数据点关联表'

CREATE TABLE `bm_execute_attachment` (
  `id` bigint NOT NULL,
  `batch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `product_plan_id` bigint NOT NULL,
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `process_id` bigint NOT NULL,
  `record_item_id` bigint NOT NULL,
  `record_version_id` bigint NOT NULL,
  `procedure_step_id` bigint NOT NULL,
  `process_change_number` int DEFAULT NULL COMMENT '工艺换班次数',
  `procedure_change_number` int DEFAULT NULL COMMENT '工序换班次数',
  `is_reuse` tinyint(1) NOT NULL,
  `copy_version` int NOT NULL,
  `path` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `attachment_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附件类型',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产执行附件'

CREATE TABLE `bm_execute_exception` (
  `id` bigint NOT NULL,
  `exception_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '异常类型',
  `exception_description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '异常描述',
  `exception_status` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '异常状态',
  `record_mode` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '录入方式',
  `record_user_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '记录人id',
  `record_user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '记录人名称',
  `record_time` datetime NOT NULL COMMENT '记录时间',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_full_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `process_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺名称',
  `process_version` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `procedure_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工序名称',
  `procedure_id` bigint DEFAULT NULL COMMENT '工序id',
  `procedure_model_id` bigint DEFAULT NULL COMMENT '工序模型id',
  `procedure_step_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工序步骤名称',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '工序步骤id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `handle_user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人id',
  `handle_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理结果',
  `handle_time` datetime DEFAULT NULL COMMENT '处理时间',
  `handle_user_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '处理人名称',
  `cancel_user_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作废人id',
  `cancel_user_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作废人名称',
  `cancel_reason` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作废原因',
  `cancel_time` datetime DEFAULT NULL COMMENT '作废时间',
  `execute_form_data_id` bigint DEFAULT NULL COMMENT '执行填报值表主键id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `exception_type_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_ingredient_input_component_instance` (
  `id` bigint NOT NULL,
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `ingredient_plan_id` bigint DEFAULT NULL COMMENT '绑定的配料单id',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_ingredient_input_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `ingredient_plan_id` bigint DEFAULT NULL COMMENT '配料单id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '暂存物料批次id',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件编号',
  `quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料量（预定量）',
  `unit_id` bigint DEFAULT NULL COMMENT '投料单位',
  `device_id` bigint DEFAULT NULL COMMENT '设备id',
  `device_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `device_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编码',
  `importer_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `input_time` datetime DEFAULT NULL COMMENT '投料时间',
  `component_instance_id` bigint DEFAULT NULL COMMENT '称量组件实例id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料投入记录表'

CREATE TABLE `bm_ingredient_plan` (
  `id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配料单名称',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `serial_no` int DEFAULT NULL COMMENT '流水号',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `completed` tinyint(1) DEFAULT NULL COMMENT '该配料单是否已完成',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料计划表'

CREATE TABLE `bm_ingredient_plan_material_batch` (
  `id` bigint NOT NULL,
  `ingredient_plan_id` bigint NOT NULL COMMENT '配料单id',
  `material_batch_id` bigint NOT NULL COMMENT '物料批次id',
  `formula_material_id` bigint NOT NULL COMMENT '配方物料id',
  `ingredient_quantity` decimal(20,10) DEFAULT NULL COMMENT '配料量',
  `theoretical_quantity` decimal(20,10) DEFAULT NULL COMMENT '理论量',
  `unit_id` bigint NOT NULL COMMENT '单位id',
  `user_id` bigint DEFAULT NULL COMMENT '计划人id',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料计划批次表'

CREATE TABLE `bm_ingredient_weigh_batch_process` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `ingredient_weigh_process_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `ingredient_plan_id` bigint DEFAULT NULL COMMENT '配料单id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '暂存物料批次id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `weigh_status` int DEFAULT NULL COMMENT '称量状态',
  `weigh_process` int DEFAULT NULL COMMENT '称量阶段',
  `put_in_quantity` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '已投物料量(基本单位量)',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料称量批次表'

CREATE TABLE `bm_ingredient_weigh_process` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `ingredient_plan_id` bigint DEFAULT NULL COMMENT '配料计划id',
  `pre_weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `pre_re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料称量流程表'

CREATE TABLE `bm_ingredient_weigh_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `ingredient_weigh_batch_process_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `ingredient_plan_id` bigint DEFAULT NULL COMMENT '配料单id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '暂存物料批次id',
  `tare_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重(基本单位量)',
  `gross_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '毛重(基本单位量)',
  `net_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '净重(基本单位量)',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `container_id` bigint DEFAULT NULL COMMENT '容器id',
  `container_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器名称',
  `material_position_id` bigint DEFAULT NULL COMMENT '货位id',
  `weigh_type` int DEFAULT NULL COMMENT '称量方式',
  `weigh_mode` int DEFAULT NULL COMMENT '称量模式',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件号',
  `sign_status` int DEFAULT NULL COMMENT '签名状态',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `weigh_time` datetime DEFAULT NULL COMMENT '称量时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配料称重记录'

CREATE TABLE `bm_inspect` (
  `id` bigint NOT NULL COMMENT '主键',
  `inspect_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验单号',
  `status` tinyint NOT NULL COMMENT '请验状态 1-检验中 2-已完成 3-已退回',
  `inspect_result` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '汇总检验结果',
  `reason` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '退回原因（请验单被lims退回后，所需要填写的退回原因）',
  `inspector_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验人id',
  `inspector` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验人用户名称-登陆名称',
  `inspect_time` datetime DEFAULT NULL COMMENT '请验时间',
  `procedure_model_id` bigint NOT NULL COMMENT '工序模型id (plan_id + procedure_model_id能够获取到当前工序所发起的请验单)',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工步模型id',
  `process_change_number` int DEFAULT NULL COMMENT '工艺换班次数',
  `procedure_change_number` int DEFAULT NULL COMMENT '工序换班次数',
  `inspect_config_id` bigint NOT NULL COMMENT '请验单id (当前物料当时所绑定的请验单配置id)',
  `formula_material_id` bigint NOT NULL COMMENT '请验的请验的配方物料id bm_product_formula_material表的主键id',
  `material_id` bigint DEFAULT NULL COMMENT '请验的物料id',
  `material_type` tinyint(1) NOT NULL COMMENT '请验的物料类型 bm_product_formula_material表的material_type',
  `material_merge_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验的物料合并编码',
  `material_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验的物料名称',
  `material_batch_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请验的物料批号',
  `plan_id` bigint NOT NULL COMMENT '生产指令单id bm_product_plan表的主键id',
  `product_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称  bm_prodcut_plan内的冗余内容',
  `product_merge_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品合并编码 bm_prodcut_plan内的冗余内容',
  `plan_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '指令单编号 bm_prodcut_plan内的冗余内容',
  `batch_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `batch_quantity` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批量 bm_prodcut_plan内的冗余内容',
  `unit_id` bigint NOT NULL COMMENT '单位id bm_prodcut_plan内的冗余内容',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='请验单'

CREATE TABLE `bm_inspect_config` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验单名称',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请验单的备注信息',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用',
  `update_show_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '最后修改人名称 username-logiNanme',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='请验单配置表'

CREATE TABLE `bm_inspect_config_data` (
  `id` bigint NOT NULL COMMENT '主键',
  `config_id` bigint NOT NULL COMMENT '请验单配置表id bm_inspect_config表主键',
  `code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请验单数据code 内置数据code前端定义，若是字典数据code则为字典的value',
  `show_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请验单数据展示名称',
  `data_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验单数据名称',
  `required` tinyint(1) NOT NULL COMMENT '是否必填',
  `default_value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '默认值',
  `sort` int NOT NULL COMMENT '排序 同一个config_id下的请验单数据在前端的显示顺序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='请验单配置数据表'

CREATE TABLE `bm_inspect_config_material` (
  `config_id` bigint NOT NULL,
  `material_id` bigint NOT NULL,
  UNIQUE KEY `uk_resource_dept` (`config_id`,`material_id`) COMMENT '请验单-物料唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='请验单与物料绑定关系表'

CREATE TABLE `bm_inspect_info` (
  `id` bigint NOT NULL COMMENT '主键',
  `inspect_id` bigint NOT NULL COMMENT '请验单主键id bm_inspect表主键',
  `inspect_config_data_id` bigint NOT NULL COMMENT '请验单配置数据id bm_inspect_config_data表主键',
  `code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请验单数据code 内置数据code前端定义，若是字典数据code则为字典的value',
  `show_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '展示名称',
  `data_name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '请验单数据名称',
  `required` tinyint(1) NOT NULL COMMENT '是否必填',
  `value` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '所填的值',
  `sort` int NOT NULL COMMENT '排序 请验详情时前端显示的排序',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='请验单信息表'

CREATE TABLE `bm_inspect_result` (
  `id` bigint NOT NULL COMMENT '主键',
  `inspect_id` bigint NOT NULL COMMENT '请验单主键id bm_inspect表主键',
  `inspect_program_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '检验项代码',
  `inspect_dict_no` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典对应的检验项目no',
  `inspect_program_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '检验项名称',
  `inspect_result` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '检验项结果',
  `inspect_conclusion` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '检验结论',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='检验结论表'

CREATE TABLE `bm_liquid_preparation_measure_batch` (
  `id` bigint NOT NULL,
  `liquid_preparation_plan_batch_id` bigint NOT NULL COMMENT '配液批次id',
  `measure_instance_id` bigint NOT NULL COMMENT '量取实例id',
  `material_batch_id` bigint NOT NULL COMMENT '物料批次id',
  `liquid_preparation_plan_id` bigint DEFAULT NULL COMMENT '配液单id',
  `measure_status` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取状态',
  `measure_stage` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取阶段',
  `put_quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投入总量',
  `measurer_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '量取人id',
  `re_checker_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液量取批次表'

CREATE TABLE `bm_liquid_preparation_measure_instance` (
  `id` bigint NOT NULL,
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `reuse` tinyint(1) NOT NULL COMMENT '是否复用',
  `procedure_step_model_id` bigint NOT NULL COMMENT '工序步骤模型id',
  `copy_version` int NOT NULL COMMENT '复制版本',
  `component_id` bigint NOT NULL COMMENT '组件id',
  `liquid_preparation_plan_id` bigint DEFAULT NULL COMMENT '配液计划id',
  `pre_measurer_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '量取人id',
  `pre_re_checker_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液量取组件实例表'

CREATE TABLE `bm_liquid_preparation_measure_log` (
  `id` bigint NOT NULL,
  `measure_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取类型',
  `measure_quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '量取量',
  `unit_id` bigint NOT NULL COMMENT '单位id',
  `unit_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单位名称',
  `measurer_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取人id',
  `measurer_login_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '量取人账号',
  `measurer_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '量取人名称',
  `re_checker_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '复核人id',
  `re_checker_login_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人账号',
  `re_checker_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人名称',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `material_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `measure_time` datetime NOT NULL COMMENT '量取时间',
  `material_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料名称',
  `material_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料编码',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `material_type` tinyint(1) DEFAULT NULL COMMENT '物料类型',
  `material_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批次号',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品编码',
  `product_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品批号',
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液量取日志表'

CREATE TABLE `bm_liquid_preparation_measure_record` (
  `id` bigint NOT NULL,
  `measure_instance_id` bigint NOT NULL COMMENT '量取组件实例id',
  `liquid_preparation_plan_id` bigint NOT NULL COMMENT '配液计划id',
  `measure_batch_id` bigint NOT NULL COMMENT '量取批次id',
  `material_id` bigint NOT NULL COMMENT '物料id',
  `material_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料名称',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `material_merge_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料编码',
  `quantity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取量',
  `unit_id` bigint NOT NULL COMMENT '单位id',
  `storage_material_id` bigint NOT NULL COMMENT '物料件id',
  `storage_material_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料件号',
  `storage_material_batch_id` bigint NOT NULL COMMENT '物料批次id',
  `storage_material_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料批次号',
  `material_position_id` bigint DEFAULT NULL COMMENT '货位id',
  `material_position` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货位编码-货位名称',
  `container_id` bigint DEFAULT NULL COMMENT '容器id',
  `container_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器编码-容器名称',
  `sign_status` int DEFAULT NULL COMMENT '签名状态',
  `measurer_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取人id',
  `re_checker_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '复核人id',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `measure_time` datetime NOT NULL COMMENT '量取时间',
  `measure_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取类型',
  `measure_mode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '量取模式',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液量取记录表'

CREATE TABLE `bm_liquid_preparation_plan` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配液单名称',
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `record_item_id` bigint NOT NULL COMMENT '记录项id',
  `record_version_id` bigint NOT NULL COMMENT '记录项版本id',
  `reuse` tinyint(1) NOT NULL COMMENT '是否复用',
  `procedure_step_model_id` bigint NOT NULL COMMENT '工序步骤模型id',
  `copy_version` int NOT NULL COMMENT '复制版本',
  `serial_no` int NOT NULL COMMENT '流水号',
  `component_id` bigint NOT NULL COMMENT '组件id',
  `completed` tinyint(1) DEFAULT NULL COMMENT '该配液单是否已完成',
  `config_json` text COLLATE utf8mb4_general_ci COMMENT '配置信息',
  `actual_target_volume` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目标体积',
  `liquid_measure_instance_id` bigint DEFAULT NULL COMMENT '配液量取组件实例id',
  `unit_id` bigint DEFAULT NULL COMMENT '目标体积单位id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液计划表'

CREATE TABLE `bm_liquid_preparation_plan_material_batch` (
  `id` bigint NOT NULL,
  `liquid_preparation_plan_id` bigint NOT NULL COMMENT '配液计划id',
  `material_batch_id` bigint NOT NULL COMMENT '物料批次id',
  `material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `formula_material_id` bigint NOT NULL COMMENT '配方物料id',
  `preparation_quantity` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配液量',
  `unit_id` bigint NOT NULL COMMENT '配方单位id',
  `material_order` int NOT NULL DEFAULT '0' COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液计划批次表'

CREATE TABLE `bm_log_operation` (
  `id` bigint NOT NULL,
  `business_id` bigint NOT NULL COMMENT '业务数据id',
  `module` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务模块',
  `operation_type` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `node_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批节点名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批节点名称',
  `detail` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '历史详情',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC

CREATE TABLE `bm_lot_release` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发编号',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `template_version` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板版本',
  `template_id` bigint DEFAULT NULL COMMENT '模版id',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `process_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次号',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_merge_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品合并编码',
  `specification` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格',
  `submitter_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '提交审核人id',
  `submitter_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '提交审核人姓名',
  `submitter_time` datetime DEFAULT NULL COMMENT '提交审核时间',
  `audit_process_instance` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核流程实例id',
  `generator_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成人姓名',
  `generator_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生成人id',
  `generate_time` datetime DEFAULT NULL COMMENT '生成时间',
  `effect_time` datetime DEFAULT NULL COMMENT '生效时间',
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批签发状态 EDIT 编辑 PROCESSING 审批中 EFFECTIVE 生效 SCRAPED 作废',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `file_url` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件地址',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发数据表'

CREATE TABLE `bm_lot_release_history` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `lot_release_id` bigint DEFAULT NULL COMMENT '批签发id',
  `operate_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作类型 CREATE 新增模板 CREATE_VERSION 新增版本 UPLOAD 上传 DOWNLOAD 下载 VALIDATE 验证 MAKE_DEFAULT 设为默认 MAKE_SURE 确认 SCRAP 作废',
  `operate_user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人id',
  `operate_user_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `operate_remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作备注',
  `ext` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展信息',
  `comment` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作摘要',
  `node_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核节点名称',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发操作历史'

CREATE TABLE `bm_lot_release_template` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `category_id` bigint DEFAULT NULL COMMENT '分类id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `effective_lot_release_id` bigint DEFAULT NULL COMMENT '生效的版本id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发模板'

CREATE TABLE `bm_lot_release_template_category` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `parent_id` bigint DEFAULT NULL COMMENT '上级分类id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集名称',
  `id_path` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据集分类id路径',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发模板分类'

CREATE TABLE `bm_lot_release_template_history` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `template_version_id` bigint DEFAULT NULL COMMENT '批签发版本id',
  `operate_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作类型 CREATE 新增模板 CREATE_VERSION 新增版本 UPLOAD 上传 DOWNLOAD 下载 VALIDATE 验证 MAKE_DEFAULT 设为默认 MAKE_SURE 确认 SCRAP 作废',
  `operate_user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人id',
  `operate_user_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称',
  `operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  `operate_remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作备注',
  `ext` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展信息',
  `comment` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作摘要',
  `node_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审核节点名称',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发模板操作历史'

CREATE TABLE `bm_lot_release_template_process` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `lot_release_template_id` bigint DEFAULT NULL COMMENT '批签发模版id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发模板关联工艺'

CREATE TABLE `bm_lot_release_template_version` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `template_id` bigint DEFAULT NULL COMMENT '模版id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模版名称',
  `version` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本',
  `template_url` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板url',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `is_default` tinyint DEFAULT NULL COMMENT '是否默认',
  `status` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本状态 EDIT 编辑 MAKE_SURE 确认 SCRAP 作废',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批签发模板版本'

CREATE TABLE `bm_lot_summary` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次摘要名称',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `process_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺名称',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1875083237731209217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批次摘要表'

CREATE TABLE `bm_lot_summary_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `lot_summary_id` bigint DEFAULT NULL COMMENT '批次摘要id',
  `label_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标题名称',
  `dataset_point_id` bigint DEFAULT NULL COMMENT '数据点名称',
  `lot_summary_item_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次摘要项类型',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1882243267769274370 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='批次摘要表数据项表'

CREATE TABLE `bm_material` (
  `id` bigint NOT NULL,
  `material_category_id` bigint NOT NULL COMMENT '分类id',
  `principal_material_id` bigint DEFAULT NULL COMMENT '所属物料id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
  `specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规格',
  `unit_id` bigint NOT NULL COMMENT '单位',
  `is_sub_material` tinyint(1) NOT NULL COMMENT '是否是成员物料',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启停状态',
  `storage_condition` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '保存条件',
  `dying_period` int DEFAULT NULL COMMENT '物料临期提醒天数(单位：天)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `merge_code` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '合并编码:分类合并编码+自身编码',
  `unit_extend_id` bigint DEFAULT NULL COMMENT '拓展单位id',
  `is_finish_product` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是成品',
  `platform_material_id` bigint NOT NULL COMMENT '平台物料关联id',
  `production_cycle` int DEFAULT NULL COMMENT '生产周期（天）',
  `inner_packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内包规格',
  `packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包装规格',
  `expand_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `product_mark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品标识',
  PRIMARY KEY (`id`,`is_finish_product`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='物料信息'

CREATE TABLE `bm_material_batch_field` (
  `id` bigint NOT NULL,
  `field_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典类型',
  `field_type_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典类型名称',
  `field` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段',
  `field_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段名称',
  `field_value` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id 表bm_storage_material_batch的主键id',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC

CREATE TABLE `bm_material_category` (
  `id` bigint NOT NULL,
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父级id，默认0',
  `code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `merge_code` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '合并编码:父级合并编码+自身编码',
  `category_type` int DEFAULT NULL COMMENT '分类类型 0原辅包信息、1中间品信息、2产品信息',
  `platform_category_Id` bigint DEFAULT NULL COMMENT '平台关联分类id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='物料分类'

CREATE TABLE `bm_material_field` (
  `id` bigint NOT NULL,
  `field_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典类型',
  `field_type_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典类型名称',
  `field` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段',
  `field_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段名称',
  `field_value` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字段值',
  `material_id` bigint DEFAULT NULL COMMENT '生产物料id 表bp_material的主键id',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC

CREATE TABLE `bm_output_finished_product` (
  `id` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品编码',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品名称',
  `product_batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品编码',
  `specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品规格',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本呢id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_output_finished_product_result` (
  `id` bigint NOT NULL,
  `output_finished_product_id` bigint DEFAULT NULL COMMENT 'output_finished_product_id',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品名称',
  `product_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品编码',
  `specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品规格',
  `product_batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '成品批号',
  `single_quantity` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '单件量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `number` int DEFAULT NULL COMMENT '件数',
  `operator_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_output_weigh_process` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `copy_version` int DEFAULT NULL COMMENT '拷贝版本',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `storage_material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批次编号',
  `expired_date` date DEFAULT NULL COMMENT '有效期',
  `relevance_material_id` bigint DEFAULT NULL COMMENT '关联物料id',
  `relevance_storage_material_batch_id` bigint DEFAULT NULL COMMENT '关联物料批次id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='产出称量流程表'

CREATE TABLE `bm_output_weigh_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `output_weigh_process_id` bigint DEFAULT NULL COMMENT '产出称量流程id',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '暂存物料批次id',
  `quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料量',
  `by_piece` tinyint(1) DEFAULT NULL COMMENT '是否按件产出',
  `tare_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重',
  `gross_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '毛重',
  `net_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '净重',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `container_id` bigint DEFAULT NULL COMMENT '容器id',
  `container_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器名称',
  `weigh_mode` int DEFAULT NULL COMMENT '称量模式',
  `sign_status` int DEFAULT NULL COMMENT '签名状态',
  `material_position_id` bigint DEFAULT NULL COMMENT '货位id',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `weigh_time` datetime DEFAULT NULL COMMENT '称量时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='产出称量记录表'

CREATE TABLE `bm_plan_template` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板名称',
  `confirmed` tinyint(1) NOT NULL COMMENT '确认状态',
  `state` tinyint(1) NOT NULL COMMENT '启停状态',
  `operator_user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作人id',
  `operation_time` datetime NOT NULL COMMENT '操作时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Plan Template Table'

CREATE TABLE `bm_plan_template_batch` (
  `id` bigint NOT NULL,
  `plan_template_id` bigint NOT NULL COMMENT '关联生产计划模板id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '工艺名称',
  `process_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `interval_duration` int NOT NULL COMMENT '间隔时长',
  `execution_duration` int NOT NULL COMMENT '执行时长',
  `production_line_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产线名称',
  `production_line_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产线编码',
  `production_line_id` bigint DEFAULT NULL COMMENT '产线id',
  `batch_quantity` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '生产批量',
  `unit_id` bigint DEFAULT NULL COMMENT '生产批量单位id',
  `reuse_batch_number` tinyint DEFAULT NULL COMMENT '是否沿用批号',
  `follow_batch_sort` int DEFAULT NULL COMMENT '沿用批号批次index',
  `relation_batch_sort_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '关联模板批次sort集合',
  `procedure_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '工序执行时长配置',
  `sort` int NOT NULL COMMENT '批次排序',
  `process_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '前端使用key',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  `product_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `product_merge_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品编码',
  `product_specification` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品规格',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `inner_packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内包规格',
  `packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包装规格',
  `product_mark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产品标识',
  `relation_processes_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '前端使用,关联工艺配置',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Your Table Description'

CREATE TABLE `bm_preparation_input_component_instance` (
  `id` bigint NOT NULL,
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `copy_version` bigint DEFAULT NULL COMMENT '复制版本',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `preparation_plan_id` bigint DEFAULT NULL COMMENT '绑定的配液单id',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `complete` tinyint(1) DEFAULT NULL COMMENT '是否完成配液投入',
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液投入实例'

CREATE TABLE `bm_preparation_input_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `preparation_plan_id` bigint DEFAULT NULL COMMENT '配料单id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '暂存物料批次id',
  `storage_material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '暂存物料批次编号',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件编号',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料量',
  `unit_id` bigint DEFAULT NULL COMMENT '投料单位',
  `device_id` bigint DEFAULT NULL COMMENT '设备id',
  `device_name` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `device_code` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编码',
  `sort` int DEFAULT NULL COMMENT '投入顺序',
  `importer_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `input_time` datetime DEFAULT NULL COMMENT '投料时间',
  `sign_status` tinyint DEFAULT NULL COMMENT '签名状态',
  `component_instance_id` bigint DEFAULT NULL COMMENT '配液投入组件实例id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液投入记录表'

CREATE TABLE `bm_preparation_produce_progress` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `copy_version` int DEFAULT NULL COMMENT '拷贝版本',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `preparation_plan_id` bigint DEFAULT NULL COMMENT '配液单id',
  `producer_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产出人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批次编号',
  `expired_date` date DEFAULT NULL COMMENT '有效期',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液产出称量流程表'

CREATE TABLE `bm_preparation_produce_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `procedure_produce_progress_id` bigint DEFAULT NULL COMMENT '配液产出称量流程id',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `storage_material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批次编号',
  `tare_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重',
  `gross_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '毛重',
  `net_weight` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '净重',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `container_id` bigint DEFAULT NULL COMMENT '容器id',
  `container_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容易编码',
  `container_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器名称',
  `weigh_mode` int DEFAULT NULL COMMENT '称量模式 1-配料称量 2-手动称量',
  `sort` int DEFAULT NULL COMMENT '产出排序',
  `sign_time` datetime DEFAULT NULL COMMENT '签名时间',
  `sign_status` int DEFAULT NULL COMMENT '签名状态 0-未签名 1-已签名 2-已作废',
  `material_position_id` bigint DEFAULT NULL COMMENT '货位id',
  `producer_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产出人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `produce_time` datetime DEFAULT NULL COMMENT '产出时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配液产出称量记录表'

CREATE TABLE `bm_procedure` (
  `id` bigint NOT NULL,
  `process_id` bigint DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_processId_name` (`process_id`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序基础信息'

CREATE TABLE `bm_procedure_condition` (
  `id` bigint NOT NULL COMMENT '主键id',
  `expression_id` bigint NOT NULL COMMENT '表达式id',
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `condition_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务详情json数据',
  `condition_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型',
  `procedure_step_model_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `default_result` tinyint(1) NOT NULL COMMENT '默认结果',
  `condition_node_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '条件节点类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序逻辑表达式条件表'

CREATE TABLE `bm_procedure_condition_instance` (
  `id` bigint NOT NULL COMMENT '主键id',
  `expression_id` bigint NOT NULL COMMENT '表达式id',
  `procedure_model_id` bigint NOT NULL COMMENT '工艺模型id',
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `condition_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务详情json数据',
  `task_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型：任务完成条件/执行条件等',
  `task_result` tinyint NOT NULL DEFAULT '0' COMMENT '任务执行结果，默认为false',
  `identifier` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标识符--非',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `plan_id` bigint NOT NULL COMMENT '计划id',
  `condition_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '条件类型',
  `default_result` bigint DEFAULT NULL COMMENT '默认结果',
  `procedure_step_model_id` bigint DEFAULT NULL,
  `condition_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序逻辑表达式条件表实例表'

CREATE TABLE `bm_procedure_condition_instance_history` (
  `id` bigint NOT NULL COMMENT '主键id',
  `expression_id` bigint NOT NULL COMMENT '表达式id',
  `procedure_model_id` bigint NOT NULL COMMENT '工艺模型id',
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `condition_details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务详情json数据',
  `task_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型：任务完成条件/物料判断条件等',
  `task_result` tinyint NOT NULL DEFAULT '0' COMMENT '任务执行结果，默认为false',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `plan_id` bigint NOT NULL COMMENT '计划id',
  `condition_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '条件类型',
  `default_result` bigint DEFAULT NULL COMMENT '默认结果',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序逻辑表达式条件表实例表'

CREATE TABLE `bm_procedure_confirm` (
  `id` bigint NOT NULL COMMENT '主键id',
  `procedure_name` varchar(64) NOT NULL COMMENT '工序名称',
  `confirm_time` datetime DEFAULT NULL COMMENT '结论填报时间',
  `procedure_time` datetime DEFAULT NULL COMMENT '工序完成时间',
  `process_confirm_id` bigint NOT NULL COMMENT '工艺结论id',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `confirm_opinion` varchar(64) DEFAULT NULL COMMENT '审批结论',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工序审批结论表'

CREATE TABLE `bm_procedure_equipment_acquisition` (
  `id` bigint NOT NULL,
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次号',
  `process_id` bigint DEFAULT NULL COMMENT '工序模型id',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录版本id',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '工序步骤id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `component_id` bigint NOT NULL COMMENT '组件id',
  `equipment_id` bigint DEFAULT NULL COMMENT '设备id',
  `copy_version` bigint DEFAULT NULL COMMENT '复制版本',
  `acquisition_id` bigint DEFAULT NULL COMMENT '采集项id',
  `acquisition_code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '采集项编码',
  `data_point_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '采集点位名称',
  `data_point_value_time` datetime NOT NULL COMMENT '点位数据时间',
  `data_point_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '点位数据',
  `acquisition_time` datetime NOT NULL COMMENT '采集时间',
  `input_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '录入类型',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `acquisition_sort` int DEFAULT NULL COMMENT '采集顺序',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `equipment_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `equipment_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编码',
  `group_component_id` bigint DEFAULT NULL COMMENT '分组组件id',
  `data_dict_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备数据编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_procedure_equipment_info` (
  `id` bigint NOT NULL,
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次号',
  `process_id` bigint DEFAULT NULL COMMENT '工序模型id',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录版本id',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '工序步骤id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `component_id` bigint NOT NULL COMMENT '组件id',
  `equipment_id` bigint DEFAULT NULL COMMENT '设备id',
  `copy_version` bigint DEFAULT NULL COMMENT '复制版本',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_procedure_expression` (
  `id` bigint NOT NULL COMMENT '主键id',
  `step_task_id` bigint DEFAULT NULL COMMENT '工步或者是工序任务id',
  `procedure_step_model_id` bigint DEFAULT NULL,
  `result` tinyint(1) NOT NULL DEFAULT '0' COMMENT '条件最终结果默认false',
  `expression_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '条件类型：完成条件/执行条件',
  `node_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程节点id',
  `expression` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表达式',
  `procedure_model_id` bigint NOT NULL COMMENT '工艺模型id',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `expression_node_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表达式节点类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工步/任务表达式表'

CREATE TABLE `bm_procedure_model` (
  `id` bigint NOT NULL,
  `node_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节点id',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工序名称',
  `principal` bigint NOT NULL COMMENT '负责人',
  `stage_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '阶段编码',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `procedure_id` bigint NOT NULL COMMENT '基础工序id',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本号',
  `process_version_id` bigint NOT NULL COMMENT '工艺版本id',
  `process_model_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程模型id',
  `duration` bigint DEFAULT NULL COMMENT '工序时长',
  `time_unit` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时长单位',
  `sort` int DEFAULT '0' COMMENT '排序号',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `del_id_flag` bigint DEFAULT '0' COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_processId_name_version_delIdFlag` (`process_id`,`name`,`process_version`,`del_id_flag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序信息'

CREATE TABLE `bm_procedure_model_group` (
  `id` bigint NOT NULL,
  `procedure_model_id` bigint NOT NULL,
  `group_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序班组'

CREATE TABLE `bm_procedure_model_material` (
  `procedure_model_id` bigint NOT NULL COMMENT '工序id',
  `product_formula_material_id` bigint NOT NULL COMMENT '配方物料id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工序绑定配方物料表'

CREATE TABLE `bm_procedure_model_room` (
  `procedure_model_id` bigint NOT NULL COMMENT '工序id',
  `room_id` bigint NOT NULL COMMENT '房间id',
  `room_id_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线id-房间id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工序绑定配方物料表'

CREATE TABLE `bm_procedure_step` (
  `id` bigint NOT NULL,
  `process_id` bigint DEFAULT NULL,
  `procedure_id` bigint DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '步骤名称',
  `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_procedureId_name` (`procedure_id`,`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序步骤基础信息'

CREATE TABLE `bm_procedure_step_config` (
  `id` bigint NOT NULL COMMENT '主键id',
  `procedure_step_id` bigint NOT NULL COMMENT '工序步骤id',
  `procedure_step_model_id` bigint NOT NULL COMMENT '工序步骤实例信息id',
  `node_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程节点id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本号',
  `record_item_id` bigint NOT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '批记录版本id',
  `config_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '配置信息',
  `component_id` bigint NOT NULL COMMENT '组件标识',
  `field_id` bigint NOT NULL COMMENT '组件标识:field_id 前端使用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_process_id_version` (`process_id`,`version`) USING BTREE,
  KEY `idx_procedure_step_id` (`procedure_step_id`) USING BTREE,
  KEY `idx_component_id` (`component_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺步骤配置表'

CREATE TABLE `bm_procedure_step_model` (
  `id` bigint NOT NULL COMMENT '主键id',
  `node_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程模型节点id',
  `procedure_step_id` bigint DEFAULT NULL COMMENT '基础工序步骤ID',
  `procedure_model_id` bigint NOT NULL COMMENT '工序模型id',
  `procedure_id` bigint NOT NULL COMMENT '历史工序id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `node_function` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '节点功能',
  `condition_id` bigint DEFAULT NULL COMMENT '任务条件id',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '步骤名称',
  `reusable` tinyint(1) DEFAULT NULL COMMENT '是否可复用',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项',
  `record_version_id` bigint DEFAULT NULL COMMENT '批记录版本id',
  `operation_sop` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作规程',
  `duration` bigint DEFAULT NULL COMMENT '时长',
  `sort` int DEFAULT NULL COMMENT '排序号',
  `time_unit` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '时间单位',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  `del_id_flag` bigint NOT NULL DEFAULT '0' COMMENT '删除标识',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `equipment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `step_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '步骤类型',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_process_procedureId_name` (`process_id`,`procedure_model_id`,`name`,`del_id_flag`) USING BTREE,
  KEY `idx_process_id_version_reusable` (`process_id`,`process_version`,`reusable`) USING BTREE,
  KEY `idx_record_item_id` (`record_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺配置步骤表'

CREATE TABLE `bm_procedure_step_role` (
  `procedure_step_id` bigint NOT NULL COMMENT '工序步骤id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  UNIQUE KEY `uk_procedure_step_role` (`procedure_step_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序步骤-角色关联'

CREATE TABLE `bm_procedure_step_sop` (
  `id` bigint NOT NULL COMMENT '主键id',
  `step_model_id` bigint NOT NULL COMMENT '工艺配置工步主键id',
  `operation_sop_id` bigint NOT NULL COMMENT '操作规程id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工步绑定操作规程表'

CREATE TABLE `bm_procedure_task` (
  `id` bigint NOT NULL COMMENT '主键id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `procedure_model_id` bigint NOT NULL COMMENT '工序模型id',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序模型任务基础信息表'

CREATE TABLE `bm_procedure_task_instance` (
  `id` bigint NOT NULL COMMENT '主键id',
  `procedure_step_model_id` bigint DEFAULT NULL,
  `process_instance_id` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `plan_id` bigint NOT NULL COMMENT '计划id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `flow_state` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'EDIT' COMMENT '流程状态：默认编辑，启动后进入作业中，任务完成进入确定',
  `flow_enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启动，默认为false',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `procedure_model_id` bigint NOT NULL COMMENT '工序模型id',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '记录任务是否重做过',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `active_time` datetime DEFAULT NULL COMMENT '激活时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `process_change_number` int DEFAULT '0' COMMENT '工艺换班次数',
  `procedure_change_number` int DEFAULT '0' COMMENT '工序换班次数',
  `coerce_user` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '强制开启人',
  `coerce_time` datetime DEFAULT NULL COMMENT '强制开始时间',
  `pause_tag` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '暂停标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序模型任务信息实例表'

CREATE TABLE `bm_procedure_task_instance_history` (
  `id` bigint NOT NULL COMMENT '主键id',
  `process_instance_id` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发起流程后工作流程实例id',
  `procedure_step_model_id` bigint NOT NULL COMMENT '任务id',
  `plan_id` bigint NOT NULL COMMENT '计划id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `flow_state` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'EDIT' COMMENT '流程状态：默认编辑，启动后进入作业中，任务完成进入确定',
  `flow_enable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启动，默认为false',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `procedure_model_id` bigint NOT NULL COMMENT '工序模型id',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '记录任务是否重做过',
  `create_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `active_time` datetime DEFAULT NULL COMMENT '激活时间',
  `process_change_number` int DEFAULT '0' COMMENT '工艺换班次数',
  `procedure_change_number` int DEFAULT '0' COMMENT '工序换班次数',
  `coerce_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '强制开启人',
  `coerce_time` datetime DEFAULT NULL COMMENT '强制开始时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工序模型任务信息实例表'

CREATE TABLE `bm_process` (
  `id` bigint NOT NULL COMMENT '主键id',
  `product_id` bigint NOT NULL COMMENT '产品id',
  `product_category_id` bigint DEFAULT NULL COMMENT '产品分类id',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺名称',
  `active_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '激活版本',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺信息表'

CREATE TABLE `bm_process_batch_record` (
  `id` bigint NOT NULL,
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `process_version_id` bigint NOT NULL COMMENT '工艺id',
  `batch_record_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '批记录版本',
  `batch_record_id` bigint NOT NULL COMMENT '批记录id',
  `batch_record_version_id` bigint NOT NULL COMMENT '批记录版本id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺关联记录中间表'

CREATE TABLE `bm_process_confirm` (
  `id` bigint NOT NULL COMMENT '主键id',
  `product_id` bigint NOT NULL COMMENT '产品id',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_code` varchar(1000) NOT NULL COMMENT '产品编码',
  `product_specification` varchar(100) DEFAULT NULL COMMENT '产品规格',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_name` varchar(100) DEFAULT NULL COMMENT '工艺名称',
  `plan_batch_no` varchar(64) DEFAULT NULL COMMENT '生产批号',
  `start_time` datetime DEFAULT NULL COMMENT '生产开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '生产结束时间时间',
  `confirm_time` datetime DEFAULT NULL COMMENT '填报结论时间',
  `instance_id` varchar(64) NOT NULL COMMENT '流程实例id',
  `confirm_opinion` varchar(64) DEFAULT NULL COMMENT '审批结论',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工艺审核结论确定表'

CREATE TABLE `bm_process_dashboard_config` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `process_id` bigint DEFAULT NULL COMMENT '工艺id',
  `process_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺名称',
  `process_version` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工艺版本',
  `procedure_list` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '工序配置json',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='工艺看板配置表'

CREATE TABLE `bm_process_production_line` (
  `id` bigint NOT NULL,
  `process_version_id` bigint NOT NULL COMMENT '工艺版本id',
  `production_line_id` bigint NOT NULL COMMENT '产线id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_process_record_order` (
  `id` bigint NOT NULL COMMENT '等于批记录版本的id',
  `record_item_id` bigint NOT NULL COMMENT '记录项id',
  `record_item_order` bigint NOT NULL COMMENT '记录项顺序',
  `process_version_id` bigint NOT NULL COMMENT '工艺版本id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工艺版本',
  `record_version_id` bigint NOT NULL COMMENT '记录版本',
  `reusable` tinyint(1) NOT NULL COMMENT '是否复用',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺批记录归档顺序'

CREATE TABLE `bm_process_relation` (
  `id` bigint NOT NULL,
  `process_id` bigint NOT NULL COMMENT '工艺id',
  `relation_process_id` bigint NOT NULL COMMENT '关联工艺id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='关联工艺'

CREATE TABLE `bm_process_relation_material` (
  `id` bigint NOT NULL,
  `process_relation_id` bigint NOT NULL COMMENT '工艺关联id',
  `material_id` bigint NOT NULL COMMENT '物料id',
  `process_id` bigint NOT NULL COMMENT '工艺id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺关联物料'

CREATE TABLE `bm_process_version` (
  `id` bigint NOT NULL COMMENT '主键id',
  `process_id` bigint DEFAULT NULL,
  `process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批流程实例id',
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '版本号',
  `product_formula_version_id` bigint DEFAULT NULL COMMENT '配方版本id',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `action_state` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '状态：1:编辑；2：审核；3：确定',
  `production_line_id` bigint DEFAULT NULL COMMENT '产线id',
  `state` tinyint NOT NULL DEFAULT '1' COMMENT '1:启用；2：停用',
  `production_stage_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `process_model_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程模型id',
  `relations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '关联工艺',
  `history_state` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '历史版本状态',
  `effect_date` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生效时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_process_version` (`process_id`,`version`) USING BTREE COMMENT '工艺版本唯一索引',
  KEY `idx_process_instance_id` (`process_instance_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='工艺版本'

CREATE TABLE `bm_product_change_team` (
  `id` bigint NOT NULL COMMENT '主键id',
  `product_instruction_team_id` bigint NOT NULL COMMENT '生产指令单确定班组信息表',
  `team_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '班组id集合',
  `change_team_number` int NOT NULL COMMENT '换班次数',
  `change_team_type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '换班类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `index_instruction_id` (`product_instruction_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='换班班次信息表'

CREATE TABLE `bm_product_formula` (
  `id` bigint NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '配方名称',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(255) DEFAULT NULL COMMENT '产品名称',
  `product_merge_code` varchar(255) DEFAULT NULL COMMENT '产品合并编码',
  `product_specification` varchar(255) DEFAULT NULL COMMENT '产品规格',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品配方'

CREATE TABLE `bm_product_formula_material` (
  `id` bigint NOT NULL,
  `version_id` bigint NOT NULL COMMENT '配方版本id',
  `material_type` tinyint(1) DEFAULT NULL COMMENT '物料类型',
  `material_id` bigint NOT NULL COMMENT '物料id',
  `material_name` varchar(255) DEFAULT NULL COMMENT '物料名称',
  `material_merge_code` varchar(255) DEFAULT NULL COMMENT '物料合并编码',
  `material_specification` varchar(255) DEFAULT NULL COMMENT '物料规格',
  `unit_id` bigint NOT NULL COMMENT '单位id',
  `quantity` varchar(64) NOT NULL COMMENT '数量',
  `quantity_type` tinyint(1) DEFAULT NULL COMMENT '数量类型',
  `rounding` varchar(255) DEFAULT NULL COMMENT '修约规则',
  `scale` varchar(64) DEFAULT NULL COMMENT '物料精度',
  `scale_length` int DEFAULT NULL COMMENT '精度长度',
  `dry_pure_type` tinyint DEFAULT NULL COMMENT '折干折纯类型',
  `dry_pure_param` varchar(64) DEFAULT NULL COMMENT '折干折纯参数',
  `tolerance_info` text COMMENT '允差信息(配液允差、余液允差)',
  `unpacking_tolerance_type` tinyint(1) DEFAULT NULL COMMENT '拆包允差类型',
  `unpacking_tolerance_upper` varchar(64) DEFAULT NULL COMMENT '拆包允差上限',
  `unpacking_tolerance_lower` varchar(64) DEFAULT NULL COMMENT '拆包允差下限',
  `charge_mixture_tolerance_type` tinyint(1) DEFAULT NULL COMMENT '配料允差类型',
  `charge_mixture_tolerance_upper` varchar(64) DEFAULT NULL COMMENT '配料允差上限',
  `charge_mixture_tolerance_lower` varchar(64) DEFAULT NULL COMMENT '配料允差下限',
  `oddment_tolerance_type` tinyint(1) DEFAULT NULL COMMENT '余料允差类型',
  `oddment_tolerance_upper` varchar(64) DEFAULT NULL COMMENT '余料允差上限',
  `oddment_tolerance_lower` varchar(64) DEFAULT NULL COMMENT '余料允差下限',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品配方物料'

CREATE TABLE `bm_product_formula_version` (
  `id` bigint NOT NULL,
  `version_no` varchar(255) DEFAULT NULL COMMENT '版本号',
  `product_formula_id` bigint DEFAULT NULL COMMENT '产品配方id',
  `description` varchar(255) DEFAULT NULL COMMENT '版本描述',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `normal` tinyint DEFAULT NULL COMMENT '是否为默认版本',
  `enable` tinyint(1) DEFAULT NULL COMMENT '启停状态',
  `batch_quantity` varchar(64) NOT NULL COMMENT '生产批量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `process_instance_id` varchar(255) DEFAULT NULL COMMENT '流程实例id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品配方版本'

CREATE TABLE `bm_product_instruction` (
  `id` bigint NOT NULL COMMENT '主键',
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `node_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工序节点id',
  `procedure_id` bigint NOT NULL COMMENT '历史工序id(以此判断多给版本的节点是否是同一工序)',
  `procedure_model_id` bigint NOT NULL COMMENT '生产工序id',
  `procedure_model_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工序名称',
  `procedure_model_code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产工序阶段编码',
  `principal` bigint NOT NULL COMMENT '负责人',
  `confirm_user_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '指令单确认人id',
  `status` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'RESOLVE' COMMENT '指令单状态 已分解 RESOLVE已确认 CONFIRM',
  `sort` int(4) unsigned zerofill NOT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_productPlanId_nodeId` (`product_plan_id`,`node_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划指令单表'

CREATE TABLE `bm_product_instruction_team` (
  `id` bigint NOT NULL COMMENT '主键',
  `instruction_id` bigint NOT NULL COMMENT '指令单id',
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `node_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工序节点id',
  `procedure_id` bigint NOT NULL COMMENT '历史工序id(以此判断多给版本的节点是否是同一工序)',
  `procedure_model_id` bigint NOT NULL COMMENT '生产工序id',
  `node_step_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工序步骤节点id',
  `procedure_step_id` bigint NOT NULL COMMENT '历史工序id(以此判断多给版本的节点是否是同一工序)',
  `procedure_step_model_id` bigint NOT NULL COMMENT '生产工序步骤id',
  `procedure_step_model_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工序步骤名称',
  `procedure_step_time` int DEFAULT NULL COMMENT '执行时长',
  `procedure_step_time_unit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '执行时长单位',
  `team_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '班组id列表',
  `sort` int(4) unsigned zerofill NOT NULL COMMENT '排序',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_instructionId_nodeStepId` (`instruction_id`,`node_step_id`) USING BTREE,
  KEY `index_plan_id` (`product_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划指令单班组表'

CREATE TABLE `bm_product_plan` (
  `id` bigint NOT NULL COMMENT '主键',
  `plan_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划编号',
  `batch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批号',
  `product_date` date NOT NULL COMMENT '生产时间',
  `production_plan_item_id` bigint DEFAULT NULL COMMENT '计划详情id',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划类型',
  `product_id` bigint NOT NULL COMMENT '产品Id',
  `product_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品名称',
  `product_merge_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品编码',
  `product_specification` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产品规格',
  `inner_packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '内包规格',
  `packing_specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包装规格',
  `process_id` bigint NOT NULL COMMENT '生产工艺id',
  `process_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工艺名称',
  `process_num` int NOT NULL COMMENT '工艺下节点数量',
  `process_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产工艺版本',
  `status` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'EDIT' COMMENT '状态 编辑EDIT 审批AUDIT 确认CONFIRM 废弃DISCARD',
  `instruct_status` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT_DECOMPOSE' COMMENT '状态 待分解WAIT_DECOMPOSE 待确认WAIT_CONFIRM 待下发WAIT_SEND 已下发 SEND',
  `is_relation` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE' COMMENT '是否被其他批次关联 未关联FALSE 已关联TRUE',
  `process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '流程实例',
  `is_start` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'WAIT' COMMENT '是否开始生产 等待WAIT 开始STARTING 结束 END',
  `start_time` datetime DEFAULT NULL COMMENT '生产计划开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '生产计划结束时间',
  `execute_process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产执行流程实例',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `batch_quantity` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批量',
  `unit_id` bigint DEFAULT NULL COMMENT '生产批量单位id',
  `execute_paused` tinyint(1) DEFAULT NULL COMMENT '生产计划执行已暂停',
  `production_line_id` bigint DEFAULT NULL COMMENT '产线id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `archive_status` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '归档状态',
  `modify_count` int DEFAULT '0' COMMENT '修订数量',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_planNo` (`plan_no`) USING BTREE,
  UNIQUE KEY `uk_processId_batchNo` (`process_id`,`batch_no`) USING BTREE,
  KEY `idx_isStart` (`is_start`) USING BTREE,
  KEY `idx_processInstanceId` (`process_instance_id`) USING BTREE,
  KEY `idx_executeProcessInstanceId` (`execute_process_instance_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划表'

CREATE TABLE `bm_product_plan_code_rule` (
  `id` bigint NOT NULL COMMENT '主键',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产计划编码规则分类',
  `process_id` bigint NOT NULL COMMENT '生产工艺id',
  `code_rule_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码规则code',
  `code_rule_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编码规则名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  UNIQUE KEY `uk_type_processId` (`type`,`process_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划编码规则'

CREATE TABLE `bm_product_plan_no_info` (
  `product_plan_id` bigint NOT NULL,
  `plan_no_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '计划编号规则code',
  `batch_no_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批号编号规则code',
  `plan_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '计划编号',
  `batch_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批次编号',
  `plan_no_id` bigint DEFAULT NULL COMMENT '计划编号id',
  `batch_no_id` bigint DEFAULT NULL COMMENT '批次编号id',
  `fields` longtext COLLATE utf8mb4_general_ci COMMENT '规则编码参数json',
  PRIMARY KEY (`product_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_product_plan_relation` (
  `id` bigint NOT NULL COMMENT '主键',
  `product_plan_id` bigint NOT NULL COMMENT '生产计划id',
  `process_id` bigint DEFAULT NULL COMMENT '工序id',
  `relation_product_plan_id` bigint NOT NULL COMMENT '关联生产计划id',
  `is_direct_relation` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FALSE' COMMENT '是否直接关联',
  `source_product_plan_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_processId_batchNo` (`product_plan_id`,`relation_product_plan_id`,`source_product_plan_id`),
  KEY `idx_relationProductPlanId` (`relation_product_plan_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划关联关系表'

CREATE TABLE `bm_product_plan_team` (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班组名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班组编码',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班组描述',
  `people` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '班组人员 json数据',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'FALSE' COMMENT '状态 TRUE 启用 FALSE 禁用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  UNIQUE KEY `uk_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='生产计划班组'

CREATE TABLE `bm_production_plan` (
  `id` bigint NOT NULL COMMENT '主键id',
  `plan_name` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划名称',
  `plan_template_id` bigint NOT NULL COMMENT '生产计划模板id',
  `plan_type` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '指令单类型',
  `plan_first_date` date NOT NULL COMMENT '首批生成日期',
  `plan_number` int NOT NULL COMMENT '计划数量',
  `duration` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '间隔时长',
  `plan_state` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'SEND' COMMENT '状态',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name` (`plan_name`) USING BTREE COMMENT '名称唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='生产计划表'

CREATE TABLE `bm_production_plan_item` (
  `id` bigint NOT NULL COMMENT '主键id',
  `template_batch_id` bigint NOT NULL COMMENT '计划模板详情表id',
  `production_plan_id` bigint NOT NULL COMMENT '计划id',
  `start_time` date NOT NULL COMMENT '计划开始日期',
  `end_time` date NOT NULL COMMENT '计划结束日期',
  `production_line_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线编码',
  `production_line_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '产线名称',
  `production_line_id` bigint NOT NULL COMMENT '产线id',
  `process_num` int DEFAULT NULL COMMENT '工序数量',
  `plan_no` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产指令单批号',
  `batch_no` varchar(60) COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批号',
  `batch_quantity` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产批量',
  `production_batch_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '关联批次信息',
  `procedure_list` text COLLATE utf8mb4_general_ci NOT NULL COMMENT '工序相关信息',
  `group_number` int NOT NULL COMMENT '分组信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  `related_batch_info` longtext COLLATE utf8mb4_general_ci COMMENT '前端使用关联批次信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='生产计划子表'

CREATE TABLE `bm_requisition_plan` (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '领料单名称',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `serial_no` int DEFAULT NULL COMMENT '流水号',
  `requisition_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '领料类型',
  `completed_plan` tinyint(1) DEFAULT NULL COMMENT '是否完成向仓库发送领料计划',
  `send_status` tinyint(1) DEFAULT NULL COMMENT '仓库发料状态',
  `received_id` bigint DEFAULT NULL COMMENT '领料接收确认组件id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `completed_receive` tinyint(1) DEFAULT NULL COMMENT '是否完成领料接收',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='领料计划表'

CREATE TABLE `bm_requisition_plan_reserved` (
  `id` bigint NOT NULL,
  `requisition_plan_id` bigint NOT NULL COMMENT '领料单id',
  `formula_material_id` bigint NOT NULL COMMENT '配方物料id',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `material_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批号',
  `planned_quantity` decimal(20,10) DEFAULT NULL COMMENT '计划量',
  `theoretical_quantity` decimal(20,10) DEFAULT NULL COMMENT '理论量',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '计划人id',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `expired_date` datetime DEFAULT NULL COMMENT '有效日期',
  `merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料编码',
  `specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料规格',
  `wms_material_id` bigint DEFAULT NULL COMMENT 'wms物料id',
  `material_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'wms物料名称',
  `hydration` decimal(10,2) DEFAULT NULL COMMENT '水分',
  `no_hydration_content` decimal(10,2) DEFAULT NULL COMMENT '无水含量',
  `supplier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商',
  `producer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产商',
  `origin_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原产批号',
  `origin_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原厂编码',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='领料单物料批次'

CREATE TABLE `bm_requisition_received` (
  `id` bigint NOT NULL,
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本呢id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `requisition_id` bigint DEFAULT NULL COMMENT '绑定领料单id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_requisition_received_batch` (
  `id` bigint NOT NULL,
  `requisition_plan_id` bigint DEFAULT NULL COMMENT '领料单id',
  `inventory_batch_id` bigint DEFAULT NULL COMMENT '仓库货品批次id',
  `inventory_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '仓库货品批次号',
  `quantity` decimal(20,10) DEFAULT NULL COMMENT '发料总量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `factory_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原厂批号',
  `produce_date` date DEFAULT NULL COMMENT '生产日期',
  `expired_date` date DEFAULT NULL COMMENT '有效日期',
  `hydration` decimal(20,10) DEFAULT NULL COMMENT '水分',
  `no_hydration_content` decimal(20,10) DEFAULT NULL COMMENT '无水含量',
  `report_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '报告单编号',
  `licence_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '放行单编号',
  `cargo_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货品混合编码',
  `cargo_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货品名称',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='领料计划--代领批次'

CREATE TABLE `bm_requisition_received_material` (
  `id` bigint NOT NULL,
  `requisition_plan_id` bigint DEFAULT NULL COMMENT '领料单id',
  `inventory_batch_id` bigint DEFAULT NULL COMMENT '货品批次id',
  `platform_material_id` bigint DEFAULT NULL COMMENT '平台物料id',
  `inventory_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `quantity` decimal(20,10) DEFAULT NULL COMMENT '发放物料量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `cargo_position_id` bigint DEFAULT NULL COMMENT '暂存货位id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `received_batch_id` bigint DEFAULT NULL COMMENT 'bm_requisition_received_batch表id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='领料计划 待领物料件'

CREATE TABLE `bm_reserve_component_instance` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `component_id` bigint DEFAULT NULL COMMENT '组件id',
  `procedure_step_model_id` bigint DEFAULT NULL COMMENT '工序步骤模型id',
  `record_item_id` bigint DEFAULT NULL COMMENT '记录项id',
  `record_version_id` bigint DEFAULT NULL COMMENT '记录项版本id',
  `reuse` tinyint(1) DEFAULT NULL COMMENT '是否复用',
  `copy_version` int DEFAULT NULL COMMENT '复制版本',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1893972446986506241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_reserve_component_material` (
  `id` bigint NOT NULL,
  `instance_id` bigint NOT NULL,
  `storage_material_id` bigint NOT NULL,
  `cancel_reserve` tinyint(1) DEFAULT NULL COMMENT '是否被取消预定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_resource_permission` (
  `resource_id` bigint NOT NULL,
  `dept_id` bigint NOT NULL,
  UNIQUE KEY `uk_resource_dept` (`resource_id`,`dept_id`) USING BTREE COMMENT '资源-部门唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='数据权限表'

CREATE TABLE `bm_storage` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `parent_id` bigint DEFAULT NULL COMMENT '上级区域id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '区域名称',
  `level` int DEFAULT NULL COMMENT '层级',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1849264621064687617 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂存间表'

CREATE TABLE `bm_storage_material` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `material_position_id` bigint DEFAULT NULL COMMENT '暂存货位id',
  `no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `unit_id` bigint DEFAULT NULL COMMENT '标准单位id',
  `unit_extend_id` bigint DEFAULT NULL COMMENT '扩展单位id',
  `init_quantity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '初始量',
  `consume_quantity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '消耗量',
  `available_quantity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '可用量',
  `reserve_quantity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预订量',
  `container` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器',
  `container_id` bigint DEFAULT NULL COMMENT '容器id',
  `sign_status` int DEFAULT NULL COMMENT '签名状态',
  `source` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料来源',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `product_id` bigint DEFAULT NULL COMMENT '产品id （来源是物料称量，和上面的productPlanId不对应是正常的！！！）',
  `batch_no` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号 （来源是物料称量，和上面的productPlanId不一样是正常的！！！）',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_no_unique` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1895025597588049921 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='物料件信息'

CREATE TABLE `bm_storage_material_batch` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '物理主键',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `material_batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批号',
  `original_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原始编码',
  `expired_date` date DEFAULT NULL COMMENT '有效日期',
  `expire_warning_flag` tinyint(1) DEFAULT '0' COMMENT '物料临期提醒标志',
  `factory_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '原厂批号',
  `hydration` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '水分(%)',
  `no_hydration_content` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '无水含量(%)',
  `supplier` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '供应商',
  `producer` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产商',
  `unit_id` bigint DEFAULT NULL COMMENT '标准单位id',
  `unit_extend_id` bigint DEFAULT NULL COMMENT '扩展单位id',
  `available` tinyint(1) DEFAULT NULL COMMENT '是否可用',
  `quality_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'QUARANTINE' COMMENT '质量状态',
  `link_explain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '来源/去向',
  `sender_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '递交人id',
  `receiver_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '接收人id',
  `produce_date` date DEFAULT NULL COMMENT '生产日期',
  `report_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '报告单编号',
  `licence_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '放行单编号',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1897565127482413057 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='物料批次'

CREATE TABLE `bm_storage_material_charge_recycle` (
  `id` bigint NOT NULL,
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料名称',
  `material_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料编码',
  `specification` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料规格',
  `material_batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批号',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `storage_material_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件好',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `quantity` decimal(20,10) DEFAULT NULL COMMENT '物料量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `operation_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作类型',
  `operator_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人id',
  `charge_recycle_component_id` bigint DEFAULT NULL COMMENT 'charge_recycle_component表主键id',
  `equipment_id` bigint DEFAULT NULL COMMENT '设备id',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `equipment_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '修改人',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_storage_material_reserve` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `storage_material_id` bigint DEFAULT NULL COMMENT '暂存物料件id',
  `product_id` bigint DEFAULT NULL COMMENT '预定产品id',
  `process_id` bigint DEFAULT NULL COMMENT '预定工艺id',
  `batch_id` bigint DEFAULT NULL COMMENT '预定生产批次id',
  `batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预定生产批号',
  `reserve_quantity` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预订量',
  `reserve_remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预定备注',
  `reserve_time` datetime DEFAULT NULL COMMENT '预定时间',
  `reserve_user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '预定人id（操作人id）',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='暂存物料预定记录'

CREATE TABLE `bm_tare_weigh_config` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `tare_weigh` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重',
  `unit` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重单位',
  `unit_id` bigint DEFAULT NULL COMMENT '皮重单位id',
  `describe_info` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `editor_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修订人',
  `edit_time` datetime DEFAULT NULL COMMENT '修订时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='皮重配置表'

CREATE TABLE `bm_team_production_line` (
  `id` bigint NOT NULL,
  `team_id` bigint NOT NULL COMMENT '班组id',
  `production_line_id` bigint NOT NULL COMMENT '产线id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_weigh_centre` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `category_id` bigint DEFAULT NULL COMMENT '称量中心分类id',
  `code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量中心编码',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量中心名称',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `enabled` tinyint(1) DEFAULT NULL COMMENT '启停',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量中心表'

CREATE TABLE `bm_weigh_centre_category` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `parent_id` bigint DEFAULT NULL COMMENT '上级称量中心分类id',
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量中心分类名称',
  `id_path` text COLLATE utf8mb4_general_ci COMMENT 'id路径',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量中心分类表'

CREATE TABLE `bm_weigh_centre_station` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `weigh_centre_id` bigint DEFAULT NULL COMMENT '称量中心id',
  `station_id` bigint DEFAULT NULL COMMENT '工位id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量中心工位关联表'

CREATE TABLE `bm_weigh_data` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `weight` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '重量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `weigh_time` datetime DEFAULT NULL COMMENT '称量时间',
  `component_instance_id` bigint DEFAULT NULL COMMENT '称量数据组件实例id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量数据组件记录'

CREATE TABLE `bm_weigh_execute_consume_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `task_id` bigint DEFAULT NULL COMMENT '称量任务id',
  `requirement_id` bigint DEFAULT NULL COMMENT '称量需求id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '称量消耗物料批次id',
  `storage_material_id` bigint DEFAULT NULL COMMENT '称量消耗物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量消耗物料件编号',
  `consume_quantity` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '消耗量',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `consume_time` datetime DEFAULT NULL COMMENT '消耗时间',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量执行添加物料记录表'

CREATE TABLE `bm_weigh_execute_weigh_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `task_id` bigint DEFAULT NULL COMMENT '任务id',
  `requirement_id` bigint DEFAULT NULL COMMENT '需求id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产计划id',
  `tare_weight` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重',
  `gross_weight` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '毛重',
  `net_weight` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '净重',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '称量产出物料批次id',
  `storage_material_batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量产出物料批次号',
  `storage_material_id` bigint DEFAULT NULL COMMENT '称量产出物料件id',
  `storage_material_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量产出物料件编号',
  `weigh_type` int DEFAULT NULL COMMENT '称量方式',
  `weigh_mode` int DEFAULT NULL COMMENT '称量模式',
  `sign_status` int DEFAULT NULL COMMENT '签名状态',
  `weigher_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `weigh_time` datetime DEFAULT NULL COMMENT '称量时间',
  `container_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '容器名称',
  `material_position_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货位名称',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量执行称量记录表'

CREATE TABLE `bm_weigh_input_process` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `component_instance_id` bigint DEFAULT NULL COMMENT '组件实例id',
  `finished` tinyint DEFAULT NULL COMMENT '是否已完成',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量物料投入流程表'

CREATE TABLE `bm_weigh_input_record` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `storage_material_id` bigint DEFAULT NULL COMMENT '暂存物料id',
  `quantity` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料量',
  `input_component_instance_id` bigint DEFAULT NULL COMMENT '投料组件实例id',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `input_user_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料人id',
  `input_user_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '投料人名称',
  `input_time` datetime DEFAULT NULL COMMENT '投料时间',
  `device_id` bigint DEFAULT NULL COMMENT '投料设备id',
  `device_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `device_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编码',
  `requirement_id` bigint DEFAULT NULL COMMENT '称量需求id',
  `product_plan_id` bigint DEFAULT NULL COMMENT '配料计划id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='物料投入记录表'

CREATE TABLE `bm_weigh_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料名称',
  `material_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料编码',
  `material_type` tinyint(1) DEFAULT NULL COMMENT '物料类型',
  `storage_material_id` bigint DEFAULT NULL COMMENT '物料件id',
  `material_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料件号',
  `material_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '物料批号',
  `material_batch_id` bigint DEFAULT NULL COMMENT '物料批次id',
  `net_weight` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '净重',
  `tare_weight` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '皮重',
  `gross_weight` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '毛重',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `unit_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '单位名称',
  `weigh_type` tinyint DEFAULT NULL COMMENT '称量类型',
  `weigher_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `weigher_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人名称',
  `weigher_login_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人登录名称',
  `re_checker_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `re_checker_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人名称',
  `re_checker_login_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人登录名',
  `weigh_time` datetime DEFAULT NULL COMMENT '称量时间',
  `equipment_id` bigint DEFAULT NULL COMMENT '设备id',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备名称',
  `equipment_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备编号·',
  `equipment_status` tinyint(1) DEFAULT NULL COMMENT '设备状态',
  `equipment_expire_date` date DEFAULT NULL COMMENT '校准日期',
  `product_id` bigint DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_merge_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品编码',
  `product_batch_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批号',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产批次id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci

CREATE TABLE `bm_weigh_requirement` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `procedure_step_config_id` bigint DEFAULT NULL COMMENT '组件配置id',
  `formula_material_id` bigint DEFAULT NULL COMMENT '配方物料id',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `weigh_centre_id` bigint DEFAULT NULL COMMENT '称量中心id',
  `requirement_date` date DEFAULT NULL COMMENT '需求日期',
  `expired_date` date DEFAULT NULL COMMENT '失效日期',
  `requirement_quantity` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '需求量',
  `product_plan_id` bigint DEFAULT NULL COMMENT '生产批次id',
  `batch_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '生产批次号',
  `product_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品名称',
  `product_merge_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '产品合并编码',
  `weigh_requirement_task_id` bigint DEFAULT NULL COMMENT '规划称量任务id',
  `program_time` datetime DEFAULT NULL COMMENT '规划时间',
  `requirement_status` int DEFAULT NULL COMMENT '需求状态 0 未规划 1 未称量 2 称量中 3 已完成 4 已失效',
  `weigh_status` int DEFAULT NULL COMMENT '称量状态 0 未称量 1 称量中 2 已完成称量 3 已完成签名',
  `weigh_process` int DEFAULT NULL COMMENT '称量阶段 1 物料称量 2 更换需求 3 余料称量 4 已完成称量 5 已完成签名',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '当前添加物料批次id',
  `weigher_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `re_checker_id` bigint DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `business_component_instance_id` bigint DEFAULT NULL COMMENT '来源业务组件id',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量中心称量需求表'

CREATE TABLE `bm_weigh_task` (
  `id` bigint NOT NULL COMMENT '物理主键',
  `task_no` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量任务编号',
  `material_id` bigint DEFAULT NULL COMMENT '物料id',
  `unit_id` bigint DEFAULT NULL COMMENT '单位id',
  `weigh_centre_id` bigint DEFAULT NULL COMMENT '称量中心id',
  `requirement_quantity` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '需求量',
  `execute_date` date DEFAULT NULL COMMENT '执行时间',
  `task_status` int DEFAULT NULL COMMENT '任务状态 0 编辑 1 待下发 2 已下发 3 已执行',
  `send_time` datetime DEFAULT NULL COMMENT '任务下发时间',
  `finish_time` datetime DEFAULT NULL COMMENT '任务完成时间',
  `task_program_type` int DEFAULT NULL COMMENT '规划类型 1 自动规划 2 手动规划',
  `process_time` datetime DEFAULT NULL COMMENT '规划时间',
  `process_operator_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '规划人id',
  `pre_weigher_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '称量人id',
  `pre_re_checker_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '复核人id',
  `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `storage_material_batch_id` bigint DEFAULT NULL COMMENT '当前称量的物料批次',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `update_by` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='称量中心称量任务表'


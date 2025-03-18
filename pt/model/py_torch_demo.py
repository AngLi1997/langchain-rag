import torch
import matplotlib.pyplot as pl
import torch.nn as nn
from torch import optim

n_samples = 100
data = torch.randn(n_samples, 2)
print(data)
labels = (data[:, 0]**2 + data[:, 1]**2 < 1).float().unsqueeze(1)
print(labels)


# 定义前馈神经网络
class SimpleNN(nn.Module):
    def __init__(self):
        super(SimpleNN, self).__init__()
        # 定义神经网络的层
        self.fc1 = nn.Linear(2, 4)  # 输入层有 2 个特征，隐藏层有 4 个神经元
        self.fc2 = nn.Linear(4, 1)  # 隐藏层输出到 1 个神经元（用于二分类）
        self.sigmoid = nn.Sigmoid()  # 二分类激活函数

    def forward(self, x):
        x = torch.relu(self.fc1(x))  # 使用 ReLU 激活函数
        x = self.sigmoid(self.fc2(x))  # 输出层使用 Sigmoid 激活函数
        return x


# 可视化决策边界
def plot_decision_boundary(model, data):
    x_min, x_max = data[:, 0].min() - 1, data[:, 0].max() + 1
    y_min, y_max = data[:, 1].min() - 1, data[:, 1].max() + 1
    xx, yy = torch.meshgrid(torch.arange(x_min, x_max, 0.1), torch.arange(y_min, y_max, 0.1), indexing='ij')
    grid = torch.cat([xx.reshape(-1, 1), yy.reshape(-1, 1)], dim=1)
    predictions = model(grid).detach().numpy().reshape(xx.shape)
    pl.contourf(xx, yy, predictions, levels=[0, 0.5, 1], cmap='coolwarm', alpha=0.7)
    pl.scatter(data[:, 0], data[:, 1], c=labels.squeeze(), cmap='coolwarm', edgecolors='k')
    pl.title("Decision Boundary")
    pl.show()

if __name__ == '__main__':
    pl.scatter(data[:, 0], data[:, 1], c=labels.squeeze(1), cmap='coolwarm')
    pl.title('graph')
    pl.xlabel('feature 1')
    pl.ylabel('feature 2')
    pl.show()

    # 实例化模型
    model = SimpleNN()

    # 定义损失函数和优化器
    criterion = nn.BCELoss()  # 二元交叉熵损失
    optimizer = optim.SGD(model.parameters(), lr=0.1)  # 使用随机梯度下降优化器

    # 训练
    epochs = 100
    for epoch in range(epochs):
        # 前向传播
        outputs = model(data)
        loss = criterion(outputs, labels)

        # 反向传播
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        # 每 10 轮打印一次损失
        if (epoch + 1) % 10 == 0:
            print(f'Epoch [{epoch + 1}/{epochs}], Loss: {loss.item():.4f}')

    plot_decision_boundary(model, data)
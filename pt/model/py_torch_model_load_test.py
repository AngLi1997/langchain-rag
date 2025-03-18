import torch
import matplotlib.pyplot as plt
from torch import nn


class LinearRegressionModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.linear = nn.Linear(2, 1)
    def forward(self, x):
        return self.linear(x)

model = torch.load('model.pth', weights_only=False)
model.eval()

x = torch.arange(0.0, 100.0).unsqueeze(1).repeat(1,2)
print(x)

with torch.no_grad():
    predictions = model(x)
    plt.scatter(x[:, 0], predictions, c='red', label='predictions', marker='.')
    plt.show()
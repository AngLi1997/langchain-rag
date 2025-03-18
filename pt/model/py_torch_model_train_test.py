import torch
import matplotlib.pyplot as plt
from torch import nn, optim

torch.manual_seed(42)
# 标本
x = torch.randn(100, 2)
# 权重
k = torch.tensor([2.0, 3.0])
# 噪声
s = torch.randn(100) * 0.1
b = 4
y = x @ k + b + s
print(f'x={x[:5]}')
print(f'y={y[:5]}')


class LinearRegressionModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.linear = nn.Linear(2, 1)
    def forward(self, x):
        return self.linear(x)

model = LinearRegressionModel()
criterion = nn.MSELoss()
optimizer = optim.SGD(model.parameters(), lr=0.01)

num_epochs = 1000
for epoch in range(num_epochs):
    model.train()
    predictions = model.forward(x)
    loss = criterion(predictions.squeeze(), y)
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()
    if (epoch + 1) % 100 == 0:
        print(f'Epoch {epoch + 1}/{num_epochs}, Loss: {loss.item():.4f}')

print('Training finished!')

torch.save(model, "model.pth")

with torch.no_grad():
    predictions = model(x)
    plt.scatter(x[:, 0], y, c='blue')
    plt.scatter(x[:, 0], predictions, c='red')
    plt.show()

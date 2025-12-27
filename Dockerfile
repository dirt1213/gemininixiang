FROM python:3.10-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目文件
COPY . .

EXPOSE 8000

# 使用非root用户运行
RUN useradd --create-home --shell /bin/bash app && chown -R app:app /app
USER app

CMD ["python", "server.py"]

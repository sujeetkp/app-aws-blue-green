FROM python:3.8-alpine

RUN apk update && \
    apk add --no-cache gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev && \
    apk add --no-cache jpeg-dev zlib-dev && \
    apk add --no-cache postgresql-libs musl-dev postgresql-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt --no-cache-dir

COPY . .

RUN chmod +x start.sh

EXPOSE 5000

CMD ["./start.sh"]
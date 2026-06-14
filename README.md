Лабораторная работа: «Технология проектирования автоматизированных систем в защищённом исполнении»

Выполнил: Коровайко Дмитрий
Группа: 21-К-АС-1
Задание

Разработать защищённый веб-сервис на FastAPI, упаковать в Docker, развернуть в Яндекс Облаке (ВМ) и в локальном Minikube.
Результаты
1. GitHub репозиторий
[https://github.com/WorkKok/my_service/](https://github.com/WorkKok/my_service/)
2. Сервис в Яндекс Облаке

    Публичный IP: 89.169.137.105
    Порт: 80
    Ссылка для проверки: http://89.169.137.105

Сервис возвращает JSON с именем студента и группой.
3. Сервис в Minikube

    Локальный кластер запущен, поды в статусе Running.
    Доступ через kubectl port-forward на порт 80.


Скриншоты выполнения

Все скриншоты находятся в папке:
screenshots_lab

В папке содержится документ с процессов выполнения работы

Инструкция по развёртыванию
Требования

    Установленные:  Docker, Terraform, Minikube, kubectl, Python 3.13+.

1. Клонирование репозитория

git clone https://github.com/DAVID704456/my_service.git
cd my_service

## Локальный запуск
```bash
pip install -r requirements.txt
uvicorn src.app:app --reload
docker build -t my-service .
docker run -p 80:80 my-service
```
Terraform (Yandex Cloud)

    1. Установите Terraform.

    2. Заполните переменные, добавьте ключи авторизации

    3. terraform apply

Kubernetes (Minikube):

kubectl apply -f k8s/  

minikube service my-service -n my-app

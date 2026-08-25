__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "Проверить текстовые идентификаторы"
  },
  Setup_132685_SetupDesc = {
    Text = "Посмотрите, какие истории были переведены вручную для текущих языковых настроек."
  },
  Setup_132685_SetupTitle = {
    Text = "Отображение отметки для глав «Расследования» с официальным переводом"
  },
  Setup_134015_SetupTitle = {
    Text = "Изменить фоновую анимацию экрана входа"
  },
  Setup_148459_SetupDesc = {
    Text = "Когда Связь достигает 20 уровня, данный Пробуждённый демонстрирует особый внешний вид карты в боях «Расследования» или «Фазовой игры»."
  },
  Setup_148459_SetupTitle = {
    Text = "Эффект «Отсвет»"
  },
  Setup_18433_SetupTitle = {
    Text = "Текст игры"
  },
  Setup_18434_SetupTitle = {
    Text = "Сглаживание краёв"
  },
  Setup_18436_SetupTitle = {
    Text = "Точность рендеринга"
  },
  Setup_18438_SetupTitle = {
    Text = "Красно-синий сдвиг"
  },
  Setup_18439_SetupTitle = {
    Text = "Проекция"
  },
  Setup_18441_SetupTitle = {
    Text = "Линфеин заполнен"
  },
  Setup_18443_SetupTitle = {
    Text = "Вспышка безумия и Подтвердить ключевой приказ"
  },
  Setup_18444_SetupTitle = {
    Text = "Качество изображения"
  },
  Setup_18445_SetupTitle = {
    Text = "Глубина резкости"
  },
  Setup_18448_SetupTitle = {
    Text = "Сценический Эффект"
  },
  Setup_18449_SetupTitle = {
    Text = "Центра пользователей"
  },
  Setup_18453_SetupTitle = {Text = "Голос"},
  Setup_18454_SetupTitle = {
    Text = "Музыка"
  },
  Setup_18455_SetupTitle = {
    Text = "Делегирование Завершено"
  },
  Setup_18458_SetupTitle = {
    Text = "Свет в реальном времени"
  },
  Setup_18459_SetupTitle = {
    Text = "Звуковые эффекты"
  },
  Setup_18460_SetupTitle = {
    Text = "Пользовательское соглашение"
  },
  Setup_18461_SetupTitle = {
    Text = "Обрезка краев размытость"
  },
  Setup_18462_SetupTitle = {Text = "Объём"},
  Setup_18463_SetupTitle = {
    Text = "Код обмена"
  },
  Setup_18466_SetupTitle = {
    Text = "Качество эффектов"
  },
  Setup_18469_SetupDesc = {
    Text = "30 кадров в секунду более энергоэффективны, 60 кадров в секунду обеспечивают более плавное изображение."
  },
  Setup_18469_SetupTitle = {
    Text = "Целевая частота кадров"
  },
  Setup_21931_SetupTitle = {
    Text = "Свяжитесь с службой поддержки клиентов"
  },
  Setup_24952_SetupDesc = {
    Text = "Включить. Главный экран, экран расследовательской операции и другие будут реагировать на индукцию гравитации."
  },
  Setup_24952_SetupTitle = {
    Text = "Гироскоп"
  },
  Setup_54468_SetupTitle = {
    Text = "Настройки изображения"
  },
  Setup_54469_SetupTitle = {
    Text = "Разрешение"
  },
  Setup_54664_SetupTitle = {
    Text = "Показать горячие клавиши"
  },
  Setup_54673_SetupTitle = {
    Text = "Выбор карты из руки 8"
  },
  Setup_54674_SetupTitle = {
    Text = "Выбор карты из руки 9"
  },
  Setup_54675_SetupTitle = {
    Text = "Выбор карты из руки 2"
  },
  Setup_54676_SetupTitle = {
    Text = "Выбор 3 карты из руки"
  },
  Setup_54677_SetupTitle = {
    Text = "Освободить ключевой приказ"
  },
  Setup_54678_SetupTitle = {
    Text = "Выбор карты из руки 6"
  },
  Setup_54679_SetupTitle = {
    Text = "Сделайте выбор карты из руки 7"
  },
  Setup_54680_SetupTitle = {
    Text = "Выбор карты из руки 4"
  },
  Setup_54681_SetupTitle = {
    Text = "Выберите 5 карт из руки"
  },
  Setup_54682_SetupTitle = {
    Text = "Вспышка безумия 1"
  },
  Setup_54683_SetupTitle = {
    Text = "Вспышка безумия 2"
  },
  Setup_54684_SetupTitle = {
    Text = "Вспышка безумия III"
  },
  Setup_54685_SetupTitle = {
    Text = "Вспышка безумия 4"
  },
  Setup_54686_SetupTitle = {
    Text = "Посмотреть колоду вытягивания"
  },
  Setup_54687_SetupTitle = {
    Text = "Выбор карты из руки 20"
  },
  Setup_54688_SetupTitle = {
    Text = "Ход завершен"
  },
  Setup_54689_SetupTitle = {
    Text = "Выбор руки 1"
  },
  Setup_54690_SetupTitle = {
    Text = "Отмена и настройки"
  },
  Setup_54691_SetupTitle = {
    Text = "Активировать способность границы 1"
  },
  Setup_54692_SetupTitle = {
    Text = "Выбор карты из руки 10"
  },
  Setup_54693_SetupTitle = {
    Text = "Выбор карты из руки 11"
  },
  Setup_54694_SetupTitle = {
    Text = "Выбор карты из руки 12"
  },
  Setup_54695_SetupTitle = {
    Text = "Выбор карты из руки 13"
  },
  Setup_54696_SetupTitle = {
    Text = "Выбор карты из руки 14"
  },
  Setup_54697_SetupTitle = {
    Text = "Выбор карты из руки 15"
  },
  Setup_54698_SetupTitle = {
    Text = "Выбор карты из руки 16"
  },
  Setup_54699_SetupTitle = {
    Text = "Выбор карты 17 из руки"
  },
  Setup_54700_SetupTitle = {
    Text = "Выбор руки 18"
  },
  Setup_54701_SetupTitle = {
    Text = "Выбор карты из руки номер 19"
  },
  Setup_55509_SetupTitle = {
    Text = "Выйти из игры"
  },
  Setup_70541_SetupTitle = {
    Text = "Фоновое воспроизведение"
  },
  Setup_72153_SetupTitle = {
    Text = "Активировать способность границы 2"
  },
  Setup_94404_SetupTitle = {
    Text = "Подтверждение хода игры"
  },
  Setup_94405_SetupTitle = {
    Text = "Предыдущая Карта"
  },
  Setup_94406_SetupTitle = {
    Text = "Следующая Карта"
  },
  Setup_94566_SetupTitle = {
    Text = "Динамический фон битвы"
  }
})
return Text_Setup

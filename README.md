#  TapGame
[«Разработка под iOS. Начинаем»](https://www.youtube.com/watch?v=RR5o5ki0888&list=PLQC2_0cDcSKA0zy20X9c5rQKNg3rkSK7c&index=25)

# Оглавление
# <a href="#View">View guide</a>
## [UIView](#Uiview)
## [UIButton](#Uibutton)
## [UIStepper](#Uistepper)
# <a href="#Core">Core Guide</a>
## [Timer](#Timer)
# <a name="View"></a> View Guide

<a name="Uiview"></a>
## UIView
### Установить границы UIView
```swift 
gameView.layer.borderWidth = 1 
gameView.layer.borderColor = UIColor.gray.cgColor 
gameView.layer.cornerRadius = 5 
```
<p align="center">
  <img width=300 src="MDFiles/gameViewBorder.png">
</p>

<a name="Uibutton"></a>
## UIButton
### Установить заголовок UIButton
```swift
startButton.setTitle("Text", for: .normal)
```

<a name="Uistepper"></a>
## UIStepper
### Активировать/Деактивировать UIStepper
```swift
stepper.isEnabled = false // true
```

<a name="Timer"></a>
## Timer
### TimeInterval
TimeInterval - обертка над Double для временных интервалов
```swift
private var gameTimeLeft: TimeInterval = 0 
private var objectMovingTime: TimeInterval = 2
``` 

### Timer
Создание таймера
```swift
gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeTick), userInfo: nil, repeats: true)
```
Вызывает функцию timeTick каждую секунду до принудительной остановки
```
selector - для подключения функций с @objc
```

Остановка/Запуск таймера
```swift
objectTimer?.invalidate()
```

Сообщение таймеру о вызове target (принудительный вызов функции таймера)
```swift
objectTimer?.fire()
```

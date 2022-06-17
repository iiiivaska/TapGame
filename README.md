#  TapGame
[«Разработка под iOS. Начинаем»](https://www.youtube.com/watch?v=RR5o5ki0888&list=PLQC2_0cDcSKA0zy20X9c5rQKNg3rkSK7c&index=25)

# Оглавление
1. [View guide](#View)
	+ [UIView](#Uiview)
	+ [UIButton](#Uibutton)
	+ [UIStepper](#Uistepper)
	+ [NSLayoutConstraint (Перемещение объекта)](#NSLayoutConstraint)
	+ [Обработка нажатия](#GestureRecognizer)
	+ [Рисование](#Draw)
	+ [Annotations](#Annotations)
2. [Core Guide](#Core)
	+ [Timer](#Timer)

# <a name="View"></a> View Guide

<a name="Uiview"></a>
## UIView
### Установить рамку UIView
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

<a name="NSLayoutConstraint"></a>
## NSLayoutConstraint
### IBOutlet для constraints
```swift
@IBOutlet weak var shapeX: NSLayoutConstraint!
@IBOutlet weak var shapeY: NSLayoutConstraint!
```

### Frame vs Bounds
[Различие Frame и Bounds в iOS. Frame vs Bounds in iOS.](https://vmityuklyaev.medium.com/различие-frame-и-bounds-в-ios-frame-vs-bounds-in-ios-4e5aee5ed477) <br><br>
<b>Frame</b> - расположение и размер view с использованием системы координат родительского представления (важно для размещения представления в superview). <br>
<b>Bounds</b> - местоположение и размер представления с использованием его собственной системы координат (важно для размещения содержимого View или subview внутри него)
<p align="center">
  <img width=500 src="MDFiles/FrameVsBounds.png">
</p>

### Перемещение объекта
```swift
let maxX = gameView.bounds.maxX - gameObject.frame.width
let maxY = gameView.bounds.maxY - gameObject.frame.height
shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
```

<a name="GestureRecognizer"></a>
## Обработка нажатия
### UITapGestureRecognizer
Накладывается на объект UIView, чтобы стал активным необходимо установить свойство UserInterfaceEnabled объект в true, вызывается как IBAction.
```swift
@IBAction func objectTapped(_ sender: UITapGestureRecognizer) {
        if isGameActive {
            repositionImageWithTimer()
            score += 1
        }
    }
```

### touchesEnded
Переопределение метода в кастомном View
```swift
var shapeHitHandler: (() -> Void)? //Обработчик нажатия

//Обрабатывает нажатие если оно произошло внутри объекта
override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let curPath = curPath else { return }
        let hit = touches.contains(where: { touch -> Bool in
            let touchPoint = touch.location(in: self)
            return curPath.contains(touchPoint)
        })
        if hit {
            shapeHitHandler?()
        }
    }
```

<a name="Draw"></a>
## Рисование
### Отрисовка объекта
```swift
let path = UIBezierPath()
path.lineWidth = 0
path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
path.close()
path.stroke()
path.fill()
return path
```


<a name="Annotations"></a>
## Annotations
### @IBDesignable
Используется для кастомного View с целью отображения его в IB

### @IBInspectable
Используется в классе кастомного View на свойствах класса, для отображения в IB

# <a name="Core"></a>Core
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
gameTimer = Timer.scheduledTimer(timeInterval: 1,
				target: self, 
				selector: #selector(timeTick), 
				userInfo: nil, repeats: true)
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

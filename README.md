#  TapGame
[«Разработка под iOS. Начинаем»](https://www.youtube.com/watch?v=RR5o5ki0888&list=PLQC2_0cDcSKA0zy20X9c5rQKNg3rkSK7c&index=25)

# Оглавление
# <a href="#view">View guide</a>
## [UIView](#uiview)
## [UIButton](#uibutton)
## [UIStepper](#uistepper)

# <a name="view"></a>View Guide

## <a name="uiview"></a>UIView
### Установить границы UIView
```swift 
gameView.layer.borderWidth = 1 
gameView.layer.borderColor = UIColor.gray.cgColor 
gameView.layer.cornerRadius = 5 
```
<p align="center">
  <img width=300 src="MDFiles/gameViewBorder.png">
</p>

## <a name="uibutton"></a>UIButton
### Установить заголовок UIButton
```swift
startButton.setTitle("Text", for: .normal)
```

## <a name="uistepper"></a>UIStepper
### Активировать/Деактивировать UIStepper
```swift
stepper.isEnabled = false // true
```

#  TapGame
[«Разработка под iOS. Начинаем»](https://www.youtube.com/watch?v=RR5o5ki0888&list=PLQC2_0cDcSKA0zy20X9c5rQKNg3rkSK7c&index=25)

## Оглавление
## <a href="#view">View guide</a>
### <a href="#UIView">UIView</a>
### <a href="#UIButton">UIButton</a>
### <a href="#UIStepper">UIStepper</a>

<a name="view"></a>
# View Guide

<a name="UIView"></a>
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

<a name="UIButton"></a>
## UIButton
### Установить заголовок UIButton
```swift
startButton.setTitle("Text", for: .normal)
```

<a name="UIStepper"></a>
## UIStepper
### Активировать/Деактивировать UIStepper
```swift
stepper.isEnabled = false // true
```

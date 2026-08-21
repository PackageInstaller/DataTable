local ItemNumberType = {}
ItemNumberType.NONE = 0 --不显示数字
ItemNumberType.TOTLE = 1 --数字为传入的
ItemNumberType.BALANCE = 2  --数字为背包中剩余数量
ItemNumberType.FRACTION = 3 --分数形式，和BALACE很像，只是分母是自己传进去的
ItemNumberType.SPACE = 4 --间隔形式，两个按从左到右传进去的顺序显示从num1 - num2
return ItemNumberType
---自动生成代码----start----
local FirstRechargeDayItemView = BaseClass( 'FirstRechargeDayItemView' , BaseView )
local M = FirstRechargeDayItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item1 =   self:AddValue('','UI.View.Shop.FirstRechargeItemView','item1')  
  self.DayNum = self:AddBaseCom( GameUIText ,'DayNum')
  self.item2 =   self:AddValue('','UI.View.Shop.FirstRechargeItemView','item2')  
  self.RewardText = self:AddBaseCom( GameUIText ,'RewardText')


end

return FirstRechargeDayItemView
---自动生成代码----end----
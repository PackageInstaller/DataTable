---自动生成代码----start----
local FirstRechargeUIView = BaseClass( 'FirstRechargeUIView' , BaseView )
local M = FirstRechargeUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Content =   self._binder:GetValue('Content')  
  self.BtnRecharge = self:AddBaseCom( GameUIImage ,'BtnRecharge')
  self.BtnReward = self:AddBaseCom( GameUIImage ,'BtnReward')
  self.DayItem =   self:AddValue('','UI.View.Shop.FirstRechargeDayItemView','DayItem')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.BtnPlay = self:AddBaseCom( GameUIImage ,'BtnPlay')
  self.BtnHero = self:AddBaseCom( GameUIImage ,'BtnHero')


end

return FirstRechargeUIView
---自动生成代码----end----
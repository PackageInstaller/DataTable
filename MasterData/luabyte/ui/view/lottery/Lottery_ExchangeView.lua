---自动生成代码----start----
local Lottery_ExchangeView = BaseClass( 'Lottery_ExchangeView' , BaseView )
local M = Lottery_ExchangeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Item1 =   self:AddValue('UI.Ctrl.Lottery.Lottery_ExchangeCellCtrl','UI.View.Lottery.Lottery_ExchangeCellView','Item1')  
  self.Item2 =   self:AddValue('UI.Ctrl.Lottery.Lottery_ExchangeCellCtrl','UI.View.Lottery.Lottery_ExchangeCellView','Item2')  
  self.Item3 =   self:AddValue('UI.Ctrl.Lottery.Lottery_ExchangeCellCtrl','UI.View.Lottery.Lottery_ExchangeCellView','Item3')  
  self.goldNum = self:AddBaseCom( GameUIText ,'goldNum')
  self.tipStr = self:AddBaseCom( GameUIText ,'tipStr')
  self.enterBtn = self:AddBaseCom( GameUIImage ,'enterBtn')
  self.cancelBtn = self:AddBaseCom( GameUIImage ,'cancelBtn')
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.topCurrency1 =   self._binder:GetValue('topCurrency1')  
  self.topCurrency2 =   self._binder:GetValue('topCurrency2')  
  self.topCurrency3 =   self._binder:GetValue('topCurrency3')  
  self.topCurrency4 =   self._binder:GetValue('topCurrency4')  


end

return Lottery_ExchangeView
---自动生成代码----end----
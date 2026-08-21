---自动生成代码----start----
local UIDanceShopItemView = BaseClass( 'UIDanceShopItemView' , BaseView )
local M = UIDanceShopItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateQuality =   self._binder:GetValue('stateQuality')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labCanBuyNum = self:AddBaseCom( GameUIText ,'labCanBuyNum')
  self.ComItemSlipCtrl =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','ComItemSlipCtrl')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.stateSold =   self._binder:GetValue('stateSold')  
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')


end

return UIDanceShopItemView
---自动生成代码----end----
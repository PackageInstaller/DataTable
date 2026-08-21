---自动生成代码----start----
local UIUniverseShopItemView = BaseClass( 'UIUniverseShopItemView' , BaseView )
local M = UIUniverseShopItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stateQuality =   self._binder:GetValue('stateQuality')  
  self.imgIcon = self:AddBaseCom( GameUIImage ,'imgIcon')
  self.labCanBuyNum = self:AddBaseCom( GameUIText ,'labCanBuyNum')
  self.ComItemSlipCtrl =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','ComItemSlipCtrl')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.tfNull =   self._binder:GetValue('tfNull')  


end

return UIUniverseShopItemView
---自动生成代码----end----
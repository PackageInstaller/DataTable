---自动生成代码----start----
local ClothBuyPopupUIView = BaseClass( 'ClothBuyPopupUIView' , BaseView )
local M = ClothBuyPopupUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.cloth = self:AddBaseCom( GameRawImage ,'cloth')
  self.txtDes = self:AddBaseCom( GameUIText ,'txtDes')
  self.txtCost = self:AddBaseCom( GameUIText ,'txtCost')
  self.rectBuy =   self._binder:GetValue('rectBuy')  
  self.rectClose = self:AddBaseCom( GameUIImage ,'rectClose')
  self.rectCancel =   self._binder:GetValue('rectCancel')  
  self.iconCost = self:AddBaseCom( GameUIImage ,'iconCost')


end

return ClothBuyPopupUIView
---自动生成代码----end----
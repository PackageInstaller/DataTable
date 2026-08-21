---自动生成代码----start----
local CommodityView = BaseClass( 'CommodityView' , BaseView )
local M = CommodityView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ItemPfb =   self._binder:GetValue('ItemPfb')  
  self.NameText = self:AddBaseCom( GameUIText ,'NameText')
  self.BuyValueText = self:AddBaseCom( GameUIText ,'BuyValueText')
  self.CostText = self:AddBaseCom( GameUIText ,'CostText')
  self.DiscountText = self:AddBaseCom( GameUIText ,'DiscountText')
  self.SellOut =   self._binder:GetValue('SellOut')  
  self.Discount =   self._binder:GetValue('Discount')  
  self.Normal =   self._binder:GetValue('Normal')  
  self.CostIcon = self:AddBaseCom( GameUIImage ,'CostIcon')
  self.BtnImg = self:AddBaseCom( GameUIImage ,'BtnImg')
  self.ItemCanvasGroup =   self._binder:GetValue('ItemCanvasGroup')  
  self.redpoint =   self._binder:GetValue('redpoint')  
  self.Alreadyowned =   self._binder:GetValue('Alreadyowned')  


end

return CommodityView
---自动生成代码----end----
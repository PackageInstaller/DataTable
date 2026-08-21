---自动生成代码----start----
local ShopUIView = BaseClass( 'ShopUIView' , BaseView )
local M = ShopUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ShopTypeTab =   self._binder:GetValue('ShopTypeTab')  
  self.ShopTab =   self._binder:GetValue('ShopTab')  
  self.CountDownText = self:AddBaseCom( GameUIText ,'CountDownText')
  self.RefreshPart =   self._binder:GetValue('RefreshPart')  
  self.AutoRefreshPart =   self._binder:GetValue('AutoRefreshPart')  
  self.CommodityScrollView = self:AddBaseCom( CircularScrollView ,'CommodityScrollView')
  self.CommodityScrollRect =   self._binder:GetValue('CommodityScrollRect')  
  self.Content =   self._binder:GetValue('Content')  
  self.scrollRecharge = self:AddBaseCom( CircularScrollView ,'scrollRecharge')
  self.scrollGiftPack = self:AddBaseCom( LoopListView ,'scrollGiftPack')
  self.tabRecommennd =   self._binder:GetValue('tabRecommennd')  
  self.imgBanner = self:AddBaseCom( GameUIImage ,'imgBanner')
  self.ShopBagTab =   self._binder:GetValue('ShopBagTab')  
  self.scrollCloth = self:AddBaseCom( LoopListView ,'scrollCloth')


end

return ShopUIView
---自动生成代码----end----
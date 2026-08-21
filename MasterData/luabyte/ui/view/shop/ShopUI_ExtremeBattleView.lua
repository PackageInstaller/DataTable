---自动生成代码----start----
local ShopUI_ExtremeBattleView = BaseClass( 'ShopUI_ExtremeBattleView' , BaseView )
local M = ShopUI_ExtremeBattleView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ShopTab =   self._binder:GetValue('ShopTab')  
  self.CountDownText = self:AddBaseCom( GameUIText ,'CountDownText')
  self.RefreshPart =   self._binder:GetValue('RefreshPart')  
  self.AutoRefreshPart =   self._binder:GetValue('AutoRefreshPart')  
  self.CommodityScrollView = self:AddBaseCom( CircularScrollView ,'CommodityScrollView')
  self.CommodityScrollRect =   self._binder:GetValue('CommodityScrollRect')  
  self.Content =   self._binder:GetValue('Content')  
  self.BackBtn = self:AddBaseCom( GameUIImage ,'BackBtn')


end

return ShopUI_ExtremeBattleView
---自动生成代码----end----
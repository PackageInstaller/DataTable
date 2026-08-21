---自动生成代码----start----
local UIVotingShopItemView = BaseClass( 'UIVotingShopItemView' , BaseView )
local M = UIVotingShopItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imageCost = self:AddBaseCom( GameUIImage ,'imageCost')
  self.textCostNum = self:AddBaseCom( GameUIText ,'textCostNum')
  self.imageIcom = self:AddBaseCom( GameUIImage ,'imageIcom')
  self.btnBuy = self:AddBaseCom( UIButton ,'btnBuy')
  self.textCanBuy = self:AddBaseCom( GameUIText ,'textCanBuy')
  self.tfNormal =   self._binder:GetValue('tfNormal')  
  self.tfSellout =   self._binder:GetValue('tfSellout')  
  self.ItemPfbMid =   self._binder:GetValue('ItemPfbMid')  
  self.ItemPfbUI =   self._binder:GetValue('ItemPfbUI')  


end

return UIVotingShopItemView
---自动生成代码----end----
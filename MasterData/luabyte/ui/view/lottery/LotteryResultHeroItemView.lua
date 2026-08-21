---自动生成代码----start----
local LotteryResultHeroItemView = BaseClass( 'LotteryResultHeroItemView' , BaseView )
local M = LotteryResultHeroItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rimg_roleIcon = self:AddBaseCom( GameUIImage ,'rimg_roleIcon')
  self.img_quality = self:AddBaseCom( GameUIImage ,'img_quality')
  self.trans_star0 = self:AddBaseCom( GameUIImage ,'trans_star0')
  self.trans_star1 = self:AddBaseCom( GameUIImage ,'trans_star1')
  self.trans_star2 = self:AddBaseCom( GameUIImage ,'trans_star2')
  self.trans_star3 = self:AddBaseCom( GameUIImage ,'trans_star3')
  self.trans_star4 = self:AddBaseCom( GameUIImage ,'trans_star4')
  self.img_proIcon = self:AddBaseCom( GameUIImage ,'img_proIcon')
  self.iconItem_Item =   self._binder:GetValue('iconItem_Item')  
  self.EffectPanel =   self._binder:GetValue('EffectPanel')  
  self.New =   self._binder:GetValue('New')  


end

return LotteryResultHeroItemView
---自动生成代码----end----
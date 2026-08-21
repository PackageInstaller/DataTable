---自动生成代码----start----
local MissionOfferRewardsItemView = BaseClass( 'MissionOfferRewardsItemView' , BaseView )
local M = MissionOfferRewardsItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_exp = self:AddBaseCom( GameUIText ,'txt_exp')
  self.tglState =   self._binder:GetValue('tglState')  
  self.txt_desc = self:AddBaseCom( EmojiText ,'txt_desc')


end

return MissionOfferRewardsItemView
---自动生成代码----end----
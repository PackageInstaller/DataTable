---自动生成代码----start----
local BossWarAwardItemView = BaseClass( 'BossWarAwardItemView' , BaseView )
local M = BossWarAwardItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.img_head = self:AddBaseCom( GameUIImage ,'img_head')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_lNum = self:AddBaseCom( GameUIText ,'txt_lNum')
  self.txt_rNum = self:AddBaseCom( GameUIText ,'txt_rNum')
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.uiState =   self._binder:GetValue('uiState')  


end

return BossWarAwardItemView
---自动生成代码----end----
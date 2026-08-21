---自动生成代码----start----
local BossWarWordsItemView = BaseClass( 'BossWarWordsItemView' , BaseView )
local M = BossWarWordsItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.slot1 =   self._binder:GetValue('slot1')  
  self.slot2 =   self._binder:GetValue('slot2')  
  self.slot3 =   self._binder:GetValue('slot3')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')


end

return BossWarWordsItemView
---自动生成代码----end----
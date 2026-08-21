---自动生成代码----start----
local OtakuSynthesisItemView = BaseClass( 'OtakuSynthesisItemView' , BaseView )
local M = OtakuSynthesisItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_lockTip = self:AddBaseCom( GameUIText ,'txt_lockTip')


end

return OtakuSynthesisItemView
---自动生成代码----end----
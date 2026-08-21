---自动生成代码----start----
local OtakuManufacturingItemView = BaseClass( 'OtakuManufacturingItemView' , BaseView )
local M = OtakuManufacturingItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.txt_lockTip = self:AddBaseCom( GameUIText ,'txt_lockTip')
  self.txt_time = self:AddBaseCom( GameUIText ,'txt_time')


end

return OtakuManufacturingItemView
---自动生成代码----end----
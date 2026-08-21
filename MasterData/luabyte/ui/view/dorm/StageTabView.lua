---自动生成代码----start----
local StageTabView = BaseClass( 'StageTabView' , BaseView )
local M = StageTabView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Text1 = self:AddBaseCom( GameUIText ,'Text1')
  self.Text2 = self:AddBaseCom( GameUIText ,'Text2')
  self.Text3 = self:AddBaseCom( GameUIText ,'Text3')
  self.uiState =   self._binder:GetValue('uiState')  


end

return StageTabView
---自动生成代码----end----
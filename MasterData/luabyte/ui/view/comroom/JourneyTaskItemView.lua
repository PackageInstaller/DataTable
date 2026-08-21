---自动生成代码----start----
local JourneyTaskItemView = BaseClass( 'JourneyTaskItemView' , BaseView )
local M = JourneyTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.first =   self._binder:GetValue('first')  
  self.uiState =   self._binder:GetValue('uiState')  


end

return JourneyTaskItemView
---自动生成代码----end----
---自动生成代码----start----
local DormPersonalEventMainUIView = BaseClass( 'DormPersonalEventMainUIView' , BaseView )
local M = DormPersonalEventMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.node_tabs =   self._binder:GetValue('node_tabs')  
  self.node_panel =   self._binder:GetValue('node_panel')  


end

return DormPersonalEventMainUIView
---自动生成代码----end----
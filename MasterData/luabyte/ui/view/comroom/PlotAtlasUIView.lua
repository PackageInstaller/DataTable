---自动生成代码----start----
local PlotAtlasUIView = BaseClass( 'PlotAtlasUIView' , BaseView )
local M = PlotAtlasUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.node_list =   self._binder:GetValue('node_list')  


end

return PlotAtlasUIView
---自动生成代码----end----
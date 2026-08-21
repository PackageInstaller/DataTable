---自动生成代码----start----
local PlotAtlasDrawAttrItemView = BaseClass( 'PlotAtlasDrawAttrItemView' , BaseView )
local M = PlotAtlasDrawAttrItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_back =   self._binder:GetValue('node_back')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')


end

return PlotAtlasDrawAttrItemView
---自动生成代码----end----
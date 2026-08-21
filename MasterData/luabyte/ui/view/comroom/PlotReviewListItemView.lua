---自动生成代码----start----
local PlotReviewListItemView = BaseClass( 'PlotReviewListItemView' , BaseView )
local M = PlotReviewListItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.node_lock =   self._binder:GetValue('node_lock')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return PlotReviewListItemView
---自动生成代码----end----
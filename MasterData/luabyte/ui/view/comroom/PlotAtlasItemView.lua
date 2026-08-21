---自动生成代码----start----
local PlotAtlasItemView = BaseClass( 'PlotAtlasItemView' , BaseView )
local M = PlotAtlasItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_role = self:AddBaseCom( GameRawImage ,'img_role')
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.txt_chName = self:AddBaseCom( GameUIText ,'txt_chName')
  self.txt_enName = self:AddBaseCom( GameUIText ,'txt_enName')
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.redPoint =   self._binder:GetValue('redPoint')  


end

return PlotAtlasItemView
---自动生成代码----end----
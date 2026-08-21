---自动生成代码----start----
local WordShowUIView = BaseClass( 'WordShowUIView' , BaseView )
local M = WordShowUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_close = self:AddBaseCom( GameUIImage ,'img_close')
  self.WordInfoRoot =   self._binder:GetValue('WordInfoRoot')  
  self.UIState =   self._binder:GetValue('UIState')  


end

return WordShowUIView
---自动生成代码----end----
---自动生成代码----start----
local ComPopupEventTipsView = BaseClass( 'ComPopupEventTipsView' , BaseView )
local M = ComPopupEventTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_content =   self._binder:GetValue('node_content')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')


end

return ComPopupEventTipsView
---自动生成代码----end----
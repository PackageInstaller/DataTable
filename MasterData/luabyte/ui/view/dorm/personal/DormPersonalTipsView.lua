---自动生成代码----start----
local DormPersonalTipsView = BaseClass( 'DormPersonalTipsView' , BaseView )
local M = DormPersonalTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_enter =   self._binder:GetValue('btn_enter')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')


end

return DormPersonalTipsView
---自动生成代码----end----
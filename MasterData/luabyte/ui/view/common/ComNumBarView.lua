---自动生成代码----start----
local ComNumBarView = BaseClass( 'ComNumBarView' , BaseView )
local M = ComNumBarView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_plus =   self._binder:GetValue('btn_plus')  
  self.btn_minus =   self._binder:GetValue('btn_minus')  
  self.btn_min =   self._binder:GetValue('btn_min')  
  self.btn_max =   self._binder:GetValue('btn_max')  
  self.txt_number = self:AddBaseCom( GameUIText ,'txt_number')


end

return ComNumBarView
---自动生成代码----end----
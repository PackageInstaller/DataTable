---自动生成代码----start----
local SetAccountView = BaseClass( 'SetAccountView' , BaseView )
local M = SetAccountView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_uid = self:AddBaseCom( GameUIText ,'txt_uid')
  self.txt_date = self:AddBaseCom( GameUIText ,'txt_date')
  self.btn_copy =   self._binder:GetValue('btn_copy')  
  self.bind =   self._binder:GetValue('bind')  
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.ani =   self._binder:GetValue('ani')  
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.bindUID =   self._binder:GetValue('bindUID')  
  self.channelArea =   self._binder:GetValue('channelArea')  


end

return SetAccountView
---自动生成代码----end----
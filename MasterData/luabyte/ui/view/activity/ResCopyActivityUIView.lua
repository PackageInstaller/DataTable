---自动生成代码----start----
local ResCopyActivityUIView = BaseClass( 'ResCopyActivityUIView' , BaseView )
local M = ResCopyActivityUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( CircularScrollView ,'looplist')
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_count = self:AddBaseCom( GameUIText ,'txt_count')
  self.txt_actTime = self:AddBaseCom( GameUIText ,'txt_actTime')
  self.txt_timer =   self._binder:GetValue('txt_timer')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')


end

return ResCopyActivityUIView
---自动生成代码----end----
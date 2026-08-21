---自动生成代码----start----
local ShareUIView = BaseClass( 'ShareUIView' , BaseView )
local M = ShareUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.img_picture = self:AddBaseCom( GameRawImage ,'img_picture')
  self.btn_save =   self._binder:GetValue('btn_save')  
  self.btn_wechat =   self._binder:GetValue('btn_wechat')  
  self.btn_wechatMoments =   self._binder:GetValue('btn_wechatMoments')  
  self.btn_qq =   self._binder:GetValue('btn_qq')  
  self.btn_qzone =   self._binder:GetValue('btn_qzone')  
  self.btn_sinaweibo =   self._binder:GetValue('btn_sinaweibo')  


end

return ShareUIView
---自动生成代码----end----
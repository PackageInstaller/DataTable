---自动生成代码----start----
local ComPopupItemUseView = BaseClass( 'ComPopupItemUseView' , BaseView )
local M = ComPopupItemUseView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_holdNum = self:AddBaseCom( GameUIText ,'txt_holdNum')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.btn_cancle =   self._binder:GetValue('btn_cancle')  
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_tips =   self._binder:GetValue('btn_tips')  
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  
  self.limitTips =   self._binder:GetValue('limitTips')  
  self.txt_limitValue = self:AddBaseCom( GameUIText ,'txt_limitValue')


end

return ComPopupItemUseView
---自动生成代码----end----
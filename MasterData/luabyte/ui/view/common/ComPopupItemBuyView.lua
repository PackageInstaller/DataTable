---自动生成代码----start----
local ComPopupItemBuyView = BaseClass( 'ComPopupItemBuyView' , BaseView )
local M = ComPopupItemBuyView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_cost = self:AddBaseCom( GameUIText ,'txt_cost')
  self.txt_useNum = self:AddBaseCom( GameUIText ,'txt_useNum')
  self.txt_maxNum = self:AddBaseCom( GameUIText ,'txt_maxNum')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.btn_minus =   self._binder:GetValue('btn_minus')  
  self.btn_plus =   self._binder:GetValue('btn_plus')  
  self.btn_cancle =   self._binder:GetValue('btn_cancle')  
  self.btn_confirm =   self._binder:GetValue('btn_confirm')  
  self.btn_tips =   self._binder:GetValue('btn_tips')  
  self.node_slider = self:AddBaseCom( UISlider ,'node_slider')
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.txt_minNum = self:AddBaseCom( GameUIText ,'txt_minNum')
  self.img_cost = self:AddBaseCom( GameUIImage ,'img_cost')
  self.txt_remain = self:AddBaseCom( GameUIText ,'txt_remain')
  self.img_huobi = self:AddBaseCom( GameUIImage ,'img_huobi')
  self.PropertyBar =   self._binder:GetValue('PropertyBar')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.txt_not = self:AddBaseCom( GameUIText ,'txt_not')
  self.BtnReduce =   self._binder:GetValue('BtnReduce')  
  self.BtnAdd =   self._binder:GetValue('BtnAdd')  
  self.txt_des = self:AddBaseCom( GameUIText ,'txt_des')


end

return ComPopupItemBuyView
---自动生成代码----end----
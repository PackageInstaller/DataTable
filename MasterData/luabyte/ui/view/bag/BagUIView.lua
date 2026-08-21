---自动生成代码----start----
local BagUIView = BaseClass( 'BagUIView' , BaseView )
local M = BagUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectState =   self:AddValue('UI.Ctrl.Bag.BagSelectAreaUICtrl','UI.View.Bag.BagSelectAreaUI','selectState')  
  self.normalState =   self:AddValue('UI.Ctrl.Bag.BagNormalStateUICtrl','UI.View.Bag.BagNormalStateUI','normalState')  
  self.gridScroll = self:AddBaseCom( CircularScrollView ,'gridScroll')
  self.filter =   self._binder:GetValue('filter')  
  self.empty =   self._binder:GetValue('empty')  
  self.group =   self._binder:GetValue('group')  
  self.descState =   self._binder:GetValue('descState')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_num = self:AddBaseCom( GameUIText ,'txt_num')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.btn_get =   self._binder:GetValue('btn_get')  
  self.btn_use =   self._binder:GetValue('btn_use')  
  self.node_n =   self._binder:GetValue('node_n')  
  self.node_r =   self._binder:GetValue('node_r')  
  self.node_sr =   self._binder:GetValue('node_sr')  
  self.node_ssr =   self._binder:GetValue('node_ssr')  
  self.btn_decomp =   self._binder:GetValue('btn_decomp')  
  self.tfTimer =   self._binder:GetValue('tfTimer')  
  self.labTimer = self:AddBaseCom( GameUIText ,'labTimer')
  self.Atmosphere =   self._binder:GetValue('Atmosphere')  
  self.AtmosphereNum = self:AddBaseCom( GameUIText ,'AtmosphereNum')


end

return BagUIView
---自动生成代码----end----
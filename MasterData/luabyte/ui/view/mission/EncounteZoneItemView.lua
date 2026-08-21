---自动生成代码----start----
local EncounteZoneItemView = BaseClass( 'EncounteZoneItemView' , BaseView )
local M = EncounteZoneItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_zoneIcon = self:AddBaseCom( GameUIImage ,'img_zoneIcon')
  self.txt_cnName = self:AddBaseCom( GameUIText ,'txt_cnName')
  self.node_pass =   self._binder:GetValue('node_pass')  
  self.node_proc =   self._binder:GetValue('node_proc')  
  self.node_leftOff =   self._binder:GetValue('node_leftOff')  
  self.node_leftOn =   self._binder:GetValue('node_leftOn')  
  self.node_rightOff =   self._binder:GetValue('node_rightOff')  
  self.node_rightOn =   self._binder:GetValue('node_rightOn')  
  self.trans_lock =   self._binder:GetValue('trans_lock')  
  self.state_diffcult =   self._binder:GetValue('state_diffcult')  
  self.state_unlock =   self._binder:GetValue('state_unlock')  
  self.tf_remainTime =   self._binder:GetValue('tf_remainTime')  


end

return EncounteZoneItemView
---自动生成代码----end----
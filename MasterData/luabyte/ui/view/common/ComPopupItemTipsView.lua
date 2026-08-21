---自动生成代码----start----
local ComPopupItemTipsView = BaseClass( 'ComPopupItemTipsView' , BaseView )
local M = ComPopupItemTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_n = self:AddBaseCom( GameUIImage ,'node_n')
  self.node_r = self:AddBaseCom( GameUIImage ,'node_r')
  self.node_sr = self:AddBaseCom( GameUIImage ,'node_sr')
  self.node_ssr = self:AddBaseCom( GameUIImage ,'node_ssr')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.node_more =   self._binder:GetValue('node_more')  
  self.node_less =   self._binder:GetValue('node_less')  
  self.node_line =   self._binder:GetValue('node_line')  
  self.node_moreItem =   self:AddValue('','UI.View.UIItemEquip.UIItemGetView','node_moreItem')  
  self.node_lessItem =   self:AddValue('','UI.View.UIItemEquip.UIItemGetView','node_lessItem')  
  self.txt_holdNum = self:AddBaseCom( GameUIText ,'txt_holdNum')
  self.node_content =   self._binder:GetValue('node_content')  
  self.btn_mask =   self._binder:GetValue('btn_mask')  


end

return ComPopupItemTipsView
---自动生成代码----end----
---自动生成代码----start----
local NewRoleBaseInfoView = BaseClass( 'NewRoleBaseInfoView' , BaseView )
local M = NewRoleBaseInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rareImg = self:AddBaseCom( GameUIImage ,'rareImg')
  self.proImg = self:AddBaseCom( GameUIImage ,'proImg')
  self.chName = self:AddBaseCom( GameUIText ,'chName')
  self.curLv = self:AddBaseCom( GameUIText ,'curLv')
  self.limitLv = self:AddBaseCom( GameUIText ,'limitLv')
  self.btnLv =   self._binder:GetValue('btnLv')  
  self.infoBtn =   self._binder:GetValue('infoBtn')  
  self.m_animator =   self._binder:GetValue('m_animator')  
  self.Attr1 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr1')  
  self.Attr2 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr2')  
  self.Attr3 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr3')  
  self.Attr4 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr4')  
  self.Attr5 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr5')  
  self.Attr8 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr8')  
  self.Attr6 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr6')  
  self.Attr7 =   self:AddValue('UI.Ctrl.RoleDevelop.AttrCtrl','UI.View.RoleDevelop.AttrView','Attr7')  
  self.upRedPoint =   self._binder:GetValue('upRedPoint')  
  self.UIHeroSpecialtyCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.UIHeroSpecialtyCtrl','UI.View.RoleDevelop.UIHeroSpecialtyView','UIHeroSpecialtyCtrl')  
  self.tfLvUp =   self._binder:GetValue('tfLvUp')  


end

return NewRoleBaseInfoView
---自动生成代码----end----
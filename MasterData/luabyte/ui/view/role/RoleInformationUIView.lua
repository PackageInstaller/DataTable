---自动生成代码----start----
local RoleInformationUIView = BaseClass( 'RoleInformationUIView' , BaseView )
local M = RoleInformationUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.baseInfo =   self:AddValue('UI.Ctrl.RoleDevelop.RoleBaseInfoUICtrl','UI.View.RoleDevelop.RoleBaseInfoView','baseInfo')  
  self.skillTitle =   self:AddValue('','UI.View.Role.RoleSkillTitleView','skillTitle')  
  self.skillItem =   self:AddValue('','UI.View.Role.RoleSkillItemAreaView','skillItem')  
  self.skillLife =   self:AddValue('','UI.View.Role.RoleLifeSkillItemView','skillLife')  
  self.img_normal = self:AddBaseCom( GameRawImage ,'img_normal')
  self.img_awake = self:AddBaseCom( GameRawImage ,'img_awake')
  self.skillContent =   self._binder:GetValue('skillContent')  
  self.node_normal =   self._binder:GetValue('node_normal')  
  self.node_awake =   self._binder:GetValue('node_awake')  
  self.img_normalBg = self:AddBaseCom( GameRawImage ,'img_normalBg')
  self.img_awakeBg = self:AddBaseCom( GameRawImage ,'img_awakeBg')
  self.txt_costTitle = self:AddBaseCom( GameUIText ,'txt_costTitle')
  self.closeBtn =   self._binder:GetValue('closeBtn')  


end

return RoleInformationUIView
---自动生成代码----end----
---自动生成代码----start----
local RoleAwakeShowView = BaseClass( 'RoleAwakeShowView' , BaseView )
local M = RoleAwakeShowView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.CloseBg =   self._binder:GetValue('CloseBg')  
  self.roleMask2 = self:AddBaseCom( GameRawImage ,'roleMask2')
  self.head = self:AddBaseCom( GameRawImage ,'head')
  self.closeEye = self:AddBaseCom( GameUIImage ,'closeEye')
  self.openEye = self:AddBaseCom( GameUIImage ,'openEye')
  self.roleIllustration = self:AddBaseCom( GameRawImage ,'roleIllustration')
  self.text1 = self:AddBaseCom( GameUIImage ,'text1')
  self.text2 = self:AddBaseCom( GameUIImage ,'text2')
  self.titleBgShadow = self:AddBaseCom( GameUIImage ,'titleBgShadow')
  self.engName = self:AddBaseCom( GameUIText ,'engName')
  self.roleMask1 = self:AddBaseCom( GameRawImage ,'roleMask1')
  self.illustrationImage = self:AddBaseCom( GameRawImage ,'illustrationImage')


end

return RoleAwakeShowView
---自动生成代码----end----
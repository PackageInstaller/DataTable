---自动生成代码----start----
local BaseFriendItemView = BaseClass( 'BaseFriendItemView' , BaseView )
local M = BaseFriendItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.headIcon = self:AddBaseCom( GameUIImage ,'headIcon')
  self.levelText = self:AddBaseCom( GameUIText ,'levelText')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.olineState =   self._binder:GetValue('olineState')  
  self.pastState =   self._binder:GetValue('pastState')  
  self.applyBtns =   self._binder:GetValue('applyBtns')  
  self.noBtn =   self._binder:GetValue('noBtn')  
  self.yesBtn =   self._binder:GetValue('yesBtn')  
  self.addBtn =   self._binder:GetValue('addBtn')  
  self.heroItem1 =   self._binder:GetValue('heroItem1')  
  self.heroItem2 =   self._binder:GetValue('heroItem2')  
  self.heroItem3 =   self._binder:GetValue('heroItem3')  
  self.heroItem4 =   self._binder:GetValue('heroItem4')  
  self.heroItem5 =   self._binder:GetValue('heroItem5')  
  self.openInfo =   self._binder:GetValue('openInfo')  
  self.pastText = self:AddBaseCom( GameUIText ,'pastText')


end

return BaseFriendItemView
---自动生成代码----end----
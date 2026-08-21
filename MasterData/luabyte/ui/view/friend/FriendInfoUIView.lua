---自动生成代码----start----
local FriendInfoUIView = BaseClass( 'FriendInfoUIView' , BaseView )
local M = FriendInfoUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uidText = self:AddBaseCom( GameUIText ,'uidText')
  self.copyBtn =   self._binder:GetValue('copyBtn')  
  self.roleIcon = self:AddBaseCom( GameRawImage ,'roleIcon')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.playerNameText = self:AddBaseCom( GameUIText ,'playerNameText')
  self.levelText = self:AddBaseCom( GameUIText ,'levelText')
  self.mainText = self:AddBaseCom( GameUIText ,'mainText')
  self.aceText = self:AddBaseCom( GameUIText ,'aceText')
  self.heroItem1 =   self._binder:GetValue('heroItem1')  
  self.heroItem2 =   self._binder:GetValue('heroItem2')  
  self.heroItem3 =   self._binder:GetValue('heroItem3')  
  self.heroItem4 =   self._binder:GetValue('heroItem4')  
  self.heroItem5 =   self._binder:GetValue('heroItem5')  
  self.deleteBtn =   self._binder:GetValue('deleteBtn')  
  self.inputField = self:AddBaseCom( UIInput ,'inputField')
  self.backBtn =   self._binder:GetValue('backBtn')  
  self.headIcon = self:AddBaseCom( GameUIImage ,'headIcon')
  self.reward =   self:AddValue('UI.Ctrl.Friend.AchievementBoxCtrl','UI.View.Friend.AchievementBoxView','reward')  
  self.stateFri =   self._binder:GetValue('stateFri')  
  self.btnAdd = self:AddBaseCom( UIButton ,'btnAdd')


end

return FriendInfoUIView
---自动生成代码----end----
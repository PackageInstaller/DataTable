---自动生成代码----start----
local PageMyInfoView = BaseClass( 'PageMyInfoView' , BaseView )
local M = PageMyInfoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uidText = self:AddBaseCom( GameUIText ,'uidText')
  self.copyBtn =   self._binder:GetValue('copyBtn')  
  self.headIcon = self:AddBaseCom( GameUIImage ,'headIcon')
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.levelText = self:AddBaseCom( GameUIText ,'levelText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.heroNumText = self:AddBaseCom( GameUIText ,'heroNumText')
  self.mimssionText = self:AddBaseCom( GameUIText ,'mimssionText')
  self.roleIcon = self:AddBaseCom( GameRawImage ,'roleIcon')
  self.reward =   self:AddValue('UI.Ctrl.Friend.AchievementBoxCtrl','UI.View.Friend.AchievementBoxView','reward')  
  self.PlayerHead =   self._binder:GetValue('PlayerHead')  
  self.roleFashionIcon = self:AddBaseCom( GameRawImage ,'roleFashionIcon')


end

return PageMyInfoView
---自动生成代码----end----
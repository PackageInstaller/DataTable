---自动生成代码----start----
local GamesBeeBattleUIView = BaseClass( 'GamesBeeBattleUIView' , BaseView )
local M = GamesBeeBattleUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.bees =   self:AddValue('','UI.View.Games.Bee.BeeMonstersView','bees')  
  self.battle =   self._binder:GetValue('battle')  
  self.base =   self._binder:GetValue('base')  
  self.plane =   self._binder:GetValue('plane')  
  self.bee1 =   self._binder:GetValue('bee1')  
  self.bullet =   self._binder:GetValue('bullet')  
  self.backBtn =   self._binder:GetValue('backBtn')  
  self.bee2 =   self._binder:GetValue('bee2')  
  self.scoreText = self:AddBaseCom( GameUIText ,'scoreText')
  self.animator =   self._binder:GetValue('animator')  
  self.emoji =   self:AddValue('','UI.View.Games.Emoji.RoleImageEmojiView','emoji')  
  self.bgAnimator =   self._binder:GetValue('bgAnimator')  


end

return GamesBeeBattleUIView
---自动生成代码----end----
---自动生成代码----start----
local BattleResultView = BaseClass( 'BattleResultView' , BaseView )
local M = BattleResultView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.victory =   self._binder:GetValue('victory')  
  self.fail =   self._binder:GetValue('fail')  
  self.jumpItem =   self:AddValue('','UI.View.Battle.BattleResultItemView','jumpItem')  
  self.jumpContent =   self._binder:GetValue('jumpContent')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.failText = self:AddBaseCom( GameUIText ,'failText')
  self.failUiState =   self._binder:GetValue('failUiState')  
  self.LevelItem =   self:AddValue('','UI.View.Battle.BattleResultFailAttrView','LevelItem')  
  self.SkillLevelItem =   self:AddValue('','UI.View.Battle.BattleResultFailAttrView','SkillLevelItem')  
  self.AiLevelItem =   self:AddValue('','UI.View.Battle.BattleResultFailAttrView','AiLevelItem')  
  self.victoryAnim =   self._binder:GetValue('victoryAnim')  
  self.failAnima =   self._binder:GetValue('failAnima')  


end

return BattleResultView
---自动生成代码----end----
---自动生成代码----start----
local DailyGoalsView = BaseClass( 'DailyGoalsView' , BaseView )
local M = DailyGoalsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tabCtrl =   self:AddValue('UI.Ctrl.Activity.DailyGoals.DailyGoalsTableCtrl','UI.View.Activity.DailyGoals.DailyGoalsTableView','tabCtrl')  
  self.timeCtrl =   self:AddValue('UI.Ctrl.Activity.DailyGoals.DailyGoalsTimeCtrl','UI.View.Activity.DailyGoals.DailyGoalsTimeView','timeCtrl')  
  self.taskCtrl =   self:AddValue('UI.Ctrl.Activity.DailyGoals.DailyGoalsTaskListCtrl','UI.View.Activity.DailyGoals.DailyGoalsTaskListView','taskCtrl')  
  self.dayCtrl =   self:AddValue('UI.Ctrl.Activity.DailyGoals.DailyGoalsDayRewardCtrl','UI.View.Activity.DailyGoals.DailyGoalsDayRewardView','dayCtrl')  
  self.scoreCtrl =   self:AddValue('UI.Ctrl.Activity.DailyGoals.DailyGoalsScoreCtrl','UI.View.Activity.DailyGoals.DailyGoalsScoreView','scoreCtrl')  
  self.allBtn =   self._binder:GetValue('allBtn')  
  self.allState =   self._binder:GetValue('allState')  


end

return DailyGoalsView
---自动生成代码----end----
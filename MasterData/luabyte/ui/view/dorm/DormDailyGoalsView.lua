---自动生成代码----start----
local DormDailyGoalsView = BaseClass( 'DormDailyGoalsView' , BaseView )
local M = DormDailyGoalsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tabCtrl =   self:AddValue('UI.Ctrl.Dorm.DormDailyGoalsTableCtrl','UI.View.Dorm.DormDailyGoalsTableView','tabCtrl')  
  self.taskCtrl =   self:AddValue('UI.Ctrl.Dorm.DormDailyGoalsTaskListCtrl','UI.View.Dorm.DormDailyGoalsTaskListView','taskCtrl')  
  self.dayCtrl =   self:AddValue('UI.Ctrl.Dorm.DormDailyGoalsDayRewardCtrl','UI.View.Dorm.DormDailyGoalsDayRewardView','dayCtrl')  
  self.videoCtrl =   self:AddValue('UI.Ctrl.Dorm.DormDailyGoalsVideoCtrl','UI.View.Dorm.DormDailyGoalsVideoView','videoCtrl')  


end

return DormDailyGoalsView
---自动生成代码----end----
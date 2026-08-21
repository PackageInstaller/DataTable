---自动生成代码----start----
local DormDailyGoalsTaskListView = BaseClass( 'DormDailyGoalsTaskListView' , BaseView )
local M = DormDailyGoalsTaskListView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.parent =   self._binder:GetValue('parent')  
  self.item =   self:AddValue('','UI.View.Dorm.DormDailyGoalsTaskItemView','item')  


end

return DormDailyGoalsTaskListView
---自动生成代码----end----
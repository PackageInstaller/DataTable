---自动生成代码----start----
local DailyGoalsTimeView = BaseClass( 'DailyGoalsTimeView' , BaseView )
local M = DailyGoalsTimeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.timeText = self:AddBaseCom( GameUIText ,'timeText')


end

return DailyGoalsTimeView
---自动生成代码----end----
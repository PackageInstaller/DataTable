---自动生成代码----start----
local UITurntableTaskView = BaseClass( 'UITurntableTaskView' , BaseView )
local M = UITurntableTaskView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')


end

return UITurntableTaskView
---自动生成代码----end----
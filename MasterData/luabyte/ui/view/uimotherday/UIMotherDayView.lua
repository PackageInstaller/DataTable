---自动生成代码----start----
local UIMotherDayView = BaseClass( 'UIMotherDayView' , BaseView )
local M = UIMotherDayView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.timeLabel = self:AddBaseCom( GameUIText ,'timeLabel')
  self.grid = self:AddBaseCom( CircularScrollView ,'grid')


end

return UIMotherDayView
---自动生成代码----end----
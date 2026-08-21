---自动生成代码----start----
local LotteryTimelineUI = BaseClass( 'LotteryTimelineUI' , BaseView )
local M = LotteryTimelineUI 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.skip = self:AddComponent( UIImage ,self._binder:GetValue('skip'))
end
return LotteryTimelineUI
---自动生成代码----end----
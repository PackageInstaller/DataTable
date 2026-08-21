---自动生成代码----start----
local DormDailyGoalsVideoView = BaseClass( 'DormDailyGoalsVideoView' , BaseView )
local M = DormDailyGoalsVideoView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.playState =   self._binder:GetValue('playState')  
  self.videoPlayer =   self._binder:GetValue('videoPlayer')  
  self.btn =   self._binder:GetValue('btn')  


end

return DormDailyGoalsVideoView
---自动生成代码----end----
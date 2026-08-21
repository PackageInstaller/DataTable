---自动生成代码----start----
local AchievementContentUIView = BaseClass( 'AchievementContentUIView' , BaseView )
local M = AchievementContentUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.content =   self:AddValue('UI.Ctrl.Achievement.AchievementDetailCtrl','UI.View.Achievement.AchievementDetailView','content')  
  self.scrollView = self._binder:GetValue('scrollView')  


end

return AchievementContentUIView
---自动生成代码----end----
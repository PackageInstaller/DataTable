---自动生成代码----start----
local AchievementSelectView = BaseClass( 'AchievementSelectView' , BaseView )
local M = AchievementSelectView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectBtn =   self._binder:GetValue('selectBtn')  
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')


end

return AchievementSelectView
---自动生成代码----end----
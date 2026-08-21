---自动生成代码----start----
local AchievementItemView = BaseClass( 'AchievementItemView' , BaseView )
local M = AchievementItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')
  self.redpoint =   self._binder:GetValue('redpoint')  


end

return AchievementItemView
---自动生成代码----end----
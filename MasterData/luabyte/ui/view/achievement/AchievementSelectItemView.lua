---自动生成代码----start----
local AchievementSelectItemView = BaseClass( 'AchievementSelectItemView' , BaseView )
local M = AchievementSelectItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectBtn =   self._binder:GetValue('selectBtn')  
  self.bar = self:AddBaseCom( GameUIImage ,'bar')
  self.barValue = self:AddBaseCom( GameUIText ,'barValue')
  self.select =   self._binder:GetValue('select')  
  self.icon = self:AddBaseCom( GameUIImage ,'icon')


end

return AchievementSelectItemView
---自动生成代码----end----
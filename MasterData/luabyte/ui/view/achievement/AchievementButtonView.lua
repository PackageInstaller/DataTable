---自动生成代码----start----
local AchievementButtonView = BaseClass( 'AchievementButtonView' , BaseView )
local M = AchievementButtonView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.select =   self._binder:GetValue('select')  
  self.nameNormal = self:AddBaseCom( GameUIText ,'nameNormal')
  self.valueNormal = self:AddBaseCom( GameUIText ,'valueNormal')
  self.nameSelect = self:AddBaseCom( GameUIText ,'nameSelect')
  self.valueSelect = self:AddBaseCom( GameUIText ,'valueSelect')
  self.clickBtn =   self._binder:GetValue('clickBtn')  
  self.redpoint =   self._binder:GetValue('redpoint')  


end

return AchievementButtonView
---自动生成代码----end----
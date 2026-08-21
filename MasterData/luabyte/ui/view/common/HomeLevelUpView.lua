---自动生成代码----start----
local HomeLevelUpView = BaseClass( 'HomeLevelUpView' , BaseView )
local M = HomeLevelUpView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.OldLevel = self:AddBaseCom( GameUIText ,'OldLevel')
  self.NewLevel = self:AddBaseCom( GameUIText ,'NewLevel')
  self.OldEnergy = self:AddBaseCom( GameUIText ,'OldEnergy')
  self.NewEnergy = self:AddBaseCom( GameUIText ,'NewEnergy')
  self.OldLimit = self:AddBaseCom( GameUIText ,'OldLimit')
  self.NewLimit = self:AddBaseCom( GameUIText ,'NewLimit')
  self.OldAttr = self:AddBaseCom( GameUIText ,'OldAttr')
  self.NewAttr = self:AddBaseCom( GameUIText ,'NewAttr')
  self.CloseBtn =   self._binder:GetValue('CloseBtn')  


end

return HomeLevelUpView
---自动生成代码----end----
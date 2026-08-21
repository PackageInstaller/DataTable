---自动生成代码----start----
local OtakuOverviewInfoHeroView = BaseClass( 'OtakuOverviewInfoHeroView' , BaseView )
local M = OtakuOverviewInfoHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.numText = self:AddBaseCom( GameUIText ,'numText')
  self.maxText = self:AddBaseCom( GameUIText ,'maxText')


end

return OtakuOverviewInfoHeroView
---自动生成代码----end----
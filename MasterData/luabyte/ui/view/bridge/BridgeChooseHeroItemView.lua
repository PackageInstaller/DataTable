---自动生成代码----start----
local BridgeChooseHeroItemView = BaseClass( 'BridgeChooseHeroItemView' , BaseView )
local M = BridgeChooseHeroItemView 
--desc

function M:__init(go)
--require

--declare
  local trans = go.transform 
  self.heroHead =   self._binder:GetValue('heroHead')  
  self.addLevel =   self._binder:GetValue('addLevel')  
  self.addLvNode =   self._binder:GetValue('addLvNode')  
end
return BridgeChooseHeroItemView
---自动生成代码----end----
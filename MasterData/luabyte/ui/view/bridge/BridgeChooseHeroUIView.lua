---自动生成代码----start----
local BridgeChooseHeroUIView = BaseClass( 'BridgeChooseHeroUIView' , BaseView )
local M = BridgeChooseHeroUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectClose =   self._binder:GetValue('rectClose')  
  self.scrollHero = self:AddBaseCom( CircularScrollView ,'scrollHero')


end

return BridgeChooseHeroUIView
---自动生成代码----end----
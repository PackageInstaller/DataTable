---自动生成代码----start----
local FreeChooseHeroSceneView = BaseClass( 'FreeChooseHeroSceneView' , BaseView )
local M = FreeChooseHeroSceneView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.girlPos =   self._binder:GetValue('girlPos')  
  self.camPos =   self._binder:GetValue('camPos')  
  self.nation =   self._binder:GetValue('nation')  


end

return FreeChooseHeroSceneView
---自动生成代码----end----
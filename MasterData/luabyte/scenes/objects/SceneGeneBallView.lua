---自动生成代码----start----
local SceneGeneBallView = BaseClass( 'SceneGeneBallView' , BaseView )
local M = SceneGeneBallView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.selectEffect =   self._binder:GetValue('selectEffect')  
  self.upEffect =   self._binder:GetValue('upEffect')  
  self.changeEffect =   self._binder:GetValue('changeEffect')  
  self.Ball =   self._binder:GetValue('Ball')  


end

return SceneGeneBallView
---自动生成代码----end----
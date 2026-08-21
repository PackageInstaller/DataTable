---自动生成代码----start----
local UIUniverseTaskView = BaseClass( 'UIUniverseTaskView' , BaseView )
local M = UIUniverseTaskView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnBack = self:AddBaseCom( GameUIImage ,'btnBack')
  self.baseTab =   self._binder:GetValue('baseTab')  
  self.gridTask = self:AddBaseCom( CircularScrollView ,'gridTask')
  self.btnGetAll = self:AddBaseCom( UINewButton ,'btnGetAll')
  self.stateGetAll =   self._binder:GetValue('stateGetAll')  


end

return UIUniverseTaskView
---自动生成代码----end----
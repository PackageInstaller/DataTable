---自动生成代码----start----
local Home = BaseClass( 'Home' , BaseView )
local M = Home 
--desc

function M:__init(go)
  local trans = go.transform 
  self.MachineActivity =   self:AddValue('','UI.View.Drom.MachineActivityView','MachineActivity')  
  self.Home01_Root =   self._binder:GetValue('Home01_Root')  


end

return Home
---自动生成代码----end----
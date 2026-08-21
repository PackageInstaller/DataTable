---自动生成代码----start----
local EncounterAwardDetailsView = BaseClass( 'EncounterAwardDetailsView' , BaseView )
local M = EncounterAwardDetailsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.backBtn =   self._binder:GetValue('backBtn')  
  self.cirScrollview = self:AddBaseCom( CircularScrollView ,'cirScrollview')
  self.gainAllBtn =   self._binder:GetValue('gainAllBtn')  


end

return EncounterAwardDetailsView
---自动生成代码----end----
---自动生成代码----start----
local EncounterGarrisonSelectView = BaseClass( 'EncounterGarrisonSelectView' , BaseView )
local M = EncounterGarrisonSelectView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPrefab =   self._binder:GetValue('itemPrefab')  
  self.itemContainer =   self._binder:GetValue('itemContainer')  
  self.btnOk = self:AddBaseCom( UINewButton ,'btnOk')
  self.btnCancel = self:AddBaseCom( UINewButton ,'btnCancel')
  self.txtNum = self:AddBaseCom( GameUIText ,'txtNum')
  self.mask =   self._binder:GetValue('mask')  
  self.state =   self._binder:GetValue('state')  
  self.needGarssionTxt = self:AddBaseCom( GameUIText ,'needGarssionTxt')


end

return EncounterGarrisonSelectView
---自动生成代码----end----
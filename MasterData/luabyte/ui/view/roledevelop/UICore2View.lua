---自动生成代码----start----
local UICore2View = BaseClass( 'UICore2View' , BaseView )
local M = UICore2View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.uiState1 =   self._binder:GetValue('uiState1')  
  self.uiState2 =   self._binder:GetValue('uiState2')  
  self.uiState3 =   self._binder:GetValue('uiState3')  
  self.uiState4 =   self._binder:GetValue('uiState4')  
  self.uiState5 =   self._binder:GetValue('uiState5')  
  self.uiState6 =   self._binder:GetValue('uiState6')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.labLockTips = self:AddBaseCom( GameUIText ,'labLockTips')
  self.btn =   self._binder:GetValue('btn')  


end

return UICore2View
---自动生成代码----end----
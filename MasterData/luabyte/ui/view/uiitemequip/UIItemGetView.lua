---自动生成代码----start----
local UIItemGetView = BaseClass( 'UIItemGetView' , BaseView )
local M = UIItemGetView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labDesc = self:AddBaseCom( GameUIText ,'labDesc')
  self.labLockDesc = self:AddBaseCom( GameUIText ,'labLockDesc')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.imageUnlock = self:AddBaseCom( GameUIImage ,'imageUnlock')
  self.imageLock = self:AddBaseCom( GameUIImage ,'imageLock')
  self.stateGet =   self._binder:GetValue('stateGet')  
  self.lockTag =   self._binder:GetValue('lockTag')  
  self.openTag =   self._binder:GetValue('openTag')  


end

return UIItemGetView
---自动生成代码----end----
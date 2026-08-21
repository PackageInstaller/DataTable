---自动生成代码----start----
local UIAwakeClassView = BaseClass( 'UIAwakeClassView' , BaseView )
local M = UIAwakeClassView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labLv = self:AddBaseCom( GameUIText ,'labLv')
  self.UIAwakeLvCtrl =   self:AddValue('UI.Ctrl.RoleDevelop.UIAwakeLvCtrl','UI.View.RoleDevelop.UIAwakeLvView','UIAwakeLvCtrl')  
  self.uiState =   self._binder:GetValue('uiState')  
  self.labLockTips = self:AddBaseCom( GameUIText ,'labLockTips')
  self.btn = self:AddBaseCom( GameUIImage ,'btn')


end

return UIAwakeClassView
---自动生成代码----end----
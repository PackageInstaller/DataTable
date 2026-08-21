---自动生成代码----start----
local UISignView = BaseClass( 'UISignView' , BaseView )
local M = UISignView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.signMask =   self._binder:GetValue('signMask')  
  self.UISignItemCtrl =   self:AddValue('UI.Ctrl.UISign.UISignItemCtrl','UI.View.UISign.UISignItemView','UISignItemCtrl')  
  self.labTimer1 = self:AddBaseCom( GameUIText ,'labTimer1')
  self.labTimer2 = self:AddBaseCom( GameUIText ,'labTimer2')


end

return UISignView
---自动生成代码----end----
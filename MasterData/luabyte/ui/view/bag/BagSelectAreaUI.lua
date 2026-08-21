---自动生成代码----start----
local BagSelectAreaUI = BaseClass( 'BagSelectAreaUI' , BaseView )
local M = BagSelectAreaUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.cancelBtn =   self._binder:GetValue('cancelBtn')  
  self.okBtn =   self._binder:GetValue('okBtn')  
  self.item1 =   self._binder:GetValue('item1')  
  self.item2 =   self._binder:GetValue('item2')  
  self.titlieTf = self:AddBaseCom( GameUIText ,'titlieTf')
  self.numberBar =   self:AddValue('UI.Ctrl.Common.ComNumBarCtrl','UI.View.Common.ComNumBarView','numberBar')  
  self.node_decompTip =   self._binder:GetValue('node_decompTip')  
  self.node_decomp =   self._binder:GetValue('node_decomp')  


end

return BagSelectAreaUI
---自动生成代码----end----
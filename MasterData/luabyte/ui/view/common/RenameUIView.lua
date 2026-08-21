---自动生成代码----start----
local RenameUIView = BaseClass( 'RenameUIView' , BaseView )
local M = RenameUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectComfirm =   self._binder:GetValue('rectComfirm')  
  self.rectCancel =   self._binder:GetValue('rectCancel')  
  self.inputContent = self:AddBaseCom( UIInput ,'inputContent')
  self.txtPlaceholder = self:AddBaseCom( GameUIText ,'txtPlaceholder')
  self.txtTitleCN = self:AddBaseCom( GameUIText ,'txtTitleCN')
  self.txtTitleEN = self:AddBaseCom( GameUIText ,'txtTitleEN')
  self.rectClose =   self._binder:GetValue('rectClose')  


end

return RenameUIView
---自动生成代码----end----
---自动生成代码----start----
local ConfirmByRecordView = BaseClass( 'ConfirmByRecordView' , BaseView )
local M = ConfirmByRecordView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ComToggle = self:AddBaseCom( UIToggle ,'ComToggle')
  self.BtnCancel = self:AddBaseCom( GameUIImage ,'BtnCancel')
  self.BtnOK = self:AddBaseCom( GameUIImage ,'BtnOK')
  self.TipStr = self:AddBaseCom( GameUIText ,'TipStr')


end

return ConfirmByRecordView
---自动生成代码----end----
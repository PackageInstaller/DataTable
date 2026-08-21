---自动生成代码----start----
local MailPopupView = BaseClass( 'MailPopupView' , BaseView )
local M = MailPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.bg = self:AddBaseCom( GameUIImage ,'bg')
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.getBtn = self:AddBaseCom( GameUIImage ,'getBtn')
  self.deleteBtn = self:AddBaseCom( GameUIImage ,'deleteBtn')
  self.getedTip = self:AddBaseCom( GameUIImage ,'getedTip')
  self.itemParent = self:AddBaseCom( GameUIImage ,'itemParent')
  self.titleText = self:AddBaseCom( GameUIText ,'titleText')
  self.timeText = self:AddBaseCom( GameUIText ,'timeText')
  self.contextText =   self._binder:GetValue('contextText')  
  self.senderText = self:AddBaseCom( GameUIText ,'senderText')
  self.restTimeText = self:AddBaseCom( GameUIText ,'restTimeText')
  self.sc = self:AddBaseCom( CircularScrollView ,'sc')
  self.scLayoutCtr =   self._binder:GetValue('scLayoutCtr')  


end

return MailPopupView
---自动生成代码----end----
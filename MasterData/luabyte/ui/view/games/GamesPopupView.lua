---自动生成代码----start----
local GamesPopupView = BaseClass( 'GamesPopupView' , BaseView )
local M = GamesPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.okBtn =   self._binder:GetValue('okBtn')  
  self.closeText =   self._binder:GetValue('closeText')  
  self.endText =   self._binder:GetValue('endText')  
  self.Tips = self:AddBaseCom( GameUIText ,'Tips')
  self.okText = self:AddBaseCom( GameUIText ,'okText')
  self.cancelText = self:AddBaseCom( GameUIText ,'cancelText')


end

return GamesPopupView
---自动生成代码----end----
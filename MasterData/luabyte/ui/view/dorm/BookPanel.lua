---自动生成代码----start----
local BookPanel = BaseClass( 'BookPanel' , BaseView )
local M = BookPanel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Textbg =   self._binder:GetValue('Textbg')  
  self.Lock =   self._binder:GetValue('Lock')  
  self.TitleText = self:AddBaseCom( GameUIText ,'TitleText')
  self.ContentText = self:AddBaseCom( GameUIText ,'ContentText')
  self.PageNumber = self:AddBaseCom( GameUIText ,'PageNumber')
  self.LockText = self:AddBaseCom( GameUIText ,'LockText')


end

return BookPanel
---自动生成代码----end----
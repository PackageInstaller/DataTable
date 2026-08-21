---自动生成代码----start----
local OtakuTipsPanelView = BaseClass( 'OtakuTipsPanelView' , BaseView )
local M = OtakuTipsPanelView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Text = self:AddBaseCom( GameUIText ,'Text')
  self.UIState =   self._binder:GetValue('UIState')  
  self.Head = self:AddBaseCom( GameUIImage ,'Head')
  self.Name = self:AddBaseCom( GameUIText ,'Name')


end

return OtakuTipsPanelView
---自动生成代码----end----
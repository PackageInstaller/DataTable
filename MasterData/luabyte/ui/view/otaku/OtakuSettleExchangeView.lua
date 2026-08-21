---自动生成代码----start----
local OtakuSettleExchangeView = BaseClass( 'OtakuSettleExchangeView' , BaseView )
local M = OtakuSettleExchangeView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Text = self:AddBaseCom( GameUIText ,'Text')
  self.BtnCancel = self:AddBaseCom( GameUIImage ,'BtnCancel')
  self.BtnOK = self:AddBaseCom( GameUIImage ,'BtnOK')
  self.Content =   self._binder:GetValue('Content')  
  self.Item =   self:AddValue('','UI.View.Otaku.OtakuSettleExchangeItem','Item')  
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')


end

return OtakuSettleExchangeView
---自动生成代码----end----
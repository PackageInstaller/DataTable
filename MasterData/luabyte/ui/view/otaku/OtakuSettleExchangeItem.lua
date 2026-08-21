---自动生成代码----start----
local OtakuSettleExchangeItem = BaseClass( 'OtakuSettleExchangeItem' , BaseView )
local M = OtakuSettleExchangeItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Head = self:AddBaseCom( GameUIImage ,'Head')
  self.OldText = self:AddBaseCom( GameUIText ,'OldText')


end

return OtakuSettleExchangeItem
---自动生成代码----end----
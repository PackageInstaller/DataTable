---自动生成代码----start----
local Lottery_ExchangeCellView = BaseClass( 'Lottery_ExchangeCellView' , BaseView )
local M = Lottery_ExchangeCellView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.name = self:AddBaseCom( GameUIText ,'name')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.state =   self._binder:GetValue('state')  


end

return Lottery_ExchangeCellView
---自动生成代码----end----
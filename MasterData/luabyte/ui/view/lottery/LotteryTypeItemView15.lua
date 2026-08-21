---自动生成代码----start----
local LotteryTypeItemView15 = BaseClass( 'LotteryTypeItemView15' , BaseView )
local M = LotteryTypeItemView15 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ssrCountTf = self:AddBaseCom( GameUIText ,'ssrCountTf')
  self.numberTip =   self._binder:GetValue('numberTip')  
  self.Time = self:AddBaseCom( GameUIText ,'Time')
  self.ssrNeedTime = self:AddBaseCom( GameUIText ,'ssrNeedTime')
  self.drawTimes = self:AddBaseCom( GameUIText ,'drawTimes')


end

return LotteryTypeItemView15
---自动生成代码----end----
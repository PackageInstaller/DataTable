---自动生成代码----start----
local LotteryTypeItemView7 = BaseClass( 'LotteryTypeItemView7' , BaseView )
local M = LotteryTypeItemView7 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ssrCountTf = self:AddBaseCom( GameUIText ,'ssrCountTf')
  self.numberTip =   self._binder:GetValue('numberTip')  
  self.Time = self:AddBaseCom( GameUIText ,'Time')
  self.ssrNeedTime = self:AddBaseCom( GameUIText ,'ssrNeedTime')
  self.drawTimes = self:AddBaseCom( GameUIText ,'drawTimes')


end

return LotteryTypeItemView7
---自动生成代码----end----
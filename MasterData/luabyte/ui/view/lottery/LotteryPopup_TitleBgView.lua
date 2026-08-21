---自动生成代码----start----
local LotteryPopup_TitleBgView = BaseClass( 'LotteryPopup_TitleBgView' , BaseView )
local M = LotteryPopup_TitleBgView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.qualityImge = self:AddBaseCom( GameUIImage ,'qualityImge')
  self.qualityText = self:AddBaseCom( GameUIText ,'qualityText')


end

return LotteryPopup_TitleBgView
---自动生成代码----end----
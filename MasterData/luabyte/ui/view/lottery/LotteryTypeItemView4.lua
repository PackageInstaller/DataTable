---自动生成代码----start----
local LotteryTypeItemView4 = BaseClass( 'LotteryTypeItemView4' , BaseView )
local M = LotteryTypeItemView4 
--desc

function M:__init(go)
  local trans = go.transform 
  self.media =   self._binder:GetValue('media')  
  self.item_name = self:AddBaseCom( GameUIText ,'item_name')
  self.item_icon = self:AddBaseCom( GameUIImage ,'item_icon')
  self.ssrNeedTime = self:AddBaseCom( GameUIText ,'ssrNeedTime')


end

return LotteryTypeItemView4
---自动生成代码----end----
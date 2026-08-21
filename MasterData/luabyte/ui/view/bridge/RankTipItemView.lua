---自动生成代码----start----
local RankTipItemView = BaseClass( 'RankTipItemView' , BaseView )
local M = RankTipItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.num = self:AddBaseCom( GameUIText ,'num')
  self.icon = self:AddBaseCom( GameUIImage ,'icon')


end

return RankTipItemView
---自动生成代码----end----
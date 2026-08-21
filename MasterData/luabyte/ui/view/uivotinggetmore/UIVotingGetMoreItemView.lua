---自动生成代码----start----
local UIVotingGetMoreItemView = BaseClass( 'UIVotingGetMoreItemView' , BaseView )
local M = UIVotingGetMoreItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.textDesc = self:AddBaseCom( GameUIText ,'textDesc')


end

return UIVotingGetMoreItemView
---自动生成代码----end----
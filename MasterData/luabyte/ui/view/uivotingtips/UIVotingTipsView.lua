---自动生成代码----start----
local UIVotingTipsView = BaseClass( 'UIVotingTipsView' , BaseView )
local M = UIVotingTipsView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.text = self:AddBaseCom( GameUIText ,'text')
  self.mask =   self._binder:GetValue('mask')
end

return UIVotingTipsView
---自动生成代码----end----
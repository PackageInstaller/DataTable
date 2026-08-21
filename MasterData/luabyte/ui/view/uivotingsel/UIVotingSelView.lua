---自动生成代码----start----
local UIVotingSelView = BaseClass( 'UIVotingSelView' , BaseView )
local M = UIVotingSelView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ScrollView = self:AddBaseCom( CircularScrollView ,'ScrollView')
  self.btnRandom = self:AddBaseCom( UIButton ,'btnRandom')
  self.textBtn = self:AddBaseCom( GameUIText ,'textBtn')
  self.textTime = self:AddBaseCom( GameUIText ,'textTime')
  self.textRefTime = self:AddBaseCom( GameUIText ,'textRefTime')


end

return UIVotingSelView
---自动生成代码----end----
---自动生成代码----start----
local UIVotingEight2View = BaseClass( 'UIVotingEight2View' , BaseView )
local M = UIVotingEight2View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textTime = self:AddBaseCom( GameUIText ,'textTime')
  self.item =   self:AddValue('UI.Ctrl.UIVotingEight.UIVotingEight2ItemCtrl','UI.View.UIVotingEight.UIVotingEight2ItemView','item')  
  self.textRefTime = self:AddBaseCom( GameUIText ,'textRefTime')


end

return UIVotingEight2View
---自动生成代码----end----
---自动生成代码----start----
local UIVotingView = BaseClass( 'UIVotingView' , BaseView )
local M = UIVotingView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnReward = self:AddBaseCom( UIButton ,'btnReward')
  self.btnGetMore = self:AddBaseCom( UIButton ,'btnGetMore')
  self.btnFirst = self:AddBaseCom( UIButton ,'btnFirst')
  self.Item1 =   self:AddValue('UI.Ctrl.UIVoting.UIVotingItemCtrl','UI.View.UIVoting.UIVotingItemView','Item1')  
  self.Item2 =   self:AddValue('UI.Ctrl.UIVoting.UIVotingItemCtrl','UI.View.UIVoting.UIVotingItemView','Item2')  
  self.Item3 =   self:AddValue('UI.Ctrl.UIVoting.UIVotingItemCtrl','UI.View.UIVoting.UIVotingItemView','Item3')  
  self.UIVotingEight1Ctrl =   self:AddValue('UI.Ctrl.UIVotingEight.UIVotingEight1Ctrl','UI.View.UIVotingEight.UIVotingEight1View','UIVotingEight1Ctrl')  
  self.tfVotingEight1UI =   self._binder:GetValue('tfVotingEight1UI')  
  self.tfMain =   self._binder:GetValue('tfMain')  
  self.UIVotingFir1Ctrl =   self:AddValue('UI.Ctrl.UIVotingFir1.UIVotingFir1Ctrl','UI.View.UIVotingFir1.UIVotingFir1View','UIVotingFir1Ctrl')  
  self.tfUIVotingFir1 =   self._binder:GetValue('tfUIVotingFir1')  


end

return UIVotingView
---自动生成代码----end----
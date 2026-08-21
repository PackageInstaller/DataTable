---自动生成代码----start----
local UIVotingFir2View = BaseClass( 'UIVotingFir2View' , BaseView )
local M = UIVotingFir2View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.tfItemL =   self._binder:GetValue('tfItemL')  
  self.tfItemR =   self._binder:GetValue('tfItemR')  
  self.ItemL =   self:AddValue('UI.Ctrl.UIVotingFir2.UIVotingFir2ItemCtrl','UI.View.UIVotingFir2.UIVotingFir2ItemView','ItemL')  
  self.ItemR =   self:AddValue('UI.Ctrl.UIVotingFir2.UIVotingFir2ItemCtrl','UI.View.UIVotingFir2.UIVotingFir2ItemView','ItemR')  
  self.tfNameL =   self._binder:GetValue('tfNameL')  
  self.tfNameR =   self._binder:GetValue('tfNameR')  
  self.textRefTime = self:AddBaseCom( GameUIText ,'textRefTime')
  self.textTime = self:AddBaseCom( GameUIText ,'textTime')


end

return UIVotingFir2View
---自动生成代码----end----
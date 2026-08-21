---自动生成代码----start----
local UIVotingFir1View = BaseClass( 'UIVotingFir1View' , BaseView )
local M = UIVotingFir1View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ItemL =   self:AddValue('UI.Ctrl.UIVotingFir1.UIVotingFir1ItemCtrl','UI.View.UIVotingFir1.UIVotingFir1ItemView','ItemL')  
  self.ItemR =   self:AddValue('UI.Ctrl.UIVotingFir1.UIVotingFir1ItemCtrl','UI.View.UIVotingFir1.UIVotingFir1ItemView','ItemR')  
  self.textTimer = self:AddBaseCom( GameUIText ,'textTimer')
  self.tfItemL =   self._binder:GetValue('tfItemL')  
  self.tfItemR =   self._binder:GetValue('tfItemR')  


end

return UIVotingFir1View
---自动生成代码----end----
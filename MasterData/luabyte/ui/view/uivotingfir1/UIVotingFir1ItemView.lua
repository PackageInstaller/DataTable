---自动生成代码----start----
local UIVotingFir1ItemView = BaseClass( 'UIVotingFir1ItemView' , BaseView )
local M = UIVotingFir1ItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.imageRole = self:AddBaseCom( GameRawImage ,'imageRole')
  self.btn =   self._binder:GetValue('btn')  


end

return UIVotingFir1ItemView
---自动生成代码----end----
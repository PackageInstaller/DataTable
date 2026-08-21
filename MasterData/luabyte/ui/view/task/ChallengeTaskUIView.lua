---自动生成代码----start----
local ChallengeTaskUIView = BaseClass( 'ChallengeTaskUIView' , BaseView )
local M = ChallengeTaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.challengeScrollView = self:AddBaseCom( CircularScrollView ,'challengeScrollView')
  self.rectChallengePanel =   self._binder:GetValue('rectChallengePanel')  
  self.togReceiveAll = self:AddBaseCom( UINewButton ,'togReceiveAll')


end

return ChallengeTaskUIView
---自动生成代码----end----
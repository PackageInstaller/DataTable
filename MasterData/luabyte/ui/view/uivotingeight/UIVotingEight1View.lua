---自动生成代码----start----
local UIVotingEight1View = BaseClass( 'UIVotingEight1View' , BaseView )
local M = UIVotingEight1View 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Item =   self._binder:GetValue('Item')  
  self.ScrollRect = self:AddBaseCom( CircularScrollView ,'ScrollRect')
  self.textTimer = self:AddBaseCom( GameUIText ,'textTimer')


end

return UIVotingEight1View
---自动生成代码----end----
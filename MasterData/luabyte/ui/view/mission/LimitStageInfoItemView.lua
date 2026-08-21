---自动生成代码----start----
local LimitStageInfoItemView = BaseClass( 'LimitStageInfoItemView' , BaseView )
local M = LimitStageInfoItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.desc = self:AddBaseCom( GameUIText ,'desc')
  self.clickArea =   self._binder:GetValue('clickArea')  


end

return LimitStageInfoItemView
---自动生成代码----end----
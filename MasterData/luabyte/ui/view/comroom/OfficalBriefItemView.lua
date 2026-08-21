---自动生成代码----start----
local OfficalBriefItemView = BaseClass( 'OfficalBriefItemView' , BaseView )
local M = OfficalBriefItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.rectOfficalBriefItem =   self._binder:GetValue('rectOfficalBriefItem')  
  self.txtTitle = self:AddBaseCom( GameUIText ,'txtTitle')
  self.txtContent = self:AddBaseCom( GameUIText ,'txtContent')


end

return OfficalBriefItemView
---自动生成代码----end----
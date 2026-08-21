---自动生成代码----start----
local UISignItemView = BaseClass( 'UISignItemView' , BaseView )
local M = UISignItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.Day = self:AddBaseCom( GameUIText ,'Day')
  self.MonthlySignUI_eff =   self._binder:GetValue('MonthlySignUI_eff')  
  self.state =   self._binder:GetValue('state')  


end

return UISignItemView
---自动生成代码----end----
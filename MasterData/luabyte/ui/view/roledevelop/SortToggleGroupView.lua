---自动生成代码----start----
local SortToggleGroupView = BaseClass( 'SortToggleGroupView' , BaseView )
local M = SortToggleGroupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Toggle1 = self:AddBaseCom( UIToggle ,'Toggle1')
  self.Toggle2 = self:AddBaseCom( UIToggle ,'Toggle2')
  self.Toggle3 = self:AddBaseCom( UIToggle ,'Toggle3')
  self.Toggle4 = self:AddBaseCom( UIToggle ,'Toggle4')
  self.Toggle5 = self:AddBaseCom( UIToggle ,'Toggle5')
  self.Toggle6 = self:AddBaseCom( UIToggle ,'Toggle6')


end

return SortToggleGroupView
---自动生成代码----end----
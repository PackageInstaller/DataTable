---自动生成代码----start----
local GuideTaskUIlView = BaseClass( 'GuideTaskUIlView' , BaseView )
local M = GuideTaskUIlView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.levelScollView = self:AddBaseCom( CircularScrollView ,'levelScollView')
  self.listScrollView = self:AddBaseCom( CircularScrollView ,'listScrollView')


end

return GuideTaskUIlView
---自动生成代码----end----
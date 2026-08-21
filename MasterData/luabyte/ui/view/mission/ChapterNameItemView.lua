---自动生成代码----start----
local ChapterNameItemView = BaseClass( 'ChapterNameItemView' , BaseView )
local M = ChapterNameItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mNum = self:AddBaseCom( GameUIText ,'mNum')
  self.mName = self:AddBaseCom( GameUIText ,'mName')
  self.cnType = self:AddBaseCom( GameUIText ,'cnType')


end

return ChapterNameItemView
---自动生成代码----end----
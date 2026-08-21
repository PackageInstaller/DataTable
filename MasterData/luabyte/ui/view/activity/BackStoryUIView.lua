---自动生成代码----start----
local BackStoryUIView = BaseClass( 'BackStoryUIView' , BaseView )
local M = BackStoryUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.list_task = self:AddBaseCom( CircularScrollView ,'list_task')
  self.txt_title = self:AddBaseCom( GameUIText ,'txt_title')
  self.txt_time = self:AddBaseCom( GameUIText ,'txt_time')


end

return BackStoryUIView
---自动生成代码----end----
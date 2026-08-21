---自动生成代码----start----
local GuideTaskUIView = BaseClass( 'GuideTaskUIView' , BaseView )
local M = GuideTaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.levelScrollView = self:AddBaseCom( CircularScrollView ,'levelScrollView')
  self.listScrollView = self:AddBaseCom( CircularScrollView ,'listScrollView')
  self.viewGuideLevelItem =   self:AddValue('','UI.View.Task.GuideLevelItemView','viewGuideLevelItem')  
  self.viewGuideListItem =   self:AddValue('','UI.View.Task.GuideListItemView','viewGuideListItem')  
  self.viewTaskAwardItem =   self:AddValue('','UI.View.Task.TaskAwardItemView','viewTaskAwardItem')  
  self.rectGuidePanel =   self._binder:GetValue('rectGuidePanel')  


end

return GuideTaskUIView
---自动生成代码----end----
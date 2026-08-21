---自动生成代码----start----
local StoryUIView = BaseClass( 'StoryUIView' , BaseView )
local M = StoryUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.imgBlink = self:AddBaseCom( GameUIImage ,'imgBlink')
  self.effPanel =   self._binder:GetValue('effPanel')  
  self.ctrlBase =   self:AddValue('UI.Ctrl.Story.StoryBgRoleCtrl','UI.View.Story.StoryBgRoleView','ctrlBase')  
  self.ctrlCmd =   self:AddValue('UI.Ctrl.Story.StoryCmdResponseCtrl','UI.View.Story.StoryCmdResponseView','ctrlCmd')  
  self.ctrlTop =   self:AddValue('UI.Ctrl.Story.StoryTopCtrl','UI.View.Story.StoryTopView','ctrlTop')  
  self.ctrlNext =   self:AddValue('UI.Ctrl.Story.StoryNextCtrl','UI.View.Story.StoryNextView','ctrlNext')  


end

return StoryUIView
---自动生成代码----end----
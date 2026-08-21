---自动生成代码----start----
local DailyTaskUIPanel = BaseClass( 'DailyTaskUIPanel' , BaseView )
local M = DailyTaskUIPanel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollView = self:AddBaseCom( CircularScrollView ,'scrollView')
  self.Liveness1 =   self:AddValue('','UI.View.Task.TaskLivenessView','Liveness1')  
  self.Liveness2 =   self:AddValue('','UI.View.Task.TaskLivenessView','Liveness2')  
  self.Liveness3 =   self:AddValue('','UI.View.Task.TaskLivenessView','Liveness3')  
  self.Liveness4 =   self:AddValue('','UI.View.Task.TaskLivenessView','Liveness4')  
  self.Liveness5 =   self:AddValue('','UI.View.Task.TaskLivenessView','Liveness5')  
  self.slider_liveness = self:AddBaseCom( GameUIImage ,'slider_liveness')
  self.txt_current = self:AddBaseCom( GameUIText ,'txt_current')
  self.txt_whole = self:AddBaseCom( GameUIText ,'txt_whole')
  self.rect_SliderLine =   self._binder:GetValue('rect_SliderLine')  
  self.TargetPos =   self._binder:GetValue('TargetPos')  


end

return DailyTaskUIPanel
---自动生成代码----end----
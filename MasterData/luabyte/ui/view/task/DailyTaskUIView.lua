---自动生成代码----start----
local DailyTaskUIView = BaseClass( 'DailyTaskUIView' , BaseView )
local M = DailyTaskUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.activityScrollView = self:AddBaseCom( CircularScrollView ,'activityScrollView')
  self.listScrollView = self:AddBaseCom( CircularScrollView ,'listScrollView')
  self.txtMaxValue = self:AddBaseCom( GameUIText ,'txtMaxValue')
  self.txtCurValue = self:AddBaseCom( GameUIText ,'txtCurValue')
  self.togReceiveAll = self:AddBaseCom( UIButton ,'togReceiveAll')
  self.rectDailyPanel =   self._binder:GetValue('rectDailyPanel')  
  self.imgBgProgress = self:AddBaseCom( GameUIImage ,'imgBgProgress')
  self.imgFgProgress = self:AddBaseCom( GameUIImage ,'imgFgProgress')
  self.togReceiveAllState =   self._binder:GetValue('togReceiveAllState')  


end

return DailyTaskUIView
---自动生成代码----end----
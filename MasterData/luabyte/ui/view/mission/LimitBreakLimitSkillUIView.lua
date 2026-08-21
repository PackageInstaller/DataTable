---自动生成代码----start----
local LimitBreakLimitSkillUIView = BaseClass( 'LimitBreakLimitSkillUIView' , BaseView )
local M = LimitBreakLimitSkillUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txt_back =   self._binder:GetValue('txt_back')  
  self.chestTips =   self._binder:GetValue('chestTips')  
  self.firstTips =   self._binder:GetValue('firstTips')  
  self.Item =   self:AddValue('UI.Ctrl.Mission.limitChallge.LimitBreakLimitSkillGroupItemCtrl','UI.View.Mission.LimitBreakLimitSkillGroupItemView','Item')  
  self.content =   self._binder:GetValue('content')  
  self.resetState =   self._binder:GetValue('resetState')  
  self.txt_resetLabel = self:AddBaseCom( GameUIText ,'txt_resetLabel')
  self.empty =   self._binder:GetValue('empty')  


end

return LimitBreakLimitSkillUIView
---自动生成代码----end----
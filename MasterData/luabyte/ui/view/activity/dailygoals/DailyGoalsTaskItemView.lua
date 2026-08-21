---自动生成代码----start----
local DailyGoalsTaskItemView = BaseClass( 'DailyGoalsTaskItemView' , BaseView )
local M = DailyGoalsTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.title = self:AddBaseCom( GameUIText ,'title')
  self.value = self:AddBaseCom( GameUIText ,'value')
  self.awardBtn =   self._binder:GetValue('awardBtn')  
  self.goBtn =   self._binder:GetValue('goBtn')  
  self.rewardScroll = self._binder:GetValue('rewardScroll') 
  self.state =   self._binder:GetValue('state')  


end

return DailyGoalsTaskItemView
---自动生成代码----end----
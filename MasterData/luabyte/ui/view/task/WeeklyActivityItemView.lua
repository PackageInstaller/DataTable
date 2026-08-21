---自动生成代码----start----
local WeeklyActivityItemView = BaseClass( 'WeeklyActivityItemView' , BaseView )
local M = WeeklyActivityItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtValue = self:AddBaseCom( GameUIText ,'txtValue')
  self.rectDoing =   self._binder:GetValue('rectDoing')  
  self.rectReceive =   self._binder:GetValue('rectReceive')  
  self.rectComplete =   self._binder:GetValue('rectComplete')  
  self.rectClickArea =   self._binder:GetValue('rectClickArea')  
  self.imgReward = self:AddBaseCom( GameUIImage ,'imgReward')
  self.txt_rewardCount = self:AddBaseCom( GameUIText ,'txt_rewardCount')


end

return WeeklyActivityItemView
---自动生成代码----end----
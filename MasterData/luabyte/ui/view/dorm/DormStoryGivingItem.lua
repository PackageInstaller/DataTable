---自动生成代码----start----
local DormStoryGivingItem = BaseClass( 'DormStoryGivingItem' , BaseView )
local M = DormStoryGivingItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.UIState =   self._binder:GetValue('UIState')  
  self.node_alpha =   self._binder:GetValue('node_alpha')  
  self.BtnTips =   self._binder:GetValue('BtnTips')  


end

return DormStoryGivingItem
---自动生成代码----end----
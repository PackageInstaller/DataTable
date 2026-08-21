---自动生成代码----start----
local UILvFundItemPfbView = BaseClass( 'UILvFundItemPfbView' , BaseView )
local M = UILvFundItemPfbView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ItemPfbUI =   self._binder:GetValue('ItemPfbUI')  
  self.tfReward =   self._binder:GetValue('tfReward')  
  self.tfLock =   self._binder:GetValue('tfLock')  
  self.tfPaid =   self._binder:GetValue('tfPaid')  
  self.btnReward =   self._binder:GetValue('btnReward')  


end

return UILvFundItemPfbView
---自动生成代码----end----
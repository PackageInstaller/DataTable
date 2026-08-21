---自动生成代码----start----
local PassRewardUIView = BaseClass( 'PassRewardUIView' , BaseView )
local M = PassRewardUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.looplist = self:AddBaseCom( LoopListView ,'looplist')
  self.btn_quickGet = self:AddBaseCom( UINewButton ,'btn_quickGet')
  self.btn_quickShop =   self._binder:GetValue('btn_quickShop')  
  self.quickShopLock =   self._binder:GetValue('quickShopLock')  
  self.stageReward =   self:AddValue('UI.Ctrl.Pass.PassItemGroupCtrl','UI.View.Pass.PassItemGroupView','stageReward')  
  self.quickGetLock =   self._binder:GetValue('quickGetLock')  


end

return PassRewardUIView
---自动生成代码----end----
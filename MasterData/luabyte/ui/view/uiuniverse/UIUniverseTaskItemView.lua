---自动生成代码----start----
local UIUniverseTaskItemView = BaseClass( 'UIUniverseTaskItemView' , BaseView )
local M = UIUniverseTaskItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.scrollbar =   self._binder:GetValue('scrollbar')  
  self.state =   self._binder:GetValue('state')  
  self.btnReward = self:AddBaseCom( UINewButton ,'btnReward')
  self.labNum = self:AddBaseCom( GameUIText ,'labNum')
  self.ItemPfbView =   self:AddValue('','UI.View.Common.ItemPfbView','ItemPfbView')  


end

return UIUniverseTaskItemView
---自动生成代码----end----
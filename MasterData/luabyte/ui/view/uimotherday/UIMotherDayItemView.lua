---自动生成代码----start----
local UIMotherDayItemView = BaseClass( 'UIMotherDayItemView' , BaseView )
local M = UIMotherDayItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.itemPfb =   self._binder:GetValue('itemPfb')  
  self.state =   self._binder:GetValue('state')  
  self.imgDay = self:AddBaseCom( GameUIImage ,'imgDay')
  self.btn =   self._binder:GetValue('btn')  
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.animReward =   self._binder:GetValue('animReward')  


end

return UIMotherDayItemView
---自动生成代码----end----
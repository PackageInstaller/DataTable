---自动生成代码----start----
local DormPuzzleItemView = BaseClass( 'DormPuzzleItemView' , BaseView )
local M = DormPuzzleItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Img = self:AddBaseCom( GameUIImage ,'Img')
  self.State =   self._binder:GetValue('State')  
  self.Activate =   self._binder:GetValue('Activate')  
  self.Card =   self._binder:GetValue('Card')  
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')

  self.groupChildId = self:GetBaseValue('groupChildId')
end

return DormPuzzleItemView
---自动生成代码----end----
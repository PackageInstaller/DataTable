---自动生成代码----start----
local DormItem = BaseClass( 'DormItem' , BaseView )
local M = DormItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.FavorNum = self:AddBaseCom( GameUIText ,'FavorNum')
  self.IconGroup =   self._binder:GetValue('IconGroup')  
  self.TheatIcon = self:AddBaseCom( GameUIImage ,'TheatIcon')
  self.InstanceIcon = self:AddBaseCom( GameUIImage ,'InstanceIcon')
  self.FaovrIcon = self:AddBaseCom( GameUIImage ,'FaovrIcon')
  self.UIState =   self._binder:GetValue('UIState')  
  self.BG = self:AddBaseCom( GameUIImage ,'BG')
  self.Open = self:AddBaseCom( GameUIImage ,'Open')
  self.RedPoint =   self._binder:GetValue('RedPoint')  


end

return DormItem
---自动生成代码----end----
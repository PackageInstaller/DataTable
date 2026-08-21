---自动生成代码----start----
local FurnitureItem = BaseClass( 'FurnitureItem' , BaseView )
local M = FurnitureItem 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Icon = self:AddBaseCom( GameUIImage ,'Icon')
  self.Num =   self._binder:GetValue('Num')  
  self.Unhave =   self._binder:GetValue('Unhave')  
  self.Quality = self:AddBaseCom( GameUIImage ,'Quality')
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.NumBg = self:AddBaseCom( GameUIImage ,'NumBg')
  self.On = self:AddBaseCom( GameUIImage ,'On')
  self.BtnTips = self:AddBaseCom( GameUIImage ,'BtnTips')
  self.UIState =   self._binder:GetValue('UIState')  
  self.AtmosphereNum = self:AddBaseCom( GameUIText ,'AtmosphereNum')
  self.Redpoint =   self._binder:GetValue('Redpoint')  


end

return FurnitureItem
---自动生成代码----end----
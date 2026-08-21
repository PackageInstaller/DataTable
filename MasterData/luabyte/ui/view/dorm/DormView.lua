---自动生成代码----start----
local DormView = BaseClass( 'DormView' , BaseView )
local M = DormView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.BtnPanel =   self._binder:GetValue('BtnPanel')  
  self.objPanel = self:AddBaseCom( GameUIImage ,'objPanel')
  self.Panel =   self._binder:GetValue('Panel')  
  self.FavorPanel =   self:AddValue('','UI.View.Dorm.FavorPanel','FavorPanel')  
  self.FavorBtn = self:AddBaseCom( GameUIImage ,'FavorBtn')
  self.TheatBtn = self:AddBaseCom( GameUIImage ,'TheatBtn')
  self.DormTask =   self:AddValue('','UI.View.Dorm.DormTaskPanel','DormTask')  
  self.node_personal =   self._binder:GetValue('node_personal')  
  self.BtnCamera =   self._binder:GetValue('BtnCamera')  
  self.BtnCall =   self._binder:GetValue('BtnCall')  
  self.BtnGift =   self._binder:GetValue('BtnGift')  
  self.BtnFurniture =   self._binder:GetValue('BtnFurniture')  
  self.TouchBg =   self._binder:GetValue('TouchBg')  
  self.Atmosphere =   self:AddValue('','UI.View.Dorm.DormAtmosphereItem','Atmosphere')  
  self.FurnitureRedpoint =   self._binder:GetValue('FurnitureRedpoint')  
  self.BtnFurnitureState =   self._binder:GetValue('BtnFurnitureState')  
  self.BtnAdd =   self._binder:GetValue('BtnAdd')  
  self.FurnitureText = self:AddBaseCom( GameUIText ,'FurnitureText')
  self.BtnCloth =   self._binder:GetValue('BtnCloth')  
  self.BtnBook =   self._binder:GetValue('BtnBook')  
  self.BtnLayout =   self._binder:GetValue('BtnLayout')  
  self.BtnValentine =   self._binder:GetValue('BtnValentine')  
  self.BtnAddAnimation =   self._binder:GetValue('BtnAddAnimation')  
  self.ValentineRedpoint =   self._binder:GetValue('ValentineRedpoint')  
  self.ActivityBtn =   self._binder:GetValue('ActivityBtn')  
  self.ActivityStoryRedpoint =   self._binder:GetValue('ActivityStoryRedpoint')  


end

return DormView
---自动生成代码----end----
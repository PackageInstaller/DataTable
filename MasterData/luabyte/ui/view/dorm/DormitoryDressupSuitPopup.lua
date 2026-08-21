---自动生成代码----start----
local DormitoryDressupSuitPopup = BaseClass( 'DormitoryDressupSuitPopup' , BaseView )
local M = DormitoryDressupSuitPopup 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Img = self:AddBaseCom( GameUIImage ,'Img')
  self.ItemGroup =   self._binder:GetValue('ItemGroup')  
  self.SuitItem1 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem1')  
  self.SuitItem2 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem2')  
  self.SuitItem3 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem3')  
  self.SuitItem4 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem4')  
  self.SuitItem5 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem5')  
  self.SuitItem6 =   self:AddValue('UI.Ctrl.Dorm.SuitItemCtrl','UI.View.Dorm.SuitItemView','SuitItem6')  
  self.BtnGet = self:AddBaseCom( GameUIImage ,'BtnGet')
  self.BtnEquip = self:AddBaseCom( GameUIImage ,'BtnEquip')
  self.Mask = self:AddBaseCom( GameUIImage ,'Mask')
  self.UIState =   self._binder:GetValue('UIState')  


end

return DormitoryDressupSuitPopup
---自动生成代码----end----
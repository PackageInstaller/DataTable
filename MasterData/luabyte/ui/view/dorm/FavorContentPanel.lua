---自动生成代码----start----
local FavorContentPanel = BaseClass( 'FavorContentPanel' , BaseView )
local M = FavorContentPanel 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Head = self:AddBaseCom( GameUIImage ,'Head')
  self.favorLevel = self:AddBaseCom( GameUIText ,'favorLevel')
  self.favourSlider = self:AddBaseCom( GameUIImage ,'favourSlider')
  self.favorProgress = self:AddBaseCom( GameUIText ,'favorProgress')
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.FavorScrollView = self:AddBaseCom( CircularScrollView ,'FavorScrollView')
  self.Tab1 =   self:AddValue('','UI.View.Dorm.StageTabView','Tab1')  
  self.Tab2 =   self:AddValue('','UI.View.Dorm.StageTabView','Tab2')  
  self.Tab3 =   self:AddValue('','UI.View.Dorm.StageTabView','Tab3')  
  self.Tab4 =   self:AddValue('','UI.View.Dorm.StageTabView','Tab4')  
  self.LockScrollView = self:AddBaseCom( CircularScrollView ,'LockScrollView')
  self.LockText = self:AddBaseCom( GameUIText ,'LockText')
  self.PanelList =   self._binder:GetValue('PanelList')  


end

return FavorContentPanel
---自动生成代码----end----
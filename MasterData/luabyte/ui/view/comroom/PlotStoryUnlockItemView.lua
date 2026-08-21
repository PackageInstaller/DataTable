---自动生成代码----start----
local PlotStoryUnlockItemView = BaseClass( 'PlotStoryUnlockItemView' , BaseView )
local M = PlotStoryUnlockItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_index = self:AddBaseCom( GameUIText ,'txt_index')
  self.uiState =   self._binder:GetValue('uiState')  
  self.btn_select =   self._binder:GetValue('btn_select')  
  self.itemSlip =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','itemSlip')  


end

return PlotStoryUnlockItemView
---自动生成代码----end----
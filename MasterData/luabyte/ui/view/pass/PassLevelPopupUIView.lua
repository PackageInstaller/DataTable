---自动生成代码----start----
local PassLevelPopupUIView = BaseClass( 'PassLevelPopupUIView' , BaseView )
local M = PassLevelPopupUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_buy = self:AddBaseCom( UINewButton ,'btn_buy')
  self.btn_cancel = self:AddBaseCom( UINewButton ,'btn_cancel')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.itemloop = self:AddBaseCom( CircularScrollView ,'itemloop')
  self.btm_mask =   self._binder:GetValue('btm_mask')  
  self.numSlider =   self:AddValue('UI.Ctrl.Common.ComNumSliderCtrl','UI.View.Common.ComNumSliderView','numSlider')  
  self.comItem =   self:AddValue('UI.Ctrl.Common.ComItemSlipCtrl','UI.View.Common.ComItemSlipView','comItem')  


end

return PassLevelPopupUIView
---自动生成代码----end----
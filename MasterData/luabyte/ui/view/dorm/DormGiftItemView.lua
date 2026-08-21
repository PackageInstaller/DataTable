---自动生成代码----start----
local DormGiftItemView = BaseClass( 'DormGiftItemView' , BaseView )
local M = DormGiftItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.item =   self._binder:GetValue('item')  
  self.UpBg =   self._binder:GetValue('UpBg')  
  self.Act =   self._binder:GetValue('Act')  
  self.TextBg =   self._binder:GetValue('TextBg')  
  self.QualityColor =   self._binder:GetValue('QualityColor')  
  self.BtnTips =   self._binder:GetValue('BtnTips')  
  self.Name =   self._binder:GetValue('Name')  
  self.StateQuality =   self._binder:GetValue('StateQuality')  


end

return DormGiftItemView
---自动生成代码----end----
---自动生成代码----start----
local DormPersonalEventPopupView = BaseClass( 'DormPersonalEventPopupView' , BaseView )
local M = DormPersonalEventPopupView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.btn_map =   self._binder:GetValue('btn_map')  
  self.btn_enemy =   self._binder:GetValue('btn_enemy')  
  self.btn_battle =   self._binder:GetValue('btn_battle')  
  self.btn_more =   self._binder:GetValue('btn_more')  
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.img_map = self:AddBaseCom( GameRawImage ,'img_map')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.node_favor =   self:AddValue('','UI.View.Dorm.Personal.DormPersonalFavorItemView','node_favor')  
  self.itemPfb =   self._binder:GetValue('itemPfb')  


end

return DormPersonalEventPopupView
---自动生成代码----end----
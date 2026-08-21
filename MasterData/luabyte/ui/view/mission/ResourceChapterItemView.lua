---自动生成代码----start----
local ResourceChapterItemView = BaseClass( 'ResourceChapterItemView' , BaseView )
local M = ResourceChapterItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.node_normal =   self._binder:GetValue('node_normal')  
  self.limitTimeTag =   self._binder:GetValue('limitTimeTag')  
  self.node_lock =   self._binder:GetValue('node_lock')  
  self.img_banner = self:AddBaseCom( GameRawImage ,'img_banner')
  self.img_itemIcon = self:AddBaseCom( GameUIImage ,'img_itemIcon')
  self.txt_itemName = self:AddBaseCom( GameUIText ,'txt_itemName')
  self.txt_lock = self:AddBaseCom( GameUIText ,'txt_lock')
  self.txt_times = self:AddBaseCom( GameUIText ,'txt_times')
  self.txt_chName = self:AddBaseCom( GameUIText ,'txt_chName')
  self.txt_enName = self:AddBaseCom( GameUIText ,'txt_enName')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.limitOpen =   self._binder:GetValue('limitOpen')  
  self.txt_openDesc = self:AddBaseCom( GameUIText ,'txt_openDesc')
  self.activityTag =   self._binder:GetValue('activityTag')  


end

return ResourceChapterItemView
---自动生成代码----end----
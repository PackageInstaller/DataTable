---自动生成代码----start----
local StoryRoleIntroView = BaseClass( 'StoryRoleIntroView' , BaseView )
local M = StoryRoleIntroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_mask =   self._binder:GetValue('btn_mask')  
  self.img_role = self:AddBaseCom( GameRawImage ,'img_role')
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_label2 = self:AddBaseCom( GameUIText ,'txt_label2')
  self.txt_label1 = self:AddBaseCom( GameUIText ,'txt_label1')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.img_roleMask = self:AddBaseCom( GameRawImage ,'img_roleMask')
  self.img_icon = self:AddBaseCom( GameUIImage ,'img_icon')
  self.label2 =   self._binder:GetValue('label2')  
  self.txt_label3 = self:AddBaseCom( GameUIText ,'txt_label3')
  self.txt_label4 = self:AddBaseCom( GameUIText ,'txt_label4')
  self.canvasGroup =   self._binder:GetValue('canvasGroup')  
  self.animator =   self._binder:GetValue('animator')  
  self.txt_label5 = self:AddBaseCom( GameUIText ,'txt_label5')
  self.txt_label6 = self:AddBaseCom( GameUIText ,'txt_label6')
  self.label3 =   self._binder:GetValue('label3')  


end

return StoryRoleIntroView
---自动生成代码----end----
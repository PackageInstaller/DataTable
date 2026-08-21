---自动生成代码----start----
local PlotReviewUIView = BaseClass( 'PlotReviewUIView' , BaseView )
local M = PlotReviewUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_back =   self._binder:GetValue('btn_back')  
  self.node_list = self:AddBaseCom( CircularScrollView ,'node_list')
  self.mainPanel =   self._binder:GetValue('mainPanel')  
  self.img_pic1 = self:AddBaseCom( GameUIImage ,'img_pic1')
  self.txt_name1 = self:AddBaseCom( GameUIText ,'txt_name1')
  self.img_pic2 = self:AddBaseCom( GameUIImage ,'img_pic2')
  self.txt_name2 = self:AddBaseCom( GameUIText ,'txt_name2')
  self.img_pic3 = self:AddBaseCom( GameUIImage ,'img_pic3')
  self.txt_name3 = self:AddBaseCom( GameUIText ,'txt_name3')
  self.banner1 =   self._binder:GetValue('banner1')  
  self.banner2 =   self._binder:GetValue('banner2')  
  self.banner3 =   self._binder:GetValue('banner3')  
  self.banner4 =   self._binder:GetValue('banner4')  
  self.img_pic4 = self:AddBaseCom( GameUIImage ,'img_pic4')
  self.txt_name4 = self:AddBaseCom( GameUIText ,'txt_name4')


end

return PlotReviewUIView
---自动生成代码----end----
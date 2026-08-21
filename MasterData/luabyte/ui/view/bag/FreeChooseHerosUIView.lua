---自动生成代码----start----
local FreeChooseHerosUIView = BaseClass( 'FreeChooseHerosUIView' , BaseView )
local M = FreeChooseHerosUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.back =   self._binder:GetValue('back')  
  self.ok =   self._binder:GetValue('ok')  
  self.heroName = self:AddBaseCom( GameUIText ,'heroName')
  self.scrollview = self:AddBaseCom( CircularScrollView ,'scrollview')
  self.selectInfoArea =   self._binder:GetValue('selectInfoArea')  
  self.img_rare = self:AddBaseCom( GameUIImage ,'img_rare')


end

return FreeChooseHerosUIView
---自动生成代码----end----
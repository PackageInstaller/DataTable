---自动生成代码----start----
local DormInteractUI = BaseClass( 'DormInteractUI' , BaseView )
local M = DormInteractUI 
--desc

function M:__init(go)
  local trans = go.transform 
  self.slider = self:AddBaseCom( UISlider ,'slider')
  self.icon =   self._binder:GetValue('icon')  
  self.value = self:AddBaseCom( GameUIText ,'value')
  self.FavorPanel =   self:AddValue('','UI.View.Dorm.FavorPanel','FavorPanel')  


end

return DormInteractUI
---自动生成代码----end----
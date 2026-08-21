---自动生成代码----start----
local RestaurantItemView = BaseClass( 'RestaurantItemView' , BaseView )
local M = RestaurantItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state =   self._binder:GetValue('state')  
  self.select =   self._binder:GetValue('select')  
  self.addClick =   self._binder:GetValue('addClick')  
  self.headImg = self:AddBaseCom( GameUIImage ,'headImg')
  self.professionImg = self:AddBaseCom( GameUIImage ,'professionImg')
  self.barState =   self._binder:GetValue('barState')  
  self.bar =   self._binder:GetValue('bar')  
  self.lockText = self:AddBaseCom( GameUIText ,'lockText')
  self.labTime = self:AddBaseCom( GameUIText ,'labTime')
  self.StateSelect =   self._binder:GetValue('StateSelect')  


end

return RestaurantItemView
---自动生成代码----end----
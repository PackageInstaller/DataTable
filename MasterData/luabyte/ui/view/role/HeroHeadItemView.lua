---自动生成代码----start----
local HeroHeadItemView = BaseClass( 'HeroHeadItemView' , BaseView )
local M = HeroHeadItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.HeadIcon = self:AddBaseCom( GameUIImage ,'HeadIcon')
  self.Name = self:AddBaseCom( GameUIText ,'Name')
  self.Choose =   self._binder:GetValue('Choose')  
  self.ItemToggle = self:AddBaseCom( UIToggle ,'ItemToggle')
  self.RedPoint =   self._binder:GetValue('RedPoint')  
  self.Quality = self:AddBaseCom( GameUIImage ,'Quality')


end

return HeroHeadItemView
---自动生成代码----end----
---自动生成代码----start----
local ClothShowUIView = BaseClass( 'ClothShowUIView' , BaseView )
local M = ClothShowUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Bg = self:AddBaseCom( GameRawImage ,'Bg')
  self.Name = self:AddBaseCom( GameUIImage ,'Name')
  self.BtnSkin = self:AddBaseCom( GameUIImage ,'BtnSkin')


end

return ClothShowUIView
---自动生成代码----end----
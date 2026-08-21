---自动生成代码----start----
local GeneralBook = BaseClass( 'GeneralBook' , BaseView )
local M = GeneralBook 
--desc

function M:__init(go)
  local trans = go.transform 
  self.mask = self:AddBaseCom( GameUIImage ,'mask')
  self.RoleImage = self:AddBaseCom( GameRawImage ,'RoleImage')
  self.LeftText = self:AddBaseCom( GameUIText ,'LeftText')
  self.TitleText = self:AddBaseCom( GameUIText ,'TitleText')
  self.ContentText = self:AddBaseCom( GameUIText ,'ContentText')


end

return GeneralBook
---自动生成代码----end----
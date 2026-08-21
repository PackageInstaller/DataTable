---自动生成代码----start----
local FavorItemView = BaseClass( 'FavorItemView' , BaseView )
local M = FavorItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.Normal = self:AddBaseCom( GameUIImage ,'Normal')
  self.Select = self:AddBaseCom( GameUIImage ,'Select')
  self.Lock = self:AddBaseCom( GameUIImage ,'Lock')
  self.LevelText1 = self:AddBaseCom( GameUIText ,'LevelText1')
  self.LevelText2 = self:AddBaseCom( GameUIText ,'LevelText2')
  self.LevelText3 = self:AddBaseCom( GameUIText ,'LevelText3')
  self.ValueBg1 = self:AddBaseCom( GameUIImage ,'ValueBg1')
  self.ValueBg2 = self:AddBaseCom( GameUIImage ,'ValueBg2')
  self.ValueBg3 = self:AddBaseCom( GameUIImage ,'ValueBg3')
  self.Text1 = self:AddBaseCom( GameUIText ,'Text1')
  self.Text2 = self:AddBaseCom( GameUIText ,'Text2')
  self.Text3 = self:AddBaseCom( GameUIText ,'Text3')
  self.LevelText4 = self:AddBaseCom( GameUIText ,'LevelText4')
  self.ValueBg4 = self:AddBaseCom( GameUIImage ,'ValueBg4')
  self.Text4 = self:AddBaseCom( GameUIText ,'Text4')
  self.SelectLock = self:AddBaseCom( GameUIImage ,'SelectLock')


end

return FavorItemView
---自动生成代码----end----
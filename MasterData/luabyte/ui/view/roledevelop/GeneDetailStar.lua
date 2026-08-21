---自动生成代码----start----
local GeneDetailStar = BaseClass( 'GeneDetailStar' , BaseView )
local M = GeneDetailStar 
--desc

function M:__init(go)
  local trans = go.transform 
  self.star1 =   self._binder:GetValue('star1')  
  self.star2 = self:AddBaseCom( GameUIImage ,'star2')
  self.star3 = self:AddBaseCom( GameUIImage ,'star3')
  self.star4 = self:AddBaseCom( GameUIImage ,'star4')
  self.star5 = self:AddBaseCom( GameUIImage ,'star5')
  self.star6 = self:AddBaseCom( GameUIImage ,'star6')
  self.starEnable1 =   self._binder:GetValue('starEnable1')  
  self.starEnable2 = self:AddBaseCom( GameUIImage ,'starEnable2')
  self.starEnable3 = self:AddBaseCom( GameUIImage ,'starEnable3')
  self.starEnable4 = self:AddBaseCom( GameUIImage ,'starEnable4')
  self.starEnable5 = self:AddBaseCom( GameUIImage ,'starEnable5')
  self.starEnable6 = self:AddBaseCom( GameUIImage ,'starEnable6')


end

return GeneDetailStar
---自动生成代码----end----
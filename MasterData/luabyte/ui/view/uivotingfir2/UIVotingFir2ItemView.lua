---自动生成代码----start----
local UIVotingFir2ItemView = BaseClass( 'UIVotingFir2ItemView' , BaseView )
local M = UIVotingFir2ItemView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.textName = self:AddBaseCom( GameUIText ,'textName')
  self.textNum = self:AddBaseCom( GameUIText ,'textNum')
  self.imageRole = self:AddBaseCom( GameRawImage ,'imageRole')
  self.btn = self:AddBaseCom( UIButton ,'btn')
  self.btnHero = self:AddBaseCom( GameUIImage ,'btnHero')
  self.imageRole2 = self:AddBaseCom( GameRawImage ,'imageRole2')


end

return UIVotingFir2ItemView
---自动生成代码----end----
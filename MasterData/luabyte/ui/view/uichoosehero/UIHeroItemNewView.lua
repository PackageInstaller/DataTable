---自动生成代码----start----
local UIHeroItemNewView = BaseClass( 'UIHeroItemNewView' , BaseView )
local M = UIHeroItemNewView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn = self:AddBaseCom( GameUIImage ,'btn')
  self.imgMask = self:AddBaseCom( GameUIImage ,'imgMask')
  self.imgProfessionBg = self:AddBaseCom( GameUIImage ,'imgProfessionBg')
  self.imgHero = self:AddBaseCom( GameUIImage ,'imgHero')
  self.imgJob = self:AddBaseCom( GameUIImage ,'imgJob')
  self.imgLock = self:AddBaseCom( GameUIImage ,'imgLock')
  self.labLock = self:AddBaseCom( GameUIText ,'labLock')
  self.labName = self:AddBaseCom( GameUIText ,'labName')
  self.labLv = self:AddBaseCom( GameUIText ,'labLv')
  self.imgRarity = self:AddBaseCom( GameUIImage ,'imgRarity')
  self.tfSelect = self:AddBaseCom( GameUIImage ,'tfSelect')
  self.imgSelectNum = self:AddBaseCom( GameUIImage ,'imgSelectNum')
  self.imgNation = self:AddBaseCom( GameUIImage ,'imgNation')
  self.tfEffect =   self._binder:GetValue('tfEffect')  
  self.tfSelectBG = self:AddBaseCom( GameUIImage ,'tfSelectBG')
  self.btnLvUp = self:AddBaseCom( UIButton ,'btnLvUp')


end

return UIHeroItemNewView
---自动生成代码----end----
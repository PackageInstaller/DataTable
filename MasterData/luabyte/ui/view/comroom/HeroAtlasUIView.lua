---自动生成代码----start----
local HeroAtlasUIView = BaseClass( 'HeroAtlasUIView' , BaseView )
local M = HeroAtlasUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.scrollHero = self:AddBaseCom( CircularScrollView ,'scrollHero')
  self.rectCollect =   self._binder:GetValue('rectCollect')  
  self.txtHeroRate = self:AddBaseCom( GameUIText ,'txtHeroRate')
  self.rectBack =   self._binder:GetValue('rectBack')  
  self.tabClass =   self._binder:GetValue('tabClass')  
  self.imgNationType = self:AddBaseCom( GameUIImage ,'imgNationType')
  self.StateNation =   self._binder:GetValue('StateNation')  
  self.imgNation = self:AddBaseCom( GameUIImage ,'imgNation')
  self.redpoint =   self._binder:GetValue('redpoint')  
  self.animator =   self._binder:GetValue('animator')  
  self.tfMask =   self._binder:GetValue('tfMask')  


end

return HeroAtlasUIView
---自动生成代码----end----
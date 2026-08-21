---自动生成代码----start----
local PageHeroUpView = BaseClass( 'PageHeroUpView' , BaseView )
local M = PageHeroUpView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.card1 =   self:AddValue('UI.Ctrl.UIChooseHero.UIHeroItemNewCtrl','UI.View.UIChooseHero.UIHeroItemNewView','card1')  
  self.card2 =   self:AddValue('UI.Ctrl.UIChooseHero.UIHeroItemNewCtrl','UI.View.UIChooseHero.UIHeroItemNewView','card2')  
  self.card3 =   self:AddValue('UI.Ctrl.UIChooseHero.UIHeroItemNewCtrl','UI.View.UIChooseHero.UIHeroItemNewView','card3')  
  self.card4 =   self:AddValue('UI.Ctrl.UIChooseHero.UIHeroItemNewCtrl','UI.View.UIChooseHero.UIHeroItemNewView','card4')  
  self.card5 =   self:AddValue('UI.Ctrl.UIChooseHero.UIHeroItemNewCtrl','UI.View.UIChooseHero.UIHeroItemNewView','card5')  
  self.card1Btn =   self._binder:GetValue('card1Btn')  
  self.card2Btn =   self._binder:GetValue('card2Btn')  
  self.card3Btn =   self._binder:GetValue('card3Btn')  
  self.card4Btn =   self._binder:GetValue('card4Btn')  
  self.card5Btn =   self._binder:GetValue('card5Btn')  
  self.null1 =   self._binder:GetValue('null1')  
  self.null2 =   self._binder:GetValue('null2')  
  self.null3 =   self._binder:GetValue('null3')  
  self.null4 =   self._binder:GetValue('null4')  
  self.null5 =   self._binder:GetValue('null5')  


end

return PageHeroUpView
---自动生成代码----end----
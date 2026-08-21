---自动生成代码----start----
local Lottery10ResultView = BaseClass( 'Lottery10ResultView' , BaseView )
local M = Lottery10ResultView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.trans_bg =   self._binder:GetValue('trans_bg')  
  self.view_HeroItem0 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem0')  
  self.view_HeroItem1 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem1')  
  self.view_HeroItem2 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem2')  
  self.view_HeroItem3 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem3')  
  self.view_HeroItem4 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem4')  
  self.view_HeroItem5 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem5')  
  self.view_HeroItem6 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem6')  
  self.view_HeroItem7 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem7')  
  self.view_HeroItem8 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem8')  
  self.view_HeroItem9 =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemView','view_HeroItem9')  
  self.trans_BtnGroup =   self._binder:GetValue('trans_BtnGroup')  
  self.tsBtn_once = self:AddBaseCom( TSButton ,'tsBtn_once')
  self.tsBtn_ten = self:AddBaseCom( TSButton ,'tsBtn_ten')
  self.trans_consume1 =   self._binder:GetValue('trans_consume1')  
  self.trans_consume2 =   self._binder:GetValue('trans_consume2')  
  self.trans_BtnGroup =   self._binder:GetValue('trans_BtnGroup')  
  self.effect_ui_lottery =   self:AddValue('','UI.View.Lottery.LotteryResultHeroItemEffectView','effect_ui_lottery')  


end

return Lottery10ResultView
---自动生成代码----end----
---自动生成代码----start----
local DormGiftView = BaseClass( 'DormGiftView' , BaseView )
local M = DormGiftView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.ScrollView = self:AddBaseCom( CircularScrollView ,'ScrollView')
  self.FavorPanel =   self:AddValue('','UI.View.Dorm.FavorPanel','FavorPanel')  
  self.noGifts =   self._binder:GetValue('noGifts')  
  self.obtainBtn =   self._binder:GetValue('obtainBtn')  
  self.BtnL =   self._binder:GetValue('BtnL')  
  self.BtnR =   self._binder:GetValue('BtnR')  
  self.Content =   self._binder:GetValue('Content')  
  self.GiftItem =   self:AddValue('UI.Ctrl.Dorm.GiftItemCtrl','UI.View.Dorm.DormGiftItemView','GiftItem')  
  self.GuideObj =   self._binder:GetValue('GuideObj')  


end

return DormGiftView
---自动生成代码----end----
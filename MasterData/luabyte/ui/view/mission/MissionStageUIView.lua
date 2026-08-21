---自动生成代码----start----
local MissionStageUIView = BaseClass( 'MissionStageUIView' , BaseView )
local M = MissionStageUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.stagePanel =   self._binder:GetValue('stagePanel')  
  self.pointMask =   self._binder:GetValue('pointMask')  
  self.stageOpen =   self._binder:GetValue('stageOpen')  
  self.stageClose =   self._binder:GetValue('stageClose')  
  self.pointItem =   self:AddValue('','UI.View.Mission.MissionPointItemView','pointItem')  
  self.chapterScroll = self:AddBaseCom( CircularScrollView ,'chapterScroll')
  self.chapterContent =   self._binder:GetValue('chapterContent')  
  self.lastChapterBtn =   self._binder:GetValue('lastChapterBtn')  
  self.nextChapterBtn =   self._binder:GetValue('nextChapterBtn')  
  self.lastChapterNum = self:AddBaseCom( GameUIText ,'lastChapterNum')
  self.nextChapterNum = self:AddBaseCom( GameUIText ,'nextChapterNum')
  self.normalTag =   self._binder:GetValue('normalTag')  
  self.hardTag =   self._binder:GetValue('hardTag')  
  self.mapBg = self:AddBaseCom( GameRawImage ,'mapBg')
  self.stageAnim =   self._binder:GetValue('stageAnim')  
  self.cptReward =   self._binder:GetValue('cptReward')  
  self.starLine1 =   self._binder:GetValue('starLine1')  
  self.starLine2 =   self._binder:GetValue('starLine2')  
  self.starLine3 =   self._binder:GetValue('starLine3')  
  self.starLine4 =   self._binder:GetValue('starLine4')  
  self.stageCtrl =   self:AddValue('UI.Ctrl.Mission.MissionStagePanelCtrl','UI.View.Mission.MissionStagePanelView','stageCtrl')  
  self.chapterStars = self:AddBaseCom( GameUIText ,'chapterStars')
  self.mapScroll = self:AddBaseCom( UIScrollView ,'mapScroll')
  self.backGround =   self._binder:GetValue('backGround')  
  self.amountCtrl =   self:AddValue('UI.Ctrl.Common.ItemAmountUICtrl','UI.View.Common.ItemAmountUIView','amountCtrl')  
  self.remainTimes =   self._binder:GetValue('remainTimes')  
  self.txt_valueL = self:AddBaseCom( GameUIText ,'txt_valueL')
  self.txt_valueR = self:AddBaseCom( GameUIText ,'txt_valueR')
  self.btn_shop =   self._binder:GetValue('btn_shop')  
  self.img_shopIcon = self:AddBaseCom( GameUIImage ,'img_shopIcon')
  self.txt_shopName = self:AddBaseCom( GameUIText ,'txt_shopName')


end

return MissionStageUIView
---自动生成代码----end----
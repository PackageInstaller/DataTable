---自动生成代码----start----
local StoryNextView = BaseClass( 'StoryNextView' , BaseView )
local M = StoryNextView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.txtDialogue = self:AddBaseCom( EmojiText ,'txtDialogue')
  self.rectLine1 =   self._binder:GetValue('rectLine1')  
  self.rectLine2 =   self._binder:GetValue('rectLine2')  
  self.txtName = self:AddBaseCom( GameUIText ,'txtName')
  self.rectArrow =   self._binder:GetValue('rectArrow')  
  self.rectTips =   self:AddValue('UI.Misc.KeyWordTipsCtrl','UI.View.KeywordTipsView','rectTips')  
  self.txtTipsTitle = self:AddBaseCom( GameUIText ,'txtTipsTitle')
  self.txtTipsContent = self:AddBaseCom( GameUIText ,'txtTipsContent')
  self.rectDialoguePanel =   self._binder:GetValue('rectDialoguePanel')  
  self.rectNameLine =   self._binder:GetValue('rectNameLine')  
  self.rectGuideMark =   self._binder:GetValue('rectGuideMark')  
  self.rectGuideMarkRef =   self._binder:GetValue('rectGuideMarkRef')  
  self.imgGuidePanel = self:AddBaseCom( GameUIImage ,'imgGuidePanel')
  self.txtGuideName = self:AddBaseCom( GameUIText ,'txtGuideName')
  self.txtGuideContent = self:AddBaseCom( GameUIText ,'txtGuideContent')
  self.imgGuideHero = self:AddBaseCom( GameUIImage ,'imgGuideHero')
  self.rectSamPanel =   self._binder:GetValue('rectSamPanel')  
  self.txtSamDialogue = self:AddBaseCom( EmojiText ,'txtSamDialogue')
  self.rectBlackPanel =   self._binder:GetValue('rectBlackPanel')  
  self.txtBlackDialogue = self:AddBaseCom( GameUIText ,'txtBlackDialogue')
  self.rectHeadDialogue =   self._binder:GetValue('rectHeadDialogue')  
  self.imgHeadIcon = self:AddBaseCom( GameUIImage ,'imgHeadIcon')
  self.txtHeadName = self:AddBaseCom( GameUIText ,'txtHeadName')


end

return StoryNextView
---自动生成代码----end----
---自动生成代码----start----
local UIVotingHeroView = BaseClass( 'UIVotingHeroView' , BaseView )
local M = UIVotingHeroView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btnVote = self:AddBaseCom( GameUIImage ,'btnVote')
  self.btnLeft = self:AddBaseCom( UIButton ,'btnLeft')
  self.btnRight = self:AddBaseCom( UIButton ,'btnRight')
  self.toggleInformation = self:AddBaseCom( UIToggle ,'toggleInformation')
  self.toggleSupport = self:AddBaseCom( UIToggle ,'toggleSupport')
  self.Left1 =   self._binder:GetValue('Left1')  
  self.Left2 =   self._binder:GetValue('Left2')  
  self.ScrollView1 = self:AddBaseCom( CircularScrollView ,'ScrollView1')
  self.ScrollView2 = self:AddBaseCom( CircularScrollView ,'ScrollView2')
  self.Role = self:AddBaseCom( GameRawImage ,'Role')
  self.textSelfIndex = self:AddBaseCom( GameUIText ,'textSelfIndex')
  self.tfNoRank =   self._binder:GetValue('tfNoRank')  
  self.textSelfName = self:AddBaseCom( GameUIText ,'textSelfName')
  self.textSelfValue = self:AddBaseCom( GameUIText ,'textSelfValue')
  self.imgProfession = self:AddBaseCom( GameUIImage ,'imgProfession')
  self.textName =   self._binder:GetValue('textName')  
  self.textTips = self:AddBaseCom( GameUIText ,'textTips')
  self.tfTips =   self._binder:GetValue('tfTips')  
  self.anim =   self._binder:GetValue('anim')  


end

return UIVotingHeroView
---自动生成代码----end----
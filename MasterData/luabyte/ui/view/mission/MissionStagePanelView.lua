---自动生成代码----start----
local MissionStagePanelView = BaseClass( 'MissionStagePanelView' , BaseView )
local M = MissionStagePanelView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_map = self:AddBaseCom( GameRawImage ,'btn_map')
  self.star4Bg =   self._binder:GetValue('star4Bg')  
  self.enemyBtn =   self._binder:GetValue('enemyBtn')  
  self.challengeContent =   self._binder:GetValue('challengeContent')  
  self.challengeItem =   self._binder:GetValue('challengeItem')  
  self.missionText = self:AddBaseCom( GameUIText ,'missionText')
  self.missionName = self:AddBaseCom( GameUIText ,'missionName')
  self.missionChapter = self:AddBaseCom( GameUIText ,'missionChapter')
  self.rewardContent =   self._binder:GetValue('rewardContent')  
  self.rewardItem =   self._binder:GetValue('rewardItem')  
  self.doubleReward =   self._binder:GetValue('doubleReward')  
  self.recommendLv = self:AddBaseCom( GameUIText ,'recommendLv')
  self.curLv = self:AddBaseCom( GameUIText ,'curLv')
  self.battleBtn =   self._binder:GetValue('battleBtn')  
  self.mopBtn =   self._binder:GetValue('mopBtn')  
  self.consumeNum = self:AddBaseCom( GameUIText ,'consumeNum')
  self.doubleTag =   self._binder:GetValue('doubleTag')  
  self.energyValue = self:AddBaseCom( GameUIText ,'energyValue')
  self.energyBtn =   self._binder:GetValue('energyBtn')  
  self.rewardBtn =   self._binder:GetValue('rewardBtn')  
  self.doubleTimes = self:AddBaseCom( GameUIText ,'doubleTimes')
  self.img_energy = self:AddBaseCom( GameUIImage ,'img_energy')
  self.suggestNode =   self._binder:GetValue('suggestNode')  
  self.wordTitle =   self._binder:GetValue('wordTitle')  
  self.starState =   self._binder:GetValue('starState')  
  self.hardType = self:AddBaseCom( UIToggle ,'hardType')
  self.helpTip =   self._binder:GetValue('helpTip')  


end

return MissionStagePanelView
---自动生成代码----end----
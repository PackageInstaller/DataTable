---自动生成代码----start----
local BossWarMainUIView = BaseClass( 'BossWarMainUIView' , BaseView )
local M = BossWarMainUIView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.btn_award =   self._binder:GetValue('btn_award')  
  self.btn_shop =   self._binder:GetValue('btn_shop')  
  self.txt_day = self:AddBaseCom( GameUIText ,'txt_day')
  self.txt_hour = self:AddBaseCom( GameUIText ,'txt_hour')
  self.txt_level = self:AddBaseCom( GameUIText ,'txt_level')
  self.missionItem1 =   self:AddValue('UI.Ctrl.BossWar.BossWarMissionItemCtrl','UI.View.BossWar.BossWarMissionItemView','missionItem1')  
  self.missionItem2 =   self:AddValue('UI.Ctrl.BossWar.BossWarMissionItemCtrl','UI.View.BossWar.BossWarMissionItemView','missionItem2')  
  self.missionItem3 =   self:AddValue('UI.Ctrl.BossWar.BossWarMissionItemCtrl','UI.View.BossWar.BossWarMissionItemView','missionItem3')  


end

return BossWarMainUIView
---自动生成代码----end----
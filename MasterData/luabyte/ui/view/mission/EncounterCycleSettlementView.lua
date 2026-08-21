---自动生成代码----start----
local EncounterCycleSettlementView = BaseClass( 'EncounterCycleSettlementView' , BaseView )
local M = EncounterCycleSettlementView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.state_bg =   self._binder:GetValue('state_bg')  
  self.txt_name = self:AddBaseCom( GameUIText ,'txt_name')
  self.txt_desc = self:AddBaseCom( GameUIText ,'txt_desc')
  self.clickBg =   self._binder:GetValue('clickBg')  
  self.fromEncounterTitle =   self:AddValue('UI.Ctrl.Mission.EncounterTitleCtrl','UI.View.Mission.EncounterTitleView','fromEncounterTitle')  
  self.toEncounterTitle =   self:AddValue('UI.Ctrl.Mission.EncounterTitleCtrl','UI.View.Mission.EncounterTitleView','toEncounterTitle')  


end

return EncounterCycleSettlementView
---自动生成代码----end----
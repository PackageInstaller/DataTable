---自动生成代码----start----
local EncounterBattleSettlementView = BaseClass( 'EncounterBattleSettlementView' , BaseView )
local M = EncounterBattleSettlementView 
--desc

function M:__init(go)
  local trans = go.transform 
  self.roleCtrl =   self:AddValue('UI.Ctrl.Battle.BattleEnd.BattleRoleCtrl','UI.View.Battle.BattleEnd.BattleRoleView','roleCtrl')  
  self.closeBtn =   self._binder:GetValue('closeBtn')  
  self.nameText = self:AddBaseCom( GameUIText ,'nameText')
  self.txt_timer = self:AddBaseCom( GameUIText ,'txt_timer')


end

return EncounterBattleSettlementView
---自动生成代码----end----
local state = BaseState:New(BattleState.BattleStart)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     local against = Game.Scene:GetComponent("AgainstComponent")
     against.BattleWin = false
     DamageShareData.ResetIdSeed()
     state.battleComp.battle_ui_component = Game.Scene:GetComponent("BattleUIComponent")
     local num = against.IsAutoGame and math.max(state.battleComp.AutoBattleValue, against.IsAutoGame) or state.battleComp.AutoBattleValue
     state.battleComp:SetAutoBattle(num)
     state.battleComp.fsm:Switch(BattleState.BatchStart)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state
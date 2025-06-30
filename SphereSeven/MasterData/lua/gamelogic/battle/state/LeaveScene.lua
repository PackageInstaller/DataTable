local state = BaseState:New(BattleState.LeaveScene)

function state:OnInit()
     state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     Time.timeScale = 1
     Game.Scene:GetComponent("BgmComponent"):Stop()
     Game.Scene:GetComponent("SoundComponent"):MainStop()
     Game.Scene:RemoveComponent("BattleUIComponent")
     Game.Scene:RemoveComponent("MatrixComponent")
     Game.Scene:RemoveComponent("BattleCameraComponent")
     Game.Scene:RemoveComponent("PlayerBattleComponent")
     Game.Scene:RemoveComponent("BattleSsUnitUIComponent")
     Game.Scene.Player:GetComponent("PlayerBuffComponent"):SetLevelBuff(false)
     Game.Scene:GetComponent("GuideComponent"):EndGuide()--新手指引结束
     Game.Scene:GetComponent("GuideComponent"):removeCards()--删除新手指引数据
     UIData.ResetCurTeam()
     --杀死敌人数在离开场景计算，中途关闭程序不计算
     local KilEnemyNum =  Game.Scene:GetComponent("BattleComponent").KilEnemyNum
     Game.Scene.SceneComponent:SwitchScene(state.battleComp.offline and SceneConfig.LoginScene or SceneConfig.HomeScene)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state
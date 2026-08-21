-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/UnitAnimState.lua

module("logic.common.datadef.UnitAnimState", package.seeall)

local UnitAnimState = {}

UnitAnimState.Idle = "idle"
UnitAnimState.IdleBack = "idle3"
UnitAnimState.Change = "change"
UnitAnimState.ChangeBack = "change1"
UnitAnimState.Walk = "run"
UnitAnimState.WalkBack = "run2"
UnitAnimState.Hit = "hit1"
UnitAnimState.Death = "die"
UnitAnimState.Cast = "cast"
UnitAnimState.React = "react"
UnitAnimState.Show = "show"
UnitAnimState.Enter = "enter"
UnitAnimState.LeftEnter = "enter_2"
UnitAnimState.XiuXian = "xiuxian"
UnitAnimState.Idle1 = "idle1"
UnitAnimState.Idle2 = "idle2"
UnitAnimState.Idle2Back = "idle4"
UnitAnimState.Walk2 = "run2"
UnitAnimState.Hit2 = "hit2"
UnitAnimState.Death2 = "die"
UnitAnimState.Change2 = "change2"
UnitAnimState.Aim = "aim_idle"
UnitAnimState.AimPrepare = "aim_start"
UnitAnimState.AimEnd = "aim_end"
UnitAnimState.AttackSkip = "attack_skip"
UnitAnimState.BreakIdle = "break_idle"
UnitAnimState.BreakHit = "break_hit1"
UnitAnimState.BreakHit2 = "break_hit2"
UnitAnimState.BreakWalk = "break_run"
UnitAnimState.BreakDeath = "break_death"
UnitAnimState.BothIdle = "both_idle"
UnitAnimState.LeftIdle = "onlyleft_idle"
UnitAnimState.RightIdle = "onlyright_idle"
UnitAnimState.NoneIdle = "none_idle"
UnitAnimState.BothToLeft = "both_onlyleft_change"
UnitAnimState.BothToRight = "both_onlyright_change"
UnitAnimState.LeftToNone = "onlyleft_none_change"
UnitAnimState.RightToNone = "onlyright_none_change"
UnitAnimState.NoneToBoth = "none_both_change"
UnitAnimState.UniqueSpecial = "boss_unique_loop"
UnitAnimState.VictoryIdle = "victory_idle"
UnitAnimState.HitList = {
	"hit1",
	"hit2",
	"hit_air",
	"hit_lie",
	"hit_up",
	"hit_down",
	"hit_floating",
	"get_up"
}
UnitAnimState.MainSceneIdle = "loop"
UnitAnimState.Greet = "greet"

return UnitAnimState

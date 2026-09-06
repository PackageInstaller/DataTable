-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/MainPlayerAnimState.lua

module("logicscene.scene.unit.MainPlayerAnimState", package.seeall)

local MainPlayerAnimState = {}

MainPlayerAnimState.Direction = {}
MainPlayerAnimState.Idle = "idle"
MainPlayerAnimState.Walk = "walk"
MainPlayerAnimState.Move = "move"
MainPlayerAnimState.Dig = "dig"
MainPlayerAnimState.Search = "search"
MainPlayerAnimState.Greet = "greet"
MainPlayerAnimState.Unlock = "unlock"
MainPlayerAnimState.Bandage = "bandage"
MainPlayerAnimState.Salute = "salute"
MainPlayerAnimState.Chop = "chop"
MainPlayerAnimState.Pick = "pick"
MainPlayerAnimState.Bomb = "bomb"
MainPlayerAnimState.Windfly = "windfly"
MainPlayerAnimState.Dance = "dance"
MainPlayerAnimState.Sit = "sit"
MainPlayerAnimState.Cloths1041 = "1041cloths"
MainPlayerAnimState.StateIntractive_Break = "intractive_break"
MainPlayerAnimState.StateIntractive_NBreak = "intractive_nbreak"
MainPlayerAnimState.StateIntractive3P_Break = "intractive_3p_break"
MainPlayerAnimState.StateIntractive3P_NBreak = "intractive_3p_nbreak"
MainPlayerAnimState.Configs = {
	[MainPlayerAnimState.Dig] = {
		state = MainPlayerAnimState.StateIntractive3P_Break,
		clips = {
			"dig01",
			"dig02",
			"dig03"
		}
	}
}

function MainPlayerAnimState.isChildStateMachine(stateName)
	return stateName == MainPlayerAnimState.StateIntractive3P_Break or stateName == MainPlayerAnimState.StateIntractive3P_NBreak
end

return MainPlayerAnimState

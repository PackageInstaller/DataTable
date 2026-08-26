-- chunkname: @modules/logic/partygame/test/PartyGame_GM.lua

module("modules.logic.partygame.test.PartyGame_GM", package.seeall)

local PartyGame_GM = class("PartyGame_GM")

require("tolua.reflection")
tolua.loadassembly("PartyGame")

local type_hotfix = tolua.findtype("PartyGame.Runtime.GameLogic.HotFix_GM")
local method1 = tolua.getmethod(type_hotfix, "GameOver")
local method2 = tolua.getmethod(type_hotfix, "CMD", typeof("System.String"))
local method3 = tolua.getmethod(type_hotfix, "GetIsUseAI")
local method4 = tolua.getmethod(type_hotfix, "SetIsUseAI", typeof("System.Boolean"))
local method5 = tolua.getmethod(type_hotfix, "CardDropWin")
local method6 = tolua.getmethod(type_hotfix, "SetPlayerNum", typeof("System.Int32"))
local method7 = tolua.getmethod(type_hotfix, "ClearGameIds")
local method8 = tolua.getmethod(type_hotfix, "AddGameId", typeof("System.Int32"))

function PartyGame_GM.GameOver()
	return method1:Call()
end

function PartyGame_GM.CMD(cmd)
	return method2:Call(cmd)
end

function PartyGame_GM.GetIsUseAI()
	return method3:Call()
end

function PartyGame_GM.SetIsUseAI(isUse)
	return method4:Call(isUse)
end

function PartyGame_GM.CardDropWin()
	return method5:Call()
end

function PartyGame_GM.SetPlayerNum(num)
	return method6:Call(num)
end

function PartyGame_GM.ClearGameIds()
	return method7:Call()
end

function PartyGame_GM.AddGameId(gameId)
	return method8:Call(gameId)
end

return PartyGame_GM

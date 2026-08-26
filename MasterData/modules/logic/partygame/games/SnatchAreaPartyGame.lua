-- chunkname: @modules/logic/partygame/games/SnatchAreaPartyGame.lua

module("modules.logic.partygame.games.SnatchAreaPartyGame", package.seeall)

local SnatchAreaPartyGame = class("SnatchAreaPartyGame", PartyGameBase)

function SnatchAreaPartyGame:getGameViewName()
	return ViewName.SnatchAreaGameView
end

function SnatchAreaPartyGame:initCsGameBase(csGameBase)
	SnatchAreaPartyGame.super.initCsGameBase(self, csGameBase)
	PartyGameCSDefine.SnatchAreaInterfaceCs.HotFix_Temp("16_SetLuaCommandCallBack", self.csCallback, self)
end

function SnatchAreaPartyGame:csCallback()
	GameFacade.showToast(ToastEnum.SnatchAreaPartyGame_341200)
end

function SnatchAreaPartyGame:onSceneClose()
	PartyGameCSDefine.SnatchAreaInterfaceCs.HotFix_Temp("16_ClearLuaCommandCallback", nil, nil)
	SnatchAreaPartyGame.super.onSceneClose(self)
end

return SnatchAreaPartyGame

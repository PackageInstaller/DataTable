-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/impl/SeasonEvtPlayGame.lua

module("logic.extensions.season.model.evt.impl.SeasonEvtPlayGame", package.seeall)

local SeasonEvtPlayGame = class("SeasonEvtPlayGame", SeasonEvtBase)

SeasonEvtPlayGame.GAME_TYPE_FLOWER = 1
SeasonEvtPlayGame.GAME_TYPE_BLOW_BALLOON = 2
SeasonEvtPlayGame.GAME_TYPE_BURY = 3

function SeasonEvtPlayGame:_doClient(teamId, evtType, params, evtConfig, evtDetailConfig)
	UIStateManager.instance:push(ViewName.SeasonDefaultGridShowView, {
		strTitle = lang("来玩一场游戏吧"),
		evtDetailConfig = evtDetailConfig,
		evtConfig = evtConfig,
		strDesc = evtDetailConfig.desc,
		teamId = teamId,
		sureCallback = function()
			self:_doSendStartGame()
		end
	})
	self:rollBackPosition()
end

function SeasonEvtPlayGame:_doSendStartGame()
	printInfo(".......................SeasonEvtPlayGame:_doSendStartGame")

	local obj = {}

	obj.startGame = true
	self.clientKey = math.random(ServerTime.now())
	obj.clientKey = self.clientKey

	self:applySendHandlerEvent(obj)
end

function SeasonEvtPlayGame:_doSendEndGame(list, key, extMap)
	printInfo(".......................SeasonEvtPlayGame:_doSendEndGame")

	local obj = {}

	obj.encryptedKey = GameUtil.getClientEncryptedKey(self.clientKey, self.serverKey, list)
	obj[key] = list

	if extMap then
		for k, v in pairs(extMap) do
			obj[k] = v
		end
	end

	self:applySendHandlerEvent(obj)
end

function SeasonEvtPlayGame:_doServer(evtType, params, evtConfig, evtDetailConfig, msg)
	if not string.nilorempty(msg.resultParam) then
		local resultJson = GameUtil.jsonToTable(msg.resultParam)

		if resultJson and resultJson.serverKey then
			self.serverKey = resultJson.serverKey

			self:openOrStartGame()
		end
	end
end

function SeasonEvtPlayGame:openOrStartGame()
	print(">>>>>>>>>>>>>openOrStartGame")

	if self._evtDetailConfig then
		local type = self._evtDetailConfig.type

		print(">>>>>>>>>>>>>openOrStartGame:::::::", type)

		if type == SeasonEvtPlayGame.GAME_TYPE_FLOWER then
			UIStateManager.instance:push(ViewName.SeasonGuessBoxSceneView, self)
		elseif type == SeasonEvtPlayGame.GAME_TYPE_BLOW_BALLOON then
			UIStateManager.instance:push(ViewName.SeasonBlowBalloonGameView, self)
		elseif type == SeasonEvtPlayGame.GAME_TYPE_BURY then
			UIStateManager.instance:push(ViewName.SeasonBuryGameMainView, self)
		end
	end
end

return SeasonEvtPlayGame

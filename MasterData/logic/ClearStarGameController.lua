-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/clearstargame/controller/ClearStarGameController.lua

module("logic.extensions.clearstargame.controller.ClearStarGameController", package.seeall)

local ClearStarGameController = class("ClearStarGameController", BaseController)

function ClearStarGameController:ctor()
	return
end

function ClearStarGameController:onInit()
	self:onReset()
end

function ClearStarGameController:onReset()
	self._curMaxTypeId = nil
end

function ClearStarGameController:getInfo(activityId)
	ClearStarGameAgent.instance:sendPM_ClearStarGameInfoReq(activityId)
end

function ClearStarGameController:handleGetInfo(msg)
	ClearStarGameModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ClearStarGameGetInfo)
end

function ClearStarGameController:startGame(activityId)
	local clientKey = ServerTime.nowServerLook()

	ClearStarGameModel.instance:saveClientKey(clientKey)
	ClearStarGameAgent.instance:sendPM_ClearStarGameStartReq(activityId, clientKey)
end

function ClearStarGameController:handleStartGame(msg)
	local info = GameUtil.pbToTable(msg)

	ClearStarGameModel.instance:saveServeKey(info.serverKey)
	GlobalDispatcher:dispatch(GlobalNotify.ClearStarGameStartGame)
end

function ClearStarGameController:enterGame(activityId, isPractise, scoreType)
	UIStateManager.instance:push(ViewName.ClearStarGameView, activityId, isPractise, scoreType)
end

function ClearStarGameController:endGame(activityId, save, scores_pb_Ary, useItems_pb_Ary)
	local req = ClearStarGameExtension_pb.PM_ClearStarGameEndReq()
	local scoresArr = {}

	if scores_pb_Ary and #scores_pb_Ary > 0 then
		for i = 1, #scores_pb_Ary do
			local param = req.scores:add()

			param.scoreType = scores_pb_Ary[i].scoreType
			param.num = scores_pb_Ary[i].num

			table.insert(scoresArr, param)
		end
	end

	local itemsArr = {}

	if useItems_pb_Ary and #useItems_pb_Ary > 0 then
		for i = 1, #useItems_pb_Ary do
			local param = req.useItems:add()

			param.id = useItems_pb_Ary[i].id
			param.num = useItems_pb_Ary[i].num

			table.insert(itemsArr, param)
		end
	end

	local serverKey = ClearStarGameModel.instance:getServeKey()
	local clientKey = ClearStarGameModel.instance:getClientKey()

	serverKey = GenEncryptedKeyUtil.dxor(serverKey, clientKey)

	local encryptedKey = 0

	local function encrypt(num)
		encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
	end

	local addparam = save and 1 or 0

	encrypt(addparam)
	ClearStarGameAgent.instance:sendPM_ClearStarGameEndReq(activityId, save, scoresArr, itemsArr, encryptedKey)
end

function ClearStarGameController:handleEndGame(msg)
	ClearStarGameModel.instance:onEndGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ClearStarGameEndGame)
end

function ClearStarGameController:handlerSweepGame(msg)
	ClearStarGameModel.instance:onEndGame(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ClearStarGameEndGame)
end

ClearStarGameController.instance = ClearStarGameController.New()

return ClearStarGameController

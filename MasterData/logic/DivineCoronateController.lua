-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinecoronate/controller/DivineCoronateController.lua

module("logic.extensions.divinecoronate.controller.DivineCoronateController", package.seeall)

local DivineCoronateController = class("DivineCoronateController", BaseController)

function DivineCoronateController:onInit()
	self:onReset()
end

function DivineCoronateController:onReset()
	math.randomseed(os.time())
end

function DivineCoronateController:shuffleConfig(table)
	for i = #table, 2, -1 do
		local j = math.random(i)

		table[i], table[j] = table[j], table[i]
	end

	return table
end

function DivineCoronateController:sendStartGameReq(activityId)
	local clientKey = math.random(ServerTime.now())

	DivineCoronateAgent.instance:sendPM_DivineCoronateStartGameReq(activityId, clientKey)
end

DivineCoronateController.instance = DivineCoronateController.New()

return DivineCoronateController

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/agent/CityAgent.lua

module("logic.extensions.city.agent.CityAgent", package.seeall)

local CityAgent = class("CityAgent", BaseAgent)

function CityAgent:onInit()
	return
end

function CityAgent:sendEnterGameReq()
	local req = RoomExtension_pb.EnterGameReq()

	self:sendMsg(req)
end

function CityAgent:handleEnterGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CityAgent:sendJoinAndLeaveRoomReq(targetRoomName, x, y, z)
	print("CityAgent:sendJoinAndLeaveRoomReq()-请求加入房间：" .. targetRoomName)

	local req = RoomExtension_pb.JoinAndLeaveRoomReq()

	req.targetRoomName = targetRoomName
	req.pos.x = x
	req.pos.y = y
	req.pos.z = z

	self:sendMsg(req)
end

function CityAgent:sendCreateAndJoinRoomReq(roomName, x, y, z)
	local req = RoomExtension_pb.CreateAndJoinRoomReq()

	req.roomName = roomName
	req.pos.x = x
	req.pos.y = y
	req.pos.z = z

	self:sendMsg(req)
end

function CityAgent:handleNotifyJoinRoomSucRes(status, msg)
	if status == 0 then
		MountController.instance:handleTeamMountRoomSyncRes(msg)
		print("请求加入房间成功,roomName:" .. msg.roomName)

		local roomname = msg.roomName
		local userlist = msg.userList
		local x = msg.pos.x
		local z = msg.pos.z

		if not msg.pos.y then
			local y = 0

			SceneMainPlayer.instance:updateVariables(msg.userVariabls)

			local userVariabls
			local targetSceneId = SceneConfig.instance:getSceneIdByEngSceneName(roomname)
			local bornX, bornZ, underBridge

			if CityModel.instance.fromSceneId > 0 then
				bornX = CityModel.instance.toScenePosX
				bornZ = CityModel.instance.toScenePosY

				if not CityModel.instance.toScenePosX or not bornZ then
					bornX, bornZ = SceneConfig.instance:getBornPoint(targetSceneId, CityModel.instance.fromSceneId)
				end
			else
				bornZ = z
				bornX = x
			end

			CityController.instance:onEnterCity(targetSceneId, bornX, bornZ, y ~= 0, userVariabls)
			CityController.instance:onEnterCityUsers(userlist)
		end
	else
		FloatWordMgr.instance:show("加入房间失败,resultCode=" .. status)
	end

	CityModel.instance.fromSceneId = 0
end

function CityAgent:handleNotifyEnterRoomRes(status, msg)
	if status == 0 then
		local mo = CityPlayerMO.New()

		mo:initData(msg)
		CityController.instance:onPlayerEnterCity(mo)
		printInfo("CityAgent:handleNotifyEnterRoomRes: succeed---------")
	end
end

function CityAgent:handleNotifyLeaveRoomToAllRes(status, msg)
	if status == 0 then
		local userid = msg.userId
		local leaveroomname = msg.leaveRoomName

		CityController.instance:onPlayerLeaveCity(userid, leaveroomname)
	end
end

function CityAgent:sendSetUserVari(...)
	local args = ...

	if args ~= nil then
		args = {
			...
		}

		local list = {}

		for i, var in ipairs(args) do
			local variable = RoomExtension_pb.Variable()

			variable.varName = var.varName
			variable.type = var.type
			variable.value = var.value

			table.insert(list, variable)
		end

		if #list > 0 then
			self:sendSetUserVariablesReq(list)
		end
	end
end

function CityAgent:sendSetUserVariablesReq(variables)
	local req = RoomExtension_pb.SetUserVariablesReq()

	for i = 1, #variables do
		table.insert(req.variables, variables[i])
	end

	self:sendMsg(req)
end

function CityAgent:handleSetUserVariablesRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CityAgent:handleNotifyUserVariablesUpdateRes(status, msg)
	if status == 0 then
		local userid = msg.userId
		local variables = msg.variables

		CityController.instance:onUserVariable(userid, variables)
	end
end

function CityAgent:sendBridgeState(under)
	local variable = RoomExtension_pb.Variable()

	variable.varName = "ob"

	if under then
		variable.type = "number"
		variable.value = "1"
	else
		variable.type = "x"
		variable.value = "1"
	end

	local req = RoomExtension_pb.SetUserVariablesReq()

	table.insert(req.variables, variable)
	self:sendMsg(req)
end

function CityAgent:sendMoveReq(x, y, z, isTeleport)
	if isTeleport == nil then
		isTeleport = false
	end

	local req = RoomExtension_pb.MoveReq()

	req.pos.x = x
	req.pos.y = y
	req.pos.z = z
	req.isTeleport = isTeleport

	self:sendMsg(req)
end

function CityAgent:handleMoveRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CityAgent:handleNotifyMoveRes(status, msg)
	if status == 0 then
		local movements = msg.movements

		for i = 1, #movements do
			local msg = movements[i]
			local userid = msg.userId
			local x = msg.pos.x
			local z = msg.pos.z
			local underBridge = msg.pos.y ~= 0
			local isteleport = msg.isTeleport

			CityController.instance:onPlayerMove(userid, x, z, underBridge, isteleport)
		end
	end
end

function CityAgent:sendRefreshRoomDataReq()
	local req = RoomExtension_pb.RefreshRoomDataReq()

	self:sendMsg(req)
end

function CityAgent:handleRefreshRoomDataRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function CityAgent:handleNotifySceneMonsterChangedRes(status, msg)
	if status == 0 then
		local zones = msg.zones

		CityController.instance:onSceneMonsters(zones)
	end
end

function CityAgent:handleNotifyNewUnlockSceneRes(status, msg)
	if status == 0 then
		local sceneid = msg.sceneId

		UnlockFacade.instance:onSceneUnLock(sceneid)
	end
end

function CityAgent:handleJoinAndLeaveRoomRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

CityAgent.instance = CityAgent.New()

return CityAgent

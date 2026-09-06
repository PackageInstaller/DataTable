-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/controller/CityController.lua

module("logic.extensions.city.controller.CityController", package.seeall)

local CityController = class("CityController", BaseController)

function CityController:onInit()
	return
end

function CityController:onReset()
	TilingSceneMgr.instance:reset()
	SceneStatusMgr.instance:clearStatus()
	SceneMgr.instance:enabledTransition()
	TriggersMgr.instance:clear()
	BarriersMgr.instance:clear()
	SceneNpcsMgr.instance:clear()
	SceneElemsMgr.instance:clear()
	LightMgr.instance:clear()
	SceneFestivalMgr.instance:clear()
end

function CityController:enterCity(sceneId, fromSceneId)
	if CityModel.instance.toSceneId > 0 or sceneId and sceneId > 0 and CityModel.instance.curSceneId == sceneId then
		printInfo("CityModel.instance.toSceneId=" .. CityModel.instance.toSceneId .. ",targetSceneId:" .. sceneId)

		return
	end

	if sceneId and sceneId > 0 then
		CityModel.instance.toSceneId = sceneId
		CityModel.instance.fromSceneId = fromSceneId
	end

	local sceneCo = SceneConfig.instance:getSceneCo(sceneId)

	if not sceneCo then
		printError("不存在的场景,sceneId=" .. sceneId)

		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and mainPlayer.syncPos then
		mainPlayer.syncPos:disable(true)
		mainPlayer.syncPos:clear()
		mainPlayer.mover:disable(true)
	end

	local posX = CityModel.instance.toScenePosX
	local posY = CityModel.instance.toScenePosY

	if not posX or not posY then
		posX, posY = SceneConfig.instance:getBornPoint(sceneId, fromSceneId)
	end

	CityAgent.instance:sendJoinAndLeaveRoomReq(sceneCo.eng_scene_name, posX, 0, posY)
	dispatcher:dispatch(GlobalNotify.LeaveCityDone)
end

function CityController:onEnterCity(sceneId, x, z, underBridge, userVariabls)
	if CityModel.instance.toSceneId > 0 then
		CityModel.instance.curSceneId = sceneId
		CityModel.instance.curCitySceneId = sceneId
		CityModel.instance.toSceneId = 0

		CityModel.instance:removeAllPlayers()
		CityModel.instance:removeAllMonsters()

		local sceneCO = SceneConfig.instance:getSceneCo(sceneId)

		SceneMgr.instance:enter(sceneCO.type, sceneId, x, z, underBridge, userVariabls)
		dispatcher:dispatch(GlobalNotify.EnterCityDone)
	end
end

function CityController:onEnterCityUsers(userlist)
	if userlist then
		for i = 1, #userlist do
			local user = userlist[i]
			local mo = CityPlayerMO.New()

			mo:initData(user)
			self:onPlayerEnterCity(mo)
		end
	end
end

function CityController:onPlayerEnterCity(mo)
	CityModel.instance:addPlayerMo(mo)
	GlobalDispatcher:dispatch(GlobalNotify.PlayerEnterScene, mo)
end

function CityController:onPlayerLeaveCity(userId, leaveroomname)
	local leaveSceneId = SceneConfig.instance:getSceneIdByEngSceneName(leaveroomname)

	if leaveSceneId ~= CityModel.instance.curSceneId then
		return
	end

	CityModel.instance:removePlayerMo(userId)
	GlobalDispatcher:dispatch(GlobalNotify.PlayerLeaveScene, userId)
end

function CityController:onUserVariable(userId, variables)
	local mo = CityModel.instance:getPlayerMo(userId)

	if mo then
		mo:updateVariables(variables)
	end

	if checknumber(userId) == LoginModel.instance.userId then
		SceneMainPlayer.instance:updateVariables(variables)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnPlayerVariables, userId)
end

function CityController:onPlayerMove(userid, x, y, underBridge, isteleport)
	local mo = CityModel.instance:getPlayerMo(userid)

	if mo then
		mo.x = x
		mo.y = y
		mo.underBridge = underBridge
	end

	GlobalDispatcher:dispatch(GlobalNotify.PlayerMove, userid, x, y, underBridge, isteleport)
end

function CityController:removeMonster(zoneId, mstId)
	CityModel.instance:removeMonsterMo(zoneId, mstId)
	GlobalDispatcher:dispatch(GlobalNotify.OnRemoveSceneMonster, zoneId, mstId)
end

function CityController:onSceneMonsters(zones)
	if zones then
		local currNums = {}
		local newNums = {}
		local dict = CityModel.instance:getMonstersMoDict()

		if dict then
			for k, v in pairs(dict) do
				local cNums = currNums[k]
				local nNums = newNums[k]

				if not cNums then
					cNums = {}
					currNums[k] = cNums
				end

				if not nNums then
					nNums = {}
					newNums[k] = nNums
				end

				for i = 1, #v do
					local mstId = v[i]

					if not cNums[mstId] then
						local num = 0

						num = num + 1
						cNums[mstId] = num
						nNums[mstId] = 0
					end
				end
			end
		end

		for i = 1, #zones do
			local zone = zones[i]
			local mstCount = #zone.monsters
			local cNums = currNums[zone.zoneId]
			local nNums = newNums[zone.zoneId]

			if not cNums then
				cNums = {}
				currNums[zone.zoneId] = cNums
			end

			if not nNums then
				nNums = {}
				newNums[zone.zoneId] = nNums
			end

			for k = 1, mstCount do
				local mstId = zone.monsters[k]

				if not nNums[mstId] then
					local num = 0

					num = num + 1
					nNums[mstId] = num
					cNums[mstId] = cNums[mstId] or 0
				end
			end
		end

		for k, v in pairs(currNums) do
			for k1, v1 in pairs(v) do
				local mstId = k1
				local cNum = v1
				local nNum = newNums[k][mstId]

				if nNum < cNum then
					local mstCount = cNum - nNum

					for k2 = 1, mstCount do
						self:removeMonster(k, mstId)
					end
				elseif cNum < nNum then
					local mstCount = nNum - cNum

					for k2 = 1, mstCount do
						CityModel.instance:addMonsterMo(k, mstId)
						GlobalDispatcher:dispatch(GlobalNotify.OnCreateSceneMonster, k, mstId)
					end
				end
			end
		end
	end

	CityModel.instance.isMonsterDataReady = true
end

CityController.instance = CityController.New()

return CityController

-- chunkname: @modules/logic/room/utils/RoomHelper.lua

module("modules.logic.room.utils.RoomHelper", package.seeall)

local RoomHelper = {}

function RoomHelper.isFSMState(stateName)
	local scene = GameSceneMgr.instance:getCurScene()
	local curStateName = scene.fsm:getCurStateName()

	return curStateName == stateName
end

function RoomHelper.isOutCameraFocusCenter(pos)
	return RoomHelper._checkOutCameraFocus(pos.x, pos.y, 0.5, 300, 440, 300, 300)
end

function RoomHelper.isOutCameraFocus(pos)
	return RoomHelper._checkOutCameraFocus(pos.x, pos.y, 3.2, 300, 440, 300, 300)
end

function RoomHelper.isOutCameraFocusByPlaceCharacter(worldX, worldZ, paddingBottom)
	return RoomHelper._checkOutCameraFocus(worldX, worldZ, 3.2, 300, paddingBottom or 440, 300, 300)
end

function RoomHelper._checkOutCameraFocus(worldX, worldZ, distance, paddingTop, paddingBottom, paddingLeft, paddingRight)
	local tscene = GameSceneMgr.instance:getCurScene()
	local focusPos = tscene.camera:getCameraFocus()
	local focusDistance = Vector2.Distance(focusPos, Vector2(worldX, worldZ))

	if distance < focusDistance then
		return true
	end

	return RoomHelper._checkCameraFocusByPadding(worldX, worldZ, paddingTop, paddingBottom, paddingLeft, paddingRight)
end

function RoomHelper._checkCameraFocusByPadding(worldX, worldZ, paddingTop, paddingBottom, paddingLeft, paddingRight)
	local worldPos = Vector3(worldX, 0, worldZ)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local hudGO = ViewMgr.instance:getUILayer("HUD")
	local hudGOTrs = hudGO.transform
	local bendingPosXBottom = bendingPos.x
	local bendingPosZBottom = bendingPos.z
	local worldPosBottom = Vector3(bendingPosXBottom, bendingPos.y, bendingPosZBottom)
	local localPosBottom = recthelper.worldPosToAnchorPos(worldPosBottom, hudGOTrs)
	local width = recthelper.getWidth(hudGOTrs)
	local height = recthelper.getHeight(hudGOTrs)
	local posX = localPosBottom.x
	local minX = math.abs(paddingLeft) - width / 2
	local maxX = width / 2 - math.abs(paddingRight)

	if posX < minX or maxX < posX then
		return true
	end

	local posY = localPosBottom.y
	local minY = math.abs(paddingBottom) - height / 2
	local maxY = height / 2 - math.abs(paddingTop)

	if posY < minY or maxY < posY then
		return true
	end

	return false
end

function RoomHelper.getCenterPoint(hexPointList)
	local centerX = 0
	local centerY = 0

	for i, hexPoint in ipairs(hexPointList) do
		centerX = centerX + hexPoint.x
		centerY = centerY + hexPoint.y
	end

	centerX = centerX / #hexPointList
	centerY = centerY / #hexPointList

	return HexPoint(centerX, centerY)
end

function RoomHelper.getAngle(p1, p2)
	local dot = Vector2.Dot(p1, p2)

	if dot == 0 then
		return 90
	end

	local length1 = Vector2.Magnitude(p1)
	local length2 = Vector2.Magnitude(p2)

	if length1 == 0 or length2 == 0 then
		return 0
	end

	local cos = dot / length1 / length2

	return Mathf.Acos(cos) * Mathf.Rad2Deg
end

function RoomHelper.setGlobalFloat(nameId, value)
	if RoomController.instance:isDebugMode() then
		return
	end

	UnityEngine.Shader.SetGlobalFloat(nameId, value)
end

function RoomHelper.getGlobalFloat(nameId)
	return UnityEngine.Shader.GetGlobalFloat(nameId)
end

function RoomHelper.setGlobalColor(nameId, value)
	if RoomController.instance:isDebugMode() then
		return
	end

	UnityEngine.Shader.SetGlobalColor(nameId, value)
end

function RoomHelper.getBlockPrefabName(prefabPath)
	local paths = string.split(prefabPath, "/")
	local nameParams = string.split(paths[#paths], ".")

	return nameParams[1]
end

function RoomHelper.hideBlockPackageReddot(packageId)
	local reddotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBlockPackage)

	if not reddotInfo or not reddotInfo.infos then
		return
	end

	local info = reddotInfo.infos[packageId]

	if not info then
		return
	end

	if info.value > 0 then
		RoomRpc.instance:sendHideBlockPackageReddotRequest(packageId)
	end
end

function RoomHelper.getRendererList(go)
	local rendererList = {}

	if go then
		local meshRendererList = go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

		RoomHelper.cArrayToLuaTable(meshRendererList, rendererList)
	end

	return rendererList
end

function RoomHelper.initSceneRootTrs()
	local sceneRootGO = CameraMgr.instance:getSceneRoot()
	local cameraRootGO = CameraMgr.instance:getCameraRootGO()
	local rootGOs = {
		cameraRootGO,
		sceneRootGO
	}

	if sceneRootGO then
		table.insert(rootGOs, gohelper.findChild(sceneRootGO, "RoomScene"))
	end

	for _, rootGO in ipairs(rootGOs) do
		if rootGO then
			local animator = rootGO:GetComponent(typeof(UnityEngine.Animator))

			if animator then
				animator.enabled = false
			end

			transformhelper.setPos(rootGO.transform, 0, 0, 0)
		end
	end
end

local prevLogTime = 0

function RoomHelper.logElapse(msg, timeLimit)
	local now = UnityEngine.Time.realtimeSinceStartup
	local elapsed = now - prevLogTime

	if not timeLimit or timeLimit < elapsed then
		prevLogTime = now

		logNormal(string.format("小屋加载：%.3f +%.3f ", now, elapsed) .. msg)
	end
end

local startTime = 0

function RoomHelper.logStart(msg)
	startTime = UnityEngine.Time.realtimeSinceStartup
	prevLogTime = UnityEngine.Time.realtimeSinceStartup

	logNormal("小屋加载：" .. msg)
end

function RoomHelper.logEnd(msg)
	local now = UnityEngine.Time.realtimeSinceStartup
	local elapsed = now - prevLogTime

	prevLogTime = now

	logNormal(string.format("小屋加载：%.3f +%.3f total=%.3f ", now, elapsed, now - startTime) .. msg)
end

function RoomHelper.getGameObjectsByNameInChildren(parentGO, name, result)
	result = result or {}

	if not parentGO or string.nilorempty(name) then
		return result
	end

	ZProj.AStarPathBridge.FindChildrenByName(parentGO, name, result)

	return result
end

function RoomHelper.cArrayToLuaTable(carray, luaList)
	if carray then
		local tLuaList = luaList or {}

		ZProj.AStarPathBridge.ArrayToLuaTable(carray, tLuaList)

		return tLuaList
	end
end

function RoomHelper.vector3Distance2(va, vb)
	return (va.x - vb.x)^2 + (va.y - vb.y)^2 + (va.z - vb.z)^2
end

function RoomHelper.audioExtendTrigger(audioExtendId, go)
	local cfg = RoomConfig.instance:getAudioExtendConfig(audioExtendId)

	if not cfg then
		return
	end

	if cfg.audioId < 1 then
		logNormal(string.format("export_音效拓展 id[%s] audioId:%s", audioExtendId, cfg.audioId))

		return
	end

	if not string.nilorempty(cfg.rtpc) then
		AudioMgr.instance:setRTPCValue(cfg.rtpc, cfg.rtpcValue)
	end

	if not string.nilorempty(cfg.switchGroup) then
		if not string.nilorempty(cfg.switchState) then
			local groupId = AudioMgr.instance:getIdFromString(cfg.switchGroup)
			local stateId = AudioMgr.instance:getIdFromString(cfg.switchState)

			AudioMgr.instance:setSwitch(groupId, stateId, go)
			logNormal(string.format("RoomHelper.audioExtendTrigger(audioExtendId,go) groupId[%s] stateId[%s] audioId[%s]", groupId, stateId, cfg.audioId))
		else
			logNormal(string.format("export_音效拓展 id[%s] switchState 字段没配置", audioExtendId))
		end
	end

	AudioMgr.instance:trigger(cfg.audioId, go, false)
end

function RoomHelper.randomArray(array)
	local count = #array
	local randomValue, random

	for i = 1, count do
		random = math.random(1, count)
		array[random] = array[i]
		array[i] = array[random]
	end
end

function RoomHelper.add2KeyValue(dict, x, y, value)
	dict[x] = dict[x] or {}
	dict[x][y] = value
end

function RoomHelper.get2KeyValue(dict, x, y)
	local xDic = dict[x]

	return xDic and xDic[y]
end

function RoomHelper.mergeCfg(targetCfg, mergeCfg)
	local metatable = {}

	function metatable.__index(t, key)
		local merge = rawget(t, 2)

		if merge then
			local mergeValue = merge[key]

			if not string.nilorempty(mergeValue) then
				return mergeValue
			end
		end

		local target = rawget(t, 1)

		if target then
			return target[key]
		end
	end

	function metatable.__newindex(_, key, value)
		logError("Can't modify config field: " .. key)
	end

	local cfg = {
		targetCfg,
		mergeCfg
	}

	setmetatable(cfg, metatable)

	return cfg
end

function RoomHelper.getBuildingLevelUpTipsParam(buildingUid)
	local params = {}
	local levelDesc = {
		desc = luaLang("room_building_level_up_tip")
	}

	table.insert(params, levelDesc)

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	local upgradeGroup = ManufactureConfig.instance:getBuildingUpgradeGroup(buildingMO.buildingId)

	if upgradeGroup and upgradeGroup ~= 0 then
		local newItemInfoList = {}
		local checkRepeatDict = {}
		local level = buildingMO:getLevel()
		local newManufactureItemList = ManufactureConfig.instance:getNewManufactureItemList(upgradeGroup, level)

		for _, manufactureItemId in ipairs(newManufactureItemList) do
			local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

			if not checkRepeatDict[itemId] then
				newItemInfoList[#newItemInfoList + 1] = {
					type = MaterialEnum.MaterialType.Item,
					id = itemId
				}
				checkRepeatDict[itemId] = true
			end
		end

		local newItemInfo = {
			desc = luaLang("room_new_manufacture_item"),
			newItemInfoList = newItemInfoList
		}

		table.insert(params, newItemInfo)
	end

	return params
end

function RoomHelper.sortBuildingById(aBuildingMO, bBuildingMO)
	if not aBuildingMO or not bBuildingMO then
		return false
	end

	return aBuildingMO.buildingId < bBuildingMO.buildingId
end

function RoomHelper.getNumberByKey(playerPrefsKey)
	local key = playerPrefsKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.getNumber(key, 0)
end

function RoomHelper.setNumberByKey(playerPrefsKey, number)
	local key = playerPrefsKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.setNumber(key, number)
end

return RoomHelper

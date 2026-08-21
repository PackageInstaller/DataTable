-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragCenter.lua

local UIUtils = require("Framework.UI.UIUtils")
local RearHouseInfoPanel = require("UI/RearHouse/RearHouseInfoPanel")
local RearHouseCleanInfoPanel = require("UI/RearHouse/RearHouseCleanInfoPanel")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local ResHero = require("ClientData/ResHero")
local ResRearHouse = require("ClientData/ResRearHouse")
local ResRearHouseBagConfig = require("ClientData/ResRearHouseBagConfig")
local ResRearHouseInitWallConfig = require("ClientData/ResRearHouseInitWallConfig")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResItem = require("ClientData/ResItem")
local ResCrystalMisc = require("ClientData/ResCrystalMisc")
local UserData = require("Helper/UserData")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseModelCenter = require("Logic/RearHouse/RearHouseModelCenter")
local SceneLightManager = UnityEngine.PostProcessing.SceneLightManager
local SHOW_EVENT = {
	CRYSTAL = 1,
	ATTR = 2
}
local RearHouseDragCenter = {}
local DEFAULT_ZONE_NAME = "Wall1"
local MODE = {
	VISIT = 3,
	EDIT = 2,
	MAIN = 1
}
local CONFIG = {
	rearHouseMainDlg = MODE.MAIN,
	rearHouseEditDlg = MODE.EDIT,
	rearHouseVisitMainDlg = MODE.VISIT
}
local self = RearHouseDragCenter

self.inited = false

function RearHouseDragCenter.start(state)
	RearHouseModelCenter.init(self)

	self.mEventDelObj = nil
	self.mEventAddObj = nil
	self.zones = {}
	self.zoneMap = {}
	self.curMode = {}
	self.pinchFlag = false
	self.clickObj = false
	self.isDragingObj = false
	self.logo = nil
	self.cleanLogo = nil
	self.MODE = MODE
	self.curWallName = DEFAULT_ZONE_NAME
	self.effectIds = {}
	self.mainState = state

	for i = 1, Const.REARHOUSE_WALL_NUM do
		self.zoneMap["Wall" .. i] = i
	end

	self.initLogo()
	self.initCleanLogo()
	self.initChoosingEffect()

	self.inited = true
end

function RearHouseDragCenter.initWallData(index)
	local i = index
	local wallName = "Wall" .. i
	local wallClassName = "RearHouseDragWall"

	if i ~= 1 then
		wallClassName = "RearHouseDragWall2"
	end

	local _class = require("Logic/RearHouse/" .. wallClassName)

	if _class then
		self.zones[wallName] = _class(self, self.mainState, wallName, index)
	end
end

function RearHouseDragCenter.dataReady(...)
	if CurAvatar.rearHouseState.unlock_award ~= 0 then
		if self.cachedVisitData ~= nil then
			self.initData(self.cachedVisitData, Const.REARHOUSE_CREATE_MODE.VISIT)

			self.cachedVisitData = nil
		else
			self.initData(nil, Const.REARHOUSE_CREATE_MODE.MINE)
		end
	end
end

function RearHouseDragCenter.setMode(ui)
	self.curMode.mode = CONFIG[ui.mUIName]
	self.curMode.ui = ui

	if ui.panelBg then
		ui.panelBg:setDragFunc(self.onDrag)
		ui.panelBg:setClickFunc(self.onClick)
		ui.panelBg:setDragBeginFunc(self.onDragBegin)
		ui.panelBg:setDragEndFunc(self.onDragEnd)
		ui.panelBg:setPinchFunc(self.onPinch)
		ui.panelBg:setLongPressFunc(self.onLongPress)
		ui.panelBg:setTouchEndFunc(self.onTouchEnd)
	end

	if self.curMode.mode == MODE.MAIN then
		self.setEffectTarget(nil)
		self.hideReflectPlane(false)
		SceneLightManager.EnableMainLightShadow(true)
	elseif self.curMode.mode == MODE.EDIT then
		self.hideReflectPlane(true)
		SceneLightManager.EnableMainLightShadow(false)
	end

	self.showBack(self.curMode.mode == MODE.EDIT)
	self.clearState(true)
	self.changeEventState("clearDrag")
end

function RearHouseDragCenter.leaveMode()
	self.showBack(false)

	self.mEventAddObj = nil
	self.mEventDelObj = nil
end

function RearHouseDragCenter.isMainMode(...)
	return self.curMode.mode == MODE.MAIN
end

function RearHouseDragCenter.getCurWallBoundsInfo(...)
	if self.curWallName and self.zones and next(self.zones) ~= nil then
		return self.zones[self.curWallName].bounds
	end
end

function RearHouseDragCenter.initLogo()
	if self.logo == nil then
		self.logo = RearHouseInfoPanel(nil, "System/Backyard/BackyardEditPanel", 0, 0, self)
	end

	self.logo:setVisible(false)

	self.logo.mConfirmClick = self.onConfirmClick
	self.logo.mDelClick = self.onDelClick
	self.logo.mFlipClick = self.onFlipClick
end

function RearHouseDragCenter.initCleanLogo(...)
	if self.cleanLogo == nil then
		self.cleanLogo = RearHouseCleanInfoPanel(nil, "System/Backyard/BackyardEditPanel2", 0, 0, self)
	end

	self.cleanLogo.mCleanClick = self.onCleanClick
end

function RearHouseDragCenter.initChoosingEffect(...)
	local instId, controller = EffectManager:loadLogicEffect("Effects/Heros/Common/efx_common_triangolo.prefab")

	controller:SetLayer("Effect")

	self.greenEffect = {
		id = instId,
		controller = controller
	}
	instId, controller = EffectManager:loadLogicEffect("Effects/Heros/Common/efx_common_triangolo_01.prefab")

	controller:SetLayer("Effect")

	self.redEffect = {
		id = instId,
		controller = controller
	}
end

function RearHouseDragCenter.changeEffectState(isRed)
	if isRed then
		self.redEffect.controller:TurnOn()
		self.greenEffect.controller:TurnOff()
	else
		self.redEffect.controller:TurnOff()
		self.greenEffect.controller:TurnOn()
	end
end

function RearHouseDragCenter.setEffectTarget(obj)
	if obj then
		self.greenEffect.controller:SetNormalEffect(obj.effectAnchor, "", Vector3(0, 0, 10), Vector3.zero, 4)
		self.redEffect.controller:SetNormalEffect(obj.effectAnchor, "", Vector3(0, 0, 10), Vector3.zero, 4)
		self.greenEffect.controller:TurnOn()
		self.redEffect.controller:TurnOn()
	else
		self.greenEffect.controller:TurnOff()
		self.redEffect.controller:TurnOff()

		self.greenEffect.controller.transform.parent = nil
		self.redEffect.controller.transform.parent = nil
	end
end

function RearHouseDragCenter.showBack(v)
	if self.inited == false then
		return
	end

	local zone = self.getCurZone()

	if not zone:isInitWallObjsLoadEnd() then
		return
	end

	self.setInitObjsGray(v)
	self.getCurZone():showBack(v)
end

function RearHouseDragCenter.changeWall(index, withoutCheck)
	local wallName = "Wall" .. index

	self.curWallName = wallName

	if self.zones[self.curWallName] then
		local houseData = self.getCurShowData()

		self.refreshUnlockAreas(houseData.level)
	else
		if next(self.zones) then
			UIUtils.StopRearHouseDrag()
		end

		for name, zone in pairs(self.zones) do
			zone:destroy()
		end

		self.zones = {}

		self.initWallData(index)
	end

	RearHouseModelCenter.changeWall(withoutCheck)
end

function RearHouseDragCenter.hideReflectPlane(v)
	if not self.reflectPlane then
		self.reflectPlane = {}

		for i = 1, Const.REARHOUSE_WALL_NUM do
			local go = UnityEngine.GameObject.Find("Wall" .. i)

			if go then
				local art = go.transform.parent
				local tran = art:Find("Plane")

				if tran then
					table.insert(self.reflectPlane, tran.gameObject)
				end
			end
		end
	end

	if self.reflectPlane and #self.reflectPlane > 0 then
		for _, plane in pairs(self.reflectPlane) do
			plane:SetActive(not v)
		end
	end
end

function RearHouseDragCenter.getCurWallName(...)
	return self.curWallName or DEFAULT_ZONE_NAME
end

function RearHouseDragCenter.getCurZone(...)
	if self.zones then
		return self.zones[self.curWallName]
	end
end

function RearHouseDragCenter.getCurZoneId(...)
	return self.getZoneId(self.curWallName)
end

function RearHouseDragCenter.onDrag(delta)
	if not self.isDragingObj then
		self.mainState:onDrag(delta)
	end
end

function RearHouseDragCenter.onClick(...)
	if self.curMode.mode == MODE.MAIN or self.curMode.mode == MODE.VISIT then
		local ui = self.curMode.ui

		if ui.hideFlag == true then
			ui:showUI(true)
		end
	end

	if self.curMode.mode == MODE.VISIT then
		return
	end

	self.clickObj = false

	self.changeEventState("click")

	if self.clickObj == false then
		if self.curMode.mode == MODE.EDIT then
			if self.curDragObj then
				self.curDragObj:onDragPut(true)
			end

			self.setEffectTarget(nil)
			self.logo:setVisible(false)
		elseif self.curMode.mode == MODE.MAIN then
			self.cleanLogo:setVisible(false)
		end

		self.clearState()
		self.changeEventState("clearDrag")
	end
end

function RearHouseDragCenter.onDragBegin(vec)
	if self.curMode.mode ~= MODE.EDIT then
		return
	end

	self.changeEventState("dragBegin", vec.x, vec.y)
end

function RearHouseDragCenter.onDragEnd(delta)
	self.changeEventState("dragEnd")

	if self.isDragingObj then
		if self.curDragObj then
			self.logo:setVisible(true)
			self.curDragObj:onDragPut(false)
		end
	elseif not self.pinchFlag then
		self.mainState:onDragEnd(delta)
	end

	self.isDragingObj = false
	self.pinchFlag = false
end

function RearHouseDragCenter.onPinch(delta)
	if not self.pinchFlag then
		self.isDragingObj = false
		self.pinchFlag = true

		self.changeEventState("pinch")
	end

	self.mainState:onPinch(delta.y)
end

function RearHouseDragCenter.onTouchEnd(...)
	self.mainState:onTouchEnd()
end

function RearHouseDragCenter.onLongPress(...)
	self.onClick()
end

function RearHouseDragCenter.onFlipClick(...)
	if self.curDragObj then
		self.curDragObj:onFlipClick()
	end
end

function RearHouseDragCenter.onConfirmClick(...)
	self.changeEventState("clearDrag")

	if self.curDragObj then
		self.curDragObj:onConfirmClick()
	end

	self.logo:setVisible(false)
end

function RearHouseDragCenter.onDelClick(...)
	if self.curDragObj then
		local result = self.curDragObj:onDelClick()

		self.logo:setVisible(not result)
	end
end

function RearHouseDragCenter.onCleanClick(...)
	self.clearState(true)
	UIManager.getUI("rearHouseCleanDlg", true):setData(self.cleanLogo:getTargetHero())
end

function RearHouseDragCenter.onSliderValueChange(value)
	self.mainState:setSliderValue(value)
end

function RearHouseDragCenter.setSliderValue(value)
	if self.curMode and self.curMode.ui and self.curMode.ui.setSliderValue then
		self.curMode.ui:setSliderValue(value)
	end
end

function RearHouseDragCenter.createWhenLoadend(...)
	RearHouseModelCenter.createWhenLoadend()
end

function RearHouseDragCenter.setPreset(id)
	if not self.inited then
		return
	end

	RearHouseModelCenter.startCreatePreview(id)
end

function RearHouseDragCenter.visit(data, mode)
	if GameFsm.isInState(Const.STATE_MAIN_REAR_HOUSE) and self.inited == true then
		self.initData(data, mode or Const.REARHOUSE_CREATE_MODE.VISIT, true)
	else
		self.cachedVisitData = data
		self.isJump = true

		if CurAvatar.rearHouseState.unlock_award == 0 then
			RPC.houseUnlockAwardGet()
		end

		GameFsm.translateState(Const.STATE_MAIN_REAR_HOUSE)
	end
end

function RearHouseDragCenter.initData(data, mode, withoutCheck)
	local creatData

	if data == nil then
		creatData = CurAvatar.rearHouseData
	else
		creatData = data.house
	end

	RearHouseModelCenter.dataReady(creatData, mode, withoutCheck)

	local initIndex = 1

	if mode == Const.REARHOUSE_CREATE_MODE.VISIT then
		if creatData.main_room and creatData.main_room ~= 0 then
			initIndex = creatData.main_room
		end
	elseif CurAvatar.mainRoom and CurAvatar.mainRoom ~= 0 then
		initIndex = CurAvatar.mainRoom
	end

	self.mainState:changeWall(initIndex, withoutCheck)

	if withoutCheck ~= true then
		self.mainState:checkMainDlg()
	end

	if mode == Const.REARHOUSE_CREATE_MODE.VISIT then
		local ui = UIManager.getUI("rearHouseVisitMainDlg", nil, false)

		if ui == nil then
			ui = UIManager.getUI("rearHouseVisitMainDlg", true)
		end

		ui:setData(data)
	end
end

function RearHouseDragCenter.refreshItems(...)
	RearHouseModelCenter.refreshItems()
end

function RearHouseDragCenter.getOccupyInfo(modelId, isTurn)
	return RearHouseModelCenter.getOccupyInfo(modelId, isTurn)
end

function RearHouseDragCenter.getModelData(...)
	return RearHouseModelCenter.getModelData()
end

function RearHouseDragCenter.getPutedMap(...)
	return RearHouseModelCenter.getPutedMap()
end

function RearHouseDragCenter.isInMode(mode)
	return RearHouseModelCenter.isInMode(mode)
end

function RearHouseDragCenter.getCurShowData(...)
	return RearHouseModelCenter.getCurShowData()
end

function RearHouseDragCenter.getCurUnlockWall(wallIndex)
	return RearHouseCommon.getCurUnlockWall(wallIndex)
end

function RearHouseDragCenter.refreshUnlockAreas(unlockLevel)
	local zone = self.getCurZone()
	local id = self.getCurZoneId()

	if zone then
		local startLevel = RearHouseCommon.getWallUnlockLevel(id)
		local endLevel = RearHouseCommon.getNextWallUnlockLevel(id)
		local level = math.min(endLevel, math.max(startLevel, unlockLevel))

		zone:initUnLockAreas(level)
	end
end

function RearHouseDragCenter.refreshHeros(removeData, isOpenTime)
	return
end

function RearHouseDragCenter.isEffectShowing(...)
	if self.effectShowing then
		return true
	else
		return false
	end
end

function RearHouseDragCenter.refreshOpArea(level)
	local idx = RearHouseCommon.getCurUnlockWall(self.getCurZoneId())

	if idx > 0 then
		self.mainState:refreshLimitHeight(idx)
		self.mainState:calculateLimitData()
	end
end

function RearHouseDragCenter.unlockEffect(data)
	local curUnlockWall = self.getCurZone():getCurUnlockWall()
	local idx = ResRearHouseLevelConfig[data.unlockLevel].unlock_wall

	if curUnlockWall < idx and idx >= 5 then
		self.mainState:refreshLimitHeight(idx)
		self.mainState:calculateLimitData()

		local localPos, worldPos = self.zones[self.curWallName]:getLockPosOffset(idx)

		self.mainState:focusToPos(worldPos)
	else
		self.mainState:focusToPos(nil)
	end

	if data.unlockLevel == ResRearHouseMiscConfig[1].crystal_unlock_lv then
		self.delObjByType(5)
		self.saveToServer()
	end

	coroutine.start(self._coPlayEffect, self.coUnlockEffect, data)
end

function RearHouseDragCenter.playCleanEffect(...)
	coroutine.start(self._coPlayEffect, self.coCleanEffect)
end

function RearHouseDragCenter.coCleanEffect()
	local tran = self.zones[self.curWallName]:getEffectParentTransform()
	local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_clean.prefab")

	controller:SetLayer("Effect")

	local pos = self.mainState:getCameraPos()

	pos.y = pos.y - tran.position.y
	pos = Vector3(0, -7.5 + pos.y, 2)

	controller:SetNormalEffect(tran, "", pos, Vector3(0, 0, 0), 0)
	controller:TurnOn()
	coroutine.wait(2)
	table.insert(self.effectIds, instId)
	UIManager.getUI("rearHouseCleanAwardDlg", true):setData(RearHouseCommon.getRandHero(), true)
end

function RearHouseDragCenter._coPlayEffect(func, ...)
	self.blockClick(true)

	self.effectShowing = true

	func(...)
	self.releaseEffect()

	self.effectShowing = false

	self.blockClick(false)
end

function RearHouseDragCenter.coUnlockEffect(data)
	local tran = self.getCurZone():getEffectParentTransform()
	local idx = ResRearHouseLevelConfig[data.unlockLevel].unlock_wall
	local curUnlockWall = self.getCurZone():getCurUnlockWall()

	if curUnlockWall < idx then
		local offset = self.getCurZone():getLockPosOffset(idx)
		local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_crystal_01.prefab")

		controller:SetLayer("Effect")
		controller:SetNormalEffect(tran, "", offset, Vector3(0, 0, 0), 0)
		table.insert(self.effectIds, instId)
		controller:TurnOn()
		coroutine.wait(0.5)
		self.refreshUnlockAreas(data.unlockLevel)
		coroutine.wait(1.5)
		UIManager.getUI("rearHouseUnlockDlg", true):setData(data.unlockDescs)
		coroutine.wait(1.5)
	else
		UIManager.getUI("rearHouseUnlockDlg", true):setData(data.unlockDescs)
		coroutine.wait(1.5)
	end

	if data.unlockLevel == ResRearHouseMiscConfig[1].crystal_unlock_lv then
		local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_crystal_02.prefab")

		controller:SetLayer("Effect")
		table.insert(self.effectIds, instId)
		controller:SetNormalEffect(tran, "", Vector3(-0.2, -15.5, 3.51), Vector3(0, 0, 0), 0)
		controller:TurnOn()
		coroutine.wait(0.2)
		self.resetLoad(Functor(RearHouseModelCenter.createStageHeros))
		self.logo:setVisible(false)
		coroutine.wait(1.8)
		controller:TurnOff()
	end
end

function RearHouseDragCenter.coCrystalSecondPart(data)
	local tran = self.zones[self.curWallName]:getEffectParentTransform()
	local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_crystal_02_1.prefab")

	controller:SetLayer("Effect")
	table.insert(self.effectIds, instId)
	controller:SetNormalEffect(tran, "", Vector3(-0.2, -15.5, 3.51), Vector3(0, 0, 0), 0)
	controller:TurnOn()
	coroutine.wait(2)
	controller:TurnOff()
	UIManager.getUI("rearHouseUnlockDlg", true):setData(data.unlockDescs)
	coroutine.wait(1.5)
end

function RearHouseDragCenter.removeHeros(removeData)
	self.zones[self.curWallName]:removeHeros(removeData)
end

function RearHouseDragCenter.removeWallPic(...)
	self.zones[self.curWallName]:removeWallPic()
end

function RearHouseDragCenter.getNowObjsCountByType(typeId)
	local zone = self.getCurZone()

	if zone then
		return zone:getNowObjsCountByType(typeId)
	end

	return 0
end

function RearHouseDragCenter.getObjsByType(typeIds)
	return self.zones[self.curWallName]:getObjsByType(typeIds)
end

function RearHouseDragCenter.addObjFinal(data)
	RearHouseModelCenter.addObjFinal(data)
end

function RearHouseDragCenter.resetLoad(func)
	self.zones[self.curWallName]:resetLoad(func)
end

function RearHouseDragCenter.delObjByType(typeId)
	for name, zone in pairs(self.zones) do
		zone:delObjByType(typeId)
	end
end

function RearHouseDragCenter.delAllObj(isForceAll, isIncludeStage)
	RearHouseModelCenter.delAllObj(isForceAll, isIncludeStage)
end

function RearHouseDragCenter.resetOpration(...)
	local zone = self.getCurZone()

	if zone then
		zone:resetOpration()
	end

	self.logo:setVisible(false)
end

function RearHouseDragCenter.getZoneId(zoneName)
	return self.zoneMap[zoneName] or 1
end

function RearHouseDragCenter.getZoneName(zoneId)
	for name, id in pairs(self.zoneMap or {}) do
		if id == zoneId then
			return name
		end
	end

	return DEFAULT_ZONE_NAME
end

function RearHouseDragCenter.setClickingObj(...)
	self.clickObj = true
end

function RearHouseDragCenter.checkLoadHigh()
	for name, zone in pairs(self.zones) do
		zone:checkHeroModelHigh()
	end
end

function RearHouseDragCenter.setCurDragObj(obj)
	if self.curDragObj and self.curDragObj ~= obj and self.curMode.mode == MODE.EDIT then
		self.curDragObj:onDragPut(true)
	end

	self.curDragObj = obj

	self.setChooseState()
end

function RearHouseDragCenter.setChooseState(...)
	if self.curMode.mode == MODE.MAIN then
		if self.curDragObj == nil then
			self.cleanLogo:setVisible(false)
		elseif self.curDragObj.type == 5 and RearHouseCommon.isCleanUnlock() == true then
			self.cleanLogo:setTarget(self, self.curDragObj)
			self.cleanLogo:setVisible(true)
		end
	else
		self.checkObjAttr()

		if self.curDragObj == nil then
			self.logo:setVisible(false)
			self.setEffectTarget(nil)
		else
			self.refreshLogoState()
			self.setEffectTarget(self.curDragObj)
		end
	end
end

function RearHouseDragCenter.checkObjAttr(...)
	if self.curDragObj == nil then
		if self.curMode and self.curMode.ui and self.curMode.ui.checkAttrInfo then
			self.curMode.ui:checkAttrInfo()
		end
	else
		local mid = self.curDragObj.modelId
		local attrInfo = RearHouseCommon.getAttrInfoByMid(mid)

		if self.curMode and self.curMode.ui and self.curMode.ui.checkAttrInfo then
			self.curMode.ui:checkAttrInfo(attrInfo)
		end
	end
end

function RearHouseDragCenter.getCurValidAttrNum(attrInfo)
	local map = {}

	for i, mid in ipairs(attrInfo.model_ids) do
		map[mid] = true
	end

	local count = 0

	for name, zone in pairs(self.zones) do
		if name == self.curWallName and zone then
			local data = zone:getCurPutSaveData()

			for i, info in ipairs(data.parts) do
				if map[info.id] then
					count = count + 1
				end
			end
		end
	end

	if CurAvatar and CurAvatar.rearHouseData then
		for i, partInfo in ipairs(CurAvatar.rearHouseData.part_data.part or {}) do
			local name = self.getZoneName(partInfo.pos.area)

			if name ~= self.curWallName and map[partInfo.id] then
				count = count + 1
			end
		end
	end

	return count
end

function RearHouseDragCenter.checkAddAttr(newSaveData)
	local data = RearHouseCommon.getAddAttrDescs(CurAvatar.rearHouseData.part_data.part, newSaveData)

	if #data > 0 then
		table.insert(self.showEvents, {
			type = SHOW_EVENT.ATTR,
			data = data
		})
	end
end

function RearHouseDragCenter.setDraging(v)
	self.isDragingObj = v

	if self.isDragingObj then
		self.logo:setVisible(false)
	end
end

function RearHouseDragCenter.refreshLogoState(...)
	if self.logo == nil then
		return
	end

	self.logo:setTarget(self, self.curDragObj)
	self.logo:setVisible(true)
	self.logo:setIsShelf(self.curDragObj.type == 8)
end

function RearHouseDragCenter:setWallTexture(url)
	self.zones[self.curWallName]:setWallTexture(url)
end

function RearHouseDragCenter.changeEventState(name, x, y)
	UIUtils.RearHouseChangeState(name, x or 0, y or 0)
end

function RearHouseDragCenter.checkCrystalIncrease(heroData)
	if CurAvatar:isCrystalOpened() == false then
		return
	end

	local heros = {}
	local delHeros = {}
	local preDic = {}

	for i, data in ipairs(CurAvatar.rearHouseData.hero_data.hero) do
		preDic[data.gid] = 1
	end

	for i, data in ipairs(heroData) do
		if preDic[data.gid] == 1 then
			preDic[data.gid] = 2
		elseif not CurAvatar.crystalSlotDic[data.gid] then
			table.insert(heros, CurAvatar.heroDic[data.gid])
		end
	end

	for gid, data in pairs(preDic) do
		if data ~= 2 then
			table.insert(delHeros, gid)
		end
	end

	if #delHeros > 0 then
		CurAvatar:offAllEquipByGids(delHeros)
	end

	if #heros > 0 then
		table.insert(self.showEvents, {
			type = SHOW_EVENT.CRYSTAL,
			data = heros
		})
	end
end

function RearHouseDragCenter.playCrystalEffect(heros, callBack)
	coroutine.start(self._coPlayEffect, self.coCrystalEffect, heros, callBack)
end

function RearHouseDragCenter.coCrystalEffect(heros, callBack)
	local objs = self.zones[self.curWallName]:getHeroObjs(heros)
	local tran = self.zones[self.curWallName]:getEffectParentTransform()
	local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_crystal_03.prefab")

	controller:SetLayer("Effect")

	local pos = self.mainState:getCameraPos()

	pos.y = pos.y - tran.position.y
	pos = Vector3(0, pos.y, 1)

	controller:SetNormalEffect(tran, "", Vector3(0, 0, 1), Vector3(0, 8.3, 0), 0)
	controller:TurnOn()
	coroutine.wait(0.2)
	table.insert(self.effectIds, instId)

	for i, obj in ipairs(objs) do
		local tran, yOffset = obj:getEffectTranAndOffset()
		local instId, controller = EffectManager:loadLogicEffect("Effects/Scene/efx_scene_crystal_04.prefab")

		controller:SetLayer("Effect")
		controller:SetNormalEffect(tran, "", Vector3(0, -yOffset, 0), Vector3(0, 0, 0), 0)
		controller:TurnOn()
		table.insert(self.effectIds, instId)
	end

	coroutine.wait(1.8)

	if callBack then
		callBack()
	end
end

function RearHouseDragCenter.playShowEventByTurn(...)
	if self.showEvents and #self.showEvents > 0 then
		local info = self.showEvents[1]

		table.remove(self.showEvents, 1)

		if info.type == SHOW_EVENT.CRYSTAL then
			self.playCrystalEffect(info.data, function(...)
				UIManager.getUI("rearHouseCrystalInfoDlg", true):setData(info.data)
			end)
		elseif info.type == SHOW_EVENT.ATTR then
			UIManager.getUI("rearHouseAttrAddDlg", true):setData(info.data)
		end
	end
end

function RearHouseDragCenter.saveToServer(removeConflict)
	local data = self.getSaveData(removeConflict)

	self.showEvents = {}

	self.checkCrystalIncrease(data.hero_data.hero)
	self.checkAddAttr(data.part_data.part)
	self:playShowEventByTurn()
	RPC.houseUpdate(data.hero_data, data.part_data)

	if CurAvatar:isCrystalOpened() == true then
		local crystalData = {}

		for i, heroInfo in ipairs(data.hero_data.hero) do
			table.insert(crystalData, heroInfo.gid)
		end

		RPC.crystalMsgSaveSympathizer(crystalData)
	end

	CurAvatar.rearHouseData.part_data = RearHouseDragCenter.saveData.part_data
	CurAvatar.rearHouseData.hero_data = RearHouseDragCenter.saveData.hero_data
	CurAvatar.rearHouseData.max_comfort = math.max(CurAvatar.rearHouseData.max_comfort, CurAvatar.rearHouseData.comfort)

	if CurAvatar.rearHouseData.comfort == CurAvatar.rearHouseData.max_comfort then
		CurAvatar:checkComfotableRedHint()
		CurAvatar:checkCleanRedHint()
	end
end

function RearHouseDragCenter.save(...)
	local ok = true
	local zone = self.getCurZone()

	return zone:save(false, true)
end

function RearHouseDragCenter.isChanged(...)
	local changed = false
	local zone = self.getCurZone()

	if zone then
		return zone:isChanged() == true
	end

	return changed
end

function RearHouseDragCenter.checkLogoBounds(...)
	if self.logo then
		self.logo:checkBounds()
	end
end

function RearHouseDragCenter.showWarning(show, content)
	if self.curMode.mode == MODE.EDIT then
		self.curMode.ui:showWarning(show, content)
	end
end

function RearHouseDragCenter.getSaveData(removeConflict)
	local heros = {}
	local parts = {}
	local showData = RearHouseModelCenter.getCurShowData()
	local zoneId = self.getZoneId(self.curWallName)

	for i, info in ipairs(showData.part_data.part) do
		if info.pos.area ~= zoneId then
			table.insert(parts, info)
		end
	end

	for i, info in ipairs(showData.hero_data.hero) do
		if info.pos.area ~= zoneId then
			table.insert(heros, info)
		end
	end

	local curData = self.zones[self.curWallName]:getSaveData(removeConflict)

	for _, hero in ipairs(curData.heros) do
		table.insert(heros, hero)
	end

	for _, part in ipairs(curData.parts) do
		table.insert(parts, part)
	end

	self.saveData = {
		hero_data = {
			hero = heros
		},
		part_data = {
			part = parts
		}
	}

	return self.saveData
end

function RearHouseDragCenter.blockClick(isBlock)
	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:blockClick(isBlock)
	end
end

function RearHouseDragCenter.setInitObjsGray(v)
	self.zones[self.curWallName]:setInitObjsGray(v)
end

function RearHouseDragCenter.onQuitEditMode(...)
	self.changeEventState("clearDrag")
	self.clearState(true)
end

function RearHouseDragCenter.clearState(isAll)
	for name, zone in pairs(self.zones) do
		zone:clearState(isAll)
	end

	if isAll then
		self.hideLogos()
	end
end

function RearHouseDragCenter.hideLogos(...)
	self.logo:setVisible(false)
	self.cleanLogo:setVisible(false)
end

function RearHouseDragCenter.isLoadFinish(...)
	if not self.inited then
		return false
	end

	if self.curWallName then
		local zone = self.zones[self.curWallName]

		return zone.inited == true
	end

	return false
end

function RearHouseDragCenter.destroy(...)
	for name, zone in pairs(self.zones) do
		zone:destroy()
	end

	self.zones = nil

	if self.logo then
		self.logo:destroy()

		self.logo = nil
	end

	if self.cleanLogo then
		self.cleanLogo:destroy()

		self.cleanLogo = nil
	end

	if self.redEffect then
		EffectManager:releaseEffect(self.redEffect.id)

		self.redEffect = nil
	end

	if self.greenEffect then
		EffectManager:releaseEffect(self.greenEffect.id)

		self.greenEffect = nil
	end

	if self.reflectPlane then
		self.reflectPlane = nil
	end

	self.inited = false
	self.curMode = nil
	self.curDragObj = nil
	self.mainState = nil

	self.releaseEffect()
	RearHouseModelCenter.destroy()
	UIUtils.StopRearHouseDrag()
end

function RearHouseDragCenter.releaseEffect()
	for i, id in ipairs(self.effectIds) do
		EffectManager:releaseEffect(id)
	end

	self.effectIds = {}
end

return RearHouseDragCenter

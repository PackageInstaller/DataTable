-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\UIManager.lua

local UIConst = require("UI/UIConst")
local SDKConst = require("SDK/SDKConst")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local ResVideoTalk = require("ClientData/ResVideoTalk")
local ResTalkSceneMap = require("ClientData/AVGData/ExcelData/ResTalkSceneMap")
local CameraManager = Framework.CameraSystem.CameraManager
local GameSettings = require("Helper/GameSettings")
local NativeHelper = require("Helper/NativeHelper")
local DeviceHelper = require("Helper/DeviceHelper")
local ResUIData = require("ClientData/ResUIData")
local ResUIBGM = require("ClientData/ResUIBGM")
local UIManager = {}
local self = UIManager

self._uiObjs = {}
self._uiRejectGroups = {}

local GROUP_MAIN = 20

self._uiBlockList = {}
self._uiCacheDelDict = {}
UIManager.prefabKeyDict = {}

function UIManager.tryHideUI(uiName)
	if self._uiObjs[uiName] then
		UIManager.getUI(uiName, false)
	end
end

function UIManager.tryGetUI(uiName)
	return UIManager.getUI(uiName, nil, false)
end

function UIManager.createUI(uiName)
	return UIManager.getUI(uiName, true)
end

function UIManager.createAndFunc(uiName, funcName, ...)
	local uiObj = self._uiObjs[uiName]

	if uiObj then
		if uiObj[funcName] then
			uiObj[funcName](uiObj, ...)
		end

		uiObj:setVisible(true)
	else
		uiObj = UIManager.getUI(uiName, nil, true)

		if uiObj[funcName] then
			uiObj[funcName](uiObj, ...)
		end

		uiObj:setVisible(true)
	end
end

function UIManager.getUI(uiName, needShow, needCreate)
	if needCreate == nil then
		needCreate = true
	end

	local uiObj = self._uiObjs[uiName]

	if uiObj ~= nil then
		if needShow ~= nil then
			uiObj:setVisible(needShow)
		end

		if self._uiCacheDelDict[uiName] and needCreate then
			self._uiCacheDelDict[uiName] = nil

			uiObj:reuseCache()
		end
	elseif needCreate then
		local uiData = UIConst.UIMap[uiName]

		if uiData ~= nil then
			local luaClass = require(uiData.pathLua)

			uiObj = luaClass(uiData.prefab, uiData.ui_order, needShow)

			uiObj:postInit(uiName, uiData)

			self._uiObjs[uiName] = uiObj

			if needShow ~= nil then
				uiObj:setVisible(needShow)
			end

			uiObj:onWindowInit()
		end
	end

	return uiObj
end

function UIManager.newDayEnter()
	for uiName, uiObj in pairs(self._uiObjs) do
		if uiObj.onNewDay then
			uiObj:onNewDay()
		end
	end
end

function UIManager.stateEnter(preStateName, nextStateName)
	local stateUIList = UIConst.STATE_MAP[nextStateName]

	if stateUIList == nil then
		return
	end

	for uiName, defVisible in pairs(stateUIList) do
		ClientUtils.trycall(UIManager._stateEnter, uiName, defVisible, preStateName, nextStateName)
	end
end

function UIManager._stateEnter(uiName, defVisible, preStateName, nextStateName)
	local uiObj = self._uiObjs[uiName]

	if defVisible == true then
		uiObj = self.getUI(uiName, true)
	end

	if uiObj ~= nil and uiObj.onStateEnter ~= nil then
		uiObj:onStateEnter(preStateName, nextStateName)
	end
end

function UIManager.stateExit(preStateName, nextStateName)
	UIManager.clearRejectGroup()

	local curState = GameFsm.getState(preStateName)

	if curState and curState.fsm and curState.fsm.mCurState then
		UIManager.stateExit(curState.fsm.mCurState, nextStateName)
	end

	local preStateUIList = UIConst.STATE_MAP[preStateName]

	if preStateUIList == nil then
		return
	end

	local nextStateUIList = UIConst.STATE_MAP[nextStateName] or {}

	for uiName, defVisible in pairs(preStateUIList) do
		ClientUtils.trycall(UIManager._stateExit, uiName, defVisible, preStateName, nextStateName, nextStateUIList)
	end
end

function UIManager._stateExit(uiName, defVisible, preStateName, nextStateName, nextStateUIList)
	local uiObj = self._uiObjs[uiName]

	if uiObj ~= nil and uiObj.onStateExit ~= nil then
		uiObj:onStateExit(preStateName, nextStateName)
	end

	if uiObj ~= nil and nextStateName ~= nil and (nextStateUIList[uiName] == nil or nextStateUIList[uiName] == "Hide") then
		uiObj:setVisible(false, false, true)

		if nextStateUIList[uiName] == nil then
			self.delUI(uiName, true)
		end
	end
end

function UIManager.delAllUI()
	for uiName, ui in pairs(self._uiObjs) do
		self._uiObjs[uiName] = nil

		ui:destroy()
	end
end

function UIManager.delUI(uiName)
	local uiCacheTime = UIManager.getUICacheTime(uiName)
	local specialDelete = false

	if self._uiObjs[uiName] and self._uiObjs[uiName].BeginnerMark then
		specialDelete = true
	end

	if uiCacheTime > 0 and not specialDelete then
		if not self._uiCacheDelDict[uiName] then
			self._uiCacheNumber = self._uiCacheNumber + 1
		end

		self._uiCacheDelDict[uiName] = Time.time + uiCacheTime

		local ui = self._uiObjs[uiName]

		if ui then
			ui:inCache()
		end
	else
		UIManager._realDelUI(uiName)
	end
end

function UIManager._realDelUI(uiName)
	local ui = self._uiObjs[uiName]

	if ui then
		self._uiObjs[uiName] = nil

		ui:destroy()
	end
end

function UIManager.visibleReject(uiObj)
	if self._flagReject or uiObj.mUIGroup == nil then
		if uiObj.mUIData.shut_down_cam or uiObj.mUIData.need_hdr then
			self.onUIShowChanged()
		end

		return
	end

	local needShowMain
	local show = not uiObj:getHide() and uiObj:getVisible()
	local uiGroupShowStack = self._uiRejectGroups[uiObj.mUIGroup] or list:new()

	self._flagReject = true

	local nowName = uiGroupShowStack:tail()
	local curName = uiObj.mUIName

	if show then
		if nowName ~= curName then
			local iter = uiGroupShowStack:findlast(uiObj.mUIName)

			if iter then
				local _

				while iter ~= nil do
					local uiName = iter.value

					if uiName == "mainMenu" then
						break
					end

					if uiName ~= curName then
						self.getUI(uiName, false, false)
					end

					uiGroupShowStack:remove(iter)

					iter, _ = uiGroupShowStack:prev(iter)
				end
			end

			if nowName and self._uiObjs[nowName] then
				self.getUI(nowName):setHide(true)
			end

			uiGroupShowStack:push(curName)
		end
	elseif nowName == curName then
		uiGroupShowStack:pop()

		local preName = uiGroupShowStack:tail()

		for index = 1, 10 do
			if self._uiObjs[preName] then
				break
			else
				uiGroupShowStack:pop()

				preName = uiGroupShowStack:tail()
			end
		end

		if preName then
			if self._uiObjs[preName]:isRejectShow() then
				self.getUI(preName):setHide(false, true)
			end
		elseif nowName ~= "mainMenu" and uiObj.mUIGroup == GROUP_MAIN and GameFsm.isInState(Const.STATE_MAIN_HOME) then
			needShowMain = "mainMenu"
		elseif nowName ~= "mazeMainDlg" and uiObj.mUIGroup == GROUP_MAIN and GameFsm.isInState(Const.STATE_MAIN_MAZE) then
			needShowMain = "mazeMainDlg"
		elseif nowName ~= "rearHouseMainDlg" and uiObj.mUIGroup == GROUP_MAIN and GameFsm.isInState(Const.STATE_MAIN_REAR_HOUSE) then
			needShowMain = "rearHouseMainDlg"
		elseif nowName ~= "circleBattleMainDlg" and uiObj.mUIGroup == GROUP_MAIN and GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
			needShowMain = "circleBattleMainDlg"
		elseif nowName ~= "mainStageDlg" and uiObj.mUIGroup == GROUP_MAIN and GameFsm.isInState(Const.STATE_MAIN_STAGE) then
			needShowMain = "mainStageDlg"
		end
	else
		local iter = uiGroupShowStack:findlast(curName)
		local iterV

		if iter then
			while iter ~= nil do
				local uiName = iter.value

				if uiName ~= curName then
					self.getUI(uiName, false, false)
				end

				uiGroupShowStack:remove(iter)

				iter, iterV = uiGroupShowStack:prev(iter)
			end
		end
	end

	self.onUIShowChanged()

	self._uiRejectGroups[uiObj.mUIGroup] = uiGroupShowStack
	self._flagReject = false

	if needShowMain then
		self.getUI(needShowMain, true)
	end
end

function UIManager.backToMainMenu()
	if GameFsm.isInState(Const.STATE_MAIN_STAGE) or GameFsm.isInState(Const.STATE_MAIN_HOME) then
		self.clearRejectGroup()
		self.openDefaultCanvas()
	else
		GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
	end
end

function UIManager.clearStateCanvas()
	self._uiRejectGroups = {}

	for uiName, uiObj in pairs(self._uiObjs) do
		if uiObj.mUIGroup or uiObj.mUIData.with_state_close then
			uiObj:setVisible(false, false, true)
			self.delUI(uiName)
		end
	end

	self._uiBlockList = {}

	self._updateBlock()
	self.onUIShowChanged()
	self.openDefaultCanvas()
end

function UIManager._getStateDefaultCanvas()
	local defaultName

	if GameFsm.isInState(Const.STATE_MAIN_MAZE) then
		defaultName = "mazeMainDlg"
	elseif GameFsm.isInState(Const.STATE_MAIN_REAR_HOUSE) then
		defaultName = "rearHouseMainDlg"
	elseif GameFsm.isInState(Const.STATE_MAIN_STAGE) then
		defaultName = "mainStageDlg"
	elseif GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		defaultName = "circleBattleMainDlg"
	elseif GameFsm.isInState(Const.STATE_MAIN_HOME) then
		defaultName = "mainMenu"
	end

	return defaultName
end

function UIManager.openDefaultCanvas(triggerUI)
	local defaultName = self._getStateDefaultCanvas()

	if defaultName and defaultName ~= triggerUI then
		local ui = self.getUI(defaultName, nil, false)

		if not ui or not ui:isInShow() then
			UIManager.getUI(defaultName, true)
		end
	end
end

function UIManager.isInDefaultCanvas()
	local defaultName = self._getStateDefaultCanvas()
	local ui = self.getUI(defaultName, nil, false)

	return ui and ui:isInShow()
end

local STATE_CLOSE_BASE_CANVAS = {
	mainMenu = 1,
	loadingui = 1,
	battleZombieMainDlg = 1,
	mainStageDlg = 1,
	login = 1,
	battleMoreHeroMainDlg = 1,
	battleReplayMainDlg = 1,
	battleMainDlg = 1
}
local STATE_GAME_EXIT_CANVAS = {
	mainMenu = 1,
	login = 1,
	mainStageDlg = 1
}

function UIManager.closeNowCanvas()
	if ClientUtils.isInBeginner() then
		return false
	end

	local confirmui = UIManager.tryGetUI("confirmui")

	if confirmui and confirmui:isInShow() then
		confirmui:tryCloseCanvas()

		return true
	end

	local nowLayer = 0
	local nowCanvas

	for uiName, uiObj in pairs(self._uiObjs) do
		if uiObj.mUIGroup and uiObj:isInShow() and uiObj._order and nowLayer < uiObj._order then
			nowLayer = uiObj._order
			nowCanvas = uiObj
		end
	end

	if nowCanvas and nowCanvas.onBtnCloseClick then
		nowCanvas:onBtnCloseClick()
	elseif nowCanvas and nowCanvas.onClickQuit then
		nowCanvas:onClickQuit()
	elseif GameFsm.isInBattleState() then
		return false
	elseif not nowCanvas or STATE_CLOSE_BASE_CANVAS[nowCanvas.mUIName] then
		local mainMenuBg = UIManager.tryGetUI("homeBg")

		if mainMenuBg and mainMenuBg:isInShow() and mainMenuBg.inGentleMode then
			mainMenuBg:_onClickGentleQuit()

			return true
		end

		if not nowCanvas or STATE_GAME_EXIT_CANVAS[nowCanvas.mUIName] then
			return nil
		else
			return false
		end
	else
		nowCanvas:setVisible(false)
	end

	return true
end

function UIManager.clearRejectGroup(tgtObj)
	self._flagReject = true

	if tgtObj == nil then
		for uiName, uiObj in pairs(self._uiObjs) do
			if uiObj.mUIGroup then
				self.clearRejectGroup(uiObj)
			end
		end

		self.onUIShowChanged()
	elseif tgtObj.mUIGroup then
		local uiGroupShowStack = self._uiRejectGroups[tgtObj.mUIGroup]

		if uiGroupShowStack then
			while uiGroupShowStack:head() do
				self.getUI(uiGroupShowStack:shift(), false, false)
			end
		end
	else
		tgtObj:setVisible(false)
	end

	self._flagReject = false
end

function UIManager.showBlock(uiObj)
	if uiObj.mUIData == nil or uiObj.mUIData.ui_block == nil then
		return
	end

	for _, info in pairs(self._uiBlockList) do
		if info.name == uiObj.mUIName then
			return
		end
	end

	local canClose = uiObj.mUIData.ui_block == 1
	local bgAlpha = uiObj.mUIData.block_alpha or 1
	local pauseDelay = uiObj.mUIData.block_pause_delay
	local curOrder = uiObj:getOrder() or 0
	local newInfo = {
		hide = false,
		name = uiObj.mUIName,
		funcV = uiObj.oriSetVisible or uiObj.setVisible,
		funcH = uiObj.oriSetHide or uiObj.setHide,
		close = canClose,
		alpha = bgAlpha,
		pauseDelay = pauseDelay
	}
	local index

	for i, info in ipairs(self._uiBlockList) do
		local ui = self.getUI(info.name, nil, false)

		if ui and curOrder < ui:getOrder() then
			table.insert(self._uiBlockList, i, newInfo)

			index = i

			break
		end
	end

	if index == nil then
		table.insert(self._uiBlockList, newInfo)
	end

	local function setVisible(ui, v, ...)
		if not v then
			UIManager.clearBlock(ui, ...)
		else
			uiObj.oriSetVisible(uiObj, true, ...)
		end
	end

	if not uiObj.oriSetVisible then
		uiObj.oriSetVisible = uiObj.setVisible
	end

	uiObj.setVisible = setVisible

	local function setHide(ui, v, ...)
		UIManager.hideBlock(ui, v, ...)
	end

	if not uiObj.oriSetHide then
		uiObj.oriSetHide = uiObj.setHide
	end

	uiObj.setHide = setHide

	self._updateBlock()
end

function UIManager._updateBlock()
	local blockBox = self.getUI("block")
	local nextInfo

	for i = #self._uiBlockList, 1, -1 do
		nextInfo = self._uiBlockList[i]

		if nextInfo and nextInfo.hide then
			nextInfo = nil
		end

		if nextInfo then
			break
		end
	end

	if nextInfo ~= nil then
		blockBox:show(nextInfo)
	else
		blockBox:setVisible(false, false)
	end
end

function UIManager.hideBlock(uiObj, isHide, ...)
	if #self._uiBlockList == 0 or uiObj == nil then
		return
	end

	for i, info in ipairs(self._uiBlockList) do
		if info.name == uiObj.mUIName then
			self._uiBlockList[i].hide = isHide

			self._uiBlockList[i].funcH(uiObj, isHide, ...)

			break
		end
	end

	self._updateBlock()
end

function UIManager.clearBlock(uiObj, ...)
	if #self._uiBlockList == 0 then
		return
	end

	local index = #self._uiBlockList
	local tgtInfo

	if uiObj ~= nil then
		for i, info in ipairs(self._uiBlockList) do
			if info.name == uiObj.mUIName then
				index = i

				break
			end
		end

		tgtInfo = self._uiBlockList[index]
	else
		tgtInfo = self._uiBlockList[index]
		uiObj = self.getUI(tgtInfo.name)
	end

	table.remove(self._uiBlockList, index)

	uiObj.setVisible = tgtInfo.funcV

	uiObj:setVisible(false, ...)
	self._updateBlock()
end

function UIManager.showConfirm(confirmType, ...)
	return self.getUI("confirmui"):show(confirmType, ...)
end

function UIManager.showConfirmWithCost(costInfo, confirmType, ...)
	return self.getUI("confirmui"):showWithCost(costInfo, confirmType, ...)
end

function UIManager.showConfirmWithId(confirmId, cbYes, cbNo, cbOther, costInfo)
	if Const.CACHED_ATTENTION_RECORD_TABLE and Const.CACHED_ATTENTION_RECORD_TABLE[confirmId] then
		cbYes()
	else
		return self.getUI("confirmui"):showFromId(confirmId, cbYes, cbNo, cbOther, costInfo)
	end
end

function UIManager.setConfirmDefault(default_back_mode)
	local confirmui = UIManager.tryGetUI("confirmui")

	if confirmui then
		confirmui:setConfirmDefault(default_back_mode)
	end
end

function UIManager.showConfirmSepcForPrivilege(priId, callBack)
	if not CurAvatar:privilegeIsValid(priId) then
		local confirmui = self.getUI("confirmui", nil, false)

		if confirmui then
			confirmui:setSpcShowForPrivilege(priId, callBack)
		end
	end
end

function UIManager.setMainCam()
	local mainBgVisible = true

	for uiName, uiObj in pairs(self._uiObjs) do
		mainBgVisible = uiObj:getMainCamVisible()

		if not mainBgVisible then
			break
		end
	end

	if GameFsm.isInState(Const.STATE_MAIN_HOME) then
		GameFsm.getState(Const.STATE_MAIN_HOME):onBgVisible(mainBgVisible)
	elseif GameFsm.isInState(Const.STATE_MAIN_STAGE) then
		GameFsm.getState(Const.STATE_MAIN_STAGE):onBgVisible(mainBgVisible)
	else
		GameFsm.getState():onBgVisible(mainBgVisible)
	end
end

function UIManager.setCamHDR()
	if GameSettings.isLowQuality() or DeviceHelper.isIOS() then
		return
	end

	local useHdr = false

	for uiName, uiObj in pairs(self._uiObjs) do
		useHdr = uiObj:need2DHDR()

		if useHdr then
			break
		end
	end

	CameraModeManager.set2DHDR(useHdr)
end

function UIManager.checkUIBgm(...)
	local hasUIBgm = false

	for uiName, uiObj in pairs(self._uiObjs) do
		hasUIBgm = uiObj:hasUIBGM()

		if hasUIBgm then
			break
		end
	end

	if not hasUIBgm then
		CueManager.stopUIBGM()
	end
end

function UIManager.playAVGVideo(videoPath, id, finishCB)
	local avgUIName = "talkBox"
	local talkBox = UIManager.getUI(avgUIName, true)
	local fakeSection = {
		talk_type = UIConst.AVG_TALK_TYPE_VIDEO,
		talk = videoPath
	}
	local sectionId, pageId

	if id then
		sectionId = math.floor(id / 1000)
		pageId = math.floor(id % 1000)
	end

	talkBox:showFakeSection(fakeSection, sectionId, pageId, finishCB)
end

function UIManager.playChapterEnd(chaperEndID, finishCB)
	local avgUIName = "talkBox"
	local talkBox = UIManager.getUI(avgUIName, true)
	local fakeSection = {
		talk_type = UIConst.AVG_TALK_TYPE_CHAPTEREND,
		talk = chaperEndID
	}

	talkBox:hideFuncPanel()
	talkBox:showFakeSection(fakeSection, nil, nil, finishCB)
end

function UIManager.playChpaterPoster(posterPath, finishCB)
	local avgUIName = "talkBox"
	local talkBox = UIManager.getUI(avgUIName, true)
	local fakeSection = {
		talk_type = UIConst.AVG_TALK_TYPE_POSTER,
		talk = posterPath
	}

	talkBox:hideFuncPanel()
	talkBox:showFakeSection(fakeSection, nil, nil, finishCB)
end

function UIManager.playAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)
	if ResTalkSceneMap[sectionID] then
		local targetSceneID = ResTalkSceneMap[sectionID].scene_id

		if targetSceneID and not SceneManager.isSameScene(targetSceneID, SceneManager.mCurSceneID) then
			if GameFsm.isInState(Const.STATE_MAIN_STAGE) then
				local PerformManager = require("Logic/perform/PerformManager")

				PerformManager.stop()
			end

			LoadManager.clear()
			SceneManager.addLoadScene(targetSceneID)

			local loadedCallback = Functor(UIManager._realPlayAVG, sectionID, pageID, finishCB, isNewbie, extraDelay)

			LoadManager.start(loadedCallback)

			return
		end
	end

	UIManager._realPlayAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)
end

function UIManager._realPlayAVG(sectionID, pageID, finishCB, isNewbie, extraDelay)
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_START_AVG, sectionID)
	CurAvatar:checkPlayNodeReport(sectionID)

	local avgUIName

	avgUIName = isNewbie and "newbieTalkDlg" or "talkBox"
	UIManager.lastAvgIsNewbie = isNewbie

	if ResVideoTalk[sectionID] then
		local avgVideoPlayer = UIManager.getUI("avgVideoPlayer", true)

		avgVideoPlayer:playVideoAvg(sectionID, finishCB, avgUIName)
	else
		local talkBox = UIManager.getUI(avgUIName, true)

		if extraDelay then
			talkBox:setExtraDelay(extraDelay)
		end

		talkBox:showSection(sectionID, pageID, finishCB)
	end
end

function UIManager.playLoginCG(endCallback, path)
	local videoDlg = UIManager.getUI("sequenceFramePlayer", true)
	local endTime

	if ChannelUtil.getSubChannelID() == SDKConst.ChannelID.SUB_DALAN then
		endTime = 89
	end

	videoDlg:playVideo(path or Const.LoginCGPath, false, endCallback, true, true, true, endTime)
end

function UIManager.onUIShowChanged()
	UIManager.setMainCam()
	UIManager.setCamHDR()
end

function UIManager.onUICacheCheck()
	self._uiCacheNumber = 0

	for uiName, delTime in pairs(self._uiCacheDelDict) do
		local ui = self._uiObjs[uiName]

		if ui then
			if delTime <= Time.time and not ui:getVisible() then
				ui:destroy()

				self._uiObjs[uiName] = nil
				self._uiCacheDelDict[uiName] = nil
			else
				self._uiCacheNumber = self._uiCacheNumber + 1
			end
		else
			self._uiCacheDelDict[uiName] = nil
		end
	end
end

function UIManager.ClearUICache()
	self._uiCacheNumber = 0

	for uiName, delTime in pairs(self._uiCacheDelDict) do
		local ui = self._uiObjs[uiName]

		if ui then
			if not ui:getVisible() then
				ui:destroy()

				self._uiObjs[uiName] = nil
				self._uiCacheDelDict[uiName] = nil
			else
				self._uiCacheNumber = self._uiCacheNumber + 1
			end
		else
			self._uiCacheDelDict[uiName] = nil
		end
	end
end

function UIManager.onReconnect()
	for uiName, uiObj in pairs(self._uiObjs) do
		if uiObj:isInShow() and uiObj.onReconnect then
			uiObj:onReconnect()
		end
	end
end

function UIManager.getUICacheTime(uiName)
	if UIConst.CacheConfig[uiName] and (self._uiCacheNumber < UIConst.CacheMaxNumber or self._uiCacheDelDict[uiName] or UIConst.CacheConfig[uiName] < 0) then
		return UIConst.CacheConfig[uiName]
	end

	return UIConst.CacheDefaultTime
end

local CACHE_CHECK_TIME = 5

UIManager.cacheTimer = Timer.New(UIManager.onUICacheCheck, CACHE_CHECK_TIME, -1)

UIManager.cacheTimer:Start()

function UIManager.emulatorAdjust()
	if not DeviceHelper.isAndroid() then
		return
	end

	if NativeHelper.preCheckEmulator(UIManager._onEmulatorChecked) then
		UIManager._onEmulatorChecked()
	end
end

function UIManager._onEmulatorChecked(...)
	local isEmulator

	if VersionUtils.hasAbilityEmulatorCheck() then
		isEmulator = NativeHelper.isEmulator()
	else
		local LuaToolkit = Framework.Tools.LuaToolkit

		isEmulator = not LuaToolkit.Is64Bit()
	end

	if isEmulator then
		local model = string.lower(DeviceHelper.deviceModel)

		if string.find(model, "mumu") then
			-- block empty
		else
			UIConst.UIMap.login.need_hdr = nil

			local loginDlg = UIManager.getUI("login", nil, false)

			if loginDlg then
				UIManager.setCamHDR()
			end
		end
	end
end

function UIManager.onGetBonusNotice(uiName, funcName, args)
	if CurAvatar then
		if not CurAvatar.cachedBonusNotice then
			CurAvatar.cachedBonusNotice = {}
		end

		table.insert(CurAvatar.cachedBonusNotice, {
			uiName,
			funcName,
			args
		})
		self.checkBonusNotice()
	end
end

function UIManager.checkBonusNotice()
	for _, ui in pairs(self._uiObjs) do
		if ui:isInShow() and ui.mUIData.logic_flag == 1 then
			return
		end
	end

	if CurAvatar and CurAvatar.cachedBonusNotice then
		local cachedArgs = table.remove(CurAvatar.cachedBonusNotice, 1)

		if cachedArgs then
			local uiName = cachedArgs[1]
			local funcName = cachedArgs[2]
			local uiArgs = cachedArgs[3]
			local ui = self.getUI(uiName, true)

			if ui[funcName] then
				ui[funcName](ui, unpack(uiArgs))
			else
				ui:setVisible(false)
				self.checkBonusNotice()
			end
		end
	end
end

function UIManager.replacePrefabOfDlg(dlgName, uiId)
	local uiData = ResUIData[uiId]
	local info = UIConst.UIMap[dlgName]

	if uiData and info then
		for key, value in pairs(uiData) do
			info[key] = value
		end

		info.resUIID = uiId

		if ResUIBGM[info.resUIID] then
			info.bgm = ResUIBGM[info.resUIID].bgm
		end

		return true
	else
		return false
	end
end

return UIManager

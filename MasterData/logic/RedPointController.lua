-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/controller/RedPointController.lua

module("logic.extensions.redpoint.controller.RedPointController", package.seeall)

local RedPointController = class("RedPointController", BaseController)

RedPointController.REV_PRE_KEY = "@@"

function RedPointController:ctor()
	self.REV_KEY_LEN = string.len(RedPointController.REV_PRE_KEY)
	self._isAllExtensionsLoaded = false
end

function RedPointController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.AllExtensionsLoaded, self._onAllExtensionsLoaded, self)
	self:onReset()
end

function RedPointController:onReset()
	removetimer(self.sendGetInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._OnSceneLoaded, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._OnSceneLoaded, self)

	self.lateUpdateRed = false
	self.redpointPool = {}
	self.redpointKeyPool = {}
	self.redGoPaths = {}

	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updateRedpoint, self)
	ClockMgr.instance:addListener(ClockMgr.TickHour, self._updateRedpoint, self)
end

function RedPointController:_OnSceneLoaded(type, sid)
	if type == SceneType.City then
		GlobalDispatcher:removeListener(GlobalNotify.SceneLoaded, self._OnSceneLoaded, self)
	end
end

function RedPointController:sendGetInfo()
	RedPointAgent.instance:sendPM_LoadAllRedPointReq()
end

function RedPointController:regRedPoint(redpointGo, ...)
	local param = ...
	local args

	GameUtil.SetActive(redpointGo, false)

	if param and redpointGo then
		self.redpointPool[redpointGo] = {
			...
		}

		if enableDebug then
			local path = redpointGo.name
			local current = redpointGo.transform

			while current.parent do
				if current.parent.name == "UIROOT" then
					break
				end

				current = current.parent
				path = current.name .. "/" .. path
			end

			self.redGoPaths[redpointGo] = path
		end
	end

	self.lateUpdateRed = true
end

function RedPointController:unregRedPoint(redpointGo)
	if redpointGo then
		self.redpointPool[redpointGo] = nil
		self.redGoPaths[redpointGo] = nil
	end
end

function RedPointController:regMasterServantRed(masterRedId, isReverse, ...)
	RedPointModel.instance:regMasterServantRed(masterRedId, isReverse, ...)
end

function RedPointController:unregMasterServantRed(masterRedId)
	RedPointModel.instance:unregMasterServantRed(masterRedId)
end

function RedPointController:_onAllExtensionsLoaded()
	self._isAllExtensionsLoaded = true
end

function RedPointController:lateUpdateRedPoint()
	if not self._isAllExtensionsLoaded then
		return
	end

	if self.lateUpdateRed == true then
		self.lateUpdateRed = false

		self:_updateRedpoint()
	end

	RedPointModel.instance:refreshAllRedPoint()
end

function RedPointController:_updateRedpoint()
	for go, arr in pairs(self.redpointPool) do
		local isOk = false

		for i, id in ipairs(arr) do
			if RedPointModel.instance:isActive(id) == true then
				isOk = true

				break
			end
		end

		GameUtil.SetActive(go, isOk)
	end

	GlobalDispatcher:dispatch(GlobalNotify.AfterRedPointUpdate)
end

function RedPointController:AddViewRedpointInfo(viewName, redGo, id)
	if string.nilorempty(viewName) or redGo == nil or checknumber(id) < 1 then
		return
	end

	self.viewRedpointList = self.viewRedpointList or {}

	if self.viewRedpointList[viewName] == nil then
		self.viewRedpointList[viewName] = {}
	end

	self.viewRedpointList[viewName][id] = redGo
end

function RedPointController:RemoveViewRedpointInfo(viewName)
	if self.viewRedpointList == nil or self.viewRedpointList[viewName] == nil then
		return
	end

	self.viewRedpointList[viewName] = nil
end

function RedPointController:UpdateViewRedpointByID(viewName, id)
	if self.viewRedpointList == nil or self.viewRedpointList[viewName] == nil then
		return
	end

	local list = self.viewRedpointList[viewName]
	local cfg

	cfg = viewName == ViewName.bonus and BonusConfig.instance:getCfgById(id) or cfg

	if list[id] == nil or cfg == nil or string.nilorempty(cfg.redpointId) then
		return
	end

	local redIds = string.split(cfg.redpointId, "#")

	for _, redId in ipairs(redIds or {}) do
		if RedPointModel.instance:isActive(redId) then
			GameUtil.SetActive(list[id], true)

			return
		end
	end

	GameUtil.SetActive(list[id], false)
end

function RedPointController:regUserDayRedPoint(redId)
	RedPointExController.instance:_regCycleRedByType(redId, GameEnum.CycleRedType.Day)
end

function RedPointController:saveUserDayRedPoint(redId)
	RedPointExController.instance:_saveCycleRedByType(redId, GameEnum.CycleRedType.Day, true)
end

function RedPointController:regUserWeekRedPoint(redId)
	RedPointExController.instance:_regCycleRedByType(redId, GameEnum.CycleRedType.Week)
end

function RedPointController:saveUserWeekRedPoint(redId)
	RedPointExController.instance:_saveCycleRedByType(redId, GameEnum.CycleRedType.Week, true)
end

function RedPointController:regUserMoonRedPoint(redId)
	RedPointExController.instance:_regCycleRedByType(redId, GameEnum.CycleRedType.Moon)
end

function RedPointController:saveUserMoonRedPoint(redId)
	RedPointExController.instance:_saveCycleRedByType(redId, GameEnum.CycleRedType.Moon, true)
end

function RedPointController:regUserOnceRedPoint(redId)
	RedPointExController.instance:_regOnceRed(redId)
end

function RedPointController:saveUserOnceRedPoint(redId, isHasActivated)
	RedPointExController.instance:_saveOnceRed(redId, isHasActivated)
end

function RedPointController:setRedPointInfo(redPointId, isActivated, isDispatch, showTime, endTime, funcIdList)
	if redPointId == "" or redPointId == 0 or redPointId == "0" then
		if enableDebug then
			printError(string.format("警告，注册红点不正确，redPointId=%s，找开发改一下", redPointId or "nil"))
		end

		return
	end

	if RedPointModel.instance:isMasterRed(redPointId) then
		printError(">>>>>> or_主红点ID不能主动设置" .. redPointId)

		return
	end

	local info = {}

	info.redPointId = redPointId
	info.isActivated = isActivated

	if showTime and type(showTime) == "table" then
		info.showTimeArr = showTime

		RedPointModel.instance:getNextShowTime(info)
	else
		info.showTime = checknumber(showTime) * 1000
	end

	if showTime and type(endTime) == "table" then
		info.endTimeArr = endTime

		RedPointModel.instance:getNextEndTime(info)
	else
		info.endTime = checknumber(endTime) * 1000
	end

	if funcIdList ~= nil then
		info.funcIdList = {}

		for _, funcId in ipairs(funcIdList) do
			table.insert(info.funcIdList, checknumber(funcId))
		end
	end

	RedPointModel.instance:updateSingleRedPointInfo(info, isDispatch)
end

RedPointController.instance = RedPointController.New()

return RedPointController

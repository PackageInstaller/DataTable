-- chunkname: @modules/logic/college/controller/helper/CollegeHelper.lua

module("modules.logic.college.controller.helper.CollegeHelper", package.seeall)

local CollegeHelper = class("CollegeHelper")

function CollegeHelper:focusTo(mo, callback, callobj)
	local pos = -mo.pos

	CollegeModel.instance.curFocusData = mo

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.EnterBuilding)
	self:focusToPos(pos, callback, callobj)
end

function CollegeHelper:focusToPos(pos, callback, callobj)
	CollegeController.instance:dispatchEvent(CollegeEvent.OnFocusBegin)
	self:setViewVisible("CollegeHelper.FocusBuilding", true, {
		ViewName.CollegeMainView
	})

	self._focusCallback = callback
	self._focusCallbackObj = callobj

	UIBlockHelper.instance:startBlock("CollegeHelper.FocusBuilding", 1)
	CollegeController.instance:dispatchEvent(CollegeEvent.TweenCameraPosAndSetSize, pos, CollegeEnum.DungeonMapCameraSizeType.Middle, 0.5, self._focusEnd, self)
end

function CollegeHelper:_focusEnd()
	CollegeController.instance:dispatchEvent(CollegeEvent.OnFocusEnd, CollegeModel.instance.curFocusData)
	self:doCallback()
end

function CollegeHelper:cancelFocus(callback, callobj)
	self._focusCallback = callback
	self._focusCallbackObj = callobj
	CollegeModel.instance.curFocusData = nil

	CollegeController.instance:dispatchEvent(CollegeEvent.OnFocusCancel)
	UIBlockHelper.instance:startBlock("CollegeHelper.CancelFocusBuilding", 0.5)
	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeCameraSizeType, CollegeEnum.DungeonMapCameraSizeType.High, 0.5, self._onCancelFocusEnd, self)
end

function CollegeHelper:_onCancelFocusEnd()
	self:setViewVisible("CollegeHelper.FocusBuilding", false)
	CollegeController.instance:dispatchEvent(CollegeEvent.OnFocusCancelEnd)
	self:doCallback()
end

function CollegeHelper:doCallback()
	local callback = self._focusCallback
	local callobj = self._focusCallbackObj

	self._focusCallback = nil
	self._focusCallbackObj = nil

	if callback then
		self._focusCallback(callobj)
	end
end

function CollegeHelper:setViewVisible(key, isHide, hideViews)
	CollegeModel.instance.hideViewConditions[key] = isHide and (hideViews or {}) or nil

	CollegeController.instance:dispatchEvent(CollegeEvent.OnViewVisibleChange)
end

function CollegeHelper:getBuildingDesc(co)
	if not co then
		return ""
	end

	local list = {}

	if not string.nilorempty(co.description) then
		table.insert(list, co.description)
	end

	if not string.nilorempty(co.skillIds) then
		local arr = string.splitToNumber(co.skillIds, "#")

		for i, v in ipairs(arr) do
			local skillCo = lua_college_skill.configDict[v]

			if skillCo and not string.nilorempty(skillCo.desc) then
				table.insert(list, skillCo.desc)
			end
		end
	end

	return table.concat(list, "\n")
end

function CollegeHelper:checkCanRecruit()
	local maxActorNum = CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.MaxActorNum)

	if maxActorNum <= #CollegeModel.instance:getSceneMo().characterBox.characters then
		GameFacade.showToast(ToastEnum.CollegeCharacterLimit)

		return false
	end

	return true
end

function CollegeHelper.checkBuildingLv(str)
	local sceneMo = CollegeModel.instance:getSceneMo()

	if not sceneMo then
		return false
	end

	if string.nilorempty(str) then
		return false
	end

	local arr = string.splitToNumber(str, "_")
	local buildingMo = sceneMo.buildingBox:getBuildingMo(arr[1])

	if not buildingMo then
		return false
	end

	return buildingMo.level >= arr[2]
end

function CollegeHelper.curBuildingId(str)
	local data = CollegeModel.instance.curFocusData

	if not data then
		return false
	end

	return data.id == tonumber(str)
end

function CollegeHelper:replaceColor(str)
	return string.gsub(str, "#FFEA73", "#A57800")
end

function CollegeHelper:clear()
	self._focusCallback = nil
	self._focusCallbackObj = nil
end

CollegeHelper.instance = CollegeHelper.New()

return CollegeHelper

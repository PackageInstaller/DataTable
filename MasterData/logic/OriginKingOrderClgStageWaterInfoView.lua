-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageWaterInfoView.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageWaterInfoView", package.seeall)

local OriginKingOrderClgStageWaterInfoView = class("OriginKingOrderClgStageWaterInfoView", ViewComponent)

function OriginKingOrderClgStageWaterInfoView:buildUI()
	OriginKingOrderClgStageWaterInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._leftFmtView = self:getGo("left/fmt/fmtView")
	self._leftFmtCell = self:getGo("left/fmt/fmtCell")

	GameUtil.SetActive(self._leftFmtCell, false)

	self._rightFmtView = self:getGo("right/fmt/fmtView")
	self._rightFmtCell = self:getGo("right/fmt/fmtCell")
	self._rightTxtRule = self:getTxt("right/rule/Viewport/Content")

	GameUtil.SetActive(self._rightFmtCell, false)
end

function OriginKingOrderClgStageWaterInfoView:bindEvents()
	OriginKingOrderClgStageWaterInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginKingOrderClgStageWaterInfoView:unbindEvents()
	OriginKingOrderClgStageWaterInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginKingOrderClgStageWaterInfoView:onEnter()
	OriginKingOrderClgStageWaterInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingOrderClgConfig.instance:getActivityData(self._activityId)

	self:_onUpdate()
end

function OriginKingOrderClgStageWaterInfoView:onExit()
	OriginKingOrderClgStageWaterInfoView.super.onExit(self)
	self:_onClearLeftFmt()
	self:_onClearRightFmt()
end

function OriginKingOrderClgStageWaterInfoView:_onUpdate()
	self:_onUpdateLeftFmt()
	self:_onUpdateRightFmt()
end

function OriginKingOrderClgStageWaterInfoView:_onUpdateLeftFmt()
	local lastFormationSoul = self._subMo:getLastFormationSoul()
	local targetStageId = self._subMo:getCurPassedStageId()
	local signs = self._subMo:getNextFormationSigns(lastFormationSoul, targetStageId)
	local signsArray = {}

	for posId = 1, 9 do
		signsArray[posId] = signs[posId] or false
	end

	local defaultMap = {}
	local stageData = OriginKingOrderClgConfig.instance:getStageData(self._activityId, targetStageId)

	if stageData then
		for _, posId in ipairs(stageData.posSigns) do
			defaultMap[posId] = true
		end
	end

	local radiations = self._subMo:getStormRadiations(signsArray)
	local childCount = self._leftFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._leftFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._leftFmtCell, self._leftFmtView.transform, self._leftFmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local tagBuff = goutil.findChild(mainGo, "tagBuff")
		local radBuff1 = goutil.findChild(mainGo, "tagBuff/rads/rad1")
		local radBuff2 = goutil.findChild(mainGo, "tagBuff/rads/rad2")
		local radTagBuffs = {
			radBuff1,
			radBuff2
		}
		local tagStorm = goutil.findChild(mainGo, "tagStorm")
		local tagStormDefault = goutil.findChild(mainGo, "tagStorm/default")
		local radStorm1 = goutil.findChild(mainGo, "tagStorm/rads/rad")
		local radStorm2 = goutil.findChild(mainGo, "tagStorm/rads/rad")
		local radTagStorms = {
			radStorm1,
			radStorm2
		}
		local tagSoul = goutil.findChild(mainGo, "tagSoul")

		if not radiations[posId] then
			local radiation = -1
			local isStormEye = signsArray[posId]
			local isSoul = lastFormationSoul[posId] == 1

			GameUtil.SetActive(tagStorm, false)
			GameUtil.SetActive(tagBuff, false)
			GameUtil.SetActive(tagSoul, false)
			GameUtil.SetActive(tagStormDefault, defaultMap[posId])

			if isStormEye then
				GameUtil.SetActive(tagStorm, true)

				for value, rad in ipairs(radTagStorms) do
					GameUtil.SetActive(rad, radiation == 3 or radiation == value)
				end
			elseif isSoul then
				GameUtil.SetActive(tagSoul, true)
			else
				GameUtil.SetActive(tagBuff, radiation > 0)

				for value, rad in ipairs(radTagBuffs) do
					GameUtil.SetActive(rad, radiation == 3 or radiation == value)
				end
			end
		end
	end
end

function OriginKingOrderClgStageWaterInfoView:_onClearLeftFmt()
	local childCount = self._leftFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._leftFmtView.transform:GetChild(idx - 1).gameObject
	end
end

function OriginKingOrderClgStageWaterInfoView:_onUpdateRightFmt()
	local lastFormationSoul = self._subMo:getLastFormationSoul()
	local targetStageId = self._subMo:getCurPassedStageId() + 1
	local signs = self._subMo:getNextFormationSigns(lastFormationSoul, targetStageId)
	local defaultMap = {}
	local stageData = OriginKingOrderClgConfig.instance:getStageData(self._activityId, targetStageId)

	if stageData then
		for _, posId in ipairs(stageData.posSigns) do
			defaultMap[posId] = true
		end
	end

	local childCount = self._rightFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._rightFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._rightFmtCell, self._rightFmtView.transform, self._rightFmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local tagBuff = goutil.findChild(mainGo, "tagBuff")
		local tagBuffDefault = goutil.findChild(mainGo, "tagBuff/default")

		if not signs[posId] then
			GameUtil.SetActive(tagBuff, signs[posId])
			GameUtil.SetActive(tagBuffDefault, defaultMap[posId])
		end
	end

	if not self._actData.ningzhiBuffDesc then
		self._rightTxtRule.text = self._actData.ningzhiBuffDesc
	end
end

function OriginKingOrderClgStageWaterInfoView:_onClearRightFmt()
	local childCount = self._rightFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._rightFmtView.transform:GetChild(idx - 1).gameObject
	end
end

return OriginKingOrderClgStageWaterInfoView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgStageKongInfoView.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgStageKongInfoView", package.seeall)

local OriginKingOrderClgStageKongInfoView = class("OriginKingOrderClgStageKongInfoView", ViewComponent)

function OriginKingOrderClgStageKongInfoView:buildUI()
	OriginKingOrderClgStageKongInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._leftFmtView = self:getGo("left/fmt/fmtView")
	self._leftFmtCell = self:getGo("left/fmt/fmtCell")

	GameUtil.SetActive(self._leftFmtCell, false)

	self._rightFmtView = self:getGo("right/fmt/fmtView")
	self._rightFmtCell = self:getGo("right/fmt/fmtCell")
	self._rightTxtRule = self:getTxt("right/rule/Viewport/Content")

	GameUtil.SetActive(self._rightFmtCell, false)
end

function OriginKingOrderClgStageKongInfoView:bindEvents()
	OriginKingOrderClgStageKongInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriginKingOrderClgStageKongInfoView:unbindEvents()
	OriginKingOrderClgStageKongInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriginKingOrderClgStageKongInfoView:onEnter()
	OriginKingOrderClgStageKongInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingOrderClgConfig.instance:getActivityData(self._activityId)

	self:_onUpdate()
end

function OriginKingOrderClgStageKongInfoView:onExit()
	OriginKingOrderClgStageKongInfoView.super.onExit(self)
	self:_onClearLeftFmt()
	self:_onClearRightFmt()
end

function OriginKingOrderClgStageKongInfoView:_onUpdate()
	self:_onUpdateLeftFmt()
	self:_onUpdateRightFmt()
end

function OriginKingOrderClgStageKongInfoView:_onUpdateLeftFmt()
	local lastFormationSoul = self._subMo:getLastFormationSoul()
	local childCount = self._leftFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._leftFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._leftFmtCell, self._leftFmtView.transform, self._leftFmtCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local tagBuff = goutil.findChild(mainGo, "tagBuff")

		if not lastFormationSoul[posId] then
			local soul = 0
			local hasSoul = soul == 1

			GameUtil.SetActive(tagBuff, hasSoul)
		end
	end
end

function OriginKingOrderClgStageKongInfoView:_onUpdateRightFmt()
	local lastFormationSoul = self._subMo:getLastFormationSoul()
	local targetStageId = self._subMo:getCurPassedStageId() + 1
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
	local childCount = self._rightFmtView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._rightFmtView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._rightFmtCell, self._rightFmtView.transform, self._rightFmtCell.name .. posId)

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

		if not radiations[posId] then
			local radiation = -1
			local isStormEye = signsArray[posId]

			GameUtil.SetActive(tagStorm, false)
			GameUtil.SetActive(tagBuff, false)
			GameUtil.SetActive(tagStormDefault, defaultMap[posId])

			if isStormEye then
				GameUtil.SetActive(tagStorm, true)

				for value, rad in ipairs(radTagStorms) do
					GameUtil.SetActive(rad, radiation == 3 or radiation == value)
				end
			else
				GameUtil.SetActive(tagBuff, radiation > 0)

				for value, rad in ipairs(radTagBuffs) do
					GameUtil.SetActive(rad, radiation == 3 or radiation == value)
				end
			end
		end
	end

	local ruleStr = ""
	local desc = self._actData.stormBuffDesc
	local index = 0
	local stormEyeIndex = {}
	local stormOrder = 0

	for posId = 1, 9 do
		if radiations[posId] == 0 then
			stormOrder = stormOrder + 1
			stormEyeIndex[posId] = stormOrder
		end
	end

	for posId, order in pairs(stormEyeIndex) do
		index = index + 1
		ruleStr = index == stormOrder and ruleStr .. string.format("风暴之眼%s：\n%s", order, desc) or ruleStr .. string.format("风暴之眼%s：\n%s\n\n", order, desc)
	end

	self._rightTxtRule.text = ruleStr
end

function OriginKingOrderClgStageKongInfoView:_onClearLeftFmt()
	local childCount = self._leftFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._leftFmtView.transform:GetChild(idx - 1).gameObject
	end
end

function OriginKingOrderClgStageKongInfoView:_onClearRightFmt()
	local childCount = self._rightFmtView.transform.childCount

	for idx = 1, childCount do
		local mainGo = self._rightFmtView.transform:GetChild(idx - 1).gameObject
	end
end

return OriginKingOrderClgStageKongInfoView

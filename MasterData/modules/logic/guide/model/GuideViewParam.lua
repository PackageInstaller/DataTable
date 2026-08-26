-- chunkname: @modules/logic/guide/model/GuideViewParam.lua

module("modules.logic.guide.model.GuideViewParam", package.seeall)

local GuideViewParam = pureTable("GuideViewParam")

function GuideViewParam:ctor()
	self.guideId = nil
	self.stepId = nil
	self.enableHoleClick = true
	self.uiOffset = nil
	self.goPath = nil
	self.touchGOPath = nil
	self.enableClick = true
	self.enableDrag = false
	self.enablePress = false
	self.enableSpaceBtn = false
	self.tipsPos = nil
	self.tipsHead = nil
	self.tipsTalker = nil
	self.tipsContent = nil
	self.hasTips = false
	self.hasDialogue = false
	self.storyContent = nil
	self.hasStory = false
end

function GuideViewParam:setStep(guideId, stepId)
	self.guideId = guideId
	self.stepId = stepId

	local stepCO = GuideConfig.instance:getStepCO(guideId, stepId)
	local goPath = GuideModel.instance:getStepGOPath(guideId, stepId)

	self:initUiType(stepCO.uiInfo)
	self:setUiOffset(stepCO.uiOffset)
	self:setGoPath(goPath)

	self.touchGOPath = stepCO.touchGOPath
	self.tipsPos = string.splitToNumber(stepCO.tipsPos, "#")
	self.tipsHead = stepCO.tipsHead
	self.tipsTalker = stepCO.tipsTalker
	self.tipsContent = stepCO.tipsContent
	self.tipsDir = stepCO.tipsDir

	if not string.nilorempty(self.tipsContent) then
		self.hasTips = not string.nilorempty(stepCO.tipsPos)
	else
		self.hasTips = false
		self.hasDialogue = false
	end

	self.portraitPos = stepCO.portraitPos
	self.storyContent = stepCO.storyContent
	self.hasStory = not string.nilorempty(self.storyContent)
	self.otherMasks = self:getOtherMasks(stepCO)
	self.hasAnyTouchAction = self:hasAction(stepCO.action, 212)
end

function GuideViewParam:getOtherMasks(stepCO)
	if stepCO.maskId > 0 then
		local maskInfo = lua_guide_mask.configDict[stepCO.maskId]

		if not maskInfo then
			return
		end

		local list = {}

		for i = 1, 4 do
			local uiOffset = maskInfo["uiOffset" .. i]
			local uiInfo = maskInfo["uiInfo" .. i]
			local goPath = maskInfo["goPath" .. i]

			if not string.nilorempty(uiInfo) and not string.nilorempty(goPath) then
				local result = {}

				result.uiInfo = self:getUiTypeParam(uiInfo)
				result.goPath = goPath
				result.uiOffset = string.splitToNumber(uiOffset, "#")

				table.insert(list, result)
			end
		end

		return #list > 0 and list
	end
end

function GuideViewParam:hasAction(action, targetActionId)
	if string.nilorempty(action) == false then
		local list = GameUtil.splitString2(action, true, "|", "#")

		for i, v in ipairs(list) do
			if v[1] == targetActionId then
				return true
			end
		end
	end

	return false
end

function GuideViewParam:setGoPath(goPath)
	self.goPath = goPath
end

function GuideViewParam:setUiOffset(uiOffset)
	self.uiOffset = string.splitToNumber(uiOffset, "#")
end

function GuideViewParam:initUiType(uiInfo)
	self.uiInfo = self:getUiTypeParam(uiInfo)
	self.showMask = self.uiInfo.maskAlpha ~= 0
end

function GuideViewParam:getUiTypeParam(uiInfo)
	local result = {}
	local temp = string.splitToNumber(uiInfo, "#")

	result.uiType = temp[1]
	result.width = 0
	result.height = 0

	local imgAlpha, maskAlpha

	if result.uiType == GuideEnum.uiTypeCircle then
		result.width = temp[2]
		result.height = temp[2]
		maskAlpha = temp[3]
		imgAlpha = temp[4]
	elseif result.uiType == GuideEnum.uiTypeRectangle then
		result.width = temp[2]
		result.height = temp[3]
		maskAlpha = temp[4]
		imgAlpha = temp[5]
	elseif result.uiType == GuideEnum.uiTypeNoHole then
		maskAlpha = temp[2] or 0.2
		imgAlpha = 0
	elseif result.uiType == GuideEnum.uiTypeDragCard or result.uiType == GuideEnum.uiTypeDragCard2 then
		maskAlpha = temp[2]
	elseif result.uiType == GuideEnum.uiTypeArrow or result.uiType == GuideEnum.uiTypePressArrow then
		if not temp[2] then
			local rotation = 1

			result.rotation = GuideEnum.ArrowRotation[rotation]
			result.width = temp[3] or 0
			result.height = temp[4] or 0
			result.arrowOffsetX = temp[5] or 0
			result.arrowOffsetY = temp[6] or 0
			maskAlpha = temp[7]
			imgAlpha = temp[8]
		end
	end

	result.maskAlpha = maskAlpha or 0
	result.imgAlpha = imgAlpha or 0
	result.stepId = self.stepId
	result.guideId = self.guideId

	return result
end

function GuideViewParam:setHole()
	return
end

function GuideViewParam:setTips()
	return
end

function GuideViewParam:setStory()
	return
end

return GuideViewParam

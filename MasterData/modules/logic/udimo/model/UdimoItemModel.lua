-- chunkname: @modules/logic/udimo/model/UdimoItemModel.lua

module("modules.logic.udimo.model.UdimoItemModel", package.seeall)

local UdimoItemModel = class("UdimoItemModel", BaseModel)
local USE_SIGN = 1

UdimoItemModel.USE_SIGN = USE_SIGN

function UdimoItemModel:onInit()
	self:clearData()
end

function UdimoItemModel:reInit()
	self:clearData()
end

function UdimoItemModel:clearData()
	self:setDecorationUseInfoByList()
	self:setSelectedDecorationId()
	self:setUseBg()
end

function UdimoItemModel:setDecorationUseInfoByList(infoList)
	self._decorationInfoList = {}
	self._decorationUseDict = {}

	if infoList then
		for _, decorationInfo in ipairs(infoList) do
			self:setIsUseDecoration(decorationInfo.decorationId, decorationInfo.isUse == USE_SIGN)
			table.insert(self._decorationInfoList, decorationInfo)
		end
	end
end

function UdimoItemModel:getDecorationInfoList()
	return self._decorationInfoList
end

function UdimoItemModel:setIsUseDecoration(decorationId, isUse)
	self._decorationUseDict = self._decorationUseDict or {}
	self._decorationUseDict[decorationId] = isUse and true or nil
end

function UdimoItemModel:setBgUseInfoByList(infoList)
	self._bgInfoList = {}
	self._useBgId = nil

	for _, bgInfo in ipairs(infoList) do
		if bgInfo.isUse == USE_SIGN then
			self:setUseBg(bgInfo.backgroundId)

			break
		end
	end

	for _, bgInfo in ipairs(infoList) do
		table.insert(self._bgInfoList, bgInfo)
	end
end

function UdimoItemModel:getBgInfoByList()
	return self._bgInfoList
end

function UdimoItemModel:setUseBg(useBgId)
	self._useBgId = useBgId
end

function UdimoItemModel:setSelectedDecorationId(decorationId)
	self._selectedDecorationId = decorationId
end

function UdimoItemModel:isUnlockBg(bgId)
	return UdimoHelper.hasUnlockItem(bgId)
end

function UdimoItemModel:isUnlockDecoration(decorationId)
	return UdimoHelper.hasUnlockItem(decorationId)
end

function UdimoItemModel:getUseBg()
	return self._useBgId or UdimoConfig.instance:getDefaultBg()
end

function UdimoItemModel:getUseBgSceneLevelId()
	local useBg = self:getUseBg()

	return (UdimoConfig.instance:getSceneLevelId(useBg))
end

function UdimoItemModel:isUseDecoration(decorationId)
	return self._decorationUseDict and self._decorationUseDict[decorationId]
end

function UdimoItemModel:getUseDecoration(targetPosIndex)
	for decorationId, _ in pairs(self._decorationUseDict) do
		local posIndex = UdimoConfig.instance:getDecorationPos(decorationId)

		if posIndex and posIndex == targetPosIndex then
			return decorationId
		end
	end
end

function UdimoItemModel:getUseDecorationDict()
	return self._decorationUseDict
end

function UdimoItemModel:getSelectedDecorationId()
	return self._selectedDecorationId
end

function UdimoItemModel:getSelectedDecorationPosIndex()
	local selectedDecorationId = self:getSelectedDecorationId()

	if selectedDecorationId then
		return UdimoConfig.instance:getDecorationPos(selectedDecorationId)
	end
end

UdimoItemModel.instance = UdimoItemModel.New()

return UdimoItemModel

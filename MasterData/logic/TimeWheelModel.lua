-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/model/TimeWheelModel.lua

module("logic.extensions.timewheel.model.TimeWheelModel", package.seeall)

local TimeWheelModel = class("TimeWheelModel", BaseModel)

function TimeWheelModel:ctor()
	return
end

function TimeWheelModel:onInit()
	self:onReset()
end

function TimeWheelModel:onReset()
	self._extraItemChangeSetId = nil
	self._strengthenItemChangeSetId = nil
	self._resetChangeSetId = nil
	self._revertChangeSetId1 = nil
	self._revertChangeSetId2 = nil
	self._isHaveRecieveFirst = false
	self._curResetCount = 0
	self._resetCdEndTimestamp = 0
	self._isCdEffective = false
	self._overflowPetScoreItemCsi = nil
	self._overflowPetStrengthenItemCsi = nil
	self._overflowItemChangeSetId = nil
	self._autoDecomposeMap = {}
end

function TimeWheelModel:setDecomposeChangeSetId(extraItemChangeSetId, strengthenItemChangeSetId)
	self._extraItemChangeSetId = extraItemChangeSetId
	self._strengthenItemChangeSetId = strengthenItemChangeSetId

	local boo = MaterialConfig.instance:getIsPopupByExtId(60)

	if boo then
		MaterialController.instance:setChangeSetPopup(self._extraItemChangeSetId)
		MaterialController.instance:setChangeSetPopup(self._strengthenItemChangeSetId)
	end
end

function TimeWheelModel:getDecomposeChangeSetId()
	return self._extraItemChangeSetId, self._strengthenItemChangeSetId
end

function TimeWheelModel:setResetChangeSetId(id)
	self._resetChangeSetId = id
end

function TimeWheelModel:getResetChangeSetId()
	return self._resetChangeSetId
end

function TimeWheelModel:setResetCount(count)
	self._curResetCount = count
end

function TimeWheelModel:setEndTimestampOnResetCD(timestamp, CDEffective)
	self._resetCdEndTimestamp = checknumber(timestamp) / 1000
	self._isCdEffective = CDEffective
end

function TimeWheelModel:getEndTimestampOnResetCD()
	return self._resetCdEndTimestamp
end

function TimeWheelModel:setCdNotAvailable()
	self._isCdEffective = false
end

function TimeWheelModel:isCdAvailable()
	return self._isCdEffective
end

function TimeWheelModel:getResetCount()
	return self._curResetCount
end

function TimeWheelModel:getTotalResetCount()
	local roleLevel = RoleModel.instance:getMyLevel()

	return (TimeWheelConfig.instance:getResetCount(roleLevel))
end

function TimeWheelModel:getLeftResetCount()
	return self:getTotalResetCount() - self._curResetCount
end

function TimeWheelModel:setRevertChangeSetId(awakenItemCsi, strengthenItemCsi)
	self._revertChangeSetId1 = awakenItemCsi
	self._revertChangeSetId2 = strengthenItemCsi

	local boo = MaterialConfig.instance:getIsPopupByExtId(60)

	if boo then
		MaterialController.instance:setChangeSetPopup(self._revertChangeSetId1)
		MaterialController.instance:setChangeSetPopup(self._revertChangeSetId2)
	end
end

function TimeWheelModel:getRevertChangeSetId()
	return self._revertChangeSetId1, self._revertChangeSetId2
end

function TimeWheelModel:isHaveRecieveFirst()
	return self._isHaveRecieveFirst
end

function TimeWheelModel:handlePM_TimeWheelGetDecomposeWhenLotteryRes(msg)
	self._autoDecomposeMap = {}

	for _, v in ipairs(msg.switchs) do
		self._autoDecomposeMap[v.rare] = checkbool(v.isDecompose)
	end

	self._isHaveRecieveFirst = true
end

function TimeWheelModel:handlePM_TimeWheelSetDecomposeWhenLotteryRes(msg)
	self._isHaveRecieveFirst = true
end

function TimeWheelModel:getAutoDecomposeMap()
	return self._autoDecomposeMap
end

function TimeWheelModel:setAutoDecomposeMap(map)
	self._autoDecomposeMap = map or {}
end

function TimeWheelModel:setOverflowPetChangeSetId(scoreItemCsi, strengthenItemCsi)
	self._overflowPetScoreItemCsi = scoreItemCsi
	self._overflowPetStrengthenItemCsi = strengthenItemCsi

	local boo = MaterialConfig.instance:getIsPopupByExtId(60)

	if boo then
		MaterialController.instance:setChangeSetPopup(self._overflowPetScoreItemCsi)
		MaterialController.instance:setChangeSetPopup(self._overflowPetStrengthenItemCsi)
	end
end

function TimeWheelModel:getOverflowPetChangeSetId()
	return self._overflowPetScoreItemCsi, self._overflowPetStrengthenItemCsi
end

function TimeWheelModel:setOverflowItemChangeSetId(changeSetId)
	self._overflowItemChangeSetId = changeSetId

	local boo = MaterialConfig.instance:getIsPopupByExtId(60)

	if boo then
		MaterialController.instance:setChangeSetPopup(self._overflowItemChangeSetId)
	end
end

function TimeWheelModel:getOverflowItemChangeSetId()
	return self._overflowItemChangeSetId
end

TimeWheelModel.instance = TimeWheelModel.New()

return TimeWheelModel

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/model/DivineChenClgModel.lua

module("logic.extensions.divinechenclg.model.DivineChenClgModel", package.seeall)

local DivineChenClgModel = class("DivineChenClgModel", BaseModel)

function DivineChenClgModel:ctor()
	return
end

function DivineChenClgModel:onInit()
	self:onReset()
end

function DivineChenClgModel:onReset()
	self._extremeInfoList = {}
	self._normalInfoList = {}
end

function DivineChenClgModel:getExtremeInfoByActId(actId)
	if not self._extremeInfoList[actId] then
		printInfo("神曜尘极限数据未初始化")
	end

	return self._extremeInfoList[actId]
end

function DivineChenClgModel:getNormalInfoByActId(actId)
	if not self._normalInfoList[actId] then
		printInfo("神曜尘全民数据未初始化")
	end

	return self._normalInfoList[actId]
end

function DivineChenClgModel:onGetExtremeInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._extremeInfoList[info.activityId] = info
end

function DivineChenClgModel:onGetNormalInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._normalInfoList[info.activityId] = info
end

function DivineChenClgModel:onResetExtremeInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local extremeInfo = self:getExtremeInfoByActId(info.activityId)

	if extremeInfo then
		extremeInfo.passStages = info.passStages
	end
end

function DivineChenClgModel:onResetNormalInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local normalInfo = self:getNormalInfoByActId(info.activityId)

	if normalInfo then
		normalInfo.passStages = info.passStages
	end
end

function DivineChenClgModel:onNormalGainPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local normalInfo = self:getNormalInfoByActId(info.activityId)

	if normalInfo then
		normalInfo.gainedPrizeIds = normalInfo.gainedPrizeIds or {}

		table.insert(normalInfo.gainedPrizeIds, info.prizeId)
	end
end

DivineChenClgModel.instance = DivineChenClgModel.New()

return DivineChenClgModel

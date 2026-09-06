-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/model/EndlessDarkClgModel.lua

module("logic.extensions.endlessdark.model.EndlessDarkClgModel", package.seeall)

local EndlessDarkClgModel = class("EndlessDarkClgModel", BaseModel)

function EndlessDarkClgModel:ctor()
	return
end

function EndlessDarkClgModel:onInit()
	self:onReset()
end

function EndlessDarkClgModel:onReset()
	self._infos = {}
	self._buffMap = {}
	self._customFmtMoPool = {}
end

function EndlessDarkClgModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = EndlessDarkClgFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function EndlessDarkClgModel:getInfo(activityId)
	return self._infos[activityId]
end

function EndlessDarkClgModel:getBuffMap(activityId)
	return self._buffMap[activityId]
end

function EndlessDarkClgModel:handlePM_EndlessDarkClgGetInfoRes(msg)
	local activityId = msg.activityId

	self._infos[activityId] = GameUtil.pbToTable(msg)
	self._buffMap[activityId] = self._buffMap[activityId] or {}

	local info = self._infos[activityId]
	local buffMap = self._buffMap[activityId]

	info.buffLvList = info.buffLvList or {}

	for _, pair in ipairs(info.buffLvList) do
		buffMap[pair.left] = pair.right
	end
end

function EndlessDarkClgModel:handlePM_EndlessDarkClgNotifyFightRes(msg)
	return
end

function EndlessDarkClgModel:handlePM_EndlessDarkClgViewRankRes(msg)
	return
end

function EndlessDarkClgModel:handlePM_EndlessDarkClgUpgradeBuffRes(msg)
	local buffMap = self._buffMap[msg.activityId]

	if buffMap then
		buffMap[msg.typeBuffLv.left] = msg.typeBuffLv.right
	end
end

EndlessDarkClgModel.instance = EndlessDarkClgModel.New()

return EndlessDarkClgModel

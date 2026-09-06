-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/model/DivinedisorderdragonModel.lua

module("logic.extensions.divinedisorderdragon.view.DivinedisorderdragonModel", package.seeall)

local DivinedisorderdragonModel = class("DivinedisorderdragonModel", BaseModel)

function DivinedisorderdragonModel:ctor()
	return
end

function DivinedisorderdragonModel:onInit()
	self:onReset()
end

function DivinedisorderdragonModel:onReset()
	self._msgInfos = {}
	self._fmtMo = DivinedisorderdragonFmtMo.New()
end

function DivinedisorderdragonModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivinedisorderdragonModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivinedisorderdragonModel:getPassStage(activityId)
	local info = self:getInfo(activityId)

	return (info or nil) and (info.curStageId - 1 or 0)
end

function DivinedisorderdragonModel:getFmtMo()
	return self._fmtMo
end

function DivinedisorderdragonModel:notifyFightRes(msg)
	local info = self:getInfo(msg.activityId)

	info.curStageId = msg.curStageId
end

DivinedisorderdragonModel.instance = DivinedisorderdragonModel.New()

return DivinedisorderdragonModel

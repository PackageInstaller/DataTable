-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yinzhiclg/model/YinZhiClgModel.lua

module("logic.extensions.yinzhiclg.model.YinZhiClgModel", package.seeall)

local YinZhiClgModel = class("YinZhiClgModel", BaseModel)

function YinZhiClgModel:onInit()
	self:onReset()
end

function YinZhiClgModel:onReset()
	self._baseInfoMap = {}
end

function YinZhiClgModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)

	self._baseInfoMap[info.activityId] = info
end

function YinZhiClgModel:getBaseInfo(activityId)
	if not self._baseInfoMap[activityId] then
		printError("音织挑战数据未初始化")
	end

	return self._baseInfoMap[activityId]
end

YinZhiClgModel.instance = YinZhiClgModel.New()

return YinZhiClgModel

-- chunkname: @modules/logic/gm/model/GMLogModel.lua

module("modules.logic.gm.model.GMLogModel", package.seeall)

local GMLogModel = class("GMLogModel", BaseModel)

function GMLogModel:ctor()
	GMLogModel.super.ctor(self)

	self.errorModel = ListScrollModel.New()
end

function GMLogModel:addMsg(logString, stackTrace, type)
	logString = string.gsub(logString, "<color[^>]+>", "")
	logString = string.gsub(logString, "</color>", "")
	stackTrace = string.gsub(stackTrace, "<color[^>]+>", "")
	stackTrace = string.gsub(stackTrace, "</color>", "")

	local msgMO = {
		msg = logString,
		stackTrace = stackTrace,
		type = type,
		time = ServerTime.now()
	}

	if msgMO.type == 0 then
		self.errorModel:addAtFirst(msgMO)
	end
end

GMLogModel.instance = GMLogModel.New()

return GMLogModel

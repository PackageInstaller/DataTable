-- chunkname: @modules/logic/autochess/act182/model/Activity182Model.lua

module("modules.logic.autochess.act182.model.Activity182Model", package.seeall)

local Activity182Model = class("Activity182Model", BaseModel)

function Activity182Model:setActInfo(info)
	if self.act182Mo then
		self.act182Mo:update(info)
	else
		self.act182Mo = Act182MO.New()

		self.act182Mo:init(info)
	end

	Activity182Controller.instance:dispatchEvent(Activity182Event.UpdateInfo)
end

function Activity182Model:getCurActId()
	return self.act182Mo and self.act182Mo.activityId
end

function Activity182Model:getActMo()
	return self.act182Mo
end

Activity182Model.instance = Activity182Model.New()

return Activity182Model

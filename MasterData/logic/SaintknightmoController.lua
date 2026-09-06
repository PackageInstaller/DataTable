-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightmo/controller/SaintknightmoController.lua

module("logic.extensions.saintknightmo.controller.SaintknightmoController", package.seeall)

local SaintknightmoController = class("SaintknightmoController", BaseController)
local WeekRedKey = ViewName.SaintknightmoView .. "week"

function SaintknightmoController:onInit()
	self:onReset()
end

function SaintknightmoController:onReset()
	self:lightWeekRedPoint()
end

function SaintknightmoController:lightWeekRedPoint()
	local function callBack(value)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SAINTKNIGHTMO_WEEK, not value)
	end

	GameUtil.getUserWeekData(WeekRedKey, callBack)
end

function SaintknightmoController:saveUserWeekRedPoint()
	GameUtil.saveUserWeekData(WeekRedKey, true)
	self:lightWeekRedPoint()
end

SaintknightmoController.instance = SaintknightmoController.New()

return SaintknightmoController

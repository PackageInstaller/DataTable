-- chunkname: @modules/logic/main/controller/work/CultivationDestinyPatWork.lua

module("modules.logic.main.controller.work.CultivationDestinyPatWork", package.seeall)

local CultivationDestinyPatWork = class("CultivationDestinyPatWork", Activity125SimpleGiftWorkBase)

function CultivationDestinyPatWork:onGetViewNames()
	local viewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)

	if not string.nilorempty(viewName) then
		return {
			viewName
		}
	end

	return {
		ViewName.VersionActivity2_3NewCultivationGiftFullView
	}
end

function CultivationDestinyPatWork:onGetActIds()
	local actId = PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)

	if actId and actId > 0 then
		return {
			actId
		}
	end

	return {
		(Activity125Config.instance:getCultivationDestinyActId())
	}
end

return CultivationDestinyPatWork

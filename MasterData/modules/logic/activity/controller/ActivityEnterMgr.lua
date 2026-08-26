-- chunkname: @modules/logic/activity/controller/ActivityEnterMgr.lua

module("modules.logic.activity.controller.ActivityEnterMgr", package.seeall)

local ActivityEnterMgr = class("ActivityEnterMgr", BaseController)

function ActivityEnterMgr:init()
	self:loadEnteredActivityDict()
end

function ActivityEnterMgr:enterActivityByList(actList)
	local hasChange = false

	for _, actId in ipairs(actList) do
		if not self:isEnteredActivity(actId) then
			hasChange = true

			table.insert(self.enteredActList, self:getActId(actId))
		end
	end

	if hasChange then
		PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(self.enteredActList, ";"))
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
	end
end

function ActivityEnterMgr:enterActivity(actId)
	if self:isEnteredActivity(actId) then
		return
	end

	table.insert(self.enteredActList, self:getActId(actId))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), table.concat(self.enteredActList, ";"))
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
end

function ActivityEnterMgr:loadEnteredActivityDict()
	self.enteredActList = {}

	local enteredActStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnteredActKey), "")

	if string.nilorempty(enteredActStr) then
		return
	end

	self.enteredActList = string.splitToNumber(enteredActStr, ";")
end

function ActivityEnterMgr:isEnteredActivity(actId)
	return tabletool.indexOf(self.enteredActList, self:getActId(actId))
end

function ActivityEnterMgr:getActId(actId)
	local actCo = ActivityConfig.instance:getActivityCo(actId)

	if actCo and actCo.isRetroAcitivity == 1 then
		actId = -actId
	end

	return actId
end

ActivityEnterMgr.instance = ActivityEnterMgr.New()

return ActivityEnterMgr

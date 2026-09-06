-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/controller/DreamTeamHudController.lua

module("logic.extensions.operationsummary.controller.DreamTeamHudController", package.seeall)

local DreamTeamHudController = class("DreamTeamHudController", BaseController)

DreamTeamHudController.UserDataKeyPrefix = "DreamTeamHud_"
DreamTeamHudController.UserDataSaveType = {
	Weekly = 2,
	Daily = 1,
	First = 0
}

function DreamTeamHudController:onInit()
	self:onReset()
	RedPointAgent.instance:addHandler(RedPointAgent.PM_LoadAllRedPointRes, self.onRedPointChange, self)
end

function DreamTeamHudController:onReset()
	return
end

function DreamTeamHudController:onRedPointChange()
	self:updateRD(RedPointModel.ID_DREAMTEAMHUD_SECOND, DreamTeamHudController.UserDataSaveType.First)
	self:updateRD(RedPointModel.ID_DREAMTEAMHUD_THIRD, DreamTeamHudController.UserDataSaveType.First)
	self:updateRD(RedPointModel.ID_DREAMTEAMHUD_FOURTH, DreamTeamHudController.UserDataSaveType.First)

	local cfgs = DreamTeamHudConfig.instance:getSkinViewCfgs()

	for k, v in ipairs(cfgs) do
		local timeStart = GameUtil.string2time(v.startTime)

		if timeStart < ServerTime.now() then
			self:updateRD(v.redpoint, DreamTeamHudController.UserDataSaveType.First)
		end
	end
end

function DreamTeamHudController:updateRD(redId, dataSaveType)
	local rpKey = DreamTeamHudController.UserDataKeyPrefix .. redId
	local isShow = false

	isShow = dataSaveType == DreamTeamHudController.UserDataSaveType.Daily and checknumber(GameUtil.getUserDayData(rpKey)) <= 0 or dataSaveType == DreamTeamHudController.UserDataSaveType.Weekly and checknumber(GameUtil.getUserWeekData(rpKey)) <= 0 or checknumber(GameUtil.getUserData(rpKey)) <= 0

	RedPointController.instance:setRedPointInfo(redId, isShow)
end

function DreamTeamHudController:setRDInfo(redId, dataSaveType)
	local rpKey = DreamTeamHudController.UserDataKeyPrefix .. redId

	if dataSaveType == DreamTeamHudController.UserDataSaveType.Daily then
		GameUtil.saveUserDayData(rpKey, 1)
	elseif dataSaveType == DreamTeamHudController.UserDataSaveType.Weekly then
		GameUtil.saveUserWeekData(rpKey, 1)
	else
		GameUtil.saveUserData(rpKey, 1)
	end

	RedPointController.instance:setRedPointInfo(redId, false)
end

DreamTeamHudController.instance = DreamTeamHudController.New()

return DreamTeamHudController

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/model/PopulaceLegendModel.lua

module("logic.extensions.activitypopup.model.PopulaceLegendModel", package.seeall)

local PopulaceLegendModel = class("PopulaceLegendModel")
local funcIdToRedId = {
	[111] = {
		RedPointModel.ID_SCRATCH
	},
	[120] = {
		"ID_BAG_ACT_PRE_1001",
		"ID_BAG_ACT_PRE_1002",
		"ID_BAG_ACT_PRE_1003",
		"ID_BAG_ACT_PRE_1101",
		"ID_BAG_ACT_PRE_1102",
		"ID_BAG_ACT_PRE_1103"
	},
	[131] = {
		RedPointModel.ID_TREASUREOX
	},
	[132] = {
		RedPointModel.ID_FLYNUO
	}
}

function PopulaceLegendModel:ctor()
	return
end

function PopulaceLegendModel:onInit()
	self:onReset()
end

function PopulaceLegendModel:onReset()
	return
end

function PopulaceLegendModel:curActiveActivityCfg()
	local cfgs = ActivityPopupConfig.instance:getCfgs()

	for i, v in ipairs(cfgs) do
		if v.uiName == ViewName.PopulaceLegendView and GameUtil.checkIsInTimePeriod(v.openTime, v.endTime) then
			return v
		end
	end

	return nil
end

function PopulaceLegendModel:isShowRedPoint()
	local cfg = self:curActiveActivityCfg()

	if not cfg then
		return false
	end

	local jumpCfgs = ActivityPopupConfig.instance:getActivityPopupJumpCfgs(cfg.jumpId)

	if not jumpCfgs or #jumpCfgs == 0 then
		return false
	end

	local isShowRed = false

	for k, v in ipairs(jumpCfgs) do
		local jumpList = string.split(v.jumpTo, "#")
		local funcId = jumpList and checknumber(jumpList[2]) or nil

		if funcId > 0 then
			isShowRed = isShowRed or self:isActiveRedPointByFuncId(funcId)
		end
	end

	return isShowRed
end

function PopulaceLegendModel:isActiveRedPointByFuncId(funcId)
	local redPointList = funcIdToRedId[checknumber(funcId)]

	if not redPointList then
		return false
	end

	local isActive = false

	for i, v in ipairs(redPointList) do
		isActive = isActive or RedPointModel.instance:isActive(v)
	end

	return isActive
end

PopulaceLegendModel.instance = PopulaceLegendModel.New()

return PopulaceLegendModel

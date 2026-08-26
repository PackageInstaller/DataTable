-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/model/VersionActivity2_3NewCultivationDestinyModel.lua

module("modules.logic.versionactivity2_3.newcultivationgift.model.VersionActivity2_3NewCultivationDestinyModel", package.seeall)

local VersionActivity2_3NewCultivationDestinyModel = class("VersionActivity2_3NewCultivationDestinyModel", BaseModel)

function VersionActivity2_3NewCultivationDestinyModel:onInit()
	return
end

function VersionActivity2_3NewCultivationDestinyModel:reInit()
	return
end

function VersionActivity2_3NewCultivationDestinyModel:getDestinyStoneById(actId)
	if actId == nil then
		return {}
	end

	local actConfig = ActivityConfig.instance:getActivityCo(actId)

	if not actConfig then
		return {}
	end

	if string.nilorempty(actConfig.param) then
		return {}
	end

	return string.splitToNumber(actConfig.param, "#") or {}
end

VersionActivity2_3NewCultivationDestinyModel.instance = VersionActivity2_3NewCultivationDestinyModel.New()

return VersionActivity2_3NewCultivationDestinyModel

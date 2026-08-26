-- chunkname: @modules/logic/rouge/controller/RougeDLCController.lua

module("modules.logic.rouge.controller.RougeDLCController", package.seeall)

local RougeDLCController = class("RougeDLCController", BaseController)

function RougeDLCController:addDLC(versionId)
	local canUpdate = self:checkCanUpdateVersion(versionId)

	if not canUpdate then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	local versionIds = self:_getTargetDLCs(versionId, true)
	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(season, versionIds)
end

function RougeDLCController:removeDLC(versionId)
	local canUpdate = self:checkCanUpdateVersion(versionId)

	if not canUpdate then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	local versionIds = self:_getTargetDLCs(versionId, false)
	local season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeDLCSettingSaveRequest(season, versionIds)
end

function RougeDLCController:checkCanUpdateVersion(versionId)
	local inRouge = RougeModel.instance:inRouge()

	if inRouge then
		return
	end

	local dlcCO = lua_rouge_season.configDict[versionId]

	if not dlcCO then
		logError(string.format("无法挂移除《%s》DLC,原因:DLC配置不存在", versionId))

		return
	end

	return true
end

function RougeDLCController:_getTargetDLCs(versionId, isAdd)
	local versionIds = RougeDLCSelectListModel.instance:getCurSelectVersions()

	if isAdd then
		table.insert(versionIds, versionId)
	else
		tabletool.removeValue(versionIds, versionId)
	end

	table.sort(versionIds, function(aVersionId, bVersionId)
		return aVersionId < bVersionId
	end)

	return versionIds
end

RougeDLCController.instance = RougeDLCController.New()

return RougeDLCController

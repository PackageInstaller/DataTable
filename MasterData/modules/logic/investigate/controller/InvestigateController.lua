-- chunkname: @modules/logic/investigate/controller/InvestigateController.lua

module("modules.logic.investigate.controller.InvestigateController", package.seeall)

local InvestigateController = class("InvestigateController", BaseController)

function InvestigateController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onLoginEnd, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
end

function InvestigateController:_onLoginEnd()
	InvestigateModel.instance:refreshUnlock(true)
end

function InvestigateController:_onUpdateDungeonInfo()
	InvestigateModel.instance:refreshUnlock()
end

function InvestigateController:openInvestigateView(param)
	ViewMgr.instance:openView(ViewName.InvestigateView, param)
end

function InvestigateController:openInvestigateOpinionView(param)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionView, param)
end

function InvestigateController:openInvestigateOpinionExtendView(param)
	ViewMgr.instance:openView(ViewName.InvestigateOpinionExtendView, param)
end

function InvestigateController:openInvestigateRoleStoryView(id)
	ViewMgr.instance:openView(ViewName.InvestigateRoleStoryView, id)
end

function InvestigateController:openInvestigateTaskView(param)
	ViewMgr.instance:openView(ViewName.InvestigateTaskView, param)
end

function InvestigateController:openInvestigateTipsView(param)
	ViewMgr.instance:openView(ViewName.InvestigateTipsView, param)
end

function InvestigateController:openInvestigateOpinionTabView(param)
	InvestigateOpinionModel.instance:setInfo(param.mo, param.moList)

	local isAllLinked = InvestigateOpinionModel.instance:allOpinionLinked(param.mo.id)

	if isAllLinked then
		param.defaultTabIds = {
			[2] = InvestigateEnum.OpinionTab.Extend
		}
	end

	ViewMgr.instance:openView(ViewName.InvestigateOpinionTabView, param)
end

function InvestigateController:jumpToInvestigateOpinionTabView(id)
	local mo = lua_investigate_info.configDict[id]
	local list = InvestigateConfig.instance:getRoleGroupInfoList(mo.group)
	local paramObj = {
		mo = mo
	}

	if #list > 1 then
		paramObj.moList = list
	end

	self:openInvestigateOpinionTabView(paramObj)
end

function InvestigateController.hasOnceActionKey(type, id)
	local key = string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id)

	return PlayerPrefsHelper.hasKey(key)
end

function InvestigateController.setOnceActionKey(type, id)
	local key = string.format("%s%s_%s_%s", PlayerPrefsKey.InvestigateOnceAnim, PlayerModel.instance:getPlayinfo().userId, type, id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function InvestigateController.showClueRedDot(id)
	local isUnlock = InvestigateOpinionModel.instance:isUnlocked(id)
	local isConnect = InvestigateOpinionModel.instance:getLinkedStatus(id)

	if isUnlock and not isConnect and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.ReddotClue, id) then
		return true
	end

	return false
end

function InvestigateController.showInfoRedDot(id)
	local mo = lua_investigate_info.configDict[id]
	local list = InvestigateConfig.instance:getRoleGroupInfoList(mo.group)

	for i, v in ipairs(list) do
		local opinionList = InvestigateConfig.instance:getInvestigateRelatedClueInfos(v.id)

		for _, clue in ipairs(opinionList) do
			local showClueRedDot = InvestigateController.showClueRedDot(clue.id)
			local isConnect = InvestigateOpinionModel.instance:getLinkedStatus(clue.id)

			if not isConnect and showClueRedDot then
				return true
			end
		end
	end

	return false
end

function InvestigateController.showSingleInfoRedDot(id)
	local opinionList = InvestigateConfig.instance:getInvestigateRelatedClueInfos(id)

	for _, clue in ipairs(opinionList) do
		local showClueRedDot = InvestigateController.showClueRedDot(clue.id)
		local isConnect = InvestigateOpinionModel.instance:getLinkedStatus(clue.id)

		if not isConnect and showClueRedDot then
			return true
		end
	end

	return false
end

InvestigateController.instance = InvestigateController.New()

return InvestigateController

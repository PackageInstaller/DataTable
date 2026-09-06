-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/controller/FormationGroupController.lua

module("logic.extensions.formation.controller.FormationGroupController", package.seeall)

local FormationGroupController = class("FormationGroupController", BaseController)

FormationGroupController.DEFAULT_GROUP_ID = 0
FormationGroupController.DEFAULT_FORM_ID = 1000

local LIMIT_TAB_COUNT = 50

function FormationGroupController:onInit()
	GlobalDispatcher:addListener("openformationprefebview", self.openFormationPrefebView, self)
	self:onReset()
end

function FormationGroupController:onReset()
	self._groupFmtMo = FormationGroupFmtMo.New()
end

function FormationGroupController:openFormationPrefebView()
	self._groupFmtMo:initParams()
	CustomFmtController.instance:showMissionFormationView(self._groupFmtMo)
end

function FormationGroupController:getTabName(tabInfo)
	if string.nilorempty(tabInfo.tabName) then
		if not ("预设" .. tabInfo.tabId) then
			return tabInfo.tabName
		end
	end
end

function FormationGroupController:getGroupName(groupInfo)
	if string.nilorempty(groupInfo.groupName) then
		if not ("分组" .. groupInfo.groupId) then
			return groupInfo.groupName
		end
	end
end

function FormationGroupController:sendGetInfoOnce()
	if not FormationGroupModel.instance:getIsInited() then
		FormationAgent.instance:sendPM_LoadPersetsAllFormsReq()
	end
end

function FormationGroupController:sendGetInfo()
	FormationAgent.instance:sendPM_LoadPersetsAllFormsReq()
end

function FormationGroupController:onGetInfo(msg)
	FormationGroupModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationGroupInfoUpdate)
end

function FormationGroupController:sendModifyOrAddGroup(groupId, newGroupName)
	if groupId == nil then
		local limit = BattleConfig.instance:getFormCommon("GROUP_NUM_LIMIT")

		limit = checknumber(limit)

		local count = FormationGroupModel.instance:getGroupCount()

		if limit <= count then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), "预设分组最多" .. limit .. "个")

			return
		end
	end

	FormationAgent.instance:sendPM_ModifyPresetsGroupReq(groupId, newGroupName)
end

function FormationGroupController:onModifyOrAddGroup(msg)
	local newGroupId = FormationGroupModel.instance:onModifyOrAddGroup(msg)

	GlobalDispatcher:dispatch(GlobalNotify.FormationGroupModify, newGroupId)
end

function FormationGroupController:sendDeleteGroup(groupId)
	FormationAgent.instance:sendPM_DeletePresetsGroupReq(groupId)
end

function FormationGroupController:onDeleteGroup(msg)
	FormationGroupModel.instance:onDeleteGroup(msg.groupId)
	GlobalDispatcher:dispatch(GlobalNotify.FormationGroupModify, -1)
end

function FormationGroupController:sendTabChangeGroup(tabId, groupId)
	FormationAgent.instance:sendPM_ChangePresetsFormationGroupReq(tabId, groupId)
end

function FormationGroupController:onTabChangeGroup(msg)
	FormationGroupModel.instance:onTabChangeGroup(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationTabModify, -1)
end

function FormationGroupController:sendDeleteTab(tabId)
	FormationAgent.instance:sendPM_DeletePresetsFormationReq(tabId)
end

function FormationGroupController:onDeleteTab(msg)
	FormationGroupModel.instance:onDeleteTab(msg.tabId)
	GlobalDispatcher:dispatch(GlobalNotify.FormationTabModify, -1)
end

function FormationGroupController:sendModifyTabName(tabId, newTabName)
	FormationAgent.instance:sendPM_SetPresetNameReq(tabId, newTabName)
end

function FormationGroupController:onModifyTabName(msg)
	FormationGroupModel.instance:onModifyTabName(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationGroupInfoUpdate)
end

function FormationGroupController:sendTopPresetsTab(tabId)
	FormationAgent.instance:sendPM_TopPresetsFormationReq(tabId)
end

function FormationGroupController:onTopPresetsTab(msg)
	FormationGroupModel.instance:onTopPresetsTab(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FormationTabModify, -2)
end

function FormationGroupController:sendModifyOrAddTab(groupId, name)
	self:sendAddNewTab(groupId, name)
end

function FormationGroupController:sendAddNewTab(groupId, name, pos, summonMasterPetId, summonedPetId)
	local count = FormationGroupModel.instance:getTabCount()

	if count >= LIMIT_TAB_COUNT then
		TipsFacade.instance:openPopupWindowWithX(lang("tip"), "预设阵最多" .. LIMIT_TAB_COUNT .. "个")

		return
	end

	local presetsForm_pb_Ary = {}
	local pb = FormationExtension_pb.PM_PresetsFormTab()

	pb.tabName = name
	pb.topId = 0
	pb.groupId = groupId
	pb.simpleForm.formId = 10

	if pos == nil then
		pos = {
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	end

	for i, v in ipairs(pos) do
		pb.simpleForm.pos:append(v)
	end

	pb.simpleForm.extParams.heroSkillId = 0

	if summonedPetId and summonMasterPetId then
		pb.simpleForm.extParams.summonedPetId = summonedPetId
		pb.simpleForm.extParams.summonMasterPetId = summonMasterPetId
	end

	table.insert(presetsForm_pb_Ary, pb)

	local curTabId = FormationGroupModel.instance.curTabId

	FormationAgent.instance:sendPM_SetPresetsFormsReq(curTabId, presetsForm_pb_Ary)
end

function FormationGroupController:sendChangeTabId(curTabId)
	FormationAgent.instance:sendPM_SetPresetsFormsReq(curTabId, nil)
end

function FormationGroupController:sendSaveCurFmtMo(curTabId, tabInfo, simpleFormPb, summonMasterId, summonedPetId)
	local presetsForm_pb_Ary = {}
	local pb = FormationExtension_pb.PM_PresetsFormTab()

	pb.tabId = tabInfo.tabId
	pb.tabName = tabInfo.tabName
	pb.topId = 0
	pb.groupId = tabInfo.groupId

	pb.simpleForm:ParseFromString(simpleFormPb:SerializeToString())
	table.insert(presetsForm_pb_Ary, pb)
	FormationAgent.instance:sendPM_SetPresetsFormsReq(curTabId, presetsForm_pb_Ary)
end

function FormationGroupController:onMontifyTab(msg)
	FormationGroupModel.instance:onMontifyTab(msg)

	local curTabId = FormationGroupModel.instance.curTabId

	GlobalDispatcher:dispatch(GlobalNotify.FormationTabModify, curTabId)
end

function FormationGroupController:onPresetsFormationChanged(msg)
	FormationGroupModel.instance:onPresetsFormationChanged(msg)
end

FormationGroupController.instance = FormationGroupController.New()

return FormationGroupController

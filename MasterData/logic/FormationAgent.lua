-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/agent/FormationAgent.lua

module("logic.extensions.formation.agent.FormationAgent", package.seeall)

local FormationAgent = class("FormationAgent", BaseAgent)

FormationAgent.PM_UserFormGlobalInfo = "FormationAgent_PM_UserFormGlobalInfo"
FormationAgent.PM_SetTabNameRes = "FormationAgent_PM_SetTabNameRes"
FormationAgent.PM_OnGainNewFormationTabsRes = "FormationAgent_PM_OnGainNewFormationTabsRes"
FormationAgent.PM_OnFormationChanged = "FormationAgent_PM_OnFormationChanged"
FormationAgent.PM_TargetMyForm = "FormationAgent_PM_TargetMyForm"
FormationAgent.PM_LoadUserTargetMyFormsReq = "FormationAgent_PM_LoadUserTargetMyFormsReq"
FormationAgent.PM_NotifyMyFormChanged = "FormationAgent_PM_NotifyMyFormChanged"

function FormationAgent:ctor()
	return
end

function FormationAgent:setExtId(extId)
	FormationAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FormationAgent:sendPM_LoadUserAllFormsReq(handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_LoadUserAllFormsReq()

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_UserFormGlobalInfo, handler, handlerObj, errHandler)
end

function FormationAgent:handlePM_LoadUserAllFormsRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadFormations===back")

	if status == 0 then
		FormationNewModel.instance:UpdateData(msg.formInfo)
		FormationNewModel.instance:updateFormStrengthInfo(msg.strengthInfo)
	end
end

function FormationAgent:handlePM_UserFormGlobalInfo(status, msg)
	self:dispatch(FormationAgent.PM_UserFormGlobalInfo, status, msg)

	if status == 0 then
		FormationNewModel.instance:UpdateData(msg)
	end
end

function FormationAgent:sendPM_UserFormGlobalInfo(curTab, userFormTab_pb_Ary, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_UserFormGlobalInfo()

	req.curTab = FormationNewModel.instance:GetCurTeamId()

	for teamId, teamInfo in ipairs(FormationNewModel.instance:GetAllTeams()) do
		local userTeam = FormationExtension_pb.PM_UserFormTab()

		if req.curTab == teamId then
			userTeam.tabId = teamId
			userTeam.curFormId = teamInfo:GetCurFormationId()

			for formId, formInfo in ipairs(teamInfo:GetAllFormations()) do
				local simpleForm = userTeam.simpleForm

				simpleForm.formId = formId

				for posId, posInfo in ipairs(formInfo:GetPositions()) do
					table.insert(simpleForm.pos, posId, posInfo)
				end

				simpleForm.extParams.heroSkillId = formInfo:GetHeroSkillId()

				local info = formInfo:GetFormStrengthInfo()

				if info then
					simpleForm.extParams.formStrengthId = checknumber(info.formStrengthId)
				end

				break
			end

			table.insert(req.userFormTab, userTeam)
		end
	end

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_UserFormGlobalInfo, handler, handlerObj, errHandler)
end

function FormationAgent:sendPM_UserFormGlobalInfoEx(curTab, userFormTab_pb_Ary, formZdlDetail_pb, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_UserFormGlobalInfo()

	req.curTab = curTab

	for i, v1 in ipairs(userFormTab_pb_Ary) do
		local userFormTab = req.userFormTab:add()

		userFormTab:ParseFromString(v1:SerializeToString())
	end

	if formZdlDetail_pb ~= nil then
		req.formZdlDetail:ParseFromString(formZdlDetail_pb:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_UserFormGlobalInfo, handler, handlerObj, errHandler)
end

function FormationAgent:sendPM_SetTabNameReq(tabId, newTabName, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_SetTabNameReq()

	req.tabId = tabId
	req.newTabName = newTabName

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_SetTabNameRes, handler, handlerObj, errHandler)
end

function FormationAgent:handlePM_SetTabNameRes(status, msg)
	self:dispatch(FormationAgent.PM_SetTabNameRes, status, msg)
end

function FormationAgent:handlePM_OnGainNewFormationTabsRes(status, msg)
	FormationController.instance:showGainNewFormation(msg)
	self:dispatch(FormationAgent.PM_OnGainNewFormationTabsRes, status, msg)
end

function FormationAgent:handlePM_OnFormationChanged(status, msg)
	if status == 0 then
		FormationNewModel.instance:FormChanged(msg.form)
	end

	self:dispatch(FormationAgent.PM_OnFormationChanged, status, msg)
end

function FormationAgent:sendPM_LoadUserTargetMyFormsReq(target, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_LoadUserTargetMyFormsReq()

	req.target = target

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_TargetMyForm, handler, handlerObj, errHandler)
end

function FormationAgent:handlePM_TargetMyForm(status, msg)
	self:dispatch(FormationAgent.PM_TargetMyForm, status, msg)
end

function FormationAgent:sendPM_TargetMyForm(target, curFormId, simpleForm_pb_Ary, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_TargetMyForm()

	req.target = target
	req.curFormId = curFormId

	for i, v2 in ipairs(simpleForm_pb_Ary) do
		local simpleForm = req.simpleForm:add()

		simpleForm:ParseFromString(v2:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_TargetMyForm, handler, handlerObj, errHandler)
end

function FormationAgent:sendPM_DelThenSetTargetMyFormsReq(targetMyForm_pb, handler, handlerObj, errHandler)
	local req = FormationExtension_pb.PM_DelThenSetTargetMyFormsReq()

	req.targetMyForm:ParseFromString(targetMyForm_pb:SerializeToString())
	self:sendMsg(req)
	self:addEventOnce(FormationAgent.PM_LoadUserTargetMyFormsReq, handler, handlerObj, errHandler)
end

function FormationAgent:handlePM_LoadUserTargetMyFormsReq(status, msg)
	self:dispatch(FormationAgent.PM_LoadUserTargetMyFormsReq, status, msg)
end

function FormationAgent:handlePM_NotifyMyFormChanged(status, msg)
	self:dispatch(FormationAgent.PM_NotifyMyFormChanged, status, msg)
end

function FormationAgent:sendPM_UpgradeFormStrengthReq(formStrengthId)
	local req = FormationExtension_pb.PM_UpgradeFormStrengthReq()

	req.formStrengthId = formStrengthId

	self:sendMsg(req)
end

function FormationAgent:handlePM_UpgradeFormStrengthRes(status, msg)
	if status == 0 then
		FormationNewModel.instance:upGradeFormSuccessed(msg.strengthInfo.formStrengthId)
	end
end

function FormationAgent:sendPM_LoadPersetsAllFormsReq()
	local req = FormationExtension_pb.PM_LoadPersetsAllFormsReq()

	self:sendMsg(req)
end

function FormationAgent:handlePM_LoadPersetsAllFormsRes(status, msg)
	if status == 0 then
		forcePrint("=====RoleDataRequestor:_loadFormations+sendGetInfoOnce===back")
		FormationGroupController.instance:onGetInfo(msg)
	end
end

function FormationAgent:sendPM_SetPresetsFormsReq(curTabId, presetsForm_pb_Ary)
	local req = FormationExtension_pb.PM_SetPresetsFormsReq()

	req.curTabId = curTabId

	if presetsForm_pb_Ary ~= nil then
		for i, v2 in ipairs(presetsForm_pb_Ary) do
			local presetsForm = req.presetsForm:add()

			presetsForm:ParseFromString(v2:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function FormationAgent:handlePM_SetPresetsFormsRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onMontifyTab(msg)
	end
end

function FormationAgent:sendPM_SetPresetNameReq(tabId, newTabName)
	local req = FormationExtension_pb.PM_SetPresetNameReq()

	req.tabId = tabId
	req.newTabName = newTabName

	self:sendMsg(req)
end

function FormationAgent:handlePM_SetPresetNameRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onModifyTabName(msg)
	end
end

function FormationAgent:sendPM_TopPresetsFormationReq(tabId)
	local req = FormationExtension_pb.PM_TopPresetsFormationReq()

	req.tabId = tabId

	self:sendMsg(req)
end

function FormationAgent:handlePM_TopPresetsFormationRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onTopPresetsTab(msg)
	end
end

function FormationAgent:sendPM_DeletePresetsFormationReq(tabId)
	local req = FormationExtension_pb.PM_DeletePresetsFormationReq()

	req.tabId = tabId

	self:sendMsg(req)
end

function FormationAgent:handlePM_DeletePresetsFormationRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onDeleteTab(msg)
	end
end

function FormationAgent:sendPM_ModifyPresetsGroupReq(groupId, newGroupName)
	local req = FormationExtension_pb.PM_ModifyPresetsGroupReq()

	if groupId ~= nil then
		req.groupId = groupId
	end

	req.newGroupName = newGroupName

	self:sendMsg(req)
end

function FormationAgent:handlePM_ModifyPresetsGroupRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onModifyOrAddGroup(msg)
	end
end

function FormationAgent:sendPM_TopPresetsGroupReq(groupId)
	local req = FormationExtension_pb.PM_TopPresetsGroupReq()

	req.groupId = groupId

	self:sendMsg(req)
end

function FormationAgent:handlePM_TopPresetsGroupRes(status, msg)
	return
end

function FormationAgent:sendPM_DeletePresetsGroupReq(groupId)
	local req = FormationExtension_pb.PM_DeletePresetsGroupReq()

	req.groupId = groupId

	self:sendMsg(req)
end

function FormationAgent:handlePM_DeletePresetsGroupRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onDeleteGroup(msg)
	end
end

function FormationAgent:sendPM_ChangePresetsFormationGroupReq(tabId, groupId)
	local req = FormationExtension_pb.PM_ChangePresetsFormationGroupReq()

	req.tabId = tabId
	req.groupId = groupId

	self:sendMsg(req)
end

function FormationAgent:handlePM_ChangePresetsFormationGroupRes(status, msg)
	if status == 0 then
		FormationGroupController.instance:onTabChangeGroup(msg)
	end
end

function FormationAgent:handlePM_OnPresetsFormationChangedRes(status, msg)
	FormationGroupController.instance:onPresetsFormationChanged(msg)
end

FormationAgent.instance = FormationAgent.New()

return FormationAgent

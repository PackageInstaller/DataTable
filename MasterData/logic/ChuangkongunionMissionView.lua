-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionMissionView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionMissionView", package.seeall)

local ChuangkongunionMissionView = class("ChuangkongunionMissionView", MissionView)

function ChuangkongunionMissionView:onEnter()
	local _openParam = self:getOpenParam()

	self._stageCfg = _openParam[1]
	self._activityId = _openParam[2]
	self._teamId = _openParam[3]
	self._teamCfg = ChuangkongunionConfig.instance:getTeamById(self._teamId or self._stageCfg.teamId)

	self:onEnterInherit()

	if self._teamId == nil then
		FastFormation.instance:setGetCurPetList(function()
			return ChuangkongunionModel.instance:getAllHelpPets()
		end)
		FastFormation.instance:setCurFormFunc(function()
			return ChuangkongunionModel.instance:getFormation(self._teamId or self._stageCfg.teamId)
		end)
	end

	self:_setDescStr(self._teamCfg.name, "", self._teamCfg.WinDesc)
	self._videoButton.gameObject:SetActive(not self._teamId and self._stageCfg.needSaveVideo)
	self:_setTxtDesc(self._teamCfg.missionDesc)
end

function ChuangkongunionMissionView:_enterBattle()
	if self._teamId then
		ChuangKongUnionAgent.instance:sendPM_CKUDoDailyTaskReq(self._activityId, self._stageCfg, false)
	else
		local formInfo = ChuangkongunionModel.instance:getFormation(self._teamId or self._stageCfg.teamId)
		local simpleForm = formInfo:createFormPb()

		ChuangKongUnionAgent.instance:sendPM_CKUDoBreachFormTaskReq(self._activityId, self._stageCfg.taskId, self._stageCfg.stage, false, simpleForm)
	end

	UIJumper.instance:pushOneStack(ViewName.ChuangkongunionView, true)
end

function ChuangkongunionMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	if self._teamId then
		return ChuangkongunionMissionView.super.checkFormationEmptyAndPosNumLimit(self, callback, hasOneKey, onekeyCallBack)
	else
		local formation = ChuangkongunionModel.instance:getFormation(self._teamId or self._stageCfg.teamId)
		local empty = true

		if formation then
			for i = 1, 9 do
				local pos = formation:GetPosition(i)

				if not pos then
					empty = true
				end

				if pos > 0 then
					empty = false

					break
				end
			end
		end

		if empty then
			TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, lang("fight_goto_fmt"))
		end

		return empty
	end
end

function ChuangkongunionMissionView:_onClickVideo()
	BattleRecordRankController.instance:enterView2("cku_" .. self._stageCfg.taskId .. "_" .. self._stageCfg.stage)
end

function ChuangkongunionMissionView:_isCurFormationEmpty()
	if self._teamId then
		return FormationFacade.instance:isCurFormationEmpty()
	else
		return false
	end
end

return ChuangkongunionMissionView

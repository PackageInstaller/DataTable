-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/RecordMissionView.lua

module(..., package.seeall)

local RecordMissionView = class("RecordMissionView", MissionView)

function RecordMissionView:ctor()
	RecordMissionView.super.ctor(self)
end

function RecordMissionView:buildUI()
	RecordMissionView.super.buildUI(self)

	self._goRecord = self:getGo("record")
	self._btnCopy = self:getBtn("record/btnCopy")
	self._btnRecordPlay = self:getBtn("record/btnPlay")
	self._btnFlower = self:getBtn("record/btnFlower")

	self:getGo("dropThrowAwayArea"):SetActive(false)
	self:getGo("bottomBg"):SetActive(false)
	self:getGo("Nego_Right"):SetActive(false)
	self:getGo("btnSetting"):SetActive(false)
	self:getGo("BtnNextForm"):SetActive(false)
end

function RecordMissionView:onEnter()
	GlobalDispatcher:addListener(BreachFormationAgent.PM_BreachFormationWatchBattleVideoRes, self._onWatchRes, self)
	self:onEnterInherit()
	self:_setMaskBlock(false)
	self:procMid()
	self._btnOneKey.gameObject:SetActive(false)
	self._btnClean.gameObject:SetActive(false)
	self._startBtn.gameObject:SetActive(false)
	self._goRecord:SetActive(true)
	self._btnCopy:AddClickListener(self._onClickCopy, self)
	self._btnRecordPlay:AddClickListener(self._onClickRecordPlay, self)
	self._btnFlower:AddClickListener(self._onClickFlower, self)
end

function RecordMissionView:onExit()
	RecordMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(BreachFormationAgent.PM_BreachFormationWatchBattleVideoRes, self._onWatchRes, self)
	self._btnCopy:RemoveClickListener()
	self._btnRecordPlay:RemoveClickListener()
	self._btnFlower:RemoveClickListener()
end

function RecordMissionView:procMid()
	local data = self._viewPresentor._openParam[1]
	local key = self._viewPresentor._openParam[2]
	local hideBtns = self._viewPresentor._openParam[3]
	local playFlag = self._viewPresentor._openParam[4]

	if not data.userName then
		local strTitle = langPara("%s的阵容", (data.headInfo or nil) and (data.headInfo.userName or ""))

		self:_setDescStr(strTitle, "", strTitle)
		goutil.setActive(self._btnRecordPlay.gameObject, hideBtns ~= true or playFlag == nil or playFlag)
		goutil.setActive(self._btnCopy.gameObject, hideBtns ~= true)
		Framework.TransformUtil.SetAnchoredPos(self._btnRecordPlay:GetComponent(goutil.Type_RectTransform), self._btnCopy.gameObject.activeSelf and 198 or 0, -309.4)

		self._isEndlessBattle = string.find(key, BattleRecordRankController.EndlessPrefix)
		self._isLegendBattle = string.find(key, BattleRecordRankController.LegendPrefix)
		self._isWTowerBattle = string.find(key, BattleRecordRankController.WTowerPrefix)

		if self._isEndlessBattle then
			goutil.setActive(self._btnRecordPlay.gameObject, false)
		end
	end
end

function RecordMissionView:_onClickCopy()
	local state = BattleRecordFmtModel.instance:hasPetState()

	if state == 1 then
		self:_doCopy()
	elseif state == 2 then
		TipsFacade.instance:openPopupWindow(lang("tip"), "阵容中存在未获得的精灵，是否继续使用此阵容？", function()
			self:_doCopy()
		end)
	else
		TipsFacade.instance:openTipWindow(lang("tip"), "缺少精灵，您无法使用此阵容")
	end
end

function RecordMissionView:_doCopyEndlessBattle()
	local fmo = BattleRecordFmtModel.instance:getFormation()
	local simpleForm = fmo:createFormPb()
	local len = #simpleForm.pos

	for i = len, 1, -1 do
		simpleForm.pos:remove(i)
	end

	simpleForm.formId = 0

	for i = 1, 9 do
		local petInfo = BattleRecordFmtModel.instance:getPetInfoByPos(i)

		simpleForm.pos:append((petInfo or nil) and checknumber(BagModel.instance:getMaxZdlPetIdByRaceId(petInfo.raceId)))
	end

	EndlessBattleController.instance:setInfiniteFightFormReq(simpleForm, self._onSetSuccess, self)
end

function RecordMissionView:_doCopyLegendBattle()
	if not LegendModel.instance:isExistSupportPet() then
		self:_copyToDeaultFormation()

		return
	end

	local formation = LegendModel.instance:getFormation()
	local challengeId, stageId = LegendModel.instance:getOpenChallengeIdAndStageId()
	local cfgSupport = LegendConfig.instance:getSuportCfgByChallengeId(challengeId, stageId)

	for i = 1, 9 do
		if i ~= ((cfgSupport or nil) and cfgSupport.posId) then
			local petInfo = BattleRecordFmtModel.instance:getPetInfoByPos(i)

			formation:SetPosition(i, (petInfo or nil) and checknumber(BagModel.instance:getMaxZdlPetIdByRaceId(petInfo.raceId)))
		end
	end

	LegendModel.instance:saveCurrFormation(challengeId, stageId)
end

function RecordMissionView:_doCopyWTowerBattle()
	local towerId = WTowerModel.instance:getTowerId()

	if towerId and towerId ~= WTowerModel.TowerType.Warrior then
		local fmo = BattleRecordFmtModel.instance:getFormation()
		local simpleForm = fmo:createFormPb()
		local len = #simpleForm.pos

		for i = len, 1, -1 do
			simpleForm.pos:remove(i)
		end

		for i = 1, 9 do
			local petInfo = BattleRecordFmtModel.instance:getPetInfoByPos(i)

			simpleForm.pos:append((petInfo or nil) and checknumber(BagModel.instance:getMaxZdlPetIdByRaceId(petInfo.raceId)))
		end

		WTowerController.instance:saveRecordForm(towerId, simpleForm, function()
			self:_onSetSuccess()
		end)
	else
		self:_copyToDeaultFormation()
		self:_onSetSuccess()
	end
end

function RecordMissionView:_onSetSuccess()
	FloatWordMgr.instance:show("阵型保存成功~")
end

function RecordMissionView:_doCopy()
	if self._isEndlessBattle then
		self:_doCopyEndlessBattle()

		return
	end

	if self._isLegendBattle then
		self:_doCopyLegendBattle()
		self:_onSetSuccess()

		return
	end

	if self._isWTowerBattle then
		self:_doCopyWTowerBattle()

		return
	end

	self:_copyToDeaultFormation()
	self:close()
	UIStateManager.instance:push(ViewName.FormationView)
end

function RecordMissionView:_copyToDeaultFormation()
	local pos = {}

	for i = 1, 9 do
		pos[i] = 0

		local petInfo = BattleRecordFmtModel.instance:getPetInfoByPos(i)

		if petInfo then
			local bagPetId = BagModel.instance:getMaxZdlPetIdByRaceId(petInfo.raceId)

			pos[i] = bagPetId and bagPetId or 0
		else
			pos[i] = 0
		end
	end

	FormationController.instance:setPositionForce(pos)
end

function RecordMissionView:_onClickRecordPlay()
	local data = self._viewPresentor._openParam[1]
	local key = self._viewPresentor._openParam[2]

	UIJumper.instance:saveCurStack()

	if string.find(key, BattleRecordRankController.BFPrefix) then
		local ids = string.split(key, "_")
		local teamId = checknumber(ids[2])
		local monsterId = checknumber(ids[3])

		BreachFormationAgent.instance:sendPM_BreachFormationWatchBattleVideoReq(teamId, monsterId, data.battleId)
	else
		BattleRecordRankAgent.instance:sendPM_BattleRecordGetBattleVideoReq2(key, data.battleId)
	end
end

function RecordMissionView:_onClickFlower()
	return
end

function RecordMissionView:_onWatchRes(status, msg)
	if status == 0 then
		BattleFacade.instance:onViewUserFightMonsterBtlResult(msg.btlResult)
	end
end

return RecordMissionView

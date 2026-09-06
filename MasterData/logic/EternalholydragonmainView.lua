-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragonmainView.lua

module("logic.extensions.eternalholydragon.view.EternalholydragonmainView", package.seeall)

local EternalholydragonmainView = class("EternalholydragonmainView", ViewComponent)

function EternalholydragonmainView:ctor()
	EternalholydragonmainView.super.ctor(self)
end

function EternalholydragonmainView:buildUI()
	EternalholydragonmainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnChallenge = self:getBtn("right/btnStart")
	self._btnCall = self:getBtn("btnCall")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._goldBarCon = self:getGo("goldBarCon")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._petCon = self:getGo("petCon")
	self._txtPetName = self:getTxt("petInfo/name/txtName")
	self._petRareCon = self:getGo("petInfo/name/imgRare")
	self._redPointChallenge = self:getGo("btnChallenge/redpoint")
	self._rules = self:getGo("right/rules")

	local buffCell = self:getGo("right/buff/buffCell")

	if buffCell then
		self._buffCell = PanduolaBuffCell.New(buffCell)
	end

	self._txtNull = self:getGo("right/buff/txtBuffEmpty")
	self._btnVerify = self:getBtn("right/buff/btnVerify")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._txtTitle = self:getTxt("txtTitle")
	self._dotGo = self:getGo("right/buff/btnVerify/dot")
	self._petConGo = self:getGo("petCon")
end

function EternalholydragonmainView:bindEvents()
	EternalholydragonmainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	self._btnVerify:AddClickListener(self._onClickVerify, self)
end

function EternalholydragonmainView:unbindEvents()
	EternalholydragonmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	self._btnVerify:RemoveClickListener()
end

function EternalholydragonmainView:onEnter()
	EternalholydragonmainView.super.onEnter(self)
	self.addGEvent(self, EternalHolyDragonChallengeAgent.EHolyDragonClgGetInfoRes, self._onGetInfo, self)
	self.addGEvent(self, GlobalNotify.PetVerifySuccess, self._updateBuffUI, self)

	self._activityType = GameEnum.ActivityType.EHolyDragon

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	EternalholydragonModel.instance:setActivityId(self._activityId)

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._actCfg = EternalholydragonConfig.instance:getActivityCfg(self._activityId)
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_setAoqiGodUI()
	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._petRareCon)

	self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._actCfg.raceId)
	self._txtTitle.text = self._actCfg.title

	self:_setTopGoldBar()
	EternalHolyDragonChallengeAgent.instance:sendPM_EHolyDragonClgGetInfoReq(self._activityId)

	self._buffPlanId = self._actCfg.petVerifyPlanId

	PetverifyController.instance:getVerifyInfo(self._buffPlanId, GameUtil.handler(self._updateBuffUI, self))
	self:_setPet()
	RedPointController.instance:regRedPoint(self._dotGo, RedPointModel.ID_ETER_HOLYDRAGON_VERIFY)
end

function EternalholydragonmainView:_setAoqiGodUI()
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnShop, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
end

function EternalholydragonmainView:onExit()
	EternalholydragonmainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRareCon)
	RedPointController.instance:unregRedPoint(self._redPointChallenge)
	RoleObjectPool.instance:removeRole(self._roleObj)

	self._roleObj = nil

	RedPointController.instance:unregRedPoint(self._dotGo)
end

function EternalholydragonmainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._actCfg.ruleKey)
end

function EternalholydragonmainView:_onClickChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.EHolyDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	local info = EternalholydragonModel.instance:getInfo()

	if not info then
		return
	end

	local cfgs = EternalholydragonConfig.instance:getStageCfgs(info.activityId)

	if info.clgProgress + 1 > #cfgs then
		FloatWordMgr.instance:show("该关卡已通关 无需重复挑战")

		return
	end

	UIStateManager.instance:push(ViewName.EternalholydragongameView)
end

function EternalholydragonmainView:_onClickCall()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function EternalholydragonmainView:_onClickShop()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function EternalholydragonmainView:_onClickRank()
	GotoMgr.gotoByString(self._actCfg.jumpTo[3])
end

function EternalholydragonmainView:_onClickPetInfo()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:openPetinfoView(self._actCfg.raceId)
	end
end

function EternalholydragonmainView:_onClickSkill()
	if checknumber(self._actCfg.raceId) > 0 then
		PetbookController.instance:previewBattle(self._actCfg.raceId)
	end
end

function EternalholydragonmainView:_setTopGoldBar()
	local barShow = string.split("8:1", "#")
	local btn_list = {}

	for i, v in ipairs(barShow) do
		local matType, matId, num = MaterialMgr.getMatParams(v)

		table.insert(btn_list, {
			showAdd = false,
			id = string.format("%d:%d", matType, matId)
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function EternalholydragonmainView:_updateRules(text)
	GameUtil.updateCellsWithCreate(self._rules, string.split(text, "\n"), function(cell, data)
		cell:GetComponent(goutil.Type_UIText).text = data
	end)
end

function EternalholydragonmainView:_updateBuffUI()
	local verifyCfg = PetverifyController.instance:getCurrPlanBuff(self._buffPlanId)

	self._hasBuff = verifyCfg ~= nil

	self._txtNull:SetActive(not self._hasBuff)
	self._buffCell:setActive(self._hasBuff)
	self._buffCell:updateWithPetVerifyCfg(verifyCfg)
	EternalholydragonController.instance:checkVerifyRedDot()
end

function EternalholydragonmainView:_onGetInfo()
	return
end

function EternalholydragonmainView:_onClickVerify()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.EHolyDragon, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end
	end

	if self._buffPlanId == nil then
		print("buffPlanId为空")

		return
	end

	UIStateManager.instance:push(ViewName.PetverifyView, self._buffPlanId)
end

function EternalholydragonmainView:_checkRedDot()
	local isRed = false

	if not self._hasBuff then
		local verifyPlanCfg = PetVerifyBuffConfig.instance:getPlanCfgById(self._buffPlanId)

		if verifyPlanCfg then
			local raceIds = string.split(verifyPlanCfg.validator, ",")
			local raceIds_kv = {}

			for i, v in ipairs(raceIds) do
				raceIds_kv[checknumber(v)] = true
			end

			local pets = BagModel.instance:getPets()

			for i, v in ipairs(pets) do
				if raceIds_kv[v.raceId] then
					isRed = true

					break
				end
			end
		end
	end

	goutil.setActive(self._dotGo, isRed)
end

function EternalholydragonmainView:_setPet()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._actCfg.raceId, self._petConGo, 1, nil, true, 0, 0)
end

return EternalholydragonmainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/tab/space/TabPTEliFinialBaseSpaceView.lua

module("logic.extensions.peaktournament.view.eliminator.tab.space.TabPTEliFinialBaseSpaceView", package.seeall)

local TabPTEliFinialBaseSpaceView = class("TabPTEliFinialBaseSpaceView", ViewComponent)

function TabPTEliFinialBaseSpaceView:buildUI()
	TabPTEliFinialBaseSpaceView.super.buildUI(self)

	self._txtRemainTime = goutil.findChildTextComponent(self.mainGO, "txtRemainTime/txt")
	self._btnExchange = goutil.findChild(self.mainGO, "btnCol/btnExchange")
	self._btnReward = goutil.findChild(self.mainGO, "btnCol/btnReward")
	self._btnWatch = goutil.findChild(self.mainGO, "roleCol/btnWatch")
	self._btnVote = goutil.findChild(self.mainGO, "btnCol/btnVote")
	self._btnBanPet = goutil.findChild(self.mainGO, "btnCol/btnBanPet")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._fightEffParent = goutil.findChild(self.mainGO, "fightEffParent")
	self._fightEff = nil
end

function TabPTEliFinialBaseSpaceView:bindEvents()
	TabPTEliFinialBaseSpaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickBtnExchange, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnWatch, self._onClickBtnWatch, self)
	GameUtil.addClickHandler(self._btnVote, self._onCLickBtnVote, self)
	GameUtil.addClickHandler(self._btnBanPet, self._onCLickBtnBanPet, self)
end

function TabPTEliFinialBaseSpaceView:unbindEvents()
	TabPTEliFinialBaseSpaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnWatch)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnBanPet)
end

function TabPTEliFinialBaseSpaceView:onEnter()
	TabPTEliFinialBaseSpaceView.super.onEnter(self)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	self._eliminatorMgr = PeakTournamentController.instance:getEliminatorMgr()

	if self._eliminatorMgr == nil then
		printError("缺失[ EliminatorMgr模块 ],无法运行")
		self:close()

		return
	end

	self._curEliRoundId = self:_getEliRoundId()

	if self._curEliRoundId == nil or self._curEliRoundId == 0 then
		printError("eliRoundId 需继承后正确重写")
		self:close()

		return
	end

	self._curGroupIdx = 1
	self._curStageIdx = 1
	self._eliRoundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._activityId)

	self:_onUpdateEliRoundInfo()
	self:_setAvatarCameraEnv(true)
	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendGetParticipationInfoReq, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetGroupStageInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._sendTheRoundGroupInfoReq, self)
	self:_sendGetParticipationInfoReq()

	local isHave = PeakTournamentController.instance:isTheSeasonHaveBanPet(self._activityId, GameEnum.PeakTournamentStep.Eliminator)

	GameUtil.SetActive(self._btnBanPet, isHave)
	settimer(0.1, self._onTicking, self)
	self:_onUpdate()
end

function TabPTEliFinialBaseSpaceView:onExit()
	TabPTEliFinialBaseSpaceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._sendGetParticipationInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetGroupStageInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGetParticipationInfoRes, self._sendTheRoundGroupInfoReq, self)
	self:_clearAvatarPool()
	self:_setAvatarCameraEnv(false)
	removetimer(self._onTicking, self)
	self:_onClearUI()

	self._eliminatorMgr = nil
end

function TabPTEliFinialBaseSpaceView:destroyUI()
	PTQualifierMainView.super.destroyUI(self)
end

function TabPTEliFinialBaseSpaceView:_sendGetParticipationInfoReq()
	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetParticipationInfoReq(self._activityId)
end

function TabPTEliFinialBaseSpaceView:_sendTheRoundGroupInfoReq()
	local roundGroupListPool = {}

	roundGroupListPool[self._curEliRoundId] = {
		self._curGroupIdx
	}

	PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetGroupStageInfoReq(self._activityId, roundGroupListPool)
end

function TabPTEliFinialBaseSpaceView:_getEliRoundId()
	return 0
end

function TabPTEliFinialBaseSpaceView:_onUpdate()
	self:_onUpdateEliRoundInfo()
	self:_onUpdateRoleColUI()
	self:_onUpdatePlaneUI()
end

function TabPTEliFinialBaseSpaceView:_onClearUI()
	UIEffectManager.instance:stopEffect(self._fightEff)
end

function TabPTEliFinialBaseSpaceView:_onUpdatePlaneUI()
	UIEffectManager.instance:stopEffect(self._fightEff)

	if self._curPeriodId == EliminatorMgr.PeriodId.Performance then
		local effParent = self._fightEffParent
		local pathName = "20221223/duizhan/fx_ui_zhandou_jian"

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = false
			end

			local handlerTarget

			self._fightEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end
end

function TabPTEliFinialBaseSpaceView:_onTicking()
	self:_onUpdateRemainTimeUI()
end

function TabPTEliFinialBaseSpaceView:_onUpdateEliRoundInfo()
	self._newestEliRoundId = self._eliminatorMgr:getNewestEliRoundId()
	self._curPeriodId = self._eliminatorMgr:getCurPeriodId(self._curEliRoundId)
end

function TabPTEliFinialBaseSpaceView:_onUpdateRemainTimeUI()
	if self._eliminatorMgr then
		self._txtRemainTime.text = self._eliminatorMgr:getRemainTimeTipsStr(self._curEliRoundId)
	end
end

function TabPTEliFinialBaseSpaceView:_onUpdateRoleColUI()
	local roleCell_1 = goutil.findChild(self.mainGO, "roleCol/roleCell_1")
	local roleCell_2 = goutil.findChild(self.mainGO, "roleCol/roleCell_2")
	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(self._curEliRoundId, self._curGroupIdx, self._curStageIdx)
	local arr = {
		roleCell_1,
		roleCell_2
	}

	for roleIdx, roleCellGo in ipairs(arr) do
		local root = goutil.findChild(self._modelCam, "posList/pos_" .. roleIdx)
		local headIcon = goutil.findChild(roleCellGo, "info/headIcon")
		local tag = goutil.findChild(roleCellGo, "info/tag")
		local tagUIImageSpriteChange = tag:GetComponent("UIImageSpriteChange")
		local txtTag = goutil.findChildTextComponent(roleCellGo, "info/tag/txt")
		local txtname = goutil.findChildTextComponent(roleCellGo, "info/txtname")
		local txtPower = goutil.findChildTextComponent(roleCellGo, "info/txtPower")
		local isMe = roleIdx == 1
		local headInfo = resultInfoMo and resultInfoMo:getHeadInfo(isMe)

		if headInfo then
			HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo, true)
		else
			HeadItemController.instance:resetHeadCell(headIcon)
		end

		txtname.text = resultInfoMo and resultInfoMo:getUserNameAddAreaId(isMe) or "???"
		txtPower.text = resultInfoMo and resultInfoMo:getEverMaxZdl(isMe)

		local gender = resultInfoMo and resultInfoMo:getGender(isMe)
		local clothes = resultInfoMo and resultInfoMo:getClothes(isMe)

		if gender and clothes then
			self:_showAvatar(root, gender, clothes)
		else
			self:_hideAvatar(root)
		end

		local isWin = resultInfoMo and resultInfoMo:isWin(isMe) or false
		local isNeedShowTag = self._curPeriodId > EliminatorMgr.PeriodId.Performance

		GameUtil.SetActive(tag, isNeedShowTag)

		if isNeedShowTag then
			tagUIImageSpriteChange:SetState(isWin and 0 or 1)

			txtTag.text = ((self._eliRoundCfg[self._curEliRoundId] and self._eliRoundCfg[self._curEliRoundId].rankSize[1] == 3 and self._eliRoundCfg[self._curEliRoundId].rankSize[2] == 4 or nil) and true or self._curEliRoundId == 7 or self._curEliRoundId == 13) and (isWin and "季军" or "殿军") or isWin and "冠军" or "亚军"
		end
	end
end

function TabPTEliFinialBaseSpaceView:_onClearRoleColUI()
	local roleCell_1 = goutil.findChild(self.mainGO, "roleCol/roleCell_1")
	local roleCell_2 = goutil.findChild(self.mainGO, "roleCol/roleCell_2")

	for roleIdx, roleCellGo in ipairs({
		roleCell_1,
		roleCell_2
	}) do
		local root = goutil.findChild(self._modelCam, "posList/pos_" .. roleIdx)
		local headIcon = goutil.findChild(roleCellGo, "info/headIcon")

		HeadItemController.instance:resetHeadCell(headIcon)
		self:_hideAvatar(root)
	end
end

function TabPTEliFinialBaseSpaceView:_showAvatar(parentGo, gender, clothes)
	local avatar = self:_getAvatar(parentGo)

	avatar:updateByMo(self:_getAvatarMo(gender, clothes))
	GameUtil.SetActive(parentGo, true)
end

function TabPTEliFinialBaseSpaceView:_hideAvatar(parentGo)
	GameUtil.SetActive(parentGo, false)
end

function TabPTEliFinialBaseSpaceView:_getAvatar(parentGo)
	if self._avatarPool == nil then
		self._avatarPool = {}
	end

	if self._avatarPool[parentGo] then
		return self._avatarPool[parentGo]
	end

	local avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	avatar.useType = AvatarUseType.Scene

	avatar:setParent(parentGo.transform)
	avatar:setLayer(SceneLayer.UI3D_Value)

	self._avatarPool[parentGo] = avatar

	return avatar
end

function TabPTEliFinialBaseSpaceView:_getAvatarMo(gender, clothes)
	return DressModel.instance:getAvatarMoByGrCosAndMount(gender, clothes, nil)
end

function TabPTEliFinialBaseSpaceView:_clearAvatarPool()
	if self._avatarPool then
		for _, avatar in pairs(self._avatarPool) do
			AvatarsMgrNew.instance:removeAvatar(avatar)
		end
	end

	self._avatarPool = nil
end

function TabPTEliFinialBaseSpaceView:_setAvatarCameraEnv(isOnEnter)
	if isOnEnter then
		goutil.addChildToParent(self._modelCam)
		LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	else
		goutil.addChildToParent(self._modelCam, self.mainGO)
		LightMgr.instance:setLightForNormalScene()
	end

	LightMgr.instance:setUseModelLight(isOnEnter)
	GlobalModel.instance:visibleSceneHUDs(not isOnEnter)
end

function TabPTEliFinialBaseSpaceView:_onClickBtnExchange()
	local jumpToStr = PeakTournamentConfig.instance:getPtCommonValue("PT_JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function TabPTEliFinialBaseSpaceView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.PTEliRankPrizeView, self._activityId)
end

function TabPTEliFinialBaseSpaceView:_onCLickBtnVote(hover)
	GlobalDispatcher:dispatch(GlobalNotify.PeakJumpToTabVote)
end

function TabPTEliFinialBaseSpaceView:_onCLickBtnBanPet()
	UIStateManager.instance:push(ViewName.PTEliBanPetTipsView, self._activityId)
end

function TabPTEliFinialBaseSpaceView:_onClickBtnWatch()
	local tipsStr = ""

	if self._newestEliRoundId < self._curEliRoundId then
		tipsStr = "未到该比赛进程"
	end

	if self._curPeriodId < EliminatorMgr.PeriodId.Performance then
		tipsStr = "战斗还未开始"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return
	end

	local resultInfoMo = PeakTournamentModel.instance:getResultInfoMo(self._curEliRoundId, self._curGroupIdx, self._curStageIdx)

	if self._curPeriodId == EliminatorMgr.PeriodId.Performance then
		local battleIdList = resultInfoMo:getBattleIdList()

		if #battleIdList > 0 then
			UIJumper.instance:saveCurStack()

			local fightType = PeakTournamentController.FightType.EliFight

			PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGetBattleVideoReq(battleIdList, nil, fightType)
			SurveyController.instance:reportBehavior(201370, self._activityId, self._curEliRoundId)
		else
			FloatWordMgr.instance:show("没有可观看的战斗")
		end
	else
		UIStateManager.instance:push(ViewName.PTBattlefieldReportAsEliFightView, {
			resultInfoMo
		}, self._activityId, self._curEliRoundId)
	end
end

return TabPTEliFinialBaseSpaceView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameMainView.lua

module("logic.extensions.pingame.view.PinGameMainView", package.seeall)

local PinGameMainView = class("PinGameMainView", ViewComponent)

function PinGameMainView:buildUI()
	PinGameMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")

	local rewardRoot = self:getGo("rewardRoot")

	self._playerSliderMo = PlayerSliderMo.New(rewardRoot)
	self._txtPlayerScore = self:getTxt("total/txtTotal")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._petInfo = self:getGo("pet/petInfo")
	self._btnInfo = self:getBtn("pet/petInfo/btnInfo")
	self._btnSkill = self:getBtn("pet/petInfo/btnSkill")
	self._rare = self:getGo("pet/petInfo/pointRare")
	self._txtName = self:getTxt("pet/petInfo/txtName")
	self._txtEggProgress = self:getTxt("eggProgress/txtProgress")
	self._btnScore = self:getBtn("btnScore")
	self._btnGame = self:getBtn("btnGame")
	self._eggShow = self:getGo("eggShow")
	self._eggShowSpriteChange = self._eggShow:GetComponent(ComponentType.UIImageSpriteChange)
	self._eggProgress = self:getGo("eggProgress")
	self._redScore = self:getGo("btnScore/redPoint")
	self._redGame = self:getGo("btnGame/redPoint")
	self._itemGo = self:getGo("btnScore/bubble/item")
	self._bubble = self:getGo("bubble")
	self._bubbleReward = self:getGo("bubble/reward")
	self._tipsRoot = self:getGo("tipsRoot")
end

function PinGameMainView:bindEvents()
	PinGameMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnScore:AddClickListener(self._onClickScore, self)
	self._btnGame:AddClickListener(self._onClickGame, self)
end

function PinGameMainView:unbindEvents()
	PinGameMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnScore:RemoveClickListener()
	self._btnGame:RemoveClickListener()
end

function PinGameMainView:onEnter()
	PinGameMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PinGameInfoRes, self._onGetPinGameInfoRes, self)
	self.addGEvent(self, GlobalNotify.GeneralWorldProgressGetInfo, self._onGetWorldProgressInfoRes, self)
	self.addGEvent(self, GlobalNotify.GeneralWorldProgressGainPrize, self._onGainWorldProgressPrizeRes, self)

	self._activityId = PinGameModel.instance:getActivityId()
	self._activityType = PinGameModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = PinGameConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.raceId

	PinGameAgent.instance:sendPM_PinGameInfoReq(self._activityId)
	self:_initActivityTime()
	self:_initPetInfo()
	self:_updateEggProgress()
	self:_setPlayerScore()
	self:_showRoleModel()
	self:_updateRedPoint()
	self:_setItemShow()
	RedPointController.instance:regRedPoint(self._redGame, RedPointModel.ID_O23)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function PinGameMainView:onExit()
	PinGameMainView.super.onExit(self)
	self._playerSliderMo:onExit()
	self:_clearPetInfo()
	self:_resetRoleModel()
	RedPointController.instance:unregRedPoint(self._redGame)
	MaterialMgr.resetAll(self._bubbleReward)
end

function PinGameMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "pingamemainview_rule")
end

function PinGameMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function PinGameMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function PinGameMainView:_onClickScore()
	UIStateManager.instance:push(ViewName.PinGameRewardView, self._activityId)
end

function PinGameMainView:_onClickGame()
	UIStateManager.instance:push(ViewName.PinGameLevelView, self._activityId)
end

function PinGameMainView:_initPlayerParams()
	if not self._progressPrizeCfgs then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._progressPrizeCfgs

	function playerParam.getPlayerProgress()
		return GeneralWorldProgressModel.instance:getCurProgress()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needScore
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return rewardCfg.needScore <= GeneralWorldProgressModel.instance:getCurProgress() and not GeneralWorldProgressModel.instance:getIsGainPrize(rewardCfg.prizeId)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return GeneralWorldProgressModel.instance:getIsGainPrize(rewardCfg.prizeId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		GeneralWorldProgressController.instance:gainPrize(self._worldProgressActId, rewardCfg.prizeId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function PinGameMainView:_onGetPinGameInfoRes()
	self:_updateRedPoint()
end

function PinGameMainView:_onGetWorldProgressInfoRes()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
	self:_setPlayerScore()
end

function PinGameMainView:_onGainWorldProgressPrizeRes()
	self._playerSliderMo:updatePlayerReward()
	self:_setPlayerScore()
end

function PinGameMainView:_setPlayerScore()
	self._txtPlayerScore.text = GeneralWorldProgressModel.instance:getCurProgress()
end

function PinGameMainView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function PinGameMainView:_updateEggProgress()
	local timeStr = PinGameConfig.instance:getCommonValue("DRAGON_EGG_TIME")
	local arr = string.split(timeStr, "#")
	local startTimestamp = GameUtil.string2time(arr[1])
	local endTimestamp = GameUtil.string2time(arr[2])
	local maxTime = Mathf.Max(0, endTimestamp - startTimestamp)
	local curTime = Mathf.Max(0, ServerTime.now() - startTimestamp)
	local progress = Mathf.Clamp(Mathf.Floor(curTime / maxTime * 100), 0, 100)

	self._txtEggProgress.text = progress
	progress = 100

	if 100 >= 100 then
		goutil.setActive(self._eggShow, false)
		goutil.setActive(self._eggProgress, false)
		goutil.setActive(self._con, true)
		goutil.setActive(self._petInfo, true)
	else
		goutil.setActive(self._eggShow, true)
		goutil.setActive(self._eggProgress, true)
		goutil.setActive(self._con, false)
		goutil.setActive(self._petInfo, false)
		self._eggShowSpriteChange:SetState(progress < 30 and 0 or progress < 60 and 1 or 2)
	end
end

function PinGameMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function PinGameMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function PinGameMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function PinGameMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PinGameMainView:_updateRedPoint()
	local isShowRed = PinGameModel.instance:isAnyCanGetPrize(self._activityId)

	goutil.setActive(self._redScore, isShowRed)
end

function PinGameMainView:_setItemShow()
	if string.nilorempty(self._cfgActivity.passPrize) then
		MaterialMgr.resetAll(self._bubbleReward)
		GameUtil.SetActive(self._bubble, false)
	else
		MaterialMgr.setCellByCfg(self._cfgActivity.passPrize, self._bubbleReward)
		GameUtil.SetActive(self._bubble, true)
	end
end

return PinGameMainView

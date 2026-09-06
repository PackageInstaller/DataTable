-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonchallengemainView.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonchallengemainView", package.seeall)

local DualdragonchallengemainView = class("DualdragonchallengemainView", ViewComponent)

function DualdragonchallengemainView:ctor()
	DualdragonchallengemainView.super.ctor(self)
end

function DualdragonchallengemainView:unbindEvents()
	DualdragonchallengemainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnPush:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnLotter:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnExtremeChallenge:RemoveClickListener()
	self._btnUniversalChallenge:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function DualdragonchallengemainView:bindEvents()
	DualdragonchallengemainView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnPush:AddClickListener(self._onClickbtnPush, self)
	self._btnShop:AddClickListener(self._onClickbtnShop, self)
	self._btnLotter:AddClickListener(self._onClickbtnLotter, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnExtremeChallenge:AddClickListener(self._onClickbtnExtremeChallenge, self)
	self._btnUniversalChallenge:AddClickListener(self._onClickbtnUniversalChallenge, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
end

function DualdragonchallengemainView:buildUI()
	DualdragonchallengemainView.super.buildUI(self)

	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._leftbtns = self:getGo("leftbtns")
	self._btnPush = self:getBtn("leftbtns/btnPush")
	self._btnShop = self:getBtn("leftbtns/btnShop")
	self._btnLotter = self:getBtn("leftbtns/btnLotter")
	self._btnRank = self:getBtn("leftbtns/btnRank")
	self._btnExtremeChallenge = self:getBtn("btnExtremeChallenge")
	self._btnUniversalChallenge = self:getBtn("btnUniversalChallenge")
	self._goldBarGo = self:getGo("goldBar")
	self._roleconGo = self:getGo("rolecon")
	self._sloganGo = self:getGo("slogan")
	self._openTime = self:getGo("openTime")
	self._txtTime = self:getTxt("openTime/txtTime")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rareGo = self:getGo("petInfo/rare")
	self._descGoBtnExt = self:getGo("btnExtremeChallenge/desc")
	self._txtLimitChallenge = self:getTxt("btnExtremeChallenge/desc/txtLimitChallenge")
	self._txtChallenge = self:getTxt("btnUniversalChallenge/desc/txtChallenge")
	self._redpointExtremeGo = self:getGo("btnExtremeChallenge/redpoint")
	self._redpointUniversalGo = self:getGo("btnUniversalChallenge/redpoint")

	self:_recordGoDefaultActive(self._leftbtns)
	self:_recordGoDefaultActive(self._btnUniversalChallenge)
	self:_recordGoDefaultActive(self._openTime)
	self:_recordGoDefaultActive(self._descGoBtnExt)
end

function DualdragonchallengemainView:onExit()
	DualdragonchallengemainView.super.onExit(self)
	MaterialMgr.resetAll(self._rareGo)
	GlobalDispatcher:removeListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	RedPointController.instance:unregRedPoint(self._redpointExtremeGo)
	RedPointController.instance:unregRedPoint(self._redpointUniversalGo)

	if self._roleObj and self._roleObj.asset then
		local zhezao = goutil.findChild(self._roleObj.asset, "fx_ui_16016_shuangshengshenglong01 (1)/zong/zhezao")

		goutil.setActive(zhezao, true)
	end

	RoleObjectPool.instance:removeRole(self._roleObj)
end

function DualdragonchallengemainView:onEnter()
	DualdragonchallengemainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DualdragonchallengeController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	RedPointController.instance:regRedPoint(self._redpointUniversalGo, RedPointModel.ID_DUALDRAGON_UNIVERSAL)
	RedPointController.instance:regRedPoint(self._redpointExtremeGo, RedPointModel.ID_DUALDRAGON_EXTREME_REWARD)
	GlobalDispatcher:addListener(DualDragonChallengeAgent.DualDragonChallengeGetInfoRes, self._updateUI, self)
	DualDragonChallengeAgent.instance:sendPM_DualDragonChallengeGetInfoReq(self._activityId)
	self:_updateUI()
	self:_setDesc()

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._leftbtns, false)
		GameUtil.SetActive(self._btnUniversalChallenge, false)
		GameUtil.SetActive(self._openTime, false)
		GameUtil.SetActive(self._descGoBtnExt, false)
	else
		self:_refreshDefaultActive(self._leftbtns)
		self:_refreshDefaultActive(self._btnUniversalChallenge)
		self:_refreshDefaultActive(self._openTime)
		self:_refreshDefaultActive(self._descGoBtnExt)
	end
end

function DualdragonchallengemainView:_onClickbtnTip()
	local actData = DualdragonchallengeConfig.instance:getActData(self._activityId)

	TipsFacade.instance:openRulesView(actData.ruleKeyMain)
end

function DualdragonchallengemainView:_onClickbtnClose()
	self:close()
end

function DualdragonchallengemainView:_onClickbtnPush()
	local jumpTo = DualdragonchallengeConfig.instance:getBtnActShopJumpTo(self._activityId)

	GotoMgr.gotoByString(jumpTo)
end

function DualdragonchallengemainView:_onClickbtnShop()
	local jumpTo = DualdragonchallengeConfig.instance:getBtnShopJumpTo(self._activityId)

	GotoMgr.gotoByString(jumpTo)
end

function DualdragonchallengemainView:_onClickbtnLotter()
	local jumpTo = DualdragonchallengeConfig.instance:getBtnLotterJumpTo(self._activityId)

	GotoMgr.gotoByString(jumpTo)
end

function DualdragonchallengemainView:_onClickbtnRank()
	local jumpTo = DualdragonchallengeConfig.instance:getBtnRankJumpTo(self._activityId)

	GotoMgr.gotoByString(jumpTo)
end

function DualdragonchallengemainView:_onClickbtnExtremeChallenge()
	UIStateManager.instance:push(ViewName.DualdragonextremechallengeView, self._activityId)
end

function DualdragonchallengemainView:_onClickbtnUniversalChallenge()
	UIStateManager.instance:push(ViewName.DualdragonallchallengeView, self._activityId)
end

function DualdragonchallengemainView:_onClickbtnInfo()
	if self._skinId then
		PetbookController.instance:openPetinfoView(self._skinId)
	end
end

function DualdragonchallengemainView:_onClickbtnSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._skinId)
	end
end

function DualdragonchallengemainView:_updateUI()
	local goldBarStr = DualdragonchallengeConfig.instance:getGoldBarStr()

	self:_setTopGoldBar(self._goldBarGo, goldBarStr)
	self:_setRole()
	self:_setActTime()
end

function DualdragonchallengemainView:_setRole()
	self._skinId = DualdragonchallengeConfig.instance:getShowRaceId(self._activityId)
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._skinId, self._roleconGo, 1, function(go)
		GoUtil.SetSortingOrder(go, 201)

		local zhezao = goutil.findChild(go, "fx_ui_16016_shuangshengshenglong01 (1)/zong/zhezao")

		goutil.setActive(zhezao, false)
	end, true, 0, 0)

	self:_setPetInfo(self._skinId)
end

function DualdragonchallengemainView:_setPetInfo(skinId)
	MaterialMgr.setCell(MatType.Rare, skinId, self._rareGo)
end

function DualdragonchallengemainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DualDragon, self._activityId)
end

function DualdragonchallengemainView:_setDesc()
	self._txtChallenge.text = DualdragonchallengeConfig.instance:getClientValue("universalChallengeDesc")
	self._txtLimitChallenge.text = DualdragonchallengeConfig.instance:getClientValue("extremeChallengeDesc")
end

function DualdragonchallengemainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DualdragonchallengemainView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return DualdragonchallengemainView

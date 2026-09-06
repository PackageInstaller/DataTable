-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/view/SaintKnightTianMainView.lua

module("logic.extensions.saintknighttian.view.SaintKnightTianMainView", package.seeall)

local SaintKnightTianMainView = class("SaintKnightTianMainView", ViewComponent)

function SaintKnightTianMainView:buildUI()
	SaintKnightTianMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._roleCon = self:getGo("role")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = goutil.findChild(self._petInfo, "btnSkill")
	self._btnInfo = goutil.findChild(self._petInfo, "btnInfo")
	self._rareCon = goutil.findChild(self._petInfo, "rare")
	self._txtPetName = goutil.findChildTextComponent(self._petInfo, "txtName")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnChallenge = self:getGo("btnChallenge")
	self._rpChallenge = goutil.findChild(self._btnChallenge, "redpoint")
	self._txtChallenge = goutil.findChildTextComponent(self._btnChallenge, "txt")
	self._btnGame = self:getGo("btnGame")
	self._rpGame = goutil.findChild(self._btnGame, "redpoint")
	self._txtGame = goutil.findChildTextComponent(self._btnGame, "txt")
	self._btnCall = self:getGo("btnCall")
	self._btnRank = self:getGo("btnRank")
	self._bubble = self:getGo("bubble")
	self._itemRank = goutil.findChild(self._bubble, "item")
	self._txtRank = goutil.findChildTextComponent(self._bubble, "txtTip")
	self._goldBar = self:getGo("goldBarCon")
	self._txtBubbleDesc = self:getTxt("roleBubble/txtDesc")
end

function SaintKnightTianMainView:bindEvents()
	SaintKnightTianMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickGame, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function SaintKnightTianMainView:unbindEvents()
	SaintKnightTianMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnGame)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
end

function SaintKnightTianMainView:onEnter()
	SaintKnightTianMainView.super.onEnter(self)
	self:getConfigs()
	self:refreshViewByCfgs()
	self:getInfo()
	GlobalDispatcher:addListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20220729/shengqixiaotian/fx_ui_shengqixiaotian_jm.prefab", nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function SaintKnightTianMainView:onExit()
	SaintKnightTianMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._rareCon)
	removetimer(self._onTick, self)
	GlobalDispatcher:removeListener(GlobalNotify.SKTianUpdateInfo, self.refreshViewByInfo, self)

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end
end

function SaintKnightTianMainView:getConfigs()
	self._challengeId = SaintKnightTianModel.instance:getCurChallengeId()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._skinId = checkint(self._challengeCfg and self._challengeCfg.raceId)
	self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)
	self._actCfg = SaintKnightTianConfig.instance:getActCfg(self._challengeId)
end

function SaintKnightTianMainView:refreshViewByCfgs()
	self:setPetInfo()
	self:setActTime()
	self:setOther()
end

function SaintKnightTianMainView:getInfo()
	if self._challengeId and TLChallengeController.instance:isInOpenTime(self._challengeId) then
		SaintKnightTianController.instance:getInfo(self._challengeId)
	end
end

function SaintKnightTianMainView:refreshViewByInfo()
	goutil.setActive(self._rpChallenge, SaintKnightTianModel.instance:getIsActiveRpChallenge())
	goutil.setActive(self._rpGame, SaintKnightTianModel.instance:getIsActiveRdGame())
	goutil.setActive(self._bubble, false)
end

function SaintKnightTianMainView:setPetInfo()
	if self._skinCfg then
		MaterialMgr.setCell(MatType.Rare, self._skinId, self._rareCon)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._skinId, self._roleCon, 1)
		self._txtPetName.text = self._skinCfg.name
	end
end

function SaintKnightTianMainView:setActTime()
	self:_onTick()

	if self._challengeId and TLChallengeController.instance:isInOpenTime(self._challengeId) then
		settimer(1, self._onTick, self, true)
	end
end

function SaintKnightTianMainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		self._txtTime.text = ""

		local text = lang("活动已经结束")

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		self._txtTime.text = string.format("距离活动结束：%s", leftTimeFormat)
	end
end

function SaintKnightTianMainView:setOther()
	if self._actCfg then
		local btn_list = {
			{
				showAdd = true,
				id = SaintKnightTianConfig.instance:getDefineValue("CHALLENGE_CURRENCY")
			}
		}

		MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)

		local playerDataKey = ViewName.SaintKnightTianMainView .. self._challengeId

		if checknumber(GameUtil.getUserData(playerDataKey)) <= 0 then
			GameUtil.saveUserData(playerDataKey, 1)

			local animConfig = {
				animName = "tianshan_dengchang",
				passable = false,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
		end

		self._txtBubbleDesc.text = langPara("saintknighttianmainviewTips")
		self._txtChallenge.text = langPara("saintknighttianmainviewTips1")
		self._txtGame.text = langPara("saintknighttianmainviewTips2")
	end
end

function SaintKnightTianMainView:_onClickTip()
	if self._challengeCfg then
		UIStateManager.instance:push(ViewName.RulesView, self._challengeCfg.ruleKey)
	end
end

function SaintKnightTianMainView:_onClickInfo()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

function SaintKnightTianMainView:_onClickSkill()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:previewBattle(raceId, self._skinId)
	end
end

function SaintKnightTianMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.SaintKnightTianChallengeView)
	SurveyController.instance:reportBehavior(201080)
end

function SaintKnightTianMainView:_onClickGame()
	UIStateManager.instance:push(ViewName.SaintKnightTianGuideView)
	SurveyController.instance:reportBehavior(201079)
end

function SaintKnightTianMainView:_onClickCall()
	GotoMgr.gotoByString(SaintKnightTianConfig.instance:getDefineValue("POOL_FUNC"))
end

function SaintKnightTianMainView:_onClickRank()
	GotoMgr.gotoByString(SaintKnightTianConfig.instance:getDefineValue("RANK_FUNC"))
end

return SaintKnightTianMainView

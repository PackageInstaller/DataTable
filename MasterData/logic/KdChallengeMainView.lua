-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeMainView.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeMainView", package.seeall)

local KdChallengeMainView = class("KdChallengeMainView", ViewComponent)

function KdChallengeMainView:buildUI()
	KdChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._btnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate")
	self._redBtnCultivate = goutil.findChild(self.mainGO, "jumpButton/btnCultivate/redPoint")
	self._btnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank/redPoint")
	self._btnChange = goutil.findChild(self.mainGO, "jumpButton/btnChange")
	self._redBtnChange = goutil.findChild(self.mainGO, "jumpButton/btnChange/redPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery")
	self._redBtnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery/redPoint")
	self._challengeButtomView = goutil.findChild(self.mainGO, "challengeButtom")
	self._btnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn")
	self._redBtnChallenge1 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge1/btn/redPoint")
	self._btnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn")
	self._redBtnChallenge2 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge2/btn/redPoint")
	self._btnChallenge3 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge3/btn")
	self._redBtnChallenge3 = goutil.findChild(self.mainGO, "challengeButtom/btnChallenge3/btn/redPoint")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
	self._bgEff = nil
end

function KdChallengeMainView:bindEvents()
	KdChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnCultivate, self._onClickBtnCultivate, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnChallenge1, self._onClickBtnChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge2, self._onClickBtnChallenge2, self)
	GameUtil.addClickHandler(self._btnChallenge3, self._onClickBtnChallenge3, self)
end

function KdChallengeMainView:unbindEvents()
	KdChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnCultivate)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnChallenge1)
	GameUtil.rmClickHandler(self._btnChallenge2)
	GameUtil.rmClickHandler(self._btnChallenge3)
end

function KdChallengeMainView:onEnter()
	KdChallengeMainView.super.onEnter(self)

	self._challengeId = KdChallengeConfig.instance:getKdCurChallengeId()

	self:_onSetUI()
	GameUtil.doCallbackWhenFirst("Kd_Rule_" .. self._challengeId, function()
		self:_onClickBtnTip()
	end, nil)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)
end

function KdChallengeMainView:onExit()
	KdChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._btnEffList then
		for idx = 0, self._challengeButtomView.transform.childCount - 1 do
			local mainGo = self._challengeButtomView.transform:GetChild(idx)
			local effRoot = goutil.findChild(mainGo, "effRoot")

			UIEffectManager.instance:stopEffect(self._btnEffList[effRoot])
		end

		self._btnEffList = nil
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redBtnRank)
	RedPointController.instance:unregRedPoint(self._redBtnChallenge1)
	RedPointController.instance:unregRedPoint(self._redBtnChallenge2)
	RedPointController.instance:unregRedPoint(self._redBtnChallenge3)
	MaterialMgr.resetAll(self._pointRare)
end

function KdChallengeMainView:_onSetUI()
	local redIdAsRank = KdChallengeConfig.instance:getKdCommonValue("PET_TOP_RANK_RED")

	RedPointController.instance:regRedPoint(self._redBtnRank, redIdAsRank)

	local timeLimitedData = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	local redIdList_1 = {}

	table.insert(redIdList_1, RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_BOSS)

	if checknumber(timeLimitedData.redPointId) ~= 0 then
		table.insert(redIdList_1, timeLimitedData.redPointId)
	end

	RedPointController.instance:regRedPoint(self._redBtnChallenge1, unpack(redIdList_1))
	RedPointController.instance:regRedPoint(self._redBtnChallenge2, RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_STAGE)
	RedPointController.instance:regRedPoint(self._redBtnChallenge3, RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_UNIT)

	if self._txtOpenTime then
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)
	end

	local effParent = self.mainGO
	local pathName = "20220902/wzsltiaozhan/fx_ui_wzsl_jiemian"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	self._btnEffList = self._btnEffList or {}

	for idx = 0, self._challengeButtomView.transform.childCount - 1 do
		local mainGo = self._challengeButtomView.transform:GetChild(idx)
		local effParent = goutil.findChild(mainGo, "effRoot")
		local pathName = "20220902/wzsltiaozhan/fx_ui_wzsl_anniu"

		UIEffectManager.instance:stopEffect(self._btnEffList[effParent])

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			local handlerTarget

			self._btnEffList[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
		end
	end

	local skinId = KdChallengeConfig.instance:getKdCurSkinId()

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local raceId = KdChallengeConfig.instance:getKdCurRaceId()

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end
end

function KdChallengeMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KdChallengeMainView:_onUpdateData()
	return
end

function KdChallengeMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
end

function KdChallengeMainView:_onUpdatePlaneUI()
	return
end

function KdChallengeMainView:_onClickBtnSkill()
	local raceId = KdChallengeConfig.instance:getKdCurRaceId()
	local skinId = KdChallengeConfig.instance:getKdCurSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KdChallengeMainView:_onClickBtnIntroduce()
	local raceId = KdChallengeConfig.instance:getKdCurRaceId()

	PetbookController.instance:openPetinfoView(raceId)
end

function KdChallengeMainView:_onClickBtnCultivate()
	local jumpToStr = KdChallengeConfig.instance:getKdCommonValue("JUMP_SHOP_MIBAO_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function KdChallengeMainView:_onClickBtnRank()
	local jumpToStr = KdChallengeConfig.instance:getKdCommonValue("JUMP_PET_TOP_RANK")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function KdChallengeMainView:_onClickBtnChange()
	local jumpToStr = KdChallengeConfig.instance:getKdCommonValue("JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function KdChallengeMainView:_onClickBtnLottery()
	local jumpToStr = KdChallengeConfig.instance:getKdCommonValue("JUMP_LOTTERY_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function KdChallengeMainView:_onClickBtnChallenge1()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Boss) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime1))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.KdChallengeBossView)
end

function KdChallengeMainView:_onClickBtnChallenge2()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Stage) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime2))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.KdChallengeStageView)
end

function KdChallengeMainView:_onClickBtnChallenge3()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Unit) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime3))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.KdChallengeUnitView)
end

function KdChallengeMainView:_onClickBtnTip()
	local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)

	TipsFacade.instance:openRulesView(data.ruleKey)
end

return KdChallengeMainView

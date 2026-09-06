-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeMainView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeMainView", package.seeall)

local DominateChallengeMainView = class("DominateChallengeMainView", KdChallengeMainView)

function DominateChallengeMainView:ctor()
	DominateChallengeMainView.super.ctor(self)
end

function DominateChallengeMainView:unbindEvents()
	DominateChallengeMainView.super.unbindEvents(self)
	self._btnLogin:RemoveClickListener()
end

function DominateChallengeMainView:bindEvents()
	DominateChallengeMainView.super.bindEvents(self)
	self._btnLogin:AddClickListener(self._onClickBtnLoginSign, self)
end

function DominateChallengeMainView:onExit()
	DominateChallengeMainView.super.onExit(self)
end

function DominateChallengeMainView:buildUI()
	DominateChallengeMainView.super.buildUI(self)

	self._btnLogin = self:getBtn("jumpButton/btnLogin")
	self._loginRedPoint = self:getGo("jumpButton/btnLogin/redPoint")
end

function DominateChallengeMainView:onEnter()
	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_onSetUI()
	GameUtil.doCallbackWhenFirst("Kd_Rule_" .. self._challengeId, function()
		self:_onClickBtnTip()
	end, nil)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)

	self._actCfg = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)

	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)
	RedPointController.instance:regRedPoint(self._loginRedPoint, checknumber(self._actCfg.loginTaskRedpointId))
end

function DominateChallengeMainView:_onClickBtnChallenge1()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Boss) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime1))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.DominateChallengeBossView)
end

function DominateChallengeMainView:_onClickBtnChallenge2()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Stage) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime2))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.DominateChallengeStageView)
end

function DominateChallengeMainView:_onClickBtnChallenge3()
	if not KdChallengeController.instance:isInOpenTimeByKdType(GameEnum.KingDragonType.Unit) then
		local data = KdChallengeConfig.instance:getKdChallengeData(self._challengeId)
		local fTimeStr = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openTime3))

		FloatWordMgr.instance:show("试炼将于 " .. fTimeStr .. "开启")

		return
	end

	UIStateManager.instance:push(ViewName.DominateChallengeUnitView)
end

function DominateChallengeMainView:_onClickBtnLoginSign()
	UIStateManager.instance:push(ViewName.DominaSigninteTaskView)
end

function DominateChallengeMainView:_onSetUI()
	local redIdAsRank = KdChallengeConfig.instance:getNuoyaCommonValue("PET_TOP_RANK_RED")

	RedPointController.instance:regRedPoint(self._redBtnRank, redIdAsRank)

	local timeLimitedData = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	local redIdList_1 = {}

	table.insert(redIdList_1, RedPointModel.ID_NUOYA_LANDINGONCE_RED_BOSS)

	if checknumber(timeLimitedData.redPointId) ~= 0 then
		table.insert(redIdList_1, timeLimitedData.redPointId)
	end

	RedPointController.instance:regRedPoint(self._redBtnChallenge1, unpack(redIdList_1))
	RedPointController.instance:regRedPoint(self._redBtnChallenge2, RedPointModel.ID_NUOYA_LANDINGONCE_RED_STAGE)
	RedPointController.instance:regRedPoint(self._redBtnChallenge3, RedPointModel.ID_NUOYA_LANDINGONCE_RED_UNIT)

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

	local skinId = KdChallengeConfig.instance:getNuoyaCurSkinId()

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, function()
		GameUtil.setLocalRotation(self._role.asset, 0, 0, 0)
	end, true, nil, nil)

	local raceId = KdChallengeConfig.instance:getNuoyaCurRaceId()

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end
end

function DominateChallengeMainView:_onClickBtnSkill()
	local raceId = KdChallengeConfig.instance:getNuoyaCurRaceId()
	local skinId = KdChallengeConfig.instance:getNuoyaCurSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DominateChallengeMainView:_onClickBtnIntroduce()
	local raceId = KdChallengeConfig.instance:getNuoyaCurRaceId()

	PetbookController.instance:openPetinfoView(raceId)
end

function DominateChallengeMainView:_onClickBtnCultivate()
	local jumpToStr = KdChallengeConfig.instance:getNuoyaCommonValue("JUMP_SHOP_MIBAO_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DominateChallengeMainView:_onClickBtnRank()
	local jumpToStr = KdChallengeConfig.instance:getNuoyaCommonValue("JUMP_PET_TOP_RANK")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DominateChallengeMainView:_onClickBtnChange()
	local jumpToStr = KdChallengeConfig.instance:getNuoyaCommonValue("JUMP_SHOP_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DominateChallengeMainView:_onClickBtnLottery()
	local jumpToStr = KdChallengeConfig.instance:getNuoyaCommonValue("JUMP_LOTTERY_KEY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

return DominateChallengeMainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/louna/LounachallengeView.lua

module("logic.extensions.timelimitedchallenge.view.louna.LounachallengeView", package.seeall)

local LounachallengeView = class("LounachallengeView", ViewComponent)

function LounachallengeView:ctor()
	LounachallengeView.super.ctor(self)
end

function LounachallengeView:unbindEvents()
	LounachallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnInfo)
	GameUtil.rmClickHandler(self.btnSkill)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnshop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
end

function LounachallengeView:bindEvents()
	LounachallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnInfo, self.onClickInfo, self)
	GameUtil.addClickHandler(self.btnSkill, self.onClickSkill, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnshop, self.onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self.onClickRank, self)
	GameUtil.addClickHandler(self._btnStart, self.onClickStart, self)
	GameUtil.addClickHandler(self._btnTip, self.onTipClick, self)
end

function LounachallengeView:buildUI()
	LounachallengeView.super.buildUI(self)

	self._btnRank = self:getGo("btnRank")
	self._btnClose = self:getGo("btnClose")
	self._btnshop = self:getGo("btnshop")
	self._btnStart = self:getGo("btnStart")
	self._btnTip = self:getGo("btnTip")
	self._con = self:getGo("con")
	self.rare = self:getGo("petInfo/rare")
	self.btnInfo = self:getGo("petInfo/btnInfo")
	self.btnSkill = self:getGo("petInfo/btnSkill")
	self._times = self:getTxt("time/txtTime")
	self._txtTotal = self:getTxt("txtTotal")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
end

function LounachallengeView:onExit()
	LounachallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ON_LOUNA_INFO_UPDATE, self.onRefreshUI, self)
end

function LounachallengeView:onEnter()
	LounachallengeView.super.onEnter(self)

	self.activityId = LounaController.instance:getActivityId()
	self.raceId = 10016

	GlobalDispatcher:addListener(GlobalNotify.ON_LOUNA_INFO_UPDATE, self.onRefreshUI, self)
	LounaController.instance:sendGetInfo(self.activityId)
	self:_initPlayerParams()
	self:setPetInfo()

	local activityType = math.floor(checknumber(self.activityId) / 1000)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self.activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._times.text = langPara("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function LounachallengeView:onRefreshUI()
	self._txtTotal.text = LounaModel.instance:getCurSoure(self.activityId)

	self:_initPlayerParams()
end

function LounachallengeView:onClickStart()
	UIStateManager.instance:push(ViewName.LounalevelsView, self.activityId)
end

function LounachallengeView:onTipClick()
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}

	UIStateManager.instance:push(ViewName.RulesView, cfg.ruleId)
end

function LounachallengeView:onClickRank()
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}

	GotoMgr.gotoByString(cfg.jumpTo1)
end

function LounachallengeView:onClickShop()
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}

	GotoMgr.gotoByString(cfg.jumpTo2)
end

function LounachallengeView:onClickInfo()
	PetbookController.instance:openPetinfoView(self.raceId)
end

function LounachallengeView:onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.raceId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.raceId)
	end
end

function LounachallengeView:setPetInfo()
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}

	self.raceId = cfg.raceId

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self.raceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self.role = RoleObjectPool.instance:addRoleToParent(self.role, self.raceId, self._con, scale, nil, true, modelCfg[1], y)

				MaterialMgr.setCell(MatType.Rare, self.raceId, self.rare)
			end
		end
	end
end

function LounachallengeView:_initPlayerParams()
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}
	local _planId = cfg.prizePlanId
	local param = {}

	param.view = self
	param.prizeCfgs = LounaConfig.instance:getProgressPrizeCfg(_planId)

	function param.getPlayerProgress()
		return (LounaModel.instance:getCurSoure(self.activityId))
	end

	function param.getPrizeByRewardCfg(cfg)
		local prizes = string.split(cfg.prize, "#")

		return prizes[1]
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.score
	end

	function param.isPlayerRewardCanGet(cfg)
		return LounaModel.instance:isPlayerRewardCanGet(self.activityId, cfg.prizeId, cfg.score)
	end

	function param.isPlayerRewardGeted(cfg)
		return LounaModel.instance:isPlayerRewardGeted(self.activityId, cfg.prizeId)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		LounaController.instance:sendGetPrize(self.activityId, cfg.prizeId)
	end

	function param.parseGetProgress(cfg)
		return cfg.score
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

return LounachallengeView

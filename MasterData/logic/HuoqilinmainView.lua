-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huoqilin/view/HuoqilinmainView.lua

module("logic.extensions.huoqilin.view.HuoqilinmainView", package.seeall)

local HuoqilinmainView = class("HuoqilinmainView", ViewComponent)

function HuoqilinmainView:ctor()
	HuoqilinmainView.super.ctor(self)

	self._HUOQILIN_CHALLENGEID = "HUOQILIN_CHALLENGEID"
	self._HUOQILIN_TITLE = "HUOQILIN_TITLE"
	self._HUOQILIN_ACTIVITY_TIME = "HUOQILIN_ACTIVITY_TIME"
	self._HUOQILIN_SKIN_ID = "HUOQILIN_SKIN_ID"
	self._HUOQILIN_ITEMS = "HUOQILIN_ITEMS"
	self._HUOQILIN_LOTTERY_JUMP = "HUOQILIN_LOTTERY_JUMP"
	self._HUOQILIN_RANK_JUMP = "HUOQILIN_RANK_JUMP"
	self._HUOQILIN_YANGCHENG_JUMP = "HUOQILIN_YANGCHENG_JUMP"
	self._HUOQILIN_REBATE_JUMP = "HUOQILIN_REBATE_JUMP"
end

function HuoqilinmainView:unbindEvents()
	HuoqilinmainView.super.unbindEvents(self)
	self._rankBtn:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._callXiaoYan:RemoveClickListener()
	self._purgatoryBtn:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnFullRebate)
	GameUtil.rmClickHandler(self._btnTip)
end

function HuoqilinmainView:bindEvents()
	HuoqilinmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._rankBtn:AddClickListener(self._onClickRank, self)
	self._callXiaoYan:AddClickListener(self._onClickLottery, self)
	self._purgatoryBtn:AddClickListener(self._onClickPurgatory, self)
	self._btnInfo:AddClickListener(self._onClickPetInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnTry:AddClickListener(self._onClickTry, self)
	GameUtil.addClickHandler(self._btnFullRebate, self._onClickBtnFullRebate, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function HuoqilinmainView:onExit()
	HuoqilinmainView.super.onExit(self)
	self._playerSliderMo:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._onRefreshUI, self)
	MaterialMgr.resetAll(self._rare)

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)
	end
end

function HuoqilinmainView:buildUI()
	HuoqilinmainView.super.buildUI(self)

	self._rankBtn = self:getBtn("rankBtn")
	self._closeBtn = self:getBtn("btnClose")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._callXiaoYan = self:getBtn("callXiaoYan")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._purgatoryBtn = self:getBtn("purgatoryBtn")
	self._btnTry = self:getBtn("btnTry")
	self._txtCoin = self:getTxt("purgatoryBtn/txtCoin")
	self._txtTime = self:getTxt("time/txtTime")
	self._petName = self:getTxt("petInfo/txtName")
	self._rare = self:getGo("petInfo/rare")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rankBtnRed = self:getGo("rankBtn/redpointGo")
	self._redpointGo = self:getGo("purgatoryBtn/redpointGo")
	self._callXiaoYanRed = self:getGo("callXiaoYan/redpointGo")
	self._txtTotal = self:getTxt("txtTotal")
	self._times = self:getTxt("times")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._btnFullRebate = self:getGo("btnFullRebate")
	self._con = self:getGo("petCon")
	self._btnTip = self:getGo("btnTip")
end

function HuoqilinmainView:onEnter()
	HuoqilinmainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeInfoUpdate, self._onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PerfectRuleModeProgressUpdate, self._onRefreshUI, self)

	local challengeId = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_CHALLENGEID)

	self._challengeId = checknumber(challengeId)
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)
	self._planId = self._commonCfg.progressPrizePlanId

	self:_initPlayerParams()
	self:_onRefreshUI()
	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGetInfoReq(self._challengeId)

	local itemsStr = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_ITEMS)
	local items = string.split(itemsStr, "#")
	local objList = {}

	for i, v in ipairs(items) do
		local obj = {
			showAdd = true,
			id = v
		}

		table.insert(objList, obj)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)

	self._petName.text = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_TITLE)
	self._txtTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)

	local skinId = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_SKIN_ID)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)

	MaterialMgr.setCell(MatType.Rare, raceId, self._rare)

	if self._con and checknumber(skinId) > 0 and self._commonCfg.isShowPet == true then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con)
	end
end

function HuoqilinmainView:_initPlayerParams()
	local param = {}

	param.view = self
	param.prizeCfgs = PerfectRuleModeConfig.instance:getProgressPrizeCfg(self._planId)

	function param.getPlayerProgress()
		local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

		return checknumber(progress.score)
	end

	function param.getPrizeByRewardCfg(cfg)
		local prizes = string.split(cfg.prize, "#")

		return prizes[1]
	end

	function param.getNeedScoreByRewardCfg(cfg)
		return cfg.progress
	end

	function param.isPlayerRewardCanGet(cfg)
		return PerfectRuleModeModel.instance:isPlayerRewardCanGet(self._challengeId, cfg.id, cfg.progress)
	end

	function param.isPlayerRewardGeted(cfg)
		return PerfectRuleModeModel.instance:isPlayerRewardGeted(self._challengeId, cfg.id)
	end

	function param.sendGainPlayerPrizeReq(cfg)
		PerfectRuleModeController.instance:sendPM_PerfectRuleFightGainProgressPrizeReq(self._challengeId, cfg.id)
	end

	function param.parseGetProgress(cfg)
		return StringUtil.numberToString(cfg.progress)
	end

	self._playerSliderMo:initParam(param, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function HuoqilinmainView:_firstOpenActivity()
	return
end

function HuoqilinmainView:_onRefreshUI()
	self._playerSliderMo:updatePlayerReward()

	local progress = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

	self._txtTotal.text = checknumber(progress.score)
	self._times.text = langPara("今日次数：%s/%s", self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes) - checknumber(progress.hasUseTimes), self._commonCfg.dailyTimes + checknumber(progress.hasBuyTimes))
end

function HuoqilinmainView:_onClickPurgatory()
	self._curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId) or {}

	local curRuleId = self._curInfo.curRuleId

	if curRuleId and curRuleId > 0 then
		UIStateManager.instance:push(self._commonCfg.ruleview, self._challengeId)
	else
		UIStateManager.instance:push(self._commonCfg.difficultyview, self._challengeId)
	end
end

function HuoqilinmainView:_onClickPetInfo()
	local skinId = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_SKIN_ID)
	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)

	PetbookController.instance:openPetinfoView(raceId)
end

function HuoqilinmainView:_onClickSkill()
	local skinId = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_SKIN_ID)

	PetbookController.instance:previewBattleWithSkinId(skinId)
end

function HuoqilinmainView:_onClickRank()
	GotoMgr.gotoByString(PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_RANK_JUMP))
end

function HuoqilinmainView:_onClickLottery()
	GotoMgr.gotoByString(PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_LOTTERY_JUMP))
end

function HuoqilinmainView:_onClickTry()
	GotoMgr.gotoByString(PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_YANGCHENG_JUMP))
end

function HuoqilinmainView:_onClickBtnFullRebate()
	local jumpToStr = PerfectRuleModeConfig.instance:getPerfectCfgByKey(self._HUOQILIN_REBATE_JUMP)

	GotoMgr.gotoByString(jumpToStr)
end

function HuoqilinmainView:_onClickBtnTip()
	self._commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(self._challengeId)

	if not string.nilorempty(self._commonCfg.ruleKey) then
		TipsFacade.instance:openRulesView(self._commonCfg.ruleKey)
	end
end

return HuoqilinmainView

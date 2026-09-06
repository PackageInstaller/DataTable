-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLordsMainView.lua

module("logic.extensions.dragonlords.view.DragonLordsMainView", package.seeall)

local DragonLordsMainView = class("DragonLordsMainView", ViewComponent)

function DragonLordsMainView:ctor()
	DragonLordsMainView.super.ctor(self)
end

function DragonLordsMainView:unbindEvents()
	DragonLordsMainView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._LimitChallenge:RemoveClickListener()
	self._NationalChallenge:RemoveClickListener()
end

function DragonLordsMainView:bindEvents()
	DragonLordsMainView.super.bindEvents(self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "dragonlordsmainview_rule")
	end, self)
	self._btnInfo:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._petId)
	end, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnShop:AddClickListener(function()
		self:_onClickjumpTo(DragonLordsConfig.instance:getCommonCfg("SHOP_FUNC"))
	end, self)
	self._btnRank:AddClickListener(function()
		self:_onClickjumpTo(DragonLordsConfig.instance:getCommonCfg("RANK_FUNC"))
	end, self)
	self._btnClose:AddClickListener(function()
		self:close()
	end, self)
	self._LimitChallenge:AddClickListener(self._limitChallengeOnClick, self)
	self._NationalChallenge:AddClickListener(self._nationalChallengeOnClick, self)
end

function DragonLordsMainView:onExit()
	DragonLordsMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DragonLordsMain, self.updatePassNumTxt, self)
	MaterialMgr.resetAll(self._rare)
	RedPointController.instance:unregRedPoint(self._naRedPoint)
end

function DragonLordsMainView:buildUI()
	DragonLordsMainView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
	self._LimitChallenge = self:getBtn("limitChallenge")
	self._NationalChallenge = self:getBtn("nationalChallenge")
	self._petName = self:getTxt("petInfo/txtName")
	self._LimitChallengeTxt = self:getTxt("limitChallenge/times")
	self._limitChallengeTipTxt = self:getTxt("limitChallengeTxt")
	self._nationalChallengeTxt = self:getTxt("nationalChallengeTxt")
	self._txtTime = self:getTxt("time/txtTime")
	self._rare = self:getGo("petInfo/rare")
	self._naRedPoint = self:getGo("nationalChallenge/redPoint")
end

function DragonLordsMainView:onEnter()
	DragonLordsMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DragonLordsMain, self.updatePassNumTxt, self)

	local actId = DrogonLordsModel.instance:getActivityId()

	if actId <= 0 then
		self:close()

		return
	end

	DragonRespectChallengeAgent.instance:sendPM_DragonRespectChallengeInfoReq(actId)

	self._passNum = nil
	self._petId = checknumber(DragonLordsConfig.instance:getCommonCfg("SHOW_PET_ID"))

	self:_firstOpenActivity()
	self:_loadInterfaceTxt()
	self:setActTime(actId)
	MaterialMgr.setCell(MatType.Rare, self._petId, self._rare)

	local petCo = CharacterConfig.instance:getPetCo(self._petId)

	self._petName.text = petCo.name

	RedPointController.instance:regRedPoint(self._naRedPoint, RedPointModel.ID_LONGZUN_CHALLENGE)
end

function DragonLordsMainView:_limitChallengeOnClick()
	local timeStr = DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE_OPEN_TIME")
	local timeArr = string.split(timeStr, "#")

	if timeArr[1] and timeArr[2] and not GameUtil.checkIsInTimePeriod(timeArr[1], timeArr[2]) then
		FloatWordMgr.instance:show("极限挑战将于10:00后开启")

		return
	end

	if not self._passNum then
		FloatWordMgr.instance:show("正在加载，请稍等~")

		return
	elseif self._passNum >= checknumber(DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT")) then
		FloatWordMgr.instance:show(DragonLordsConfig.instance:getCommonCfg("LIMIT_TIPS_TEXT"))

		return
	end

	UIStateManager.instance:push(ViewName.DragonLimitChallengeView)
end

function DragonLordsMainView:_nationalChallengeOnClick()
	UIStateManager.instance:push(ViewName.DragonNationalChallengeView)
end

function DragonLordsMainView:updatePassNumTxt()
	self._passNum = DrogonLordsModel.instance:getPassNum()

	if self._passNum > checknumber(DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT")) then
		self._passNum = checknumber(DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT"))
	end

	self._LimitChallengeTxt.text = string.format(DragonLordsConfig.instance:getCommonCfg("LIMIT_NUM_TEXT"), self._passNum, DragonLordsConfig.instance:getCommonCfg("EXTREME_PASS_LIMIT"))
end

function DragonLordsMainView:_firstOpenActivity()
	local str = "dragonlordsmainview_donghua"
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) == 1 then
		return
	end

	ViewBlockMgr.instance:blockClick(true, self)
	AnimationPlayer.play("storyconfig/animations/dh_3long.txt", function()
		ViewBlockMgr.instance:blockClick(false, self)
	end, nil, self)
	GameUtil.saveUserDayData(str, 1)
end

function DragonLordsMainView:_onClickSkill()
	local skinId = self._petId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function DragonLordsMainView:_onClickjumpTo(cfgStr)
	GotoMgr.gotoByString(cfgStr)
end

function DragonLordsMainView:_loadInterfaceTxt()
	local limitTimes = string.split(DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE_OPEN_TIME"), "#")
	local limitStart = GameUtil.string2date(limitTimes[1])
	local limitEnd = GameUtil.string2date(limitTimes[2])
	local commonTimes = string.split(DragonLordsConfig.instance:getCommonCfg("UNIVERSAL_CHALLENGE_OPEN_TIME"), "#")
	local commonStart = GameUtil.string2date(commonTimes[1])
	local commonEnd = GameUtil.string2date(commonTimes[2])

	self._limitChallengeTipTxt.text = string.format(DragonLordsConfig.instance:getCommonCfg("EXTREME_CHALLENGE"), limitStart.month, limitStart.day, limitEnd.month, limitEnd.day)
	self._nationalChallengeTxt.text = string.format(DragonLordsConfig.instance:getCommonCfg("UNIVERSAL_CHALLENGE"), commonStart.month, commonStart.day, commonEnd.month, commonEnd.day)
end

function DragonLordsMainView:setActTime(actId)
	local activityType = math.floor(actId / 1000)

	self._txtTime.text = GameUtil.getActTimeDesc(activityType, actId)
end

return DragonLordsMainView

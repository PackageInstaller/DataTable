-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengemainView.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengemainView", package.seeall)

local CiyuanshenglongchallengemainView = class("CiyuanshenglongchallengemainView", ViewComponent)

function CiyuanshenglongchallengemainView:ctor()
	CiyuanshenglongchallengemainView.super.ctor(self)
end

function CiyuanshenglongchallengemainView:unbindEvents()
	CiyuanshenglongchallengemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRank2)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPetInfo)
end

function CiyuanshenglongchallengemainView:bindEvents()
	CiyuanshenglongchallengemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnRank2, self._onClickRankChallenge, self)
	GameUtil.addClickHandler(self._btnShop, self._onclickShop, self)
	GameUtil.addClickHandler(self._btnPetInfo, self._onClickInfo, self)
end

function CiyuanshenglongchallengemainView:buildUI()
	CiyuanshenglongchallengemainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnRank = self:getGo("btnRank")
	self._btnRank2 = self:getGo("btnRank2")
	self._btnShop = self:getGo("btnShop")
	self._petCon = self:getGo("petCon")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._petRare = self:getGo("petInfo/rare")
	self._btnPetInfo = self:getGo("petInfo/btnInfo")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtChallengeTip = self:getTxt("btnChallenge/txtTip")
	self._redChallenge = self:getGo("btnChallenge/redpoint")
	self._redChallenge = self:getGo("btnChallenge/redpoint")
	self._pointItem = self:getGo("reward/pointItem")
end

function CiyuanshenglongchallengemainView:onExit()
	CiyuanshenglongchallengemainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRare)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	MaterialMgr.resetAll(self._pointItem)
end

function CiyuanshenglongchallengemainView:onEnter()
	CiyuanshenglongchallengemainView.super.onEnter(self)

	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.CiYuanShengLong)

	if activityId <= 0 then
		self:close()

		return
	end

	self._activityId = activityId
	self._activityConfig = CiyuanshenglongConfig.instance:getActivityCfgById(self._activityId)

	self:_refreshUI()
end

function CiyuanshenglongchallengemainView:_refreshUI()
	self._txtChallengeTip.text = CiyuanshenglongConfig.instance:getCommonValue("TIPS")

	MaterialMgr.resetAll(self._pointItem)

	local itemStr = CiyuanshenglongConfig.instance:getCommonValue("REWARD")

	if not string.nilorempty(itemStr) then
		MaterialMgr.setCellByCfg(itemStr, self._pointItem)
	end

	local raceId = CiyuanshenglongConfig.instance:getCommonValue("RACEID", true)

	MaterialMgr.setCell(MatType.Rare, raceId, self._petRare)

	self._skinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)
	self._txtPetName.text = self._skinCfg.name
	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(raceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, raceId, self._petCon, scale, true, modelCfg[1], y)

				local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.CiYuanShengLong, self._activityId)
				local startDate = GameUtil.time2date(startTime)
				local endDate = GameUtil.time2date(endTime)

				self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
			end
		end
	end
end

function CiyuanshenglongchallengemainView:_onClickRule()
	local rule = CiyuanshenglongConfig.instance:getCommonValue("RULE")

	TipsFacade.instance:openRulesView(rule)
end

function CiyuanshenglongchallengemainView:_onClickFight()
	if not self._activityConfig.challengeClosedTimeRange then
		local arr = string.split(self._activityConfig.challengeClosedTimeRange, "-") or {}

		if not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true) then
			UIStateManager.instance:push(ViewName.CiyuanshenglongchallengefightView)
		else
			FloatWordMgr.instance:show(lang("不在开放时间内"))
		end
	end
end

function CiyuanshenglongchallengemainView:_onClickRank()
	local gotoStr = CiyuanshenglongConfig.instance:getCommonValue("JUMP_TO")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function CiyuanshenglongchallengemainView:_onClickRankChallenge()
	UIStateManager.instance:push(ViewName.CiyuanshenglongchallengerankView, self._activityId, CiyuanshenglongModel.TAB_HISTORY)
end

function CiyuanshenglongchallengemainView:_onClickShop()
	local gotoStr = CiyuanshenglongConfig.instance:getCommonValue("SHOP")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function CiyuanshenglongchallengemainView:_onClickInfo()
	if self._skinCfg then
		local raceId = self._skinCfg.raceId

		PetbookController.instance:openPetinfoView(raceId)
	end
end

return CiyuanshenglongchallengemainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenmainView.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenmainView", package.seeall)

local HeartofjieshenmainView = class("HeartofjieshenmainView", ViewComponent)

function HeartofjieshenmainView:ctor()
	HeartofjieshenmainView.super.ctor(self)
end

function HeartofjieshenmainView:unbindEvents()
	HeartofjieshenmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRankChallenge)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPetInfo1)
	GameUtil.rmClickHandler(self._btnPetInfo2)
end

function HeartofjieshenmainView:bindEvents()
	HeartofjieshenmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnRankChallenge, self._onClickRankChallenge, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnPetInfo1, self._onClickInfo1, self)
	GameUtil.addClickHandler(self._btnPetInfo2, self._onClickInfo2, self)
end

function HeartofjieshenmainView:buildUI()
	HeartofjieshenmainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnRank = self:getGo("btnRank")
	self._btnRankChallenge = self:getGo("btnRankChallenge")
	self._btnShop = self:getGo("btnShop")
	self._petCon1 = self:getGo("petCon1")
	self._petCon2 = self:getGo("petCon2")
	self._txtPetName1 = self:getTxt("petInfo1/txtName")
	self._txtPetName2 = self:getTxt("petInfo2/txtName")
	self._petRare1 = self:getGo("petInfo1/rare")
	self._petRare2 = self:getGo("petInfo2/rare")
	self._btnPetInfo1 = self:getGo("petInfo1/btnInfo")
	self._btnPetInfo2 = self:getGo("petInfo2/btnInfo")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtChallengeTip = self:getTxt("btnChallenge/txtTip")
	self._redChallenge = self:getGo("btnChallenge/redpoint")
	self._pointItem = self:getGo("reward/pointItem")
	self._txtOpenTime = self:getTxt("time/txtOpenTime")
end

function HeartofjieshenmainView:onExit()
	HeartofjieshenmainView.super.onExit(self)
	MaterialMgr.resetAll(self._petRare)

	self._roleObj1 = RoleObjectPool.instance:removeRole(self._roleObj1)
	self._roleObj2 = RoleObjectPool.instance:removeRole(self._roleObj2)

	MaterialMgr.resetAll(self._pointItem)
end

function HeartofjieshenmainView:onEnter()
	HeartofjieshenmainView.super.onEnter(self)
	self:_setActId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._actCfg = HeartofjieshenConfig.instance:getActCfg(self._activityId) or {}

	self:_setTime()
	HeartofjieshenModel.instance:resetClgFinishDic()
	self:_showRoles()
	self:_setOpenTime()
end

function HeartofjieshenmainView:_setActId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = HeartofjieshenController.instance:getActivityId()
	end
end

function HeartofjieshenmainView:_showRoles()
	local raceId1 = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "raceId1")
	local raceId2 = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "raceId2")

	self._roleObj1 = self:_showRole(raceId1, self._roleObj1, self._petCon1, self._petRare1, self._txtPetName1)
	self._roleObj2 = self:_showRole(raceId2, self._roleObj2, self._petCon2, self._petRare2, self._txtPetName2)
end

function HeartofjieshenmainView:_showRole(raceId, loader, petCon, rareCon, txtPetName)
	if checknumber(raceId) == 0 then
		return
	end

	MaterialMgr.setCell(MatType.Rare, raceId, rareCon)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId) or {}

	txtPetName.text = skinCfg.skinName

	local loader = RoleObjectPool.instance:removeRole(loader)
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(raceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				loader = RoleObjectPool.instance:addRoleToParent(loader, raceId, petCon, scale, true, modelCfg[1], y)

				return loader
			end
		end
	end
end

function HeartofjieshenmainView:_onClickRule()
	local rule = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "ruleKey")

	TipsFacade.instance:openRulesView(rule)
end

function HeartofjieshenmainView:_onClickFight()
	if self:_isInChallengeTime() then
		UIStateManager.instance:push(ViewName.HeartofjieshenclgView, self._activityId)
	else
		FloatWordMgr.instance:show(HeartofjieshenConfig.instance:getCommonValue(self._activityId, "tips"))
	end
end

function HeartofjieshenmainView:_onClickRank()
	local gotoStr = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "jumpTo")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function HeartofjieshenmainView:_onClickRankChallenge()
	UIStateManager.instance:push(ViewName.HeartofjieshenrankView, self._activityId, HeartofjieshenModel.TAB_HISTORY)
end

function HeartofjieshenmainView:_onClickShop()
	local gotoStr = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "shop")

	if not string.nilorempty(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function HeartofjieshenmainView:_onClickInfo1()
	local raceId = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "raceId1")

	PetbookController.instance:openPetinfoView(raceId)
end

function HeartofjieshenmainView:_onClickInfo2()
	local raceId = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "raceId2")

	PetbookController.instance:openPetinfoView(raceId)
end

function HeartofjieshenmainView:_setTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function HeartofjieshenmainView:_setOpenTime()
	self._txtOpenTime.text = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "tips")
end

function HeartofjieshenmainView:_isInChallengeTime()
	if not self._actCfg.challengeClosedTimeRange then
		local arr = string.split(self._actCfg.challengeClosedTimeRange, "-") or {}

		return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
	end
end

return HeartofjieshenmainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmengmeng/view/KingmmMainView.lua

module("logic.extensions.kingmengmeng.view.KingmmMainView", package.seeall)

local KingmmMainView = class("KingmmMainView", ViewComponent)

function KingmmMainView:ctor()
	KingmmMainView.super.ctor(self)
end

function KingmmMainView:buildUI()
	KingmmMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._jumpCol = self:getGo("jumpCol")
	self._btnRank = self:getGo("jumpCol/btnRank")
	self._btnSummon = self:getGo("jumpCol/btnSummon")
	self._btnCultivate = self:getGo("jumpCol/btnCultivate")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._con = self:getGo("con")
	self._txtBubble1 = self:getTxt("bubble1/txt")
	self._prizeBubble1 = self:getGo("bubble1/prize")
	self._bubble2 = self:getGo("bubble2")
	self._txtBubble2 = self:getTxt("bubble2/txt")
	self._prizeBubble2 = self:getGo("bubble2/prize")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._redPoint1 = self:getGo("btnChallenge1/redPoint")
	self._redPoint2 = self:getGo("btnChallenge2/redPoint")
end

function KingmmMainView:bindEvents()
	KingmmMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRank, GameUtil.handler(self._onClickBtnJump, self, "gotoRank"))
	GameUtil.addClickHandler(self._btnSummon, GameUtil.handler(self._onClickBtnJump, self, "gotoSummon"))
	GameUtil.addClickHandler(self._btnCultivate, GameUtil.handler(self._onClickBtnJump, self, "gotoCultivate"))
end

function KingmmMainView:unbindEvents()
	KingmmMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnSummon)
	GameUtil.rmClickHandler(self._btnCultivate)
end

function KingmmMainView:onEnter()
	KingmmMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KingmmController.instance:getActivityId()
	end

	self._activityType = KingmmController.instance:getActivityType()

	local isInTime = KingmmController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._cfgActivity = KingmmConfig.instance:getActivityCfg(self._activityId)
	self._raceId = self._cfgActivity.raceId
	self._skinId = 0

	GameUtil.SetActive(self._jumpCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._bubble2, not self._isAoqiGodProcessType)

	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	self:_initBubblePrize()
	self:_showRoleModel()
	self:_initPetInfo()
	self:_updateRedPoint1()
	self:_updateRedPoint2()
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGetCommonInfoRes, self._onGetCommonInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.KMMChallengeGetExtremeInfoRes, self._onGetExtremeInfoRes, self)

	if not self._isAoqiGodProcessType then
		KingmmAgent.instance:sendPM_KMMChallengeGetCommonInfoReq(self._activityId)
	end

	KingmmAgent.instance:sendPM_KMMChallengeGetExtremeInfoReq(self._activityId)
end

function KingmmMainView:onExit()
	KingmmMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGetCommonInfoRes, self._onGetCommonInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.KMMChallengeGetExtremeInfoRes, self._onGetExtremeInfoRes, self)
	self:_clearBubblePrize()
	self:_resetRoleModel()
end

function KingmmMainView:_onGetCommonInfoRes()
	self:_updateRedPoint1()
end

function KingmmMainView:_onGetExtremeInfoRes()
	self:_updateRedPoint2()
end

function KingmmMainView:_onClickTip()
	local key = self._cfgActivity.mainRuleKey

	TipsFacade.instance:openRulesView(key)
end

function KingmmMainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	if self._cfgActivity then
		local jumpToStr = self._cfgActivity[key]

		GotoMgr.gotoByString(jumpToStr)
	end
end

function KingmmMainView:_onClickChallenge1()
	if self._isAoqiGodProcessType then
		return
	end

	UIStateManager.instance:push(ViewName.KingmmEntireView, self._activityId)
end

function KingmmMainView:_onClickChallenge2()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	UIStateManager.instance:push(ViewName.KingmmExtremeView, self._activityId)
end

function KingmmMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function KingmmMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId, self._skinId)
	end
end

function KingmmMainView:_initBubblePrize()
	MaterialMgr.setCellByCfg(self._cfgActivity.bubblePrize1, self._prizeBubble1)
	MaterialMgr.setCellByCfg(self._cfgActivity.bubblePrize2, self._prizeBubble2)
end

function KingmmMainView:_clearBubblePrize()
	MaterialMgr.resetAll(self._prizeBubble1)
	MaterialMgr.resetAll(self._prizeBubble2)
end

function KingmmMainView:_showRoleModel()
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

function KingmmMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function KingmmMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function KingmmMainView:_updateRedPoint1()
	local isLeftTodayChallengeTimes = KingmmModel.instance:isLeftTodayChallengeTimes(self._activityId)
	local isExistCanGetReward = KingmmModel.instance:isExistCanGetReward(self._activityId)
	local isShowRedPoint1 = isLeftTodayChallengeTimes or isExistCanGetReward

	goutil.setActive(self._redPoint1, isShowRedPoint1)
end

function KingmmMainView:_updateRedPoint2()
	local isShowRedPoint2 = KingmmModel.instance:isCanGetPassPrize()

	goutil.setActive(self._redPoint2, isShowRedPoint2)
end

return KingmmMainView

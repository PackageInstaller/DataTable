-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiChallengeMainView.lua

module("logic.extensions.shenjichallenge.view.ShenJiChallengeMainView", package.seeall)

local ShenJiChallengeMainView = class("ShenJiChallengeMainView", ViewComponent)

function ShenJiChallengeMainView:ctor()
	ShenJiChallengeMainView.super.ctor(self)
end

function ShenJiChallengeMainView:buildUI()
	ShenJiChallengeMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnTask = self:getBtn("btnTask")
	self._btnSummon = self:getBtn("btnSummon")
	self._btnRank = self:getBtn("btnRank")
	self._btnReturn = self:getBtn("btnReturn")
	self._btnGift = self:getBtn("btnGift")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtProgress1 = self:getTxt("bgProgress1/txtProgress1")
	self._txtProgress2 = self:getTxt("bgProgress2/txtProgress2")
	self._goldBarCon = self:getGo("goldBarCon")
end

function ShenJiChallengeMainView:bindEvents()
	ShenJiChallengeMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnSummon:AddClickListener(self._onClickSummon, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnGift:AddClickListener(self._onClickGift, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function ShenJiChallengeMainView:unbindEvents()
	ShenJiChallengeMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSummon:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function ShenJiChallengeMainView:onEnter()
	ShenJiChallengeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)

	self._activityId = self:_getActivityId()

	ShenJiChallengeModel.instance:setCurActivityId(self._activityId)

	self._activityType = ShenJiChallengeModel.instance:getActivityType()
	self._isClick = false

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._challengeId = self._cfgActivity.challengeId
	self._ruleTip = self._cfgActivity.ruleTip

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self._dailySelectTimes = self._cfgActivity.dailySelectTimes
	self._fightBossTimes = self._cfgActivity.fightBossTimes

	self:_initActivityTime()
	self:_initPetInfo()
	self:_showRoleModel()
	self:_setTopGoldBar(self._goldBarCon, self._cfgActivity.goldBarCon)
	self:_updateProgress1()
	self:_updateProgress2()
	ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeGetInfoReq(self._activityId)
end

function ShenJiChallengeMainView:onExit()
	ShenJiChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function ShenJiChallengeMainView:_getActivityId()
	return ShenJiChallengeModel.instance:getActivityId()
end

function ShenJiChallengeMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._ruleTip)
end

function ShenJiChallengeMainView:_onClickSummon()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function ShenJiChallengeMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function ShenJiChallengeMainView:_onClickReturn()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function ShenJiChallengeMainView:_onClickGift()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function ShenJiChallengeMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.ShenJiTaskView, self._activityId)
end

function ShenJiChallengeMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function ShenJiChallengeMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function ShenJiChallengeMainView:_onClickChallenge1()
	UIStateManager.instance:push(ViewName.ShenJiSelectView, self._activityId)
end

function ShenJiChallengeMainView:_onClickChallenge2()
	UIStateManager.instance:push(ViewName.ShenJiBossView, self._activityId)
end

function ShenJiChallengeMainView:_onGetInfoRes()
	self:_updateProgress1()
	self:_updateProgress2()
end

function ShenJiChallengeMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ShenJiChallengeMainView:_showRoleModel()
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

function ShenJiChallengeMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ShenJiChallengeMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function ShenJiChallengeMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function ShenJiChallengeMainView:_updateProgress1()
	local maxNum = self._dailySelectTimes
	local curNum = ShenJiChallengeModel.instance:getTodayChallengeTimes()

	self._txtProgress1.text = string.format("今日剩余次数：%d/%d", Mathf.Max(maxNum - curNum, 0), maxNum)
end

function ShenJiChallengeMainView:_updateProgress2()
	local cfgs = ShenJiChallengeConfig.instance:getBossList(self._activityId)
	local maxNum = #cfgs
	local curNum = ShenJiChallengeModel.instance:getPassBossNum(self._activityId)

	self._txtProgress2.text = string.format("当前挑战进度：%d/%d", curNum, maxNum)
end

return ShenJiChallengeMainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanMainView.lua

module("logic.extensions.watertianyan.view.WaterTianYanMainView", package.seeall)

local WaterTianYanMainView = class("WaterTianYanMainView", ViewComponent)

function WaterTianYanMainView:ctor()
	WaterTianYanMainView.super.ctor(self)
end

function WaterTianYanMainView:buildUI()
	WaterTianYanMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnJump1 = self:getGo("btnJump1")
	self._btnJump3 = self:getGo("btnJump3")
	self._btnJump2 = self:getGo("btnJump2")
	self._btnJump4 = self:getGo("btnJump4")
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

function WaterTianYanMainView:bindEvents()
	WaterTianYanMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpTo1"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpTo2"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpTo3"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpTo4"))
end

function WaterTianYanMainView:unbindEvents()
	WaterTianYanMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
end

function WaterTianYanMainView:_getActivityId()
	return WaterTianYanModel.instance:getActivityId()
end

function WaterTianYanMainView:onEnter()
	WaterTianYanMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanGetInfoRes, self._onGetInfoRes, self)

	self._activityId = self:_getActivityId()
	self._activityType = WaterTianYanModel.instance:getActivityType()
	self._isClick = false

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = WaterTianYanConfig.instance:getActivityCfg(self._activityId)
	self._challengeId = self._cfgActivity.challengeId
	self._ruleTip = self._cfgActivity.ruleTip
	self._buildingDailyChallengeTimes = self._cfgActivity.buildingDailyChallengeTimes

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_initPetInfo()
	self:_showRoleModel()
	self:_setTopGoldBar(self._goldBarCon, self._cfgActivity.goldBarCon)
	self:_updateProgress1()
	self:_updateProgress2()
	WaterTianYanAgent.instance:sendPM_WaterTianYanGetInfoReq(self._activityId)
end

function WaterTianYanMainView:onExit()
	WaterTianYanMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanGetInfoRes, self._onGetInfoRes, self)
	self:_resetRoleModel()
	self:_clearPetInfo()
end

function WaterTianYanMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._ruleTip)
end

function WaterTianYanMainView:_onClickBtnJump(key)
	if self._cfgActivity then
		GotoMgr.gotoByString(self._cfgActivity)
	end
end

function WaterTianYanMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function WaterTianYanMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function WaterTianYanMainView:_getClgMainView()
	return WaterTianYanEnum.ViewNames[self._activityId][WaterTianYanEnum.ViewTypes_ClgMainView]
end

function WaterTianYanMainView:_getClgBuildView()
	return WaterTianYanEnum.ViewNames[self._activityId][WaterTianYanEnum.ViewTypes_ClgBuildView]
end

function WaterTianYanMainView:_onClickChallenge1()
	UIStateManager.instance:push(self:_getClgMainView(), self._activityId)
end

function WaterTianYanMainView:_onClickChallenge2()
	UIStateManager.instance:push(self:_getClgBuildView(), self._activityId)
end

function WaterTianYanMainView:_onGetInfoRes()
	self:_updateProgress1()
	self:_updateProgress2()
end

function WaterTianYanMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function WaterTianYanMainView:_showRoleModel()
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

function WaterTianYanMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function WaterTianYanMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function WaterTianYanMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function WaterTianYanMainView:_updateProgress1()
	local passStageId = WaterTianYanModel.instance:getMainStagePassId(self._activityId)
	local cfgs = WaterTianYanConfig.instance:getMainStageCfgList(self._activityId)

	if cfgs then
		if not #cfgs then
			local maxStage = 1
			local curStage = Mathf.Clamp(passStageId + 1, 1, maxStage)

			self._txtProgress1.text = string.format("当前挑战进度：%d/%d", curStage, maxStage)
		end
	end
end

function WaterTianYanMainView:_updateProgress2()
	local usedCount = WaterTianYanModel.instance:getBuildingStageChallengeTimes(self._activityId)
	local maxCount = self._buildingDailyChallengeTimes
	local leftCount = Mathf.Max(0, maxCount - usedCount)

	self._txtProgress2.text = string.format("今日可挑战次数：%d/%d", leftCount, maxCount)
end

return WaterTianYanMainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/view/DivineEternalDragonClgMainView.lua

module("logic.extensions.divineeternaldragonclg.view.DivineEternalDragonClgMainView", package.seeall)

local DivineEternalDragonClgMainView = class("DivineEternalDragonClgMainView", ViewComponent)

function DivineEternalDragonClgMainView:ctor()
	DivineEternalDragonClgMainView.super.ctor(self)
end

function DivineEternalDragonClgMainView:unbindEvents()
	DivineEternalDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnClg)
end

function DivineEternalDragonClgMainView:bindEvents()
	DivineEternalDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "gotoStr1"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "gotoStr2"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "gotoStr3"))
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
end

function DivineEternalDragonClgMainView:buildUI()
	DivineEternalDragonClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClg = self:getGo("btnClg")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._con = self:getGo("con")
	self._pass = self:getGo("pass")
	self._txtOpenTimeGo = self:getGo("txtOpenTime")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
end

function DivineEternalDragonClgMainView:onExit()
	DivineEternalDragonClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DivineEternalDragonClgMainView:onEnter()
	DivineEternalDragonClgMainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_updateByCfg()
	self:_initAoqiGodUI()
	DivineEternalDragonClgController.instance:getInfo(self._activityId)
	self.addGEvent(self, GlobalNotify.DivineEternalDragonClgUpdateInfo, self._updateByInfo, self)
end

function DivineEternalDragonClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtOpenTimeGo, not self._isAoqiGodProcessType)
end

function DivineEternalDragonClgMainView:_checkAoqiGodFinish()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local pass = self:_isAllPass()

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(445, self._activityId)
		end
	end
end

function DivineEternalDragonClgMainView:_updateByCfg()
	self._actCfg = DivineEternalDragonClgConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgs = DivineEternalDragonClgConfig.instance:getStageCfgs(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._curSkinId = checknumber(self._actCfg.skinId)
	self._curRaceId = PetSkinConfig.instance:getPetSkinRaceId(self._curSkinId)

	if self._curSkinId > 0 then
		MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
		self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._curSkinId)
	end
end

function DivineEternalDragonClgMainView:_onClickBtnTip()
	local ruleKey = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(ruleKey)
end

function DivineEternalDragonClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function DivineEternalDragonClgMainView:_onClickBtnClg()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, 445, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if self._isCurAllPass then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineEternalDragonClgStageView, self._activityId)
end

function DivineEternalDragonClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function DivineEternalDragonClgMainView:_onClickBtnSkill()
	if self._curRaceId > 0 and self._curSkinId > 0 then
		PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
	elseif self._curRaceId > 0 then
		PetbookController.instance:previewBattle(self._curRaceId)
	end
end

function DivineEternalDragonClgMainView:_updateByInfo()
	local baseInfo = DivineEternalDragonClgModel.instance:getBaseInfoByActId(self._activityId)

	self:_checkAoqiGodFinish()

	self._isCurAllPass = baseInfo.passStageId >= #self._stageCfgs

	goutil.setActive(self._pass, self._isCurAllPass)
end

function DivineEternalDragonClgMainView:_isAllPass()
	local baseInfo = DivineEternalDragonClgModel.instance:getBaseInfoByActId(self._activityId)
	local stageCfgs = DivineEternalDragonClgConfig.instance:getStageCfgs(self._activityId)

	return baseInfo.passStageId >= #stageCfgs
end

return DivineEternalDragonClgMainView

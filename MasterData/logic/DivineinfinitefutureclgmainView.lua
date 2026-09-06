-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgmainView.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgmainView", package.seeall)

local DivineinfinitefutureclgmainView = class("DivineinfinitefutureclgmainView", ViewComponent)

function DivineinfinitefutureclgmainView:buildUI()
	DivineinfinitefutureclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "btnTip")
	self._time = self:getGo("time")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._passGo = self:getGo("btnClg/passGo")
	self._txtClgOpenTime = self:getTxt("btnClg/txtOpenTime")
end

function DivineinfinitefutureclgmainView:bindEvents()
	DivineinfinitefutureclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function DivineinfinitefutureclgmainView:unbindEvents()
	DivineinfinitefutureclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._btnClg)
end

function DivineinfinitefutureclgmainView:onEnter()
	DivineinfinitefutureclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineInfiniteFutureClgGetInfoRes, self._updateUI, self)

	self._activityType = DivineinfinitefutureclgController.instance:getActivityType()
	self._activityId = self:_getActivityId()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if self._activityId <= 0 then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._activityId)
	self._params = GameUtil.jsonToTable(self._actCfg.paramStr)

	self:_updateStaticUI()
	self:_initAoqiGodUI()
	DivineInfiniteFutureClgAgent.instance:sendPM_DivineInfiniteFutureClgGetInfoReq(self._activityId)
end

function DivineinfinitefutureclgmainView:onExit()
	DivineinfinitefutureclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function DivineinfinitefutureclgmainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineinfinitefutureclgmainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineinfinitefutureclgmainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineinfinitefutureclgmainView:_getSkinId()
	return ChuangzhengliConfig.instance:getSkinId(self._activityId)
end

function DivineinfinitefutureclgmainView:_onClickBtnJump(key)
	local jumpToStr = self._params[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineinfinitefutureclgmainView:_onClickBtnClg()
	if not DivineinfinitefutureclgController.instance:checkIsInOpenTime(self._activityId) then
		local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._activityId)

		FloatWordMgr.instance:show(string.format("挑战在%s开启", actCfg.openTime))

		return
	end

	local info = DivineinfinitefutureclgModel.instance:getInfo(self._activityId)
	local cfgs = DivineinfinitefutureclgConfig.instance:getStageCfgs(self._activityId)

	if info.curPassStageId >= #cfgs then
		if self._isAoqiGodProcessType then
			AoqiGodController.instance:doHandleChallengeFinishReady(DivineinfinitefutureclgController.instance:getActivityType(), self._activityId)
		end

		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	if not DivineinfinitefutureclgController.instance:checkPassAoqiGodProcessResult(self._activityId) then
		return
	end

	UIStateManager.instance:push(ViewName.DivineinfinitefutureclgstageView, self._activityId)
end

function DivineinfinitefutureclgmainView:_onClickBtnTip()
	local challengeCfg = DivineinfinitefutureclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineinfinitefutureclgmainView:_updateUI()
	local info = DivineinfinitefutureclgModel.instance:getInfo(self._activityId)
	local cfgs = DivineinfinitefutureclgConfig.instance:getStageCfgs(self._activityId)

	goutil.setActive(self._passGo, info.curPassStageId >= #cfgs)
end

function DivineinfinitefutureclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	self:_setOpenTime()
end

function DivineinfinitefutureclgmainView:_initAoqiGodUI()
	local showNormalUI = not self._isAoqiGodProcessType

	GameUtil.SetActive(self._time, showNormalUI)
	GameUtil.SetActive(self._jumpBtnCol, showNormalUI)
end

function DivineinfinitefutureclgmainView:_setOpenTime()
	local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._activityId)
	local arr = string.split(actCfg.openTime, ":")
	local hour = checknumber(arr[1])
	local min = checknumber(arr[2])
	local sec = checknumber(arr[3])

	self._txtClgOpenTime.text = string.format("开启时间：%s点-%s点", hour, 24)
end

function DivineinfinitefutureclgmainView:_getSkinId()
	return DivineinfinitefutureclgConfig.instance:getSkinId(self._activityId)
end

function DivineinfinitefutureclgmainView:_getActivityId()
	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		activityId = DivineinfinitefutureclgController.instance:getActivityId()
	end

	return activityId
end

return DivineinfinitefutureclgmainView

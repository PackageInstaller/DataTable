-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiMainView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiMainView", package.seeall)

local TongLinShiJiMainView = class("TongLinShiJiMainView", ViewComponent)

function TongLinShiJiMainView:ctor()
	TongLinShiJiMainView.super.ctor(self)
end

function TongLinShiJiMainView:buildUI()
	TongLinShiJiMainView.super.buildUI(self)

	self._btnClg = self:getGo("btnClg/btn")
	self._btnClg2 = self:getGo("btnClg2/btn")
	self._itemcell = self:getGo("btnClg/bubble/itemcell")
	self._itemcell2 = self:getGo("btnClg2/bubble/itemcell")
	self._imgHasGain = self:getGo("btnClg/bubble/imgHasGain")
	self._imgHasGain2 = self:getGo("btnClg2/bubble/imgHasGain")
	self._txtBubble1 = self:getTxt("btnClg/bubble/txt")
	self._txtBubble2 = self:getTxt("btnClg2/bubble/txt")
	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._imgPass = self:getGo("btnClg/btn/imgPass")
	self._imgPass2 = self:getGo("btnClg2/btn/imgPass")
	self._redPoint = self:getGo("btnClg/btn/redPoint")
	self._redPoint2 = self:getGo("btnClg2/btn/redPoint")
end

function TongLinShiJiMainView:bindEvents()
	TongLinShiJiMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg, self._onClickNorBtnClg, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickExtBtnClg, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function TongLinShiJiMainView:unbindEvents()
	TongLinShiJiMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnClg2)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function TongLinShiJiMainView:onEnter()
	TongLinShiJiMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TongLinShiJiController.instance:getActivityId()
	end

	self._activityType = TongLinShiJiController.instance:getActivityType()

	local isInTime = TongLinShiJiController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actStartTime, self._actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_TONG_LIN_SHI_JI_DAILY)
	TongLinShiJiController.instance:sendPM_JiClgGetInfoReq(self._activityId)
	self:_onSetUI()
end

function TongLinShiJiMainView:onExit()
	TongLinShiJiMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcell)
	MaterialMgr.resetAll(self._itemcell2)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redPoint)
end

function TongLinShiJiMainView:_onSetUI()
	if self._txtOpenTime and not self:_isResidentAct() then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	if self:_isResidentAct() then
		self._txtOpenTime.text = "常驻"
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function TongLinShiJiMainView:_onUpdate()
	local canGetReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)
	local showRedPoint = TongLinShiJiController.instance:isInActivityTime(self._activityId) and canGetReward

	GameUtil.SetActive(self._redPoint2, showRedPoint)

	self._NorPass = TongLinShiJiModel.instance:FinishNorChallenge(self._activityId)
	self._ExtPass = TongLinShiJiModel.instance:FinishExtChallenge(self._activityId)

	local hasRewardNor = TongLinShiJiModel.instance:FinishNorChallenge(self._activityId)
	local hasRewardExt = TongLinShiJiModel.instance:FinishExtChallenge(self._activityId)
	local normalPassPrize, extmalPassPrize = TongLinShiJiConfig.instance:GetPrizes(self._activityId)

	MaterialMgr.setCellByCfg(normalPassPrize, self._itemcell)
	MaterialMgr.setCellByCfg(extmalPassPrize, self._itemcell2)

	self._txtBubble1.text = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "bubbleStrOne")
	self._txtBubble2.text = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "bubbleStrTwo")

	GameUtil.SetActive(self._imgHasGain, hasRewardNor)
	GameUtil.SetActive(self._imgHasGain2, hasRewardExt)
	GameUtil.SetActive(self._imgPass, self._NorPass)
	GameUtil.SetActive(self._imgPass2, self._ExtPass)
	TongLinShiJiController.instance:_updateDateClgTimesRed(self._activityId)
	TongLinShiJiController.instance:_updateNorRewardRed(self._activityId)
end

function TongLinShiJiMainView:_onClickNorBtnClg()
	if not TongLinShiJiController:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("还未到活动开启时间")

		return
	end

	if self._NorPass then
		FloatWordMgr.instance:show("已通关该挑战")

		return
	end

	UIStateManager.instance:push(ViewName.TongLinShiJiNorView, self._activityId)
end

function TongLinShiJiMainView:_onClickExtBtnClg()
	if not TongLinShiJiController:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("还未到活动开启时间")

		return
	end

	if self._ExtPass then
		FloatWordMgr.instance:show("已通关该挑战")

		return
	end

	UIStateManager.instance:push(ViewName.TongLinShiJiExtView, self._activityId)
end

function TongLinShiJiMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function TongLinShiJiMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function TongLinShiJiMainView:_onClickBtnTip()
	local key = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function TongLinShiJiMainView:_getRaceId()
	return TongLinShiJiController.instance:getRaceId(self._activityId)
end

function TongLinShiJiMainView:_getSkinId()
	return TongLinShiJiController.instance:getSkinId(self._activityId)
end

function TongLinShiJiMainView:_isResidentAct()
	return GameUtil.getDaysByTimestamp(self._actStartTime, self._actEndTime) > 1095
end

return TongLinShiJiMainView

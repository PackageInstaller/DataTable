-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgMainView.lua

module("logic.extensions.kingmoyanclg.view.KingMoYanClgMainView", package.seeall)

local KingMoYanClgMainView = class("KingMoYanClgMainView", ViewComponent)

function KingMoYanClgMainView:buildUI()
	KingMoYanClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._timeGo = goutil.findChild(self.mainGO, "txtOpenTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._redBtnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._redBtnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._redBtnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._redGoList = {
		self._redBtnJump1,
		self._redBtnJump2,
		self._redBtnJump3
	}
	self._btnStartGo = goutil.findChild(self.mainGO, "btnStart")
	self._btnStart = goutil.findChild(self.mainGO, "btnStart/btn")
	self._redBtnStart = goutil.findChild(self.mainGO, "btnStart/btn/redPoint")
	self._imgPass = goutil.findChild(self.mainGO, "btnStart/btn/imgPass")
end

function KingMoYanClgMainView:bindEvents()
	KingMoYanClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, function()
		local key = self._actData.ruleKeyMain

		TipsFacade.instance:openRulesView(key)
	end)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
end

function KingMoYanClgMainView:unbindEvents()
	KingMoYanClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnStart)
end

function KingMoYanClgMainView:onEnter()
	KingMoYanClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KingMoYanClgController.instance:getActivityId()
	end

	self._activityType = KingMoYanClgController.instance:getActivityType()

	local isInTime = KingMoYanClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._moYanClgMo = KingMoYanClgController.instance:getKingMoYanClgMo(self._activityId)
	self._actData = KingMoYanClgConfig.instance:getActData(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_KingMoYanClgInfoRes, self._onUpdate, self)
	KingMoYanClgController.instance:sendPM_KingMoYanClgInfoReq(self._activityId)
end

function KingMoYanClgMainView:onExit()
	KingMoYanClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)

	for _, v in ipairs(self._redGoList) do
		RedPointController.instance:unregRedPoint(v)
	end
end

function KingMoYanClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)
end

function KingMoYanClgMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redInfoList = {
		{
			not string.nilorempty(self._actData.jumpRedIdOne) and string.split(self._actData.jumpRedIdOne, "#"),
			self._redBtnJump1
		},
		{
			not string.nilorempty(self._actData.jumpRedIdTwo) and string.split(self._actData.jumpRedIdTwo, "#"),
			self._redBtnJump2
		},
		{
			not string.nilorempty(self._actData.jumpRedIdThree) and string.split(self._actData.jumpRedIdThree, "#"),
			self._redBtnJump3
		}
	}

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]

		if list then
			local redIdList = {}

			for _, redId in ipairs(list) do
				if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
					table.insert(redIdList, redId)
				end
			end

			if #redIdList > 0 and not goutil.isNil(redGo) then
				RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
			end
		end
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function KingMoYanClgMainView:_onUpdate()
	local result = self:getTryStartClgResultAndTips(false, self._activityId)

	GameUtil.SetActive(self._imgPass, result == GameEnum.ResultCode.IsPass)
end

function KingMoYanClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function KingMoYanClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function KingMoYanClgMainView:_getRaceId()
	return KingMoYanClgController.instance:getRaceId(self._activityId)
end

function KingMoYanClgMainView:_getSkinId()
	return KingMoYanClgController.instance:getSkinId(self._activityId)
end

function KingMoYanClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function KingMoYanClgMainView:_onClickBtnStart()
	local result = self:getTryStartClgResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.KingMoYanClgStageView, self._activityId)
end

function KingMoYanClgMainView:getTryStartClgResultAndTips(isNeedTips, activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._moYanClgMo

	if not KingMoYanClgController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif mo:isPassAll() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return KingMoYanClgMainView

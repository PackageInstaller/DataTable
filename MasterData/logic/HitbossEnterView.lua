-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hitboss/view/HitbossEnterView.lua

module("logic.extensions.hitboss.view.HitbossEnterView", package.seeall)

local HitbossEnterView = class("HitbossEnterView", ViewComponent)

function HitbossEnterView:ctor()
	HitbossEnterView.super.ctor(self)
end

function HitbossEnterView:buildUI()
	HitbossEnterView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._redJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._redJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._redJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._redJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._btnBtnClg1 = goutil.findChild(self.mainGO, "btnClg1/btn")
	self._redClg1 = goutil.findChild(self.mainGO, "btnClg1/btn/redPoint")
	self._imgPassClg1 = goutil.findChild(self.mainGO, "btnClg1/btn/imgPass")
	self._itemcellClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/itemcell")
	self._imgHasGainClg1 = goutil.findChild(self.mainGO, "btnClg1/bubble/imgHasGain")
	self._txtBubbleClg1 = goutil.findChildTextComponent(self.mainGO, "btnClg1/bubble/txt")
	self._btnBtnClg2 = goutil.findChild(self.mainGO, "btnClg2/btn")
	self._redClg2 = goutil.findChild(self.mainGO, "btnClg2/btn/redPoint")
	self._imgPassClg2 = goutil.findChild(self.mainGO, "btnClg2/btn/imgPass")
end

function HitbossEnterView:bindEvents()
	HitbossEnterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnBtnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnBtnClg2, self._onClickBtnClg2, self)
end

function HitbossEnterView:unbindEvents()
	HitbossEnterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnBtnClg1)
	GameUtil.rmClickHandler(self._btnBtnClg2)
end

function HitbossEnterView:onEnter()
	HitbossEnterView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = HitbossController.instance:getActivityId()
	end

	self._activityType = HitbossController.instance:getActivityType()

	local isInTime = HitbossController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = HitbossConfig.instance:getActivityCfg(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, HitBossAgent.HitBossGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, HitBossAgent.HitBossGainPrizeRes, self._onUpdate, self)
	HitBossAgent.instance:sendPM_HitBossGetInfoReq(self._activityId)
end

function HitbossEnterView:onExit()
	HitbossEnterView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellClg1)
	self:_unRegAllRedPoint()
end

function HitbossEnterView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local redInfoList = {}

	table.insert(redInfoList, {
		{
			HitbossConfig.instance:getCommonValue(self._activityId, "jumpRedIdOne")
		},
		self._redJump1
	})
	table.insert(redInfoList, {
		{
			HitbossConfig.instance:getCommonValue(self._activityId, "jumpRedIdTwo")
		},
		self._redJump2
	})
	table.insert(redInfoList, {
		{
			HitbossConfig.instance:getCommonValue(self._activityId, "jumpRedIdThree")
		},
		self._redJump3
	})
	table.insert(redInfoList, {
		{
			HitbossConfig.instance:getCommonValue(self._activityId, "jumpRedIdFour")
		},
		self._redJump4
	})

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]
		local redIdList = {}

		for _, redId in ipairs(list) do
			if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
				table.insert(redIdList, redId)
			end
		end

		self:_regRedPoint(redGo, redIdList)
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
end

function HitbossEnterView:_onUpdate()
	local isNeedRed = false
	local prizeCfgs = HitbossConfig.instance:getPrizeCfgs(self._activityId)

	if prizeCfgs then
		for _, data in ipairs(prizeCfgs) do
			local isCanGain = HitbossController.instance:isCanGainPrize(self._activityId, data.prizeId)

			if isCanGain then
				isNeedRed = true

				break
			end
		end
	end

	GameUtil.SetActive(self._redClg1, isNeedRed)
end

function HitbossEnterView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function HitbossEnterView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function HitbossEnterView:_getRaceId()
	return HitbossController.instance:getRaceId(self._activityId)
end

function HitbossEnterView:_getSkinId()
	return HitbossController.instance:getSkinId(self._activityId)
end

function HitbossEnterView:_regRedPoint(redGo, redIdList)
	if #redIdList > 0 and not goutil.isNil(redGo) then
		RedPointController.instance:regRedPoint(redGo, unpack(redIdList))

		if self._redGoPool == nil then
			self._redGoPool = {}
		end

		self._redGoPool[redGo] = redGo
	end
end

function HitbossEnterView:_unRegAllRedPoint()
	if self._redGoPool then
		for k, v in pairs(self._redGoPool) do
			RedPointController.instance:unregRedPoint(v)
		end

		table.clear(self._redGoPool)
	end
end

function HitbossEnterView:_onClickBtnJump(key)
	local jumpToStr = HitbossConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function HitbossEnterView:_onClickBtnClg1()
	UIStateManager.instance:push(ViewName.HitbossmainView, self._activityId)
end

function HitbossEnterView:_onClickBtnClg2()
	return
end

function HitbossEnterView:_onClickBtnTip()
	local key = KingKaYaConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return HitbossEnterView

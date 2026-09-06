-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeMainView.lua

module("logic.extensions.xuchallenge.view.XuChallengeMainView", package.seeall)

local XuChallengeMainView = class("XuChallengeMainView", ViewComponent)

function XuChallengeMainView:buildUI()
	XuChallengeMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._btnClg = self:getGo("btnClg/btn")
	self._redBtnClg = self:getGo("btnClg/btn/redPoint")
	self._imgPassBtnClg = self:getGo("btnClg/btn/imgPass")
	self._bubbleItem = self:getGo("btnClg/bubble/item")
	self._tagHasGain = self:getGo("btnClg/bubble/tagHasGain")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._redBtnJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._redBtnJump5 = self:getGo("jumpBtnCol/btnJump5/redPoint")
	self._redBtnJumps = {
		self._redBtnJump1,
		self._redBtnJump2,
		self._redBtnJump3,
		self._redBtnJump4,
		self._redBtnJump5
	}
	self._redDataFields = {
		"jumpRedIdOne",
		"jumpRedIdTwo",
		"jumpRedIdThree",
		"jumpRedIdFour",
		"jumpRedIdFive"
	}
end

function XuChallengeMainView:bindEvents()
	XuChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function XuChallengeMainView:unbindEvents()
	XuChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnClg)
end

function XuChallengeMainView:onEnter()
	XuChallengeMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = XuChallengeController.instance:getActivityId()
	end

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("虚挑战活动未开启")
		self:close()

		return
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = XuChallengeController.instance:getSubMo(self._activityId)
	self._actData = XuChallengeConfig.instance:getActivityData(self._activityId)

	if self._actData == nil then
		FloatWordMgr.instance:show("虚挑战活动配置缺失")
		self:close()

		return
	end

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeNotifyClgRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeResetRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_XuChallengeReplacePetRes, self._onUpdate, self)
	XuChallengeController.instance:sendPM_XuChallengeInfoReq(self._activityId)
end

function XuChallengeMainView:onExit()
	XuChallengeMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._bubbleItem)
	self:_unregisterRedPoints()
end

function XuChallengeMainView:_registerRedPoints()
	for idx, redGo in ipairs(self._redBtnJumps) do
		local redField = self._redDataFields[idx]
		local redIdStr = self._actData[redField]

		if not goutil.isNil(redGo) and not string.nilorempty(redIdStr) then
			local redIdList = string.split(redIdStr, "#")
			local validRedIds = {}

			for _, redId in ipairs(redIdList) do
				if not string.nilorempty(redId) and checknumber(redId) ~= 0 then
					table.insert(validRedIds, redId)
				end
			end

			if #validRedIds > 0 then
				RedPointController.instance:regRedPoint(redGo, GameUtil.unpack10(validRedIds))
			else
				RedPointController.instance:unregRedPoint(redGo)
			end
		end
	end
end

function XuChallengeMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function XuChallengeMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_registerRedPoints()
	GameUtil.SetActive(self._redBtnClg, false)

	local skinId = self:_getSkinId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId) or {}

	if not modelCfg[1] then
		local x = 0

		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

				if skinId > 0 then
					MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
				end

				self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

				self:_updatePrize()
			end
		end
	end
end

function XuChallengeMainView:_onUpdate()
	local lastLayerData = XuChallengeConfig.instance:getLastStageLayerData(self._activityId)
	local isLastLayerHasGain = self._subMo and lastLayerData ~= nil and self._subMo:isAllStageEverPass(lastLayerData.stageIds) or false

	GameUtil.SetActive(self._imgPassBtnClg, isLastLayerHasGain)
	GameUtil.SetActive(self._tagHasGain, isLastLayerHasGain)
end

function XuChallengeMainView:_updatePrize()
	local prize = self._actData.prize

	MaterialMgr.resetAll(self._bubbleItem)

	if not string.nilorempty(prize) then
		MaterialMgr.setCellByCfg(prize, self._bubbleItem)
	end
end

function XuChallengeMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function XuChallengeMainView:_getSkinId()
	return checknumber(self._actData.skinId)
end

function XuChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function XuChallengeMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function XuChallengeMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function XuChallengeMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	if not string.nilorempty(key) then
		TipsFacade.instance:openRulesView(key)
	end
end

function XuChallengeMainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.XuChallengeStageView, self._activityId)
end

return XuChallengeMainView

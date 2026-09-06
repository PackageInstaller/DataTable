-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/view/HeartOfAoJiuClgMainView.lua

module("logic.extensions.heartofaojiuclg.view.HeartOfAoJiuClgMainView", package.seeall)

local HeartOfAoJiuClgMainView = class("HeartOfAoJiuClgMainView", ViewComponent)

function HeartOfAoJiuClgMainView:buildUI()
	HeartOfAoJiuClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._btnClg = self:getGo("btnClg/btn")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._btnClgExt = self:getGo("btnClgExt/btn")
	self._txtOpenTimeExt = self:getTxt("btnClgExt/time/txtOpenTime")
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
	self._roles = {}
end

function HeartOfAoJiuClgMainView:bindEvents()
	HeartOfAoJiuClgMainView.super.bindEvents(self)
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
	GameUtil.addClickHandler(self._btnRank, GameUtil.handler(self._onClickBtnJump, self, "jumpRank"))
	GameUtil.addClickHandler(self._btnClgExt, self._onClickBtnClgExt, self)
end

function HeartOfAoJiuClgMainView:unbindEvents()
	HeartOfAoJiuClgMainView.super.unbindEvents(self)
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
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnClgExt)
end

function HeartOfAoJiuClgMainView:onEnter()
	HeartOfAoJiuClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = HeartOfAoJiuClgController.instance:getActivityId()
	end

	self._activityIdExt = 389002

	HeartofjieshenModel.instance:resetClgFinishDic()
	self:_isInChallengeTime()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = HeartOfAoJiuClgController.instance:getSubMo(self._activityId)
	self._actData = HeartOfAoJiuClgConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_HeartOfAoJiuClgGetInfoRes, self._onUpdate, self)
	HeartOfAoJiuClgController.instance:sendPM_HeartOfAoJiuClgGetInfoReq(self._activityId)
end

function HeartOfAoJiuClgMainView:onExit()
	HeartOfAoJiuClgMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	self:_unregisterRedPoints()
end

function HeartOfAoJiuClgMainView:_registerRedPoints()
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
				RedPointController.instance:regRedPoint(redGo, unpack(validRedIds))
			else
				RedPointController.instance:unregRedPoint(redGo)
			end
		end
	end
end

function HeartOfAoJiuClgMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function HeartOfAoJiuClgMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_registerRedPoints()

	local skinId = self:_getSkinId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)

				local skinId = self:_getSkinId()

				if skinId > 0 then
					MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
				end

				self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
			end
		end
	end
end

function HeartOfAoJiuClgMainView:_onUpdate()
	return
end

function HeartOfAoJiuClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function HeartOfAoJiuClgMainView:_getSkinId()
	return self._actData.skinId
end

function HeartOfAoJiuClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function HeartOfAoJiuClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function HeartOfAoJiuClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function HeartOfAoJiuClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function HeartOfAoJiuClgMainView:_onClickBtnClg()
	if not self._subMo:isInOpenTime() then
		FloatWordMgr.instance:show("不在开放时间内")

		return
	end

	UIStateManager.instance:push(ViewName.HeartOfAoJiuClgStageView, self._activityId)
end

function HeartOfAoJiuClgMainView:_onClickBtnClgExt()
	if self:_isInChallengeTime() then
		UIStateManager.instance:push(ViewName.HeartofaojiurepclgView, self._activityIdExt)
	else
		FloatWordMgr.instance:show("未在开放时间")
	end
end

function HeartOfAoJiuClgMainView:_isInChallengeTime()
	local cfg = HeartofjieshenConfig.instance:getActCfg(self._activityIdExt) or {}

	if not cfg.challengeClosedTimeRange then
		local challengeClosedTimeRange = ""
		local arr = string.split(challengeClosedTimeRange, "-") or {}
		local startStr = "0-0-0 " .. arr[2]
		local endStr = "0-0-0 " .. arr[1]
		local startDate = GameUtil.string2date(startStr)
		local endDate = GameUtil.string2date(endStr)

		self._txtOpenTimeExt.text = langPara("开启时间：%02d:%02d-%02d:%02d", startDate.hour, startDate.min, endDate.hour, endDate.min)

		return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
	end
end

function HeartOfAoJiuClgMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.HeartofaojiureprankExtView, self._activityId)
end

return HeartOfAoJiuClgMainView

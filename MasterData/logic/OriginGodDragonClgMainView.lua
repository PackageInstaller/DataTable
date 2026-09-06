-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/view/OriginGodDragonClgMainView.lua

module("logic.extensions.origingoddragonclg.view.OriginGodDragonClgMainView", package.seeall)

local OriginGodDragonClgMainView = class("OriginGodDragonClgMainView", ViewComponent)

function OriginGodDragonClgMainView:buildUI()
	OriginGodDragonClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._btnClg = self:getGo("btnClg/btn")
	self._imgPassBtnClg = self:getGo("btnClg/btn/imgPass")
	self._timeBtnClg = self:getGo("btnClg/time")
	self._txtOpenTimeBtnClg = self:getTxt("btnClg/time/txt")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._redBtnJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._redBtnJumps = {
		self._redBtnJump1,
		self._redBtnJump2,
		self._redBtnJump3,
		self._redBtnJump4
	}
	self._redDataFields = {
		"jumpRedIdOne",
		"jumpRedIdTwo",
		"jumpRedIdThree",
		"jumpRedIdFour"
	}
end

function OriginGodDragonClgMainView:bindEvents()
	OriginGodDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function OriginGodDragonClgMainView:unbindEvents()
	OriginGodDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function OriginGodDragonClgMainView:onEnter()
	OriginGodDragonClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = OriginGodDragonClgController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginGodDragonClgController.instance:getSubMo(self._activityId)
	self._actData = OriginGodDragonClgConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginGodDragonClgInfoRes, self._onUpdate, self)
	OriginGodDragonClgController.instance:sendPM_OriginGodDragonClgInfoReq(self._activityId)
end

function OriginGodDragonClgMainView:onExit()
	OriginGodDragonClgMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	self:_unregisterRedPoints()
end

function OriginGodDragonClgMainView:_registerRedPoints()
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

function OriginGodDragonClgMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function OriginGodDragonClgMainView:_onSetUI()
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

				local isInTime = OriginGodDragonClgController.instance:isInOpenTime(self._activityId)

				GameUtil.SetActive(self._timeBtnClg, not isInTime)

				local date = GameUtil.string2date(self._actData.openTime)

				self._txtOpenTimeBtnClg.text = string.format("开放时间：%02d.%02d.%02d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
			end
		end
	end
end

function OriginGodDragonClgMainView:_onUpdate()
	return
end

function OriginGodDragonClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function OriginGodDragonClgMainView:_getSkinId()
	return self._actData.skinId
end

function OriginGodDragonClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function OriginGodDragonClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OriginGodDragonClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginGodDragonClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginGodDragonClgMainView:_onClickBtnClg()
	if not OriginGodDragonClgController.instance:isInOpenTime(self._activityId) then
		FloatWordMgr.instance:show("未在开放时间内")

		return
	end

	UIStateManager.instance:push(ViewName.OriginGodDragonClgZoneView, self._activityId)
end

return OriginGodDragonClgMainView

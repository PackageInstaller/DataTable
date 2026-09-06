-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuMainView.lua

module("logic.extensions.originjiu.view.OriginJiuMainView", package.seeall)

local OriginJiuMainView = class("OriginJiuMainView", ViewComponent)

function OriginJiuMainView:buildUI()
	OriginJiuMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._btnNor = self:getGo("btnNor/btn")
	self._imgPassNor = self:getGo("btnNor/btn/imgPass")
	self._tagHasGainNor = self:getGo("btnNor/bubble/tagHasGain")
	self._btnExt = self:getGo("btnExt/btn")
	self._imgPassExt = self:getGo("btnExt/btn/imgPass")
	self._tagHasGainExt = self:getGo("btnExt/bubble/tagHasGain")
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

function OriginJiuMainView:bindEvents()
	OriginJiuMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnNor, self._onClickBtnNor, self)
	GameUtil.addClickHandler(self._btnExt, self._onClickBtnExt, self)
end

function OriginJiuMainView:unbindEvents()
	OriginJiuMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnNor)
	GameUtil.rmClickHandler(self._btnExt)
end

function OriginJiuMainView:onEnter()
	OriginJiuMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 577001
	end

	self._actData = OriginJiuConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginJiuClgInfoRes, self._onUpdate, self)
	OriginJiuController.instance:sendGetInfo(self._activityId)
end

function OriginJiuMainView:onExit()
	OriginJiuMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	self:_unregisterRedPoints()
end

function OriginJiuMainView:_registerRedPoints()
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

function OriginJiuMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function OriginJiuMainView:_onSetUI()
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

				if skinId > 0 then
					MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
				end

				self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(skinId)
			end
		end
	end
end

function OriginJiuMainView:_onUpdate()
	local extPass = OriginJiuModel.instance:isHasHistoryPassModelId(self._activityId, OriginJiuModel.ModelId_Ext)
	local norPass = OriginJiuModel.instance:isHasHistoryPassModelId(self._activityId, OriginJiuModel.ModelId_Nor)

	GameUtil.SetActive(self._imgPassExt, extPass)
	GameUtil.SetActive(self._tagHasGainExt, extPass)
	GameUtil.SetActive(self._imgPassNor, norPass)
	GameUtil.SetActive(self._tagHasGainNor, norPass)
end

function OriginJiuMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function OriginJiuMainView:_getSkinId()
	return self._actData.skinId
end

function OriginJiuMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	PetbookController.instance:previewBattle(raceId, skinId)
end

function OriginJiuMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OriginJiuMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function OriginJiuMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginJiuMainView:_onClickBtnNor()
	UIStateManager.instance:push(ViewName.OriginjiustageView, self._activityId, OriginJiuModel.ModelId_Nor)
end

function OriginJiuMainView:_onClickBtnExt()
	UIStateManager.instance:push(ViewName.OriginjiustageView, self._activityId, OriginJiuModel.ModelId_Ext)
end

return OriginJiuMainView

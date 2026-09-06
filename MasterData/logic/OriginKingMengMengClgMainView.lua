-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgMainView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgMainView", package.seeall)

local OriginKingMengMengClgMainView = class("OriginKingMengMengClgMainView", ViewComponent)

function OriginKingMengMengClgMainView:buildUI()
	OriginKingMengMengClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._buffRoot = self:getGo("buffRoot")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnNor = self:getGo("btnNor/btn")
	self._redBtnNor = self:getGo("btnNor/btn/redPoint")
	self._imgPassBtnNor = self:getGo("btnNor/btn/imgPass")
	self._itemNor = self:getGo("btnNor/bubble/item")
	self._tagHasGainNor = self:getGo("btnNor/bubble/tagHasGain")
	self._btnExt = self:getGo("btnExt/btn")
	self._redBtnExt = self:getGo("btnExt/btn/redPoint")
	self._imgPassBtnExt = self:getGo("btnExt/btn/imgPass")
	self._itemExt = self:getGo("btnExt/bubble/item")
	self._tagHasGainExt = self:getGo("btnExt/bubble/tagHasGain")
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

function OriginKingMengMengClgMainView:bindEvents()
	OriginKingMengMengClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnNor, self._onClickBtnNor, self)
	GameUtil.addClickHandler(self._btnExt, self._onClickBtnExt, self)
end

function OriginKingMengMengClgMainView:unbindEvents()
	OriginKingMengMengClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnNor)
	GameUtil.rmClickHandler(self._btnExt)
end

function OriginKingMengMengClgMainView:onEnter()
	OriginKingMengMengClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = checknumber(ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginKingMengMengClg))
	end

	if self._activityId <= 0 then
		self:close()

		return
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)

	if not self._actData then
		self:close()

		return
	end

	SignInBuffController.instance:addCommonSignInBuffView(self._buffRoot, self._viewPresentor, self._activityId)
	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgGetInfoRes, self._onUpdate, self)
	OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgGetInfoReq(self._activityId)
end

function OriginKingMengMengClgMainView:onExit()
	OriginKingMengMengClgMainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemNor)
	MaterialMgr.resetAll(self._itemExt)
	self:_unregisterRedPoints()
end

function OriginKingMengMengClgMainView:_registerRedPoints()
	for idx, redGo in ipairs(self._redBtnJumps) do
		local redField = self._redDataFields[idx]

		if self._actData then
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
			elseif not goutil.isNil(redGo) then
				GameUtil.SetActive(redGo, false)
			end
		end
	end
end

function OriginKingMengMengClgMainView:_unregisterRedPoints()
	for _, redGo in ipairs(self._redBtnJumps) do
		if not goutil.isNil(redGo) then
			RedPointController.instance:unregRedPoint(redGo)
		end
	end
end

function OriginKingMengMengClgMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_registerRedPoints()
	MaterialMgr.setCellByCfg(self._actData.normalClgPrize, self._itemNor)
	MaterialMgr.setCellByCfg(self._actData.extremePrize, self._itemExt)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
		local x, y, scale = 0, 0, 1

		if offset then
			x = checknumber(offset[1])
			y = checknumber(offset[2])
			scale = offset[3] or 1
		end

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)

		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)

		self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)
	end
end

function OriginKingMengMengClgMainView:_onUpdate()
	local isNormalPass = self._subMo:isNormalClgPass()
	local isExtremePass = self._subMo:isExtremeClgPass()

	GameUtil.SetActive(self._imgPassBtnNor, isNormalPass)
	GameUtil.SetActive(self._tagHasGainNor, isNormalPass)
	GameUtil.SetActive(self._imgPassBtnExt, isExtremePass)
	GameUtil.SetActive(self._tagHasGainExt, isExtremePass)
end

function OriginKingMengMengClgMainView:_getRaceId()
	return checknumber(PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId()))
end

function OriginKingMengMengClgMainView:_getSkinId()
	return checknumber(self._actData and self._actData.skinId)
end

function OriginKingMengMengClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	end
end

function OriginKingMengMengClgMainView:_onClickBtnIntroduce()
	local raceId = self:_getRaceId()

	if raceId > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function OriginKingMengMengClgMainView:_onClickBtnJump(key)
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		GotoMgr.gotoByString(self._actData)
	end
end

function OriginKingMengMengClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginKingMengMengClgMainView:_openStageView(viewName)
	UIStateManager.instance:push(viewName, self._activityId)
end

function OriginKingMengMengClgMainView:_onClickBtnNor()
	self:_openStageView(ViewName.OriginKingMengMengClgNormalStageView)
end

function OriginKingMengMengClgMainView:_onClickBtnExt()
	self:_openStageView(ViewName.OriginKingMengMengClgExtremeStageView)
end

return OriginKingMengMengClgMainView

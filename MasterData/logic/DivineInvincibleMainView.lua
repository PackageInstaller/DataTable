-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleMainView.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleMainView", package.seeall)

local DivineInvincibleMainView = class("DivineInvincibleMainView", ViewComponent)

function DivineInvincibleMainView:buildUI()
	DivineInvincibleMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redBtnJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redBtnJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redBtnJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._redBtnJump4 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._btnExt = self:getGo("btnExt/btn")
	self._itemcellBtnExt = self:getGo("btnExt/bubble/itemcell")
	self._imgHasGainBtnExt = self:getGo("btnExt/bubble/imgHasGain")
	self._bubbleBtnExt = self:getGo("btnExt/bubble")
	self._btnNor = self:getGo("btnNor/btn")

	self:_recordGoDefaultActive(self._jumpBtnCol)
	self:_recordGoDefaultActive(self._btnNor)
	self:_recordGoDefaultActive(self._bubbleBtnExt)
end

function DivineInvincibleMainView:bindEvents()
	DivineInvincibleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnExt, self._onClickBtnExt, self)
	GameUtil.addClickHandler(self._btnNor, self._onClickBtnNor, self)
end

function DivineInvincibleMainView:unbindEvents()
	DivineInvincibleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnExt)
	GameUtil.rmClickHandler(self._btnNor)
end

function DivineInvincibleMainView:onEnter()
	DivineInvincibleMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineInvincibleController.instance:getActivityId()
	end

	self._activityType = DivineInvincibleController.instance:getActivityType()

	local isInTime = DivineInvincibleController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)
	self._actData = DivineInvincibleConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeInfoRes, self._onUpdate, self)
	DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeInfoReq(self._activityId)
end

function DivineInvincibleMainView:onExit()
	DivineInvincibleMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellBtnExt)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
	RedPointController.instance:unregRedPoint(self._redBtnJump4)
end

function DivineInvincibleMainView:_onSetUI()
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
		},
		{
			not string.nilorempty(self._actData.jumpRedIdFour) and string.split(self._actData.jumpRedIdFour, "#"),
			self._redBtnJump4
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

	if self._isUltTrialClg then
		GameUtil.SetActive(self._jumpBtnCol, false)
		GameUtil.SetActive(self._btnNor, false)
		GameUtil.SetActive(self._bubbleBtnExt, false)
	else
		self:_refreshDefaultActive(self._jumpBtnCol)
		self:_refreshDefaultActive(self._btnNor)
		self:_refreshDefaultActive(self._bubbleBtnExt)
	end

	if not string.nilorempty(self._actData.extremePrize) then
		MaterialMgr.setCellByCfg(self._actData.extremePrize, self._itemcellBtnExt)
	else
		MaterialMgr.resetAll(self._itemcellBtnExt)
	end
end

function DivineInvincibleMainView:_onUpdate()
	GameUtil.SetActive(self._imgHasGainBtnExt, self._clgMo:isPassExtremeClg())
end

function DivineInvincibleMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineInvincibleMainView:_getSkinId()
	local data = DivineInvincibleConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.skinId or 0)
end

function DivineInvincibleMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineInvincibleMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineInvincibleMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineInvincibleMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineInvincibleMainView:_onClickBtnExt()
	if UltimateTrialController.instance:isBanInUltTrialClg(true, self._activityId) then
		return
	end

	UIStateManager.instance:push(ViewName.DivineInvincibleExtremeView, self._activityId)
end

function DivineInvincibleMainView:_onClickBtnNor()
	if self._isUltTrialClg then
		return
	end

	UIStateManager.instance:push(ViewName.DivineInvincibleNormalView, self._activityId)
end

function DivineInvincibleMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineInvincibleMainView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function DivineInvincibleMainView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

return DivineInvincibleMainView

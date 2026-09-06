-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/view/DivineFuYaoClgMainView.lua

module("logic.extensions.divinefuyaoclg.view.DivineFuYaoClgMainView", package.seeall)

local DivineFuYaoClgMainView = class("DivineFuYaoClgMainView", ViewComponent)

function DivineFuYaoClgMainView:buildUI()
	DivineFuYaoClgMainView.super.buildUI(self)

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
	self._btnJump5 = self:getGo("jumpBtnCol/btnJump5")
	self._redBtnJump5 = self:getGo("jumpBtnCol/btnJump5/redPoint")
	self._btnClg1 = self:getGo("btnClg1/btn")
	self._redClg1 = self:getGo("btnClg1/btn/redPoint")
	self._imgPassClg1 = self:getGo("btnClg1/btn/imgPass")
	self._btnClg2 = self:getGo("btnClg2/btn")
	self._redClg2 = self:getGo("btnClg2/btn/redPoint")
	self._imgPassClg2 = self:getGo("btnClg2/btn/imgPass")
	self._itemClg2 = self:getGo("btnClg2/bubble/item")
	self._imgHasGainClg2 = self:getGo("btnClg2/bubble/imgHasGain")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function DivineFuYaoClgMainView:bindEvents()
	DivineFuYaoClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnJump5, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFive"))
	GameUtil.addClickHandler(self._btnClg1, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickBtnClg2, self)
end

function DivineFuYaoClgMainView:unbindEvents()
	DivineFuYaoClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnJump5)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
end

function DivineFuYaoClgMainView:onEnter()
	DivineFuYaoClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineFuYaoClgController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)
	self._actData = DivineFuYaoClgConfig.instance:getActivityData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineFuYaoClgInfoRes, self._onUpdate, self)
	DivineFuYaoClgController.instance:sendPM_DivineFuYaoClgInfoReq(self._activityId)
end

function DivineFuYaoClgMainView:onExit()
	DivineFuYaoClgMainView.super.onExit(self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
	RedPointController.instance:unregRedPoint(self._redBtnJump4)
	RedPointController.instance:unregRedPoint(self._redBtnJump5)
	MaterialMgr.resetAll(self._itemPrize)
end

function DivineFuYaoClgMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

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
		},
		{
			not string.nilorempty(self._actData.jumpRedIdFive) and string.split(self._actData.jumpRedIdFive, "#"),
			self._redBtnJump5
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

				self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())
			end
		end
	end
end

function DivineFuYaoClgMainView:_onUpdate()
	local isPassNor = self._subMo:isPassNormalClg()

	GameUtil.SetActive(self._imgPassClg1, isPassNor)

	local isHasGainExtremePrize = self._subMo:isHasGainExtremePrize()

	GameUtil.SetActive(self._imgPassClg2, isHasGainExtremePrize)
	GameUtil.SetActive(self._imgHasGainClg2, isHasGainExtremePrize)
	MaterialMgr.setCellByCfg(self._actData.extremePrize, self._itemClg2)
end

function DivineFuYaoClgMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

function DivineFuYaoClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineFuYaoClgMainView:_getSkinId()
	return (self._actData or nil) and (self._actData.skinId or 0)
end

function DivineFuYaoClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineFuYaoClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineFuYaoClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineFuYaoClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineFuYaoClgMainView:_onClickBtnClg1()
	if self._subMo:isPassNormalClg() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineFuYaoClgNormalView, self._activityId)
end

function DivineFuYaoClgMainView:_onClickBtnClg2()
	UIStateManager.instance:push(ViewName.DivineFuYaoClgExtremeView, self._activityId)
end

return DivineFuYaoClgMainView

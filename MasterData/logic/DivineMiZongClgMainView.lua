-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgMainView.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgMainView", package.seeall)

local DivineMiZongClgMainView = class("DivineMiZongClgMainView", ViewComponent)

function DivineMiZongClgMainView:buildUI()
	DivineMiZongClgMainView.super.buildUI(self)

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
	self._btnStart = self:getGo("btnStart/btn")
	self._btnSign = self:getGo("btnSign")
	self._itemcellSign = self:getGo("btnSign/itemcell")
	self._imgHasGainSign = self:getGo("btnSign/imgHasGain")
	self._redPointBtnSign = self:getGo("btnSign/redPoint")
	self._btnGainSign = self:getGo("btnSign/btnGain")
end

function DivineMiZongClgMainView:bindEvents()
	DivineMiZongClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStrFour"))
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnGainSign, self._onClickBtnSign, self)
end

function DivineMiZongClgMainView:unbindEvents()
	DivineMiZongClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnGainSign)
end

function DivineMiZongClgMainView:onEnter()
	DivineMiZongClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineMiZongClgController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)
	self._actData = DivineMiZongClgConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGainBuffItemRes, self._handlePM_DivineMiZongClgGainBuffItemRes, self)
	DivineMiZongClgController.instance:sendPM_DivineMiZongClgGetInfoReq(self._activityId)
end

function DivineMiZongClgMainView:onExit()
	DivineMiZongClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellSign)
	RedPointController.instance:unregRedPoint(self._redBtnJump1)
	RedPointController.instance:unregRedPoint(self._redBtnJump2)
	RedPointController.instance:unregRedPoint(self._redBtnJump3)
	RedPointController.instance:unregRedPoint(self._redBtnJump4)
end

function DivineMiZongClgMainView:_handlePM_DivineMiZongClgGainBuffItemRes()
	FloatWordMgr.instance:show("领取成功")
	self:_onUpdate()
end

function DivineMiZongClgMainView:_onSetUI()
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

function DivineMiZongClgMainView:_onUpdate()
	local arr = self._clgMo:getUpgradeItem()
	local proxy = MaterialMgr.setCell(arr.matType, arr.matId, self._itemcellSign)

	if proxy then
		local num = checknumber(self._actData.dailyGainItemCount)

		proxy:setNum(num)
	end

	GameUtil.SetActive(self._imgHasGainSign, self._clgMo:isTodayGainItem())
	GameUtil.SetActive(self._redPointBtnSign, not self._clgMo:isTodayGainItem())
	GameUtil.SetActive(self._btnGainSign, not self._clgMo:isTodayGainItem())
end

function DivineMiZongClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineMiZongClgMainView:_getSkinId()
	local data = DivineMiZongClgConfig.instance:getActData(self._activityId)

	return (data or nil) and (data.skinId or 0)
end

function DivineMiZongClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineMiZongClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineMiZongClgMainView:_onClickBtnJump(key)
	local jumpToStr = self._actData[key]

	GotoMgr.gotoByString(jumpToStr)
end

function DivineMiZongClgMainView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DivineMiZongClgMainView:_onClickBtnStart()
	UIStateManager.instance:push(ViewName.DivineMiZongClgStageView, self._activityId)
end

function DivineMiZongClgMainView:_onClickBtnSign()
	if self._clgMo:isTodayGainItem() then
		FloatWordMgr.instance:show("已领取")

		return
	end

	DivineMiZongClgController.instance:sendPM_DivineMiZongClgGainBuffItemReq(self._activityId)
end

return DivineMiZongClgMainView

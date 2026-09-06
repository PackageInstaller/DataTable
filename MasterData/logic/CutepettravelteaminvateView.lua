-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelteaminvateView.lua

module("logic.extensions.cutepet.view.CutepettravelteaminvateView", package.seeall)

local CutepettravelteaminvateView = class("CutepettravelteaminvateView", ViewComponent)

function CutepettravelteaminvateView:ctor()
	CutepettravelteaminvateView.super.ctor(self)
end

function CutepettravelteaminvateView:unbindEvents()
	CutepettravelteaminvateView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function CutepettravelteaminvateView:bindEvents()
	CutepettravelteaminvateView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function CutepettravelteaminvateView:buildUI()
	CutepettravelteaminvateView.super.buildUI(self)

	self._btnClose = self:getBtn("static/btnClose")
	self._btnReward = self:getBtn("btnReward")
	self._btnTip = self:getBtn("static/btnTip")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._petCon = self:getGo("pet/petcon")
	self._imgQuality = goutil.findChildComponent(self.mainGO, "pet/info/imgQuality", "UIImageSpriteChange")
	self._imgType = goutil.findChildComponent(self.mainGO, "pet/info/imgType", "UIImageSpriteChange")
	self._txtName = self:getTxt("pet/info/txtName")
	self._txtLv = self:getTxt("pet/info/txtLevel")
	self._empty = self:getGo("emptyGo")
end

function CutepettravelteaminvateView:onExit()
	CutepettravelteaminvateView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
	self._scrollerList:dispose()

	self._invateDataList = {}

	removetimer(self._tickCd, self)
end

function CutepettravelteaminvateView:onEnter()
	CutepettravelteaminvateView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FriendInfoGeted, self._onFriendInfoGeted, self)
	self.addGEvent(self, GlobalNotify.handlePM_LoadBuddyTravelInfoResp, self._onhandlePM_LoadBuddyTravelInfoResp, self)
	self.addGEvent(self, GlobalNotify.handlePM_NotifyReceiverRespInviteMsgResp, self._PM_NotifyReceiverRespInviteMsgResp, self)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)

	self._sendInvateIndex = 0
	self._sendInvateCount = 0
	self._sendInvateMoList = {}
	self._sendInvateMoMap = {}
	self._invateDataList = {}
	self._invateCds = CutePetController.instance:getTeamInvateCDList()
	self._selectMo = CutePetModel.instance:getTeamTravelSelectMo()

	local params = self:getOpenParam() or {}

	self._inviteUserId = checknumber(params[1])

	self._imgQuality:SetState(self._selectMo.curQuality - 1)

	local raceCfg = CutePetConfig.instance:getCutePetById(self._selectMo.config.raceId)

	self._imgType:SetState(raceCfg.type - 1)

	self._txtName.text = self._selectMo.name
	self._txtLv.text = self._selectMo.curLvl

	CutePetModelMgr.instance:resetModel(1, self._selectMo.config.modelId)
	CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._selectMo.config.raceId))

	self._dailyTravelCount = CutePetConfig.instance:getCommonValue("TravelDailyMaxCount", true)

	local isInTime, txtTime = CutePetController.instance:updateTimeTip(CutePetConfig.instance:getPrivilegeCommonValue("PrivilegeTimePlan_TravelDailyMaxCount", false))

	if isInTime == true then
		self._dailyTravelCount = CutePetConfig.instance:getPrivilegeCommonValue("Privilege_TravelDailyMaxCount", true)
	end

	self:_sendGetBuddyInfo()
	settimer(1, self._tickCd, self, true)
end

function CutepettravelteaminvateView:_onClickbtnClose()
	local isPairing = false
	local waitTime = CutePetConfig.instance:getCommonValue("TravelBuddyPairingWaitInviteMsgTimeoutSecd", true)
	local now = ServerTime.now()

	for i, v in pairs(self._invateCds) do
		local isInCd = v and waitTime > now - v

		if isInCd == true then
			isPairing = true
		end
	end

	if isPairing == true then
		CutePetGardenAgent.instance:sendPM_CutePetTravelCancelBuddyPairingReq()
	end

	self:close()
end

function CutepettravelteaminvateView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.CutePetSurpriseView)
end

function CutepettravelteaminvateView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("cute_pet_travel_team_invate_rule")
end

function CutepettravelteaminvateView:_sendGetBuddyInfo()
	FriendAgent.instance:sendGetBuddyInfoReq()
end

function CutepettravelteaminvateView:_onFriendInfoGeted()
	local mos = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)
	local result = {}

	for i, v in ipairs(mos) do
		if v:getIsOnline() then
			table.insert(result, v)
		end
	end

	self._sendInvateIndex = 0
	self._sendInvateCount = #result
	self._sendInvateMoList = result

	self:_startSendInvate()
end

function CutepettravelteaminvateView:_startSendInvate()
	local perSendCount = 20
	local buddyIds = {}
	local count = math.min(self._sendInvateCount - self._sendInvateIndex, perSendCount)

	for i = self._sendInvateIndex + 1, self._sendInvateIndex + count do
		local mo = self._sendInvateMoList[i]

		self._sendInvateMoMap[mo.simpleInfo.headInfo.userId] = mo

		table.insert(buddyIds, mo.simpleInfo.headInfo.userId)
	end

	self._sendInvateIndex = self._sendInvateIndex + count

	if #buddyIds > 0 then
		CutePetGardenAgent.instance:sendPM_LoadBuddyTravelInfoReq(buddyIds)
	end
end

function CutepettravelteaminvateView:_onhandlePM_LoadBuddyTravelInfoResp(msg)
	if self._sendInvateIndex < self._sendInvateCount then
		self:_startSendInvate()
	end

	local count = table.nums(self._invateDataList)

	for i, v in ipairs(msg.buddyTravelInfo) do
		count = count + 1

		local isCanTravel = checknumber(v.todayHasTravelCount) < self._dailyTravelCount

		if v.canTravelCutePetCount > 0 and isCanTravel then
			self._invateDataList[v.buddyId] = {
				travelInfo = v,
				headInfo = self._sendInvateMoMap[v.buddyId].simpleInfo.headInfo
			}
		end
	end

	self:_updateInvateView()
end

function CutepettravelteaminvateView:_updateInvateView()
	local list = table.values(self._invateDataList)

	if self._inviteUserId > 0 then
		local newList = {}
		local hit = false

		for i, v in ipairs(list) do
			if not hit and checknumber(v.headInfo.userId) == self._inviteUserId then
				hit = true

				table.insert(newList, 1, v)
			else
				table.insert(newList, v)
			end
		end

		self._curViewDatas = newList
	else
		self._curViewDatas = list
	end

	if self._curViewDatas and #self._curViewDatas > 0 then
		GameUtil.SetActive(self._empty, false)
	else
		GameUtil.SetActive(self._empty, true)
	end

	self:_reloadDatas()
end

function CutepettravelteaminvateView:_updateCell(view, cell, data, tag)
	local btnInvate = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnInvate")
	local goHead = goutil.findChild(cell.gameObject, "head")
	local txtLeftTime = goutil.findChildTextComponent(cell.gameObject, "txtLeftTime")
	local txtLevel = goutil.findChildTextComponent(cell.gameObject, "txtLevel")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtCD = goutil.findChildTextComponent(cell.gameObject, "txtCD")
	local recommendGo = goutil.findChild(cell.gameObject, "recommend")
	local lastTime = self._invateCds[data.headInfo.userId]
	local now = ServerTime.now()
	local isInCd = lastTime and now < lastTime

	goutil.setActive(btnInvate.gameObject, not isInCd)
	GameUtil.SetActive(txtCD, isInCd)
	self:_unProxyCDTxt(txtCD)

	if txtCD and isInCd then
		txtCD.text = lastTime - now

		self:_proxyCDTxt(txtCD, lastTime)
	end

	txtName.text = data.headInfo.userName
	txtLevel.text = data.headInfo.playerLv
	txtLeftTime.text = string.format("可出游宠物：%s", data.travelInfo.canTravelCutePetCount)

	HeadItemController.instance:setHeadCellByInfo(goHead, data.headInfo, true)
	btnInvate:AddClickListener(function()
		self:_onClickInvite(data.headInfo.userId)
	end)
	goutil.setActive(recommendGo, self._inviteUserId > 0 and self._inviteUserId == checknumber(data.headInfo.userId))
end

function CutepettravelteaminvateView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local txtCD = goutil.findChildTextComponent(cell.gameObject, "txtCD")

	HeadItemController.instance:resetHeadCell(goHead)
	self:_unProxyCDTxt(txtCD)
end

function CutepettravelteaminvateView:_proxyCDTxt(cdTxt, lastTime)
	self._cdTxtList[cdTxt] = lastTime
end

function CutepettravelteaminvateView:_unProxyCDTxt(cdTxt)
	self._cdTxtList[cdTxt] = nil
end

function CutepettravelteaminvateView:_tickCd()
	local now = ServerTime.now()
	local cd = 0

	if self._cdTxtList then
		for cdTxt, lastTime in pairs(self._cdTxtList) do
			cd = lastTime - now

			if lastTime - now <= 0 then
				self:_reloadDatas()

				return
			end

			if cd > CutePetConfig.instance:getCommonValue("TravelBuddyPairingWaitInviteMsgTimeoutSecd", true) then
				local date = GameUtil.time2date(cd)

				cdTxt.text = langPara("旅行社打扫中\n%d:%2d:%2d", date.hour, date.min, date.sec)
			else
				cdTxt.text = cd
			end
		end
	end
end

function CutepettravelteaminvateView:_reloadDatas()
	self._cdTxtList = {}
	self._cdTxtListTempAdd = {}
	self._invateCds = CutePetController.instance:getTeamInvateCDList()

	self._scrollerList:reloadData(self._curViewDatas)
end

function CutepettravelteaminvateView:_onClickInvite(userId)
	local friendMo = FriendModel.instance:getFriendMo(userId)

	if friendMo:getIsOnline() == true then
		CutePetController.instance:sendPM_CutePetTravelInviteBuddyPairingReq(self._selectMo.id, userId)

		self.isPairing = true

		self:_reloadDatas()
	else
		FloatWordMgr.instance:show(lang("对方已下线"))
	end
end

function CutepettravelteaminvateView:_PM_NotifyReceiverRespInviteMsgResp(msg)
	if msg.accept == false then
		self._resultCode = self._resultCode or usingnow("logicconfig.config.t_lang_tip_result_code")

		local key = msg.rejectReason and checknumber(msg.rejectReason) ~= 0 and "rc_" .. checknumber(msg.rejectReason) or nil

		if key ~= nil and self._resultCode[key] then
			local langKey = "content" .. LanguageMgr.instance:getLanguageType()
			local msg = self._resultCode[key][langKey]

			if not string.nilorempty(msg) then
				FloatWordMgr.instance:show(msg)
			else
				FloatWordMgr.instance:show(lang("十分遗憾，对方拒绝了本次出游邀请！"))
			end
		else
			FloatWordMgr.instance:show(lang("十分遗憾，对方拒绝了本次出游邀请！"))
		end
	end
end

return CutepettravelteaminvateView

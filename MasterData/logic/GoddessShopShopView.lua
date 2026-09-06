-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/view/GoddessShopShopView.lua

module("logic.extensions.goddessshop.view.GoddessShopShopView", package.seeall)

local GoddessShopShopView = class("GoddessShopShopView", ViewComponent)

function GoddessShopShopView:buildUI()
	GoddessShopShopView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnGif = self:getGo("btnGif")
	self._btnTrigger = self:getGo("btnTrigger")
	self._con = self:getGo("con")
	self._bubbleRoot = self:getGo("bubbleRoot")
	self._btnChat = self:getGo("btnChat/btn")
	self._txtFeelChat = self:getFormatTxt("btnChat/txtFeel")
	self._txtTimesChat = self:getFormatTxt("btnChat/txtTimes")
	self._txtInvest = self:getFormatTxt("infoCol/txtInvest")
	self._txtNextStep = self:getFormatTxt("infoCol/txtNextStep")
	self._txtNextUnlock = self:getFormatTxt("infoCol/txtNextUnlock")
	self._txtGet = self:getFormatTxt("infoCol/txtGet")
	self._txtCurStep = self:getFormatTxt("infoCol/txtCurStep")
	self._btnInvest = self:getGo("infoCol/btnInvest")
	self._redBtnInvest = self:getGo("infoCol/btnInvest/redpoint")
end

function GoddessShopShopView:getFormatTxt(field)
	local txt = self:getTxt(field)

	self._defaultStrs = self._defaultStrs or {}
	self._defaultStrs[txt] = txt.text

	return txt
end

function GoddessShopShopView:setFormatTxt(txt, ...)
	local defaultStr = self._defaultStrs[txt]

	txt.text = string.format(defaultStr, ...)
end

function GoddessShopShopView:bindEvents()
	GoddessShopShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnInvest, self._onClickBtnInvest, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickBtnChat, self)
	GameUtil.addClickHandler(self._btnGif, self._onClickBtnGif, self)
	GameUtil.addClickHandler(self._btnTrigger, self._onClickBtnTrigger, self)
end

function GoddessShopShopView:unbindEvents()
	GoddessShopShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInvest)
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnGif)
	GameUtil.rmClickHandler(self._btnTrigger)
end

function GoddessShopShopView:onEnter()
	GoddessShopShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._girlId = checknumber(params[2])

	GoddessShopController.instance:enterInMgr(self._activityId)

	local isInTime = GoddessShopController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = GoddessShopController.instance:getActivityType()
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._actData = GoddessShopConfig.instance:getActData(self._activityId)
	self._girlData = GoddessShopConfig.instance:getGirlData(self._activityId, self._girlId)

	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SurroundByDreamGirlChatRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopFetterUpdate, self._handleFetterUpdate, self)
	self.addGEvent(self, GlobalNotify.SurroundByDreamGirlShopToTryReqInfo, self._surroundByDreamGirlShopToTryReqInfo, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	self._skinId = self._girlData.skinId

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self._skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._skinId, self._con, scale, nil, true, modelCfg[1], y)

				self:_onUpdate()
				self:_tryPlayFetterStoryId()
			end
		end
	end
end

function GoddessShopShopView:onExit()
	GoddessShopShopView.super.onExit(self)
	GoddessShopController.instance:exitInMgr(self._activityId)
	GlobalDispatcher:dispatch(GlobalNotify.CloseBubble)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
end

function GoddessShopShopView:_surroundByDreamGirlShopToTryReqInfo()
	GoddessShopController.instance:sendPM_SurroundByDreamGirlInfoReq(self._activityId)
end

function GoddessShopShopView:_handleFetterUpdate()
	self:_onUpdateUI()
	self:_tryPlayFetterStoryId()
end

function GoddessShopShopView:_onEndStory(storyId, isAllEnd)
	if not isAllEnd then
		return
	end

	self:_tryPlayFetterStoryId()
end

function GoddessShopShopView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GoddessShopShopView:_onUpdateData()
	return
end

function GoddessShopShopView:_onUpdateUI()
	local investLv = self._goddessShopMo:getInvestLvInShop(self._girlId)
	local chatTimes = self._goddessShopMo:getTodayChatTimesInShop(self._girlId)
	local fetter = self._goddessShopMo:getFetterInShop(self._girlId)
	local leftChatTimes = self._goddessShopMo:getLeftChatTimesInShop(self._girlId)
	local nextInvestLv = investLv + 1
	local investData = GoddessShopConfig.instance:getGirlInvestData(self._activityId, self._girlId, investLv)
	local nextInvestData = GoddessShopConfig.instance:getGirlInvestData(self._activityId, self._girlId, nextInvestLv)

	if nextInvestData then
		self:setFormatTxt(self._txtNextStep, nextInvestData.shopSizeDesc)
		self:setFormatTxt(self._txtNextUnlock, nextInvestData.propName)
	else
		self:setFormatTxt(self._txtNextStep, "无")
		self:setFormatTxt(self._txtNextUnlock, "无")
	end

	self:setFormatTxt(self._txtCurStep, investData.shopSizeDesc)
	self:setFormatTxt(self._txtInvest, investData.cost)
	self:setFormatTxt(self._txtGet, investData.moneyAddSpeed * 60)
	self:setFormatTxt(self._txtTimesChat, leftChatTimes)

	local feelData = GoddessShopConfig.instance:getFeelData(self._activityId, self._girlId, fetter)
	local name = feelData and feelData.name

	if not string.nilorempty(name) then
		self:setFormatTxt(self._txtFeelChat, fetter, "【" .. name .. "】")
	else
		self:setFormatTxt(self._txtFeelChat, fetter, "")
	end

	local isCanInvest = self._goddessShopMo:isCanInvestLvInShop(self._girlId)

	GameUtil.SetActive(self._redBtnInvest, isCanInvest)
end

function GoddessShopShopView:_tryPlayFetterStoryId()
	local key = string.format("GoddessShopFeelId_%s_%s", self._activityId, self._girlId)
	local oldFeelId = checknumber(GameUtil.getUserData(key))
	local fetter = self._goddessShopMo:getFetterInShop(self._girlId)
	local feelData = GoddessShopConfig.instance:getFeelData(self._activityId, self._girlId, fetter)
	local curFeelId = feelData.feelId
	local list = {}

	for id = oldFeelId + 1, curFeelId do
		local data = GoddessShopConfig.instance:getFeelDataById(self._activityId, self._girlId, id)
		local storyId = data.storyId

		if storyId > 0 then
			table.insert(list, data)
		end
	end

	if #list > 0 then
		for id = 1, #list - 2 do
			local data = table.remove(list, 1)

			if data then
				local feelId = data.feelId

				GameUtil.saveUserData(key, feelId)
			end
		end

		local data = table.remove(list, 1)

		if data then
			local storyId = data.storyId
			local feelId = data.feelId

			GameUtil.saveUserData(key, feelId)
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end
	end
end

function GoddessShopShopView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actData.ruleKeyMain)
end

function GoddessShopShopView:_onClickBtnInvest()
	UIStateManager.instance:push(ViewName.GoddessShopShopInvestView, self._activityId, self._girlId)
end

function GoddessShopShopView:_onClickBtnChat()
	UIStateManager.instance:push(ViewName.GoddessShopShopChatView, self._activityId, self._girlId)
end

function GoddessShopShopView:_onClickBtnGif()
	UIStateManager.instance:push(ViewName.GoddessShopShopGoodsView, self._activityId, self._girlId)
end

function GoddessShopShopView:_onClickBtnTrigger()
	if self._skinId > 0 then
		local pos = self._bubbleRoot.transform.position

		PetCvController.instance:playPetCv(self._skinId, nil, true, pos)
	end
end

return GoddessShopShopView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elvesrevealed/view/ElvesRevealedMainView.lua

module("logic.extensions.elvesrevealed.view.ElvesRevealedMainView", package.seeall)

local ElvesRevealedMainView = class("ElvesRevealedMainView", ViewComponent)

function ElvesRevealedMainView:ctor()
	ElvesRevealedMainView.super.ctor(self)
end

function ElvesRevealedMainView:unbindEvents()
	ElvesRevealedMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnNext)
	GameUtil.rmClickHandler(self._btnGoto1)
	GameUtil.rmClickHandler(self._btnGoto2)
	GameUtil.rmClickHandler(self._btnPicRule)
end

function ElvesRevealedMainView:bindEvents()
	ElvesRevealedMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPreBtn, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNextBtn, self)
	GameUtil.addClickHandler(self._btnPicRule, self._onClickPicRule, self)
end

function ElvesRevealedMainView:buildUI()
	ElvesRevealedMainView.super.buildUI(self)

	self._roleCon = self:getGo("role")
	self._imgSlogan = self:getGo("imgSlogan")
	self._petInfo = self:getGo("petInfo")
	self._imgPetQuality = self:getGo("petInfo/rare/img"):GetComponent("UIImageSpriteChange")
	self._txtTime = self:getTxt("txtTime/txt")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnPre = self:getBtn("btnPre")
	self._btnNext = self:getBtn("btnNext")
	self._btnGoto1 = self:getBtn("btnGoto1")
	self._btnGoto2 = self:getBtn("btnGoto2")
	self._rpBtnPre = self:getGo("btnPre/redpoint")
	self._rpBtnNext = self:getGo("btnNext/redpoint")
	self._rpBtnGoto1 = self:getGo("btnGoto1/redpoint")
	self._rpBtnGoto2 = self:getGo("btnGoto2/redpoint")
	self._btnPicRule = self:getGo("btnPicRule")
end

function ElvesRevealedMainView:onExit()
	ElvesRevealedMainView.super.onExit(self)
	GameUtil.saveUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_ID, self._curTabId)
	uGuiUtil.clearImage(self._imgSlogan)
	self:_clearRedPoint()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function ElvesRevealedMainView:onEnter()
	ElvesRevealedMainView.super.onEnter(self)
	self:_initViewData()
end

function ElvesRevealedMainView:_initViewData()
	self._localDataKey = "elvesrevealed_"

	self:_initActivityId()
	self:_initTabConfigs()

	local lastTabId = GameUtil.getUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_ID)

	self._curTabId = lastTabId or 1

	local showChangeTabBtn = #self._tabCfgs > 1

	goutil.setActive(self._btnPre.gameObject, showChangeTabBtn)
	goutil.setActive(self._btnNext.gameObject, showChangeTabBtn)
	self:_refreshView()
end

function ElvesRevealedMainView:_initActivityId()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElvesRevealed)
end

function ElvesRevealedMainView:_initTabConfigs()
	self._tabCfgs = ElvesRevealedConfig.instance:getTabCfgsByActId(self._activityId)

	if TableUtil.isTableEmpty(self._tabCfgs) then
		TipsFacade.instance:showTips("活动未配置")
		self:close()

		return
	end
end

function ElvesRevealedMainView:_refreshView()
	self:_refreshTabTime()
	self:_refreshRedPoint()
	self:_refreshMainUI()
	self:_refreshBtnClickHandler()
	print("curTabId = ", self._curTabId)
end

function ElvesRevealedMainView:_refreshTabTime()
	local curTagCfg = self._tabCfgs[self._curTabId]

	if not curTagCfg then
		self._curTabId = 1
		curTagCfg = self._tabCfgs[self._curTabId]
	end

	local startTimeStemp = curTagCfg.startTime
	local endTimeStemp = curTagCfg.endTime
	local startTime = GameUtil.string2date(startTimeStemp)
	local endTime = GameUtil.string2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function ElvesRevealedMainView:_refreshRedPoint()
	self:_clearRedPoint()

	local rpId1 = string.split(self._tabCfgs[self._curTabId].guessViewJumpStr, "#")[4]
	local rpId2 = string.split(self._tabCfgs[self._curTabId].TrialsViewJumpStr, "#")[4]

	RedPointController.instance:regRedPoint(self._rpBtnGoto1, rpId1)
	RedPointController.instance:regRedPoint(self._rpBtnGoto2, rpId2)

	local needRp = ElvesRevealedController.instance:checkRedPoints(self._curTabId)

	goutil.setActive(self._rpBtnNext, needRp)
end

function ElvesRevealedMainView:_refreshMainUI()
	local tabConfig = self._tabCfgs[self._curTabId]

	goutil.setActive(self._imgSlogan, false)

	local titleName = tabConfig.titleName

	if not tabConfig.sloganPos then
		local sloganPos = {}

		if self._imgSlogan then
			local isNeedSetBg = not string.nilorempty(titleName)

			local function localFunc()
				local image = self._imgSlogan:GetComponent(goutil.Type_UIImage)

				if image then
					image:SetNativeSize()
				end

				goutil.setActive(self._imgSlogan, true)
				GameUtil.setAnchoredPos(self._imgSlogan, checknumber(sloganPos[1]), checknumber(sloganPos[2]))
			end

			if isNeedSetBg then
				local bgUrl = string.format("ui/bigbg/views/elvesrevealed/%s.png", titleName)

				uGuiUtil.setSpriteToImage(self._imgSlogan, uGuiUtil.SpriteType.BigBg, bgUrl, localFunc)
			end

			self._txtPetName.text = tabConfig.petName

			self._imgPetQuality:SetState(tabConfig.petQuality - 1)

			if self._role then
				self._role = RoleObjectPool.instance:removeRole(self._role)
				self._role = nil
			end

			local showSkinId = tabConfig.showSkinId
			local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("baglihui", showSkinId)

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, showSkinId, self._roleCon, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])

			goutil.setActive(self._btnPicRule, not GameUtil.isEmptyString(tabConfig.rulePicPath))
		end
	end
end

function ElvesRevealedMainView:_refreshBtnClickHandler()
	GameUtil.rmClickHandler(self._btnGoto1)
	GameUtil.rmClickHandler(self._btnGoto2)
	GameUtil.addClickHandler(self._btnGoto1, self._onClickGotoBtn1, self)
	GameUtil.addClickHandler(self._btnGoto2, self._onClickGotoBtn2, self)
end

function ElvesRevealedMainView:_clearRedPoint()
	RedPointController.instance:unregRedPoint(self._rpBtnGoto1)
	RedPointController.instance:unregRedPoint(self._rpBtnGoto2)

	if TableUtil.isTableEmpty(self._newTabsIdx) then
		self._newTabsIdx = {}
	end
end

function ElvesRevealedMainView:_onClickTipBtn()
	TipsFacade.instance:openRulesView("elvesrevealedmainview_rule")
end

function ElvesRevealedMainView:_onClickPreBtn()
	print("ElvesRevealedMainView:_onClickPreBtn")

	if self._curTabId - 1 > 0 then
		self._curTabId = self._curTabId - 1 or #self._tabCfgs
	end

	GameUtil.saveUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_ID, self._curTabId)
	self:_refreshView()
end

function ElvesRevealedMainView:_onClickNextBtn()
	print("ElvesRevealedMainView:_onClickNextBtn")

	if self._curTabId + 1 <= #self._tabCfgs then
		self._curTabId = self._curTabId + 1 or 1
	end

	GameUtil.saveUserData(ElvesRevealedController.LOLOCAL_DATA_KEY_LAST_TAB_ID, self._curTabId)
	self:_refreshView()
end

function ElvesRevealedMainView:_onClickGotoBtn1()
	local gotoStr = self._tabCfgs[self._curTabId].guessViewJumpStr

	if string.nilorempty(gotoStr) then
		FloatWordMgr.instance:show("未配置跳转指令")

		return
	end

	gotoStr = string.split(gotoStr, "#")

	local viewName, actId, imgCh = gotoStr[2], gotoStr[3], gotoStr[5]

	UIStateManager.instance:push(viewName, actId, imgCh)
end

function ElvesRevealedMainView:_onClickGotoBtn2()
	local gotoStr = self._tabCfgs[self._curTabId].TrialsViewJumpStr

	if string.nilorempty(gotoStr) then
		FloatWordMgr.instance:show("未配置跳转指令")

		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function ElvesRevealedMainView:_onClickPicRule()
	local tabConfig = self._tabCfgs[self._curTabId]

	UIStateManager.instance:push(ViewName.ElvesrevealedPicruleView, tabConfig.rulePicPath)
end

return ElvesRevealedMainView

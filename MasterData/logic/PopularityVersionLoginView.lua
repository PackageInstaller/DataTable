-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityVersionLoginView.lua

module("logic.extensions.popularitylist.view.PopularityVersionLoginView", package.seeall)

local PopularityVersionLoginView = class("PopularityVersionLoginView", ViewComponent)

function PopularityVersionLoginView:buildUI()
	PopularityVersionLoginView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._versionScrollerview = goutil.findChild(self.mainGO, "versionScrollerview")
	self._versionContent = goutil.findChild(self.mainGO, "versionScrollerview/Viewport/Content")
	self._versionCol = goutil.findChild(self.mainGO, "versionScrollerview/Viewport/Content/versionCol")
	self._lineCol = goutil.findChild(self.mainGO, "versionScrollerview/Viewport/Content/lineCol")
	self._tuDingCol = goutil.findChild(self.mainGO, "versionScrollerview/Viewport/Content/tuDingCol")
	self._versionGoList = GameUtil.getChildren(self._versionCol)
	self._lineGoList = GameUtil.getChildren(self._lineCol)
	self._tuDingGoList = GameUtil.getChildren(self._tuDingCol)
end

function PopularityVersionLoginView:bindEvents()
	PopularityVersionLoginView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function PopularityVersionLoginView:unbindEvents()
	PopularityVersionLoginView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function PopularityVersionLoginView:onEnter()
	PopularityVersionLoginView.super.onEnter(self)

	self._activityId = PopularityListController.instance:getCurActivityId()
	self._activityType = PopularityListController.instance:getCurActivityType()

	local isInTime = PopularityListController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.PopularityListGetSkinVoteCountsRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PopularityListSkinVoteGainYearVersionPrizeRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
	PopularityListController.instance:sendPM_GetSkinVoteCountsReq(self._activityId)
end

function PopularityVersionLoginView:onExit()
	PopularityVersionLoginView.super.onExit(self)
	self:_onClear()
end

function PopularityVersionLoginView:_onSetUI()
	return
end

function PopularityVersionLoginView:_onUpdate()
	self:_onUpdateVersionColUI()
end

function PopularityVersionLoginView:_onClear()
	self:_clearVersionColUI()
end

function PopularityVersionLoginView:_onUpdateVersionColUI()
	local cfg = PopularityListConfig.instance:getPlYearVersionCfg(self._activityId) or {}
	local length = #cfg

	for idx, data in ipairs(cfg) do
		local mainGo = self._versionGoList[idx]

		if goutil.isNil(mainGo) then
			printError("预制为空，请联系开发增加( activityId=%s, versionId=%s )", self._activityId, data.versionId)
		else
			self:_updateVersionCell(idx, mainGo, data)
		end
	end

	for idx, mainGo in ipairs(self._versionGoList) do
		GameUtil.SetActive(mainGo, idx <= length)
	end

	for idx, mainGo in ipairs(self._lineGoList) do
		GameUtil.SetActive(mainGo, idx <= length)
	end

	for idx, mainGo in ipairs(self._tuDingGoList) do
		GameUtil.SetActive(mainGo, idx <= length)
	end
end

function PopularityVersionLoginView:_clearVersionColUI()
	for _, mainGo in pairs(self._versionGoList) do
		self:_clearVersionCell(mainGo)
	end
end

function PopularityVersionLoginView:_updateVersionCell(index, mainGo, data)
	local versionId = data.versionId
	local redId = PopularityListController.instance:getRedIdOfLoginVersionPrize(self._activityId, versionId)
	local isVersionLogin = PopularityListController.instance:isVersionLogin(self._activityId, versionId)
	local isHasGain = PopularityListController.instance:isHasGainLoginVersionPrize(self._activityId, versionId)
	local isCanGain = PopularityListController.instance:isCanGetPrizeOfLoginVersion(self._activityId, versionId)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local canGain = goutil.findChild(mainGo, "canGain")
	local notLogin = goutil.findChild(mainGo, "notLogin")

	GameUtil.SetActive(canGain, isCanGain)
	GameUtil.SetActive(notLogin, not isVersionLogin)

	txtName.text = data.versionName

	self:_loadBigBg(icon, data.iconPath)
	GameUtil.addClickHandler(head, GameUtil.handler(self._onClickVersionCell, self, versionId))
end

function PopularityVersionLoginView:_clearVersionCell(mainGo)
	local head = goutil.findChild(mainGo, "head")
	local icon = goutil.findChild(mainGo, "head/icon")

	GameUtil.rmClickHandler(head)
	self:_unLoadBigBg(icon)
end

function PopularityVersionLoginView:_onClickVersionCell(versionId)
	UIStateManager.instance:push(ViewName.PopularityVersionLoginDetailView, self._activityId, versionId)
end

function PopularityVersionLoginView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function PopularityVersionLoginView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function PopularityVersionLoginView:_onClickBtnTip()
	local key = PopularityListConfig.instance:getPlCommonValue(self._activityId, "ruleKeyRecord")

	TipsFacade.instance:openRulesView(key)
end

return PopularityVersionLoginView

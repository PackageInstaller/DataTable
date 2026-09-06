-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanSignView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanSignView", package.seeall)

local DivineCiYuanSignView = class("DivineCiYuanSignView", ViewComponent)

function DivineCiYuanSignView:ctor()
	DivineCiYuanSignView.super.ctor(self)
end

function DivineCiYuanSignView:unbindEvents()
	DivineCiYuanSignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSign)
	GameUtil.rmClickHandler(self._btnClearance)

	for tabId, tab in ipairs(self._tabList) do
		GameUtil.rmClickHandler(tab.btn)
	end
end

function DivineCiYuanSignView:bindEvents()
	DivineCiYuanSignView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSign, self._onClickSign, self)
	GameUtil.addClickHandler(self._btnClearance, self._onClickClearance, self)

	for tabId, tab in ipairs(self._tabList) do
		GameUtil.addClickHandler(tab.btn, GameUtil.handler(self._onClickTab, self, tabId))
	end
end

function DivineCiYuanSignView:buildUI()
	DivineCiYuanSignView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnsGroup = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtSign = self:getTxt("btns/btnSign/txt")
	self._txtProgress = self:getTxt("txtProgress")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnSign = self:getBtn("btns/btnSign")
	self._btnClearance = self:getBtn("btns/btnClearance")
	self._tabList = {}

	for tabId = 1, 2 do
		local tab = {}

		tab.lock = self:getGo("btnSign_" .. tabId .. "/lock")
		tab.btn = self:getBtn("btnSign_" .. tabId)
		tab.change = tab.btn:GetComponent(typeof(UIChangeGroup))

		table.insert(self._tabList, tab)
	end

	self._signDayList = {}

	for dayId = 1, 7 do
		local signDay = {}

		signDay.go = self:getGo("sign/day_" .. dayId)
		signDay.lock = self:getGo("sign/day_" .. dayId .. "/lock")

		table.insert(self._signDayList, signDay)
	end
end

function DivineCiYuanSignView:onExit()
	DivineCiYuanSignView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function DivineCiYuanSignView:onEnter()
	DivineCiYuanSignView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCiYuan)
	self._selectTabId = 1

	self.addGEvent(self, GlobalNotify.DivineCiYuanGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanUniversalSignInRes, self._sendGetInfoReq, self)
	self:_sendGetInfoReq()
end

function DivineCiYuanSignView:_sendGetInfoReq()
	DivineCiYuanController.instance:sendPM_DivineCiYuanGetInfoReq(self._activityId)
end

function DivineCiYuanSignView:_refresh()
	self:_onClickTab(self._selectTabId)
end

function DivineCiYuanSignView:_refreshTab()
	for tabId, tab in ipairs(self._tabList) do
		local isUnLock = DivineCiYuanController.instance:isUnLockSign(self._activityId, tabId)

		GameUtil.SetActive(tab.lock, not isUnLock)
		tab.change:SetState(self._selectTabId == tabId and 1 or 0)
	end
end

function DivineCiYuanSignView:_refreshSign()
	for dayId, signDay in ipairs(self._signDayList) do
		local signCfg = DivineCiYuanConfig.instance:getUniversalSignCfgById(self._activityId, self._selectTabId, dayId)
		local buffCfg = DivineCiYuanConfig.instance:getBuffCfg(signCfg.buffId)
		local isUnLock = DivineCiYuanController.instance:isUnLockSignDay(self._activityId, self._selectTabId, dayId)

		GameUtil.SetActive(signDay.lock, not isUnLock)
	end

	self._signCfg = DivineCiYuanConfig.instance:getUniversalSignCfg(self._activityId, self._selectTabId)
	self._txtProgress.text = string.format("当前激活进度：%d/%d", self._signDays, #self._signCfg)
	self._txtDesc.text = "未激活"

	if self._signDays > 0 then
		local buffCfg = DivineCiYuanConfig.instance:getBuffCfg(self._signCfg[self._signDays].buffId)

		self._txtDesc.text = buffCfg.desc
	end

	self._isHasOneKey = DivineCiYuanModel.instance:getHasOneKeySignIn()

	local actCfg = DivineCiYuanConfig.instance:getActCfgById(self._activityId)
	local nowTime = ServerTime.now()
	local isCanOneKey = nowTime >= GameUtil.string2time(actCfg.universalOneKeySignInOpenTime)

	if self._isHasOneKey then
		self._txtSign.text = "已全部点亮"
	elseif self._hasSignToday then
		self._txtSign.text = "今日已点亮"
	end

	self._txtSign.text = "立即点亮"

	uGuiUtil.setGoGrayState(self._btnSign.gameObject, self._hasSignToday or self._isHasOneKey)
	GameUtil.SetActive(self._btnClearance.gameObject, not self._isHasOneKey and isCanOneKey)
	self._btnsGroup:Layout()
end

function DivineCiYuanSignView:_playEffect()
	local effectPath = "20230929/shenyaociyuanlong/fx_ui_shenyaociyuanlong_dianliang.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, false, nil, nil, nil, self)

	self._pmEff:setParent(self._signDayList[4].go.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function DivineCiYuanSignView:_onClickTab(tabId)
	local isUnlock = DivineCiYuanController.instance:isUnLockSign(self._activityId, tabId)

	if not isUnlock then
		FloatWordMgr.instance:show("点亮全部次元之力且通关次元试炼后，可解锁逆次元之力及逆次元试炼关卡")

		return
	end

	self._signDays, self._hasSignToday = DivineCiYuanController.instance:getSignInfo(self._activityId, tabId)
	self._selectTabId = tabId

	self:_refreshTab()
	self:_refreshSign()
end

function DivineCiYuanSignView:_onClickSign()
	if self._isHasOneKey then
		FloatWordMgr.instance:show("已全部点亮")

		return
	end

	if self._hasSignToday then
		FloatWordMgr.instance:show("明天再来点亮吧")

		return
	end

	local signDays = DivineCiYuanController.instance:getSignInfo(self._activityId, self._selectTabId)
	local cnt = #DivineCiYuanConfig.instance:getUniversalSignCfg(self._activityId, self._selectTabId)

	if cnt <= signDays then
		if self._selectTabId == 1 then
			FloatWordMgr.instance:show("当前页面签到已满，明天再来吧")
		else
			FloatWordMgr.instance:show("当前页面签到已满")
		end

		return
	end

	DivineCiYuanController.instance:sendPM_DivineCiYuanUniversalSignInReq(self._activityId, self._selectTabId)
	self:_playEffect()
end

function DivineCiYuanSignView:_onClickClearance()
	local price = DivineCiYuanController.instance:getRemainSignPrice(self._activityId)

	if string.nilorempty(price) then
		printError("price is nil")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(price)
	local matName = MaterialMgr.getMaterialsNameByCfg(price)
	local tips = string.format("是否确认消耗<color=#eb4642>%s*%d</color>一键激活剩余的次元之力吗？\nps：价格根据当前次元之力剩余数量换算\n剩余数量越少，价格越低哦！\n<color=#eb4642>另有【次元战令】、【商城-神曜礼包】等活动可直接购买获得次元法球哦！</color>", matName, matNum)

	local function okFunc()
		local isHasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if isHasCount < matNum then
			FloatWordMgr.instance:show("道具不足，无法购买哦~")

			return
		end

		DivineCiYuanController.instance:sendPM_DivineCiYuanUniversalOneKeySignInReq(self._activityId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, tips, okFunc)
end

return DivineCiYuanSignView

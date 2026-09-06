-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanNationalView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanNationalView", package.seeall)

local DivineCiYuanNationalView = class("DivineCiYuanNationalView", ViewComponent)

function DivineCiYuanNationalView:ctor()
	DivineCiYuanNationalView.super.ctor(self)
end

function DivineCiYuanNationalView:unbindEvents()
	DivineCiYuanNationalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSign)
	GameUtil.rmClickHandler(self._btnTrail)
	GameUtil.rmClickHandler(self._btnOneKey)

	for tabId, tab in ipairs(self._tabList) do
		GameUtil.rmClickHandler(tab.btn)
	end
end

function DivineCiYuanNationalView:bindEvents()
	DivineCiYuanNationalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnSign, self._onClickSign, self)
	GameUtil.addClickHandler(self._btnTrail, self._onClickTrail, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)

	for tabId, tab in ipairs(self._tabList) do
		GameUtil.addClickHandler(tab.btn, GameUtil.handler(self._onClickTab, self, tabId))
	end
end

function DivineCiYuanNationalView:buildUI()
	DivineCiYuanNationalView.super.buildUI(self)

	self._stageViewGo = self:getGo("stage/tableview")
	self._stageCell = self:getGo("stage/cell")
	self._signRd = self:getGo("btnSign/redpoint")
	self._stageView = ScrollerList.create(self._stageViewGo, self._stageCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._tabList = {}

	for i = 1, 2 do
		local tab = {}

		tab.lock = self:getGo("tab_" .. i .. "/lock")
		tab.pass = self:getGo("tab_" .. i .. "/pass")
		tab.select = self:getGo("tab_" .. i .. "/select")
		tab.btn = self:getBtn("tab_" .. i)

		table.insert(self._tabList, tab)
	end

	self._txtTimes = self:getTxt("times/txt")
	self._txtBubble = self:getTxt("bubble/txtDesc")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnSign = self:getBtn("btnSign")
	self._btnTrail = self:getBtn("btnTrail")
	self._btnOneKey = self:getBtn("btnOneKey")
end

function DivineCiYuanNationalView:onExit()
	DivineCiYuanNationalView.super.onExit(self)
	self._stageView:dispose()
end

function DivineCiYuanNationalView:onEnter()
	DivineCiYuanNationalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanUniversalOneKeyPassRes, self._passCloseCheck, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		printError("DivineCiYuanNationalView 缺少 activityId")
		self:close()

		return
	end

	self._actCfg = DivineCiYuanConfig.instance:getActCfgById(self._activityId)
	self._remainTimes = 0

	self:_sendGetInfoReq()

	local isPopTrailView = GameUtil.getUserData(ViewName.DivineCiYuanTrailView .. self._activityId)

	if not isPopTrailView then
		UIStateManager.instance:push(ViewName.DivineCiYuanTrailView)
	end
end

function DivineCiYuanNationalView:_sendGetInfoReq()
	DivineCiYuanController.instance:sendPM_DivineCiYuanGetInfoReq(self._activityId)
end

function DivineCiYuanNationalView:_passCloseCheck()
	FloatWordMgr.instance:show("恭喜通关全民挑战哦~")
	self:_sendGetInfoReq()
end

function DivineCiYuanNationalView:_refresh()
	self._selectTabId, self._selectBossId = DivineCiYuanModel.instance:getNationalIds()

	self:_onClickTab(self._selectTabId)
end

function DivineCiYuanNationalView:_refreshInfo()
	local challengeTimes = DivineCiYuanModel.instance:getTodayChallengeTimes(self._selectTabId)

	self._remainTimes = Mathf.Clamp(self._actCfg.universalDailyTimes - challengeTimes, 0, self._actCfg.universalDailyTimes)
	self._txtTimes.text = string.format("今日剩余次数：%d/%d", self._remainTimes, self._actCfg.universalDailyTimes)

	local tabId, days = DivineCiYuanController.instance:getSignProgress(self._activityId)
	local isLight = DivineCiYuanController.instance:isLightSignRd()

	GameUtil.SetActive(self._signRd, isLight)

	local signCfg = DivineCiYuanConfig.instance:getUniversalSignCfg(self._activityId, tabId)

	self._txtBubble.text = "未激活"

	if days > 0 then
		local buffCfg = DivineCiYuanConfig.instance:getBuffCfg(signCfg[days].buffId)

		self._txtBubble.text = buffCfg.desc
	end
end

function DivineCiYuanNationalView:_refreshTab()
	local isAllPass = true

	for tabId, tab in ipairs(self._tabList) do
		local isUnlock = DivineCiYuanController.instance:isUnLockUniversalTab(tabId)
		local isPass = DivineCiYuanController.instance:isPassUniversalTab(tabId)

		GameUtil.SetActive(tab.select, self._selectTabId == tabId)
		GameUtil.SetActive(tab.lock, not isUnlock)
		GameUtil.SetActive(tab.pass, isPass)

		if not isPass then
			isAllPass = false
		end
	end

	local nowTime = ServerTime.now()
	local isCanOneKey = nowTime >= GameUtil.string2time(self._actCfg.universalOneKeyPassOpenTime)
	local isOneKey = DivineCiYuanModel.instance:getIsOneKeyPass()

	GameUtil.SetActive(self._btnOneKey.gameObject, isCanOneKey and not isOneKey and not isAllPass)
end

function DivineCiYuanNationalView:_updateStageCell(view, cell, data)
	local icon = goutil.findChild(cell, "mask/icon")
	local defend = goutil.findChild(cell, "defend")
	local blood = goutil.findChild(cell, "blood/slider"):GetComponent("Slider")
	local select = goutil.findChild(cell, "select")
	local txtBlood = goutil.findChildTextComponent(cell, "blood/txtBlood")
	local cfg = data.cfg
	local bossInfo = data.bossInfo
	local monsterCfg = DivineCiYuanConfig.instance:getMonsterCfg(cfg.creepsMasterId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(monsterCfg.showFaceId))

	if modelCo then
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	local leftHp, bossHp = checknumber(bossInfo.leftHp), checknumber(bossInfo.bossHp)

	txtBlood.text = string.format("剩余血量：<color=#20b376>%d</color><color=#eb4642>/%d</color>", leftHp, bossHp)
	blood.value = leftHp / bossHp

	GameUtil.SetActive(defend, leftHp <= 0)
	GameUtil.SetActive(select, self._selectBossId == cfg.bossId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickChallenge, self, cfg.bossId, leftHp <= 0))
end

function DivineCiYuanNationalView:_clearStageCell(cell)
	local icon = goutil.findChild(cell, "mask/icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(cell)
end

function DivineCiYuanNationalView:_onClickTip()
	local key = DivineCiYuanConfig.instance:getActRuleKey(self._activityId, "ruleKeyNation")

	TipsFacade.instance:openRulesView(key)
end

function DivineCiYuanNationalView:_onClickTab(tabId)
	local isUnlock = DivineCiYuanController.instance:isUnLockUniversalTab(tabId)

	if not isUnlock then
		FloatWordMgr.instance:show("当前关卡未解锁")

		return
	end

	self._selectTabId = tabId

	local data = DivineCiYuanController.instance:sortUniversalStage(self._activityId, tabId)

	self._stageView:reloadData(data)
	self:_refreshTab()
	self:_refreshInfo()
end

function DivineCiYuanNationalView:_onClickSign()
	UIStateManager.instance:push(ViewName.DivineCiYuanSignView)
end

function DivineCiYuanNationalView:_onClickTrail()
	UIStateManager.instance:push(ViewName.DivineCiYuanTrailView)
end

function DivineCiYuanNationalView:_onClickOneKey()
	local hpRate = DivineCiYuanModel.instance:getBossBlood()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.universalOneKeyPassUnitPrice)
	local price = hpRate * matNum
	local matName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.universalOneKeyPassUnitPrice)
	local tips = string.format("是否确认消耗<color=#eb4642>%s*%d</color>一键击败剩余boss吗？击败所有boss，且点亮所有次元之力，视为通关次元考验。\nps：价格根据当前关卡剩余血量换算，剩余血量越少，价格越低哦！\n<color=#eb4642>另有【次元战令】、【商城-神曜礼包】等活动可直接购买获得次元法球哦！</color>", matName, price)

	local function okFunc()
		local isHasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if isHasCount < matNum then
			FloatWordMgr.instance:show("道具不足，无法购买哦~")
			MaterialMgr.openGetSourceByStr(self._actCfg.universalOneKeyPassUnitPrice)

			return
		end

		DivineCiYuanController.instance:sendPM_DivineCiYuanUniversalOneKeyPassReq(self._activityId, hpRate)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, price, tips, okFunc)
end

function DivineCiYuanNationalView:_onClickChallenge(bossId, isDefend)
	if self._remainTimes <= 0 then
		FloatWordMgr.instance:show("当前关卡挑战次数已用完哦~")

		return
	end

	if isDefend then
		FloatWordMgr.instance:show("当前boss已挑战成功")

		return
	end

	self._selectBossId = bossId

	DivineCiYuanModel.instance:setNationalIds(self._selectTabId, self._selectBossId)
	DivineCiYuanController.instance:openDivineCiYuanNationalForm(self._activityId, self._selectTabId, bossId)
end

function DivineCiYuanNationalView:_onClickClose()
	DivineCiYuanModel.instance:resetNationalIds()
	self:close()
end

return DivineCiYuanNationalView

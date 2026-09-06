-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQBuffView.lua

module("logic.extensions.godlongyan.view.LongYanSQBuffView", package.seeall)

local LongYanSQBuffView = class("LongYanSQBuffView", ViewComponent)

function LongYanSQBuffView:ctor()
	LongYanSQBuffView.super.ctor(self)
end

function LongYanSQBuffView:unbindEvents()
	LongYanSQBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnGet2)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnActivation)

	for i, go in ipairs(self._buffCells) do
		GameUtil.rmClickHandler(go)
	end
end

function LongYanSQBuffView:bindEvents()
	LongYanSQBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnGet2, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnActivation, self._onClickActive, self)

	for i, go in ipairs(self._buffCells) do
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickCell, self, i))
	end
end

function LongYanSQBuffView:onExit()
	LongYanSQBuffView.super.onExit(self)

	for i, go in ipairs(self._buffCells) do
		local icon = goutil.findChild(go, "icon/con")

		uGuiUtil.clearImage(icon)
	end

	local icon = goutil.findChild(self._buff, "icon/con")

	uGuiUtil.clearImage(icon)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanUpgradeBuff, self._onUpgradeBuff, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodLongYanChallengeResetBuffRes, self.onRefreshUI, self)
	self:_clearUpgradeEffect()
end

function LongYanSQBuffView:buildUI()
	LongYanSQBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._normalGo = self:getGo("normal")
	self._btnGet = self:getGo("normal/btnGet")
	self._txtCount = self:getTxt("normal/txtCount")
	self._tip = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txt")
	self._buffCells = {}

	for i = 1, 10 do
		local go = self:getGo("buff/cell_" .. i)

		table.insert(self._buffCells, go)
	end

	self._infoGo = self:getGo("info")
	self._buff = self:getGo("info/buff")
	self._btnReset = self:getGo("info/btnReset")
	self._btnGet2 = self:getGo("info/btnGet")
	self._btnActivation = self:getGo("info/btnActivation")
	self._txtBtnAct = self:getTxt("info/btnActivation/Text")
	self._txtCount2 = self:getTxt("info/txtCount")
	self._txtCostGo = self:getGo("info/txtCost")
	self._txtCost = self:getTxt("info/txtCost")
	self._costIcon = self:getGo("info/txtCost/icon")
	self._txtEffect = self:getTxt("info/desc/txtEffect")
	self._txtLimitEffect = self:getTxt("info/desc/txtLimitEffect")
	self._txtNextLevel = self:getTxt("info/desc/txtNextLevel")
	self._goldBarCon = self:getGo("goldBarCon")
	self._animator = self.mainGO:GetComponent(ComponentType.Animator)
	self._redPointBtn = self:getGo("info/btnActivation/redPoint")
	self._effectGo = self:getGo("effect")
end

function LongYanSQBuffView:onEnter()
	LongYanSQBuffView.super.onEnter(self)

	self._challengeId = GodLongYanModel.instance:getChallengeId()
	self._glyData = GodLongYanConfig.instance:getGlyData(self._challengeId)
	self._planId = self._glyData.buffPlan
	self._totalPlayTimes = GodLongYanConfig.instance:getDayGameTimes()
	self.currSelectType = -1
	self._isPlayedViewAnim = false

	local prize = GodLongYanConfig.instance:getCommonValue("GAME_PRIZE")

	MaterialMgr.updateItemByStr(self._costIcon, prize)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeGetInfoRes, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanUpgradeBuff, self._onUpgradeBuff, self)
	GlobalDispatcher:addListener(GlobalNotify.GodLongYanChallengeResetBuffRes, self.onRefreshUI, self)
	GodLongYanController.instance:onSendGodLongYanChallengeGetInfoReq()
	self:onRefreshUI()
	self:_setGoldBar(self._glyData.consume)
	self:_loadUpgradeEffect()
end

function LongYanSQBuffView:_onClickActive()
	local lvl = checknumber(self._buffLv[self.currSelectType])
	local maxLvl = GodLongYanConfig.instance:getBuffMaxLvl(self._planId, self.currSelectType)

	maxLvl = math.max(1, maxLvl)

	if lvl == maxLvl then
		-- block empty
	else
		local tmp = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, self.currSelectType, lvl + 1)
		local count = checknumber(tmp.upgradeCostNum)
		local prize = GodLongYanConfig.instance:getCommonValue("GAME_PRIZE")
		local type, id, _ = MaterialMgr.getMatParams(prize)
		local matName = MaterialMgr.getMaterialsNameByCfg(prize)
		local desc = lang("升级")

		if lvl == 0 then
			desc = lang("激活")
		end

		local content = langPara("确定要花费%sx%s对【%s】%s吗", matName, count, tmp.name or "", desc)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
			GodLongYanController.instance:onSendGodLongYanChallengeUpgradeBuffReq(self.currSelectType)
		end)
	end
end

function LongYanSQBuffView:_onClickGet()
	if self._hasPalyTimes < self._totalPlayTimes then
		local gameData = GodLongYanConfig.instance:getGameData(self._challengeId)
		local animPath = gameData.enterAnimPath

		local function onAnimPlayFinish()
			ViewBlockMgr.instance:blockClick(false, self)
			UIStateManager.instance:push(ViewName.CutFruitSceneView, self._challengeId)
		end

		local function onAnimPlayStart()
			ViewBlockMgr.instance:blockClick(true, self)
		end

		if not string.nilorempty(animPath) then
			AnimationPlayer.play(animPath, onAnimPlayFinish, onAnimPlayStart, self)
		end
	else
		TipsFacade.instance:openCommonTips(lang("FunArenaView_Tips_1"))
	end
end

function LongYanSQBuffView:_onClickReset()
	if self.currSelectType > 0 and GodLongYanModel.instance:getBuffLvl(self.currSelectType) > 0 then
		local lvl = checknumber(self._buffLv[self.currSelectType])
		local clientLvl = math.max(1, lvl)
		local cfg = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, self.currSelectType, clientLvl)
		local costNum = GodLongYanConfig.instance:getTotalUpgradeCostNum(self._planId, self.currSelectType, clientLvl)
		local matType, id = MaterialMgr.getMatParams(self._glyData.consume)
		local content = string.format("是否重置%s,重置后将返还%s*%d", cfg.name, MaterialMgr.getMaterialsName(matType, id), costNum)

		local function sureFunc()
			GodLongYanAgent.instance:sendPM_GodLongYanChallengeResetBuffReq(self.currSelectType)
		end

		local costMatType, costId, costNum = MaterialMgr.getMatParams(self._glyData.buffResetCost)

		TipsFacade.instance:openPopupCostMatViewNew(costMatType, costId, costNum, content, sureFunc)
	else
		FloatWordMgr.instance:show("还没有升级，无法重置")
	end
end

function LongYanSQBuffView:_onClickCell(type)
	if self.currSelectType == -1 and not self._isPlayedViewAnim then
		self._animator:Play("longyansqbuffview_2")

		self._isPlayViewAnim = false
	end

	self.currSelectType = type

	self:onRefreshUI()
end

function LongYanSQBuffView:updateCell(go, cfg)
	local select = goutil.findChild(go, "select")
	local icon = goutil.findChild(go, "icon/con")
	local level = Framework.SliderAdapter.GetFrom(go, "level")
	local txtName = goutil.findChildTextComponent(go, "name/txtName")
	local levelLine = goutil.findChild(go, "levelLine")
	local redPoint = goutil.findChild(go, "redPoint")
	local lvl = checknumber(self._buffLv[checknumber(cfg.buffType)])
	local maxLvl = GodLongYanConfig.instance:getBuffMaxLvl(self._planId, checknumber(cfg.buffType))

	maxLvl = math.max(1, maxLvl)

	level:SetValue(lvl / maxLvl)

	txtName.text = cfg.name or ""

	GameUtil.SetActive(select, self.currSelectType == checknumber(cfg.buffType))

	local url = GameUrl.getExpEventUrl(cfg.icon)

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, url)
	GameUtil.SetGray(icon, lvl == 0)
	goutil.setActive(levelLine, maxLvl > 1)
	goutil.setActive(redPoint, GodLongYanModel.instance:isBuffCanUpgrade(cfg.buffType))
end

function LongYanSQBuffView:updateInfoView()
	GameUtil.SetActive(self._normalGo, self.currSelectType < 0)
	GameUtil.SetActive(self._infoGo, self.currSelectType > 0)
	GameUtil.SetActive(self._redPointBtn, GodLongYanModel.instance:isBuffCanUpgrade(self.currSelectType))

	if self.currSelectType > 0 then
		local lvl = checknumber(self._buffLv[self.currSelectType])
		local clientLvl = math.max(1, lvl)
		local cfg = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, self.currSelectType, clientLvl)

		self:updateCell(self._buff, cfg)

		self._txtEffect.text = langPara("当前效果：%s", cfg.desc)
		self._txtLimitEffect.text = langPara("限时效果：%s", cfg.timeDesc)
		self._txtBtnAct.text = lvl == 0 and lang("激活") or lang("升级")

		local maxLvl = GodLongYanConfig.instance:getBuffMaxLvl(self._planId, self.currSelectType)

		maxLvl = math.max(1, maxLvl)

		if lvl == maxLvl then
			self._txtNextLevel.text = ""

			GameUtil.SetActive(self._txtNextLevel, false)
			GameUtil.SetActive(self._txtCostGo, false)
			GameUtil.SetActive(self._btnActivation, false)
		else
			GameUtil.SetActive(self._txtNextLevel, true)
			GameUtil.SetActive(self._txtCostGo, true)
			GameUtil.SetActive(self._btnActivation, true)

			local cfgNextLevel = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, self.currSelectType, lvl + 1)

			if cfgNextLevel then
				self._txtNextLevel.text = langPara("下一级效果: %s", cfgNextLevel.desc)
			end

			local tmp = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, self.currSelectType, lvl + 1)

			self._txtCost.text = tmp.upgradeCostNum
		end
	end
end

function LongYanSQBuffView:onRefreshUI()
	self._buffLv = GodLongYanModel.instance:getAllBuffLvlList()
	self._hasPalyTimes = GodLongYanModel.instance:getHasPalyGameTimes()

	for i, go in ipairs(self._buffCells) do
		local lvl = checknumber(self._buffLv[i])
		local clientLvl = math.max(1, lvl)
		local cfg = GodLongYanConfig.instance:getBuffByIdAndLvl(self._planId, i, clientLvl)

		self:updateCell(go, cfg)
	end

	self:updateInfoView()

	local left = math.max(0, self._totalPlayTimes - self._hasPalyTimes)

	self._txtCount.text = langPara("挑战次数：%s/%s", left, self._totalPlayTimes)
	self._txtCount2.text = langPara("挑战次数：%s/%s", left, self._totalPlayTimes)
end

function LongYanSQBuffView:_setGoldBar(coinStr)
	local matMo = string.splitToNumber(coinStr, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function LongYanSQBuffView:_playUpgradeEffect()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end

	goutil.setActive(self._effectGo, false)
	goutil.setActive(self._effectGo, true)

	self._tween = TweenUtil.DoDelay(1, function()
		self:_stopUpgradeEffect()

		self._tween = nil
	end)
end

function LongYanSQBuffView:_stopUpgradeEffect()
	goutil.setActive(self._effectGo, false)
end

function LongYanSQBuffView:_loadUpgradeEffect()
	self:_stopUpgradeEffect()
	self:_clearUpgradeEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, LongYanSQBuffViewPresentor.Effect, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function LongYanSQBuffView:_clearUpgradeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function LongYanSQBuffView:_onUpgradeBuff()
	self:_playUpgradeEffect()
	self:onRefreshUI()
end

return LongYanSQBuffView

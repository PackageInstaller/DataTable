-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpMainView.lua

module("logic.extensions.stknexp.view.StKnExpMainView", package.seeall)

local StKnExpMainView = class("StKnExpMainView", ViewComponent)

function StKnExpMainView:buildUI()
	StKnExpMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnRank = self:getGo("btnCol/btnRank")
	self._btnMining = self:getGo("btnMining")
	self._redBtnMining = self:getGo("btnMining/redpoint")
	self._btnBuff = self:getGo("btnCol/btnBuff")
	self._btnShop = self:getGo("btnCol/btnShop")
	self._btnPrize = self:getGo("btnCol/btnPrize")
	self._btnIsland = self:getGo("btnIsland/btn")
	self._redBtnIsland = self:getGo("btnIsland/btn/redPoint")
	self._zoneView = self:getGo("zoneCol/view")
	self._zoneCell = self:getGo("zoneCol/cell")
end

function StKnExpMainView:bindEvents()
	StKnExpMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnMining, self._onClickBtnMining, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnIsland, self._onClickBtnIsland, self)
end

function StKnExpMainView:unbindEvents()
	StKnExpMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnMining)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnIsland)
end

function StKnExpMainView:onEnter()
	StKnExpMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = StKnExpController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._actData = StKnExpConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMaterialCountChange, self)
	self.addGEvent(self, GlobalNotify.UpdataEnergyCount, self._onMaterialCountChange, self)
	StKnExpController.instance:sendPM_SaintKnightExpeditionInfoReq(self._activityId)
end

function StKnExpMainView:onExit()
	StKnExpMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnIsland)
	RedPointController.instance:unregRedPoint(self._redBtnMining)
	self:_onClear()
end

function StKnExpMainView:_onMaterialCountChange()
	StKnExpController.instance:updateRedInMining(self._activityId)
end

function StKnExpMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redBtnIsland, RedPointModel.ID_STKNEXP_ISLAND_UPGARDE, RedPointModel.ID_CLEARSTARGAME_TIMES)
	RedPointController.instance:regRedPoint(self._redBtnMining, RedPointModel.ID_STKNEXP_MINING)
end

function StKnExpMainView:_onUpdate()
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._zoneView, self._zoneCell, cfg, self._updateZoneCell, self)
end

function StKnExpMainView:_onClear()
	GameUtil.clearCells(self._zoneView, self._clearZoneCell, self)
end

function StKnExpMainView:_updateZoneCell(mainGo, data, index)
	local zoneId = data.zoneId
	local isUnlock = self._subMo:isUnlockZone(zoneId)
	local clgType = self._subMo:getClgTypeInZone(zoneId)
	local root = goutil.findChild(mainGo, "root")
	local redpoint = goutil.findChild(mainGo, "root/redpoint")
	local tipsRoot = goutil.findChild(mainGo, "root/tips")
	local txtTipsRoot = goutil.findChildTextComponent(mainGo, "root/tips/txt")
	local nameRoot = goutil.findChild(mainGo, "root/name")
	local txtNameRoot = goutil.findChildTextComponent(mainGo, "root/name/txt")
	local lock = goutil.findChild(mainGo, "lock")
	local txtNameLock = goutil.findChildTextComponent(mainGo, "lock/txtName")
	local txtTipsLock = goutil.findChildTextComponent(mainGo, "lock/txtTips")

	if not data.pos then
		if not data.pos[3] then
			local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])

			txtNameRoot.text = data.name
			txtNameLock.text = data.name

			GameUtil.SetActive(root, isUnlock)
			GameUtil.SetActive(lock, not isUnlock)

			txtTipsLock.text = GameUtil.formatTimeString("%m.%d %H:%M后开启", data.openTime)

			local redIdTimes = StKnExpController.instance:getRedIdInBossTimes(self._activityId, zoneId)
			local redIdPrize = StKnExpController.instance:getRedIdInBossPrize(self._activityId, zoneId)

			RedPointController.instance:regRedPoint(redpoint, redIdTimes, redIdPrize)

			local curStage, maxStage = self._subMo:getCurStageId(zoneId), self._subMo:getMaxStageId(zoneId)

			if clgType == StKnExpEnum.ClgType_Stage then
				txtTipsRoot.text = string.format("<color=#FFFFFFFF>守卫：%s/%s</color>\n<color=#B0B0B0FF>BOSS：未开启</color>", curStage, maxStage)
			elseif clgType == StKnExpEnum.ClgType_Boss then
				txtTipsRoot.text = string.format("<color=#B0B0B0FF>守卫：%s/%s</color>\n<color=#FFFFFFFF>BOSS：已开启</color>", curStage, maxStage)
			end

			local function callBack()
				if not self._subMo:isUnlockZone(zoneId) then
					FloatWordMgr.instance:show("未开启")

					return
				end

				UIStateManager.instance:push(ViewName.StKnExpClgTabView, self._activityId, zoneId, clgType)
			end

			GameUtil.addClickHandler(nameRoot, callBack)
			GameUtil.addClickHandler(lock, callBack)
		end
	end
end

function StKnExpMainView:_clearZoneCell(mainGo)
	local nameRoot = goutil.findChild(mainGo, "root/name")
	local redpoint = goutil.findChild(mainGo, "root/redpoint")
	local lock = goutil.findChild(mainGo, "lock")

	RedPointController.instance:unregRedPoint(redpoint)
	GameUtil.rmClickHandler(nameRoot)
	GameUtil.rmClickHandler(lock)
end

function StKnExpMainView:_onClickBtnTip()
	local value = StKnExpConfig.instance:getActDataValue(self._activityId, "mainRuleKey", false)

	TipsFacade.instance:openRulesView(value)
end

function StKnExpMainView:_onClickBtnRank()
	local headTabIndex, secTabIndex
	local cfg = StKnExpConfig.instance:getZoneCfg(self._activityId) or {}

	for zoneId, data in ipairs(cfg) do
		if self._subMo:isUnlockZone(zoneId) then
			secTabIndex = zoneId

			local clgType = self._subMo:getClgTypeInZone(zoneId)

			if clgType == StKnExpEnum.ClgType_Stage then
				headTabIndex = 1
			elseif clgType == StKnExpEnum.ClgType_Boss then
				headTabIndex = 2
			end
		end
	end

	UIStateManager.instance:push(ViewName.StKnExpRankTabFatherView, self._activityId, headTabIndex, secTabIndex)
end

function StKnExpMainView:_onClickBtnMining()
	UIStateManager.instance:push(ViewName.StKnExpMiningView, self._activityId)
end

function StKnExpMainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.StKnExpBuffPreView, self._activityId)
end

function StKnExpMainView:_onClickBtnShop()
	local value = StKnExpConfig.instance:getActDataValue(self._activityId, "shopJump", false)

	GotoMgr.gotoByString(value)
end

function StKnExpMainView:_onClickBtnIsland()
	UIStateManager.instance:push(ViewName.StKnExpIslandView, self._activityId)
end

function StKnExpMainView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.StKnExpRankPrizeWinView, self._activityId)
end

return StKnExpMainView

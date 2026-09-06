-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldGameView.lua

module("logic.extensions.uniqueworld.view.UniqueWorldGameView", package.seeall)

local UniqueWorldGameView = class("UniqueWorldGameView", ViewComponent)

function UniqueWorldGameView:ctor()
	UniqueWorldGameView.super.ctor(self)
end

function UniqueWorldGameView:unbindEvents()
	UniqueWorldGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFmt)
	GameUtil.rmClickHandler(self._goldBarCon)
end

function UniqueWorldGameView:bindEvents()
	UniqueWorldGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._showPlayRule, self)
	GameUtil.addClickHandler(self._btnFmt, self._onClickBtnFmt, self)
	GameUtil.addClickHandler(self._goldBarCon, self._onClickBtnGoldBar, self)
end

function UniqueWorldGameView:buildUI()
	UniqueWorldGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnFmt = self:getGo("btnFmt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtGoldNum = self:getTxt("goldBarCon/txtNum")
	self._iconGold = self:getGo("goldBarCon/icon")
	self._txtFloor = self:getTxt("tip/txtFloor")
	self._txtProgress = self:getTxt("tip/txtProgress")
	self._emptyProp = self:getGo("prop/empty")
	self._prop = self:getGo("prop")
	self._tableviewProp = self:getGo("prop/tableview")
	self._tablecellProp = self:getGo("prop/tableview/tablecell")
	self._scrollListProp = ScrollerList.create(self._tableviewProp, self._tablecellProp, GameUtil.handler(self._updatePropCell, self), GameUtil.handler(self._clearPropCell, self))
	self._templetBg = self:getGo("templet/templetBg")
	self._templetNPC = self:getGo("templet/templetNPC")
	self._templetCell = self:getGo("templet/templetCell")
	self._templetBoss = self:getGo("templet/templetBoss")
	self._fmtCellGoList = {}
	self._onFmt = self:getGo("onFmt")

	for i = 1, 6 do
		local cellGo = self:getGo("onFmt/cell" .. i)

		table.insert(self._fmtCellGoList, cellGo)
	end

	self._tableview = self:getGo("tableview")
	self._bgRoot = self:getGo("tableview/viewport/content/bgRoot")
	self._eventRoot = self:getGo("tableview/viewport/content/eventRoot")
	self._contentGo = self:getGo("tableview/viewport/content")
	self._player = self:getGo("tableview/viewport/content/eventRoot/player")
end

function UniqueWorldGameView:onExit()
	UniqueWorldGameView.super.onExit(self)
	self:_clearBottomFmt()
	MaterialMgr.clearIcon(self._iconGold)
	self._scrollListProp:dispose()
	UniqueWorldMapMgr.instance:clear()
	UniqueWorldPlayerMgr.instance:clear()
end

function UniqueWorldGameView:onEnter()
	UniqueWorldGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldMoveRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldMapChangeRes, self._onMapChangeRes, self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldUseItemRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldGiveUpRes, self.close, self)
	self.addGEvent(self, GlobalNotify.FormationChanged, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 584001
	end

	self._gameId = checknumber(params[2])

	local info = UniqueWorldModel.instance:getInfo(self._activityId)
	local mapInfo = info and info.mapInfo

	self._gameInfo = mapInfo and mapInfo.gameInfo

	if self._gameInfo then
		self._levelId = self._gameInfo.curLevel or 1
	end

	if self._gameInfo then
		self._curCoinNum = self._gameInfo.leftCoin or 0
	end

	if self._gameInfo then
		self._curPlayerGridId = self._gameInfo.curGridId or 1
	end

	self._propViewPos = GameUtil.getLocalPos(self._tableview)
	self._propViewPos.x = self._propViewPos.x + 250
	self._actCfg = UniqueWorldConfig.instance:getActCfg(self._activityId)

	UniqueWorldMapMgr.instance:setComplateInstance(UniqueWorldEnum.MapGoType.Bg, self._templetBg)
	UniqueWorldMapMgr.instance:setComplateInstance(UniqueWorldEnum.MapGoType.Cell, self._templetCell)

	local key = string.format("UniqueWorldGameView%s", self._activityId)

	local function firstCallback()
		self:_showPlayRule()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback)
	self:_tryPopPrize()
	self:_initUI()
	self:_initMap()
	self:_onUpdate()
end

function UniqueWorldGameView:_initUI()
	local coinMatStr = self._actCfg.coinMatStr
	local matType, matId, matNum = MaterialMgr.getMatParams(coinMatStr)

	MaterialMgr.setIcon(self._iconGold, matType, matId, nil, nil)

	self._txtGoldNum.text = self._curCoinNum
end

function UniqueWorldGameView:_initMap()
	UniqueWorldMapMgr.instance:initParam(self._activityId, self._gameId, self._levelId, self._bgRoot, self._eventRoot, self._contentGo)
	UniqueWorldMapMgr.instance:createMap()
	UniqueWorldPlayerMgr.instance:initParam(self._player, self._curPlayerGridId, self, self._tableview)
	UniqueWorldPlayerMgr.instance:focusOnPlayer()
end

function UniqueWorldGameView:_onUpdate()
	self:_checkGameIsOver()

	local info = UniqueWorldModel.instance:getInfo(self._activityId)
	local mapInfo = info and info.mapInfo

	self._gameInfo = mapInfo and mapInfo.gameInfo

	if self._gameInfo then
		self._levelId = self._gameInfo.curLevel or 1
	end

	if self._gameInfo then
		self._curCoinNum = self._gameInfo.leftCoin or 0
	end

	local itemList = UniqueWorldController.instance:getCurHasPropList(self._activityId)

	self._itemMap = UniqueWorldModel.instance:getItemMap(self._activityId) or {}
	self._petHpMap = UniqueWorldModel.instance:getPetHpMap(self._activityId)

	self:_updateBottomFmt()

	local floorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)
	local progress = math.floor(floorPercent * 100)

	self._txtGoldNum.text = self._curCoinNum
	self._txtFloor.text = string.format("洞穴层数：第%d层", self._levelId)
	self._txtProgress.text = string.format("本层进度：%d%%", progress)

	self._scrollListProp:reloadData(itemList)
	GameUtil.SetActive(self._emptyProp, #itemList <= 0)
	GameUtil.SetActive(self._tableviewProp, #itemList > 0)
end

function UniqueWorldGameView:_updatePropCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local btnProp = goutil.findChild(cell, "btnProp")
	local itemId = data.itemId
	local count = checknumber(self._itemMap[itemId])
	local itemCfg = UniqueWorldConfig.instance:getItemCfg(itemId)
	local matStr = itemCfg.matStr
	local effects = itemCfg.effects
	local effectArr = string.split(effects, "$")
	local effect = effectArr[1]
	local isPetProp = UniqueWorldController.instance:isPetProp(effect)

	matStr = string.format("%s:%d", matStr, count)

	if itemCfg then
		MaterialMgr.setCellByCfg(matStr, item)
	end

	GameUtil.addClickHandler(btnProp, function()
		if count <= 0 then
			FloatWordMgr.instance:show(lang("该道具数量为0，暂无法使用"))

			return
		end

		UIStateManager.instance:push(ViewName.UniqueWorldPropView, self._activityId, self._propViewPos, itemId, isPetProp)
	end, self)
end

function UniqueWorldGameView:_clearPropCell(cell)
	local btnProp = goutil.findChild(cell, "btnProp")
	local item = goutil.findChild(cell, "item")

	GameUtil.rmClickHandler(btnProp)
	MaterialMgr.resetAll(item)
end

function UniqueWorldGameView:_updateBottomFmt()
	local creepsIdList = UniqueWorldController.instance:getOnFmtCreepsIdList(self._activityId)

	for idx, cellGo in ipairs(self._fmtCellGoList) do
		local creepsId = checknumber(creepsIdList[idx])
		local petGo = goutil.findChild(cellGo, "pet")
		local sliderGo = goutil.findChild(cellGo, "slider")
		local empty = goutil.findChild(cellGo, "empty")
		local dead = goutil.findChild(cellGo, "dead")
		local bloodSlider = sliderGo:GetComponent(ComponentType.Slider)
		local sliderChangeComp = goutil.findChild(cellGo, "slider/FillArea/Fill"):GetComponent(ComponentType.UIImageColorChange)
		local txtBlood = goutil.findChildTextComponent(cellGo, "txtBlood")

		if creepsId > 0 then
			local creepsCfg = UniqueWorldConfig.instance:getSystemPetCfg(creepsId)

			if creepsCfg then
				local raceId = creepsCfg.raceId
				local leftHPPrecent = checknumber(self._petHpMap[creepsId])
				local val = leftHPPrecent / 10000

				if val < 0.01 and val > 0 then
					val = 0.01
				end

				local colorIdx = 2

				if val > 0.6 then
					colorIdx = 0
				elseif val >= 0.21 then
					colorIdx = 1
				end

				bloodSlider.value = val
				txtBlood.text = string.format("%d%%", val * 100)

				MaterialMgr.setCell(MatType.Pet, raceId, petGo)
				sliderChangeComp:SetState(colorIdx)
				GameUtil.SetActive(dead, leftHPPrecent <= 0)
				GameUtil.SetActive(empty, false)
				GameUtil.SetActive(petGo, true)
				GameUtil.SetActive(sliderGo, true)
			end
		else
			GameUtil.SetActive(petGo, false)
			GameUtil.SetActive(sliderGo, false)
			GameUtil.SetActive(dead, false)
			GameUtil.SetActive(empty, true)
		end
	end
end

function UniqueWorldGameView:_clearBottomFmt()
	for idx, cellGo in ipairs(self._fmtCellGoList) do
		local petGo = goutil.findChild(cellGo, "pet")

		MaterialMgr.resetAll(petGo)
	end
end

function UniqueWorldGameView:_onClickBtnFmt()
	local customFmtMo = UniqueWorldModel.instance:getFmtMo(self._activityId)

	customFmtMo:updateCfg(self._activityId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function UniqueWorldGameView:_onClickBtnClose()
	UniqueWorldMapMgr.instance:cancelPendingEvent()

	local tipsContent = "<color=#FF0000>是否结算本次副本?</color>\n结算：领取奖励，进度<color=#FF0000>重置</color>。\n暂离：暂时回到主界面，进度<color=#FF0000>保留</color>。"

	local function okFunc()
		UniqueWorldController.instance:sendPM_UniqueWorldGiveUpReq(self._activityId)
	end

	local function cancelFunc()
		self:close()
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cancelFunc, "结算", "暂时退出")
end

function UniqueWorldGameView:_onClickBtnGoldBar()
	local coinMatStr = self._actCfg.coinMatStr
	local matType, matId, matNum = MaterialMgr.getMatParams(coinMatStr)

	CommonTipsMgr.instance:openMaterialTips(self._goldBarCon, matType, matId, matNum)
end

function UniqueWorldGameView:_onMapChangeRes(extParam)
	if extParam == UniqueWorldEnum.ExtParam.NextLevel then
		TipsFacade.instance:openTipWindowNoX("提示", "进入下一层", function()
			self:_onUpdate()

			if self._gameInfo then
				self._curPlayerGridId = self._gameInfo.curGridId or 1
			end

			UniqueWorldPlayerMgr.instance:clear()
			UniqueWorldMapMgr.instance:initParam(self._activityId, self._gameId, self._levelId, self._bgRoot, self._eventRoot, self._contentGo)
			UniqueWorldMapMgr.instance:reCreateMap()
			UniqueWorldPlayerMgr.instance:initParam(self._player, self._curPlayerGridId, self, self._tableview)
			UniqueWorldPlayerMgr.instance:focusOnPlayer()
		end, "确定")
	else
		self:_onUpdate()
	end
end

function UniqueWorldGameView:_checkGameIsOver()
	if UniqueWorldModel.instance:getCurGameIsOver() then
		TipsFacade.instance:openTipWindowNoX("提示", "恭喜通关！", function()
			self:close()
		end, "确定")
	end
end

function UniqueWorldGameView:_showPlayRule()
	local ruleCfg = UniqueWorldConfig.instance:getRuleCfgs(self._actCfg.ruleId)
	local ruleList = {}

	if ruleCfg then
		for i, v in ipairs(ruleCfg) do
			local obj = {}

			obj.url = v.resPath
			obj.desc = v.desc

			table.insert(ruleList, obj)
		end

		TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
	end
end

function UniqueWorldGameView:_tryPopPrize()
	local changeSetId = UniqueWorldModel.instance:popChangeSetId(self._activityId)

	while changeSetId do
		MaterialController.instance:showChangeSetInTemp(changeSetId)

		changeSetId = UniqueWorldModel.instance:popChangeSetId(self._activityId)
	end
end

return UniqueWorldGameView

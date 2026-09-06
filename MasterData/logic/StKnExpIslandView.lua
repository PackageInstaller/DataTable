-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpIslandView.lua

module("logic.extensions.stknexp.view.StKnExpIslandView", package.seeall)

local StKnExpIslandView = class("StKnExpIslandView", ViewComponent)

function StKnExpIslandView:buildUI()
	StKnExpIslandView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._effRoot = self:getGo("effRoot")
	self._btnPrize = self:getGo("btnPrize")
	self._btnPlay = self:getGo("btnPlay/btn")
	self._txtDescBtnPlay = self:getTxt("btnPlay/desc/txt")
	self._btnPlayCanvas = self:getGo("btnPlay"):GetComponent(ComponentType.Canvas)
	self._imgConsoleCanvas = self:getGo("imgConsole"):GetComponent(ComponentType.Canvas)
	self._consoleCanvas = self:getGo("console"):GetComponent(ComponentType.Canvas)
	self._btnUpgarde = self:getGo("console/btnUpgarde")

	local matScrView = self:getGo("console/matCol/scrView")
	local matScrCell = self:getGo("console/matCol/scrCell")

	self._matScrollList = ScrollerList.create(matScrView, matScrCell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
	self._emptyMat = self:getGo("console/matCol/empty")
	self._btnIsland = self:getGo("btnIsland/btn")
	self._redBtnIsland = self:getGo("btnIsland/btn/redPoint")
	self._islandView = self:getGo("islandCol/view")
	self._islandCell = self:getGo("islandCol/cell")
	self._islandCells = {}
end

function StKnExpIslandView:bindEvents()
	StKnExpIslandView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickBtnPlay, self)
	GameUtil.addClickHandler(self._btnUpgarde, self._onClickBtnUpgarde, self)
end

function StKnExpIslandView:unbindEvents()
	StKnExpIslandView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnPlay)
	GameUtil.rmClickHandler(self._btnUpgarde)
end

function StKnExpIslandView:onEnter()
	StKnExpIslandView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)
	self._isCanUpgarde = false
	self._isPlaying = false

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionUpgardeIslandRes, self._handlePM_SaintKnightExpeditionUpgardeIslandRes, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameGetInfo, self._updateGameTipsUI, self)

	self._gameActivityId = StKnExpConfig.instance:getActDataValue(self._activityId, "gameActivityId", true)

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._gameActivityId) then
		ClearStarGameController.instance:getInfo(self._gameActivityId)
	end

	StKnExpController.instance:sendPM_SaintKnightExpeditionInfoReq(self._activityId)
	self:_onUpdate()
end

function StKnExpIslandView:onExit()
	StKnExpIslandView.super.onExit(self)
	MmUtil.clearCondCallback("StKnExpIsland_Upgrade")

	self._imgConsoleCanvas.overrideSorting = false
	self._btnPlayCanvas.overrideSorting = false
	self._consoleCanvas.overrideSorting = false

	self:_onClear()
end

function StKnExpIslandView:_handlePM_SaintKnightExpeditionUpgardeIslandRes(msg)
	local list = {}

	for _, v in ipairs(msg.islandIdAndNum) do
		local islandId = v.left

		table.insert(list, islandId)
	end

	local function finfishCallback()
		self._isPlaying = false

		local changeSetId = self._subMo:getChangeSetIdInUpgarde()

		if changeSetId then
			MaterialController.instance:showChangeSetInTemp(changeSetId)
			self._subMo:setChangeSetIdInUpgarde(nil)
		end

		self:_onUpdate()
		StKnExpController.instance:sendPM_SaintKnightExpeditionInfoReq(self._activityId)
	end

	if #list > 0 then
		local callBackKey = "StKnExpIsland_Upgrade"

		MmUtil.createCondCallback(callBackKey, finfishCallback)

		for _, islandId in ipairs(list) do
			local mainGo = self._islandCells[islandId]

			if not goutil.isNil(mainGo) then
				MmUtil.addCondCallback(callBackKey, islandId)

				self._isPlaying = true

				local effRoot = goutil.findChild(mainGo, "imgIsland/effRoot")
				local effPath = "20230825/yonghengguodu/fx_ui_yonghengguodu_shu.prefab"

				self:playViewEffectUniGo(effPath, effRoot, self.mainGO, false, function(handlerTarget, eff)
					MmUtil.finishCondCallback(callBackKey, islandId)
				end)
			end
		end
	else
		finfishCallback()
	end
end

function StKnExpIslandView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	self._imgConsoleCanvas.overrideSorting = true
	self._imgConsoleCanvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 10
	self._btnPlayCanvas.overrideSorting = true
	self._btnPlayCanvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 20
	self._consoleCanvas.overrideSorting = true
	self._consoleCanvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 30
end

function StKnExpIslandView:_onUpdate()
	local cfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}

	self._islandCells = GameUtil.updateCellsList(self._islandView, self._islandCell, cfg, self._updateIslandCell, self)

	local costDic = {}

	for islandId, data in ipairs(cfg) do
		local mat = self._subMo:getIslandCostMat(islandId)

		costDic[mat.matOnlyId] = mat
	end

	local isCanUpgarde = false
	local islandIdAndNum = self._subMo:getUpgardeIslandIdAndNum()

	for _, v in ipairs(islandIdAndNum) do
		local islandId, num = v.left, v.right

		if num > 0 then
			isCanUpgarde = true

			break
		end
	end

	self._isCanUpgarde = isCanUpgarde

	local costList = TableUtil.toList(costDic)

	self._matScrollList:reloadData(costList)
	GameUtil.SetActive(self._emptyMat, #costList <= 0)
	GameUtil.SetGray(self._btnUpgarde, not isCanUpgarde)
end

function StKnExpIslandView:_onClear()
	table.clear(self._islandCells)
	GameUtil.clearCells(self._islandView, self._clearIslandCell, self)
	self._matScrollList:dispose()
end

function StKnExpIslandView:_updateGameTipsUI()
	local info = ClearStarGameModel.instance:getInfo(self._gameActivityId)
	local cur = checknumber(info and info.todayTimes)
	local max = ClearStarGameConfig.instance:getDailyTime(self._gameActivityId)
	local left = Mathf.Max(max - cur, 0)

	self._txtDescBtnPlay.text = string.format("今日剩余：%s/<color=#75FF29FF>%s</color>", left, max)
end

function StKnExpIslandView:_updateIslandCell(mainGo, data, index)
	local islandId = data.islandId
	local curExp = self._subMo:getIslandExp(islandId)
	local level = self._subMo:getIslandLevel(islandId)
	local levelData = StKnExpConfig.instance:getIslandLevelData(self._activityId, islandId, level)
	local nextLevel = level + 1
	local nextLevelData = StKnExpConfig.instance:getIslandLevelData(self._activityId, islandId, nextLevel)

	if nextLevelData then
		if not nextLevelData.exp then
			local nextExp = 0
			local isUnlockUpgardeTime = self._subMo:isUnlockUpgardeTime(islandId)
			local canvas = mainGo:GetComponent(ComponentType.Canvas)
			local imgIsland = goutil.findChild(mainGo, "imgIsland")
			local bubble = goutil.findChild(mainGo, "bubble")
			local iconBubble = goutil.findChild(mainGo, "bubble/icon")
			local txtNameBubble = goutil.findChildTextComponent(mainGo, "bubble/txtName")
			local txtCountBubble = goutil.findChildTextComponent(mainGo, "bubble/txtCount")
			local txtProgress = goutil.findChildTextComponent(mainGo, "progress/txt")

			if not data.pos then
				if not data.pos[3] then
					local x, y, scale = checknumber(data.pos[1]), checknumber(data.pos[2]), 1

					GameUtil.setLocalPos(mainGo, x, y, 0)
					GameUtil.setLocalScale(mainGo, data.pos[3], data.pos[3], data.pos[3])

					canvas.overrideSorting = true
					canvas.sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + data.sorting
					txtProgress.text = isUnlockUpgardeTime and (nextLevelData == nil and "建设进度<color=#6EF226FF>已满级</color>" or string.format("建设进度%s/<color=#6EF226FF>%s</color>", curExp, nextExp)) or GameUtil.formatTimeString("%m.%d %H点后开启", data.unlockUpgardeTime)
					txtNameBubble.text = levelData.showPrizeName

					GameUtil.SetActive(txtNameBubble.gameObject, not string.nilorempty(levelData.showPrizeName))

					if not levelData.imgPos then
						if not levelData.imgPos[3] then
							local x, y, scale = checknumber(levelData.imgPos[1]), checknumber(levelData.imgPos[2]), 1

							GameUtil.setLocalPos(imgIsland, x, y, 0)
							GameUtil.setLocalScale(imgIsland, levelData.imgPos[3], levelData.imgPos[3], levelData.imgPos[3])

							local spriteName = GameUrl.getBigbgPngUrl(levelData.imgPath)

							uGuiUtil.setSpriteToImage(imgIsland, uGuiUtil.SpriteType.BigBg, spriteName, function()
								imgIsland:GetComponent(goutil.Type_UIImage):SetNativeSize()
							end)

							local isEmptyPrizeShow = string.nilorempty(levelData.showPrize)

							if not isEmptyPrizeShow then
								local matType, matId, matNum = MaterialMgr.getMatParams(levelData.showPrize)

								MaterialMgr.setIcon(iconBubble, matType, matId, nil, nil)

								txtCountBubble.text = matNum

								GameUtil.addClickHandler(iconBubble, function()
									CommonTipsMgr.instance:openMaterialTips(iconBubble, matType, matId, 0)
								end)
							else
								txtCountBubble.text = 0

								MaterialMgr.clearIcon(iconBubble)
								GameUtil.rmClickHandler(iconBubble)
							end

							GameUtil.SetActive(iconBubble.gameObject, not isEmptyPrizeShow)
							GameUtil.SetActive(txtCountBubble.gameObject, not isEmptyPrizeShow)
							GameUtil.addClickHandler(imgIsland, function()
								UIStateManager.instance:push(ViewName.StKnExpIslandUpdateView, self._activityId, islandId)
							end)
						end
					end
				end
			end
		end
	end
end

function StKnExpIslandView:_clearIslandCell(mainGo)
	local iconBubble = goutil.findChild(mainGo, "bubble/icon")
	local imgIsland = goutil.findChild(mainGo, "imgIsland")

	GameUtil.rmClickHandler(imgIsland)
	GameUtil.rmClickHandler(iconBubble)
	MaterialMgr.clearIcon(iconBubble)
	uGuiUtil.clearImage(imgIsland)
end

function StKnExpIslandView:_updateMatCell(view, cell, mat, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")

	MaterialMgr.setIcon(icon, mat.matType, mat.matId)

	txtCount.text = MaterialModel.instance:getMaterialsNumber(mat.matType, mat.matId)

	GameUtil.addClickHandler(mainGo, function()
		CommonTipsMgr.instance:openMaterialTips(icon, mat.matType, mat.matId, 0)
	end)
end

function StKnExpIslandView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function StKnExpIslandView:_onClickBtnTip()
	local value = StKnExpConfig.instance:getActDataValue(self._activityId, "islandRuleKey", false)

	TipsFacade.instance:openRulesView(value)
end

function StKnExpIslandView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.StKnExpIslandUpdateView, self._activityId)
end

function StKnExpIslandView:_onClickBtnPlay()
	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._gameActivityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	local info = ClearStarGameModel.instance:getInfo(self._gameActivityId)
	local cur = checknumber(info and info.todayTimes)
	local max = ClearStarGameConfig.instance:getDailyTime(self._gameActivityId)

	if max <= cur then
		FloatWordMgr.instance:show("游戏次数不足")

		return
	end

	local index = self._subMo:getCurIslandGameIndex()
	local data = StKnExpConfig.instance:getIslandGameData(self._activityId, index)

	if data == nil then
		printError(string.format("错误，对应游戏配置为空( activityId:%s, index:%s ( export_岛屿小游戏配置  in  ys运营-圣骑团远征.xlsx  ) )", self._activityId, index))

		return
	end

	local openParam = data and data.openParam
	local scoreType = openParam and openParam.scoreType

	ClearStarGameController.instance:enterGame(self._gameActivityId, false, scoreType)
end

function StKnExpIslandView:_onClickBtnUpgarde()
	if self._isPlaying then
		FloatWordMgr.instance:show("岛屿修复中")

		return
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	if self._subMo:isAllIslandFullMax() then
		FloatWordMgr.instance:show("岛屿已满级")

		return
	end

	if not self._isCanUpgarde then
		local cfg = StKnExpConfig.instance:getIslandCfg(self._activityId) or {}
		local isAllUnlock = true

		for islandId, data in ipairs(cfg) do
			if self._subMo:isUnlockUpgardeTime(islandId) then
				if not self._subMo:isFullMaxLevelIsland(islandId) then
					FloatWordMgr.instance:show("道具不足，点击“获得材料”前往获取")

					return
				end
			else
				isAllUnlock = false
			end
		end

		if not isAllUnlock then
			FloatWordMgr.instance:show("岛屿未开启")

			return
		end

		FloatWordMgr.instance:show("道具不足，点击“获得材料”前往获取")

		return
	end

	local isCan = false
	local islandIdAndNum = self._subMo:getUpgardeIslandIdAndNum()

	for _, v in ipairs(islandIdAndNum) do
		local islandId, num = v.left, v.right

		if num > 0 then
			isCan = true

			break
		end
	end

	if not isCan then
		FloatWordMgr.instance:show("道具不足，点击“获得材料”前往获取")

		return
	end

	StKnExpController.instance:sendPM_SaintKnightExpeditionUpgardeIslandReq(self._activityId, islandIdAndNum)
end

return StKnExpIslandView

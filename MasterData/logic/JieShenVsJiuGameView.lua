-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/view/JieShenVsJiuGameView.lua

module("logic.extensions.jieshenvsjiu.view.JieShenVsJiuGameView", package.seeall)

local JieShenVsJiuGameView = class("JieShenVsJiuGameView", LinkGameBaseView)

JieShenVsJiuGameView.hideTime = 0.1

function JieShenVsJiuGameView:ctor()
	JieShenVsJiuGameView.super.ctor(self)
end

function JieShenVsJiuGameView:bindEvents()
	JieShenVsJiuGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
end

function JieShenVsJiuGameView:unbindEvents()
	JieShenVsJiuGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
end

function JieShenVsJiuGameView:buildUI()
	JieShenVsJiuGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._txtStep = self:getTxt("txtStep")
	self._txtTime = self:getTxt("txtTime")
	self._txtPairs = self:getTxt("txtPairs")
	self._btnStart = self:getGo("btnStart")
end

function JieShenVsJiuGameView:onEnter()
	JieShenVsJiuGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PopupImageRuleClose, self._onCloseRuleView, self)

	local params = self:getOpenParam()

	if params then
		self._lastViewId = params[1] or 0
	end

	if params then
		self._gameId = params[2] or 394001
	end

	print("gameId = ", self._gameId, "lastViewId = ", self._lastViewId)

	self._gameActCfg = JieShenVsJiuConfig.instance:getGameActCfg(self._gameId)
	self._ruleId = checknumber(self._gameActCfg.ruleId or 1)
	self._gameTime = self._gameActCfg.gameTime or 60
	self._pairs = 0
	self._txtTime.text = lang("游戏尚未开始")
	self._txtPairs.text = lang("当前已获投票数：<color=#63EFF7FF>0</color>")

	if not LinkGameModel.instance:getIsReadRule(self._gameId) then
		self._isFirstReadRule = true

		self:_onClickRule()
		LinkGameModel.instance:setIsReadRule(self._gameId)
	else
		self._isFirstReadRule = false

		self:_readyStartGame()
	end
end

function JieShenVsJiuGameView:onExit()
	JieShenVsJiuGameView.super.onExit(self)

	self._targetTime = nil

	removetimer(self._onClock, self)
	removetimer(self._onLinkEffectEnd, self)
end

function JieShenVsJiuGameView:setMapData()
	local gameId = JieShenVsJiuController.instance:getTheGameId()

	self._miniGameCfg = JieShenVsJiuConfig.instance:getGameMiniGameCfgs(gameId)
	self._iconCfg = JieShenVsJiuConfig.instance:getGameIconCfgs(self._miniGameCfg.iconPlan)

	if string.nilorempty(self._miniGameCfg.map) then
		FloatWordMgr.instance:show("未有地图数据")
		self:close()
	else
		local mapInfo = GameUtil.jsonToTable(self._miniGameCfg.map)

		LinkGameModel.instance:setMapData(mapInfo, true)
	end

	if self._miniGameCfg.isRandom == true then
		LinkGameController.instance:randomCurMap()
	end
end

function JieShenVsJiuGameView:_readyStartGame()
	GameUtil.SetActive(self._btnStart, true)
end

function JieShenVsJiuGameView:_startGame()
	JieShenVsJiuGameView.super._startGame(self)
	GameUtil.SetActive(self._btnStart, false)

	self._targetTime = ServerTime.now() + self._gameTime
	self._isOnTime = false

	self:_onClock()
	removetimer(self._onClock, self)
	settimer(1, self._onClock, self, true)

	self._txtPairs.text = lang("已获投票数：<color=#63EFF7FF>0</color>")
end

function JieShenVsJiuGameView:_onDeadGame()
	self:_pauseGame(self._gameTime)
	TipsFacade.instance:openTipWindow(lang("提示"), lang("当前无操作空间，即将重新排列！"), function()
		LinkGameController.instance:randomCurMap()
		self:_genarateMap()
		self:_recoverGame()
		removetimer(self._onSelectEnd, self)
		settimer(1, self._onSelectEnd, self, false)
	end)
end

function JieShenVsJiuGameView:_updateCell(cell, cellInfo)
	local go = cell.gameObject
	local cellInfoGo = goutil.findChild(go, "cellInfo")
	local iconChangeColor = goutil.findChildComponent(go, "cellInfo/imgIconColor", "UIImageColorChange")
	local imgIcon = goutil.findChild(go, "cellInfo/imgIcon/con")
	local linkGo = goutil.findChild(go, "linkGo")
	local btnClick = goutil.findChild(go, "cellInfo/btnClick")
	local selectGo = goutil.findChild(go, "cellInfo/imgSelect")

	GameUtil.SetActive(selectGo, false)
	GameUtil.addClickHandler(btnClick, function()
		self:_onSelectCell(cellInfo.index)
	end, self)
	MaterialMgr.resetAll(imgIcon)

	if cellInfo.stateIdx > 0 then
		if self._iconCfg[cellInfo.stateIdx] then
			GameUtil.SetActive(iconChangeColor, false)
			GameUtil.SetActive(imgIcon, true)
			MaterialMgr.setIcon(imgIcon, MatType.Pet, self._iconCfg[cellInfo.stateIdx].raceId)
		else
			GameUtil.SetActive(iconChangeColor, false)
			GameUtil.SetActive(imgIcon, false)
		end

		iconChangeColor:SetState(cellInfo.stateIdx - 1)
		GameUtil.SetActive(cellInfoGo, true)
		GameUtil.SetActive(linkGo, false)
	else
		GameUtil.SetActive(cellInfoGo, false)
	end
end

function JieShenVsJiuGameView:_onSelectEnd()
	self._txtPairs.text = langPara("已获投票数：<color=#63EFF7FF>%d</color>", self:_getCurRemovePairs())

	JieShenVsJiuGameView.super._onSelectEnd(self)
end

function JieShenVsJiuGameView:_checkGame()
	local countMap = LinkGameModel.instance:getStateCountMap()
	local hasPairs = false

	for i, v in pairs(countMap) do
		if checknumber(v) > 0 then
			hasPairs = true

			break
		end
	end

	if not hasPairs then
		self._pairs = LinkGameModel.instance:getRemovePairs() + checknumber(self._pairs)

		self:setMapData()
		self:_genarateMap()
	end

	if self._isOnTime == true then
		self:_endGame()
	end
end

function JieShenVsJiuGameView:_getCurRemovePairs()
	return LinkGameModel.instance:getRemovePairs() + checknumber(self._pairs)
end

function JieShenVsJiuGameView:_showLinkEffect()
	for i = 2, #self._curPath - 1 do
		if self._linkObject[self._curPath[i].row] and self._linkObject[self._curPath[i].row][self._curPath[i].col] then
			local go = self._linkObject[self._curPath[i].row][self._curPath[i].col]
			local linkGo = goutil.findChild(go, "linkGo")

			for j = 0, linkGo.transform.childCount - 1 do
				local stateGo = linkGo.transform:GetChild(j)

				for k = 0, stateGo.transform.childCount - 1 do
					local imageGO = stateGo.transform:GetChild(k)
					local img = imageGO:GetComponent(typeof(UnityEngine.UI.Image))

					img.color = Color.white
				end
			end
		end

		local beforePoint = self._curPath[i - 1]
		local afterPoint = self._curPath[i + 1]

		if beforePoint.col == afterPoint.col then
			self:setCellLinkState(self._curPath[i], true, 1, 0)
		elseif beforePoint.row == afterPoint.row then
			self:setCellLinkState(self._curPath[i], true, 1, 1)
		else
			local rotateTime = 0

			rotateTime = beforePoint.col == self._curPath[i].col and (beforePoint.row > self._curPath[i].row and 0 or 2) or beforePoint.col > self._curPath[i].col and 1 or -1

			local vectorBegin = {
				x = self._curPath[i].col - beforePoint.col,
				y = self._curPath[i].row - beforePoint.row
			}
			local vectorAfter = {
				x = afterPoint.col - self._curPath[i].col,
				y = afterPoint.row - self._curPath[i].row
			}
			local vectorOffset = {
				x = vectorAfter.x + vectorBegin.x,
				y = vectorAfter.y + vectorBegin.y
			}
			local crossProduct = vectorBegin.x * vectorOffset.y - vectorOffset.x * vectorBegin.y

			if crossProduct > 0 then
				self:setCellLinkState(self._curPath[i], true, 2, rotateTime)
			else
				self:setCellLinkState(self._curPath[i], true, 3, rotateTime)
			end
		end
	end

	removetimer(self._hideLinkEffect, self)
	settimer(math.min(0.05 * #self._curPath, 0.05), self._hideLinkEffect, self, false)
end

function JieShenVsJiuGameView:_hideLinkEffect()
	for i, cellInfo in ipairs(self._curPath) do
		if self._linkObject[cellInfo.row] and self._linkObject[cellInfo.row][cellInfo.col] and i > 1 and i < #self._curPath then
			local go = self._linkObject[cellInfo.row][cellInfo.col]
			local linkGo = goutil.findChild(go, "linkGo")

			for j = 0, linkGo.transform.childCount - 1 do
				local stateGo = linkGo.transform:GetChild(j)

				for k = 0, stateGo.transform.childCount - 1 do
					local imageGO = stateGo.transform:GetChild(k)

					UnityTweens.UITweenFadeOut.StartTween(imageGO.gameObject, JieShenVsJiuGameView.hideTime)
				end
			end
		end

		if self._mapObject[cellInfo.row] and self._mapObject[cellInfo.row][cellInfo.col] and (i == 1 or i == #self._curPath) then
			local go = self._mapObject[cellInfo.row][cellInfo.col]
			local cellInfoGo = goutil.findChild(go, "cellInfo")
			local bg = goutil.findChild(cellInfoGo, "bg")
			local imgSelect = goutil.findChild(cellInfoGo, "imgSelect")
			local imgIconGo = goutil.findChild(cellInfoGo, "imgIcon")
			local imgCon = goutil.findChild(cellInfoGo, "imgIcon/con")

			UnityTweens.UITweenFadeOut.StartTween(bg, JieShenVsJiuGameView.hideTime)
			UnityTweens.UITweenFadeOut.StartTween(imgSelect, JieShenVsJiuGameView.hideTime)
			UnityTweens.UITweenFadeOut.StartTween(imgCon, JieShenVsJiuGameView.hideTime)

			local disappearEffectPath = "20230929/tianyanlianliankan/fx_ui_gezixiaoshi1.prefab"
			local effectHandle = UIEffectManager.instance:playEffect(self, disappearEffectPath, nil, 0, 0, false)

			effectHandle:setParent(imgIconGo.transform)
			effectHandle:setLocalPos(1, -8.5, 0)
			effectHandle:setScale(0.7, 0.77, 0.7)
		end
	end

	removetimer(self._onLinkEffectEnd, self)
	settimer(JieShenVsJiuGameView.hideTime + 0.01, self._onLinkEffectEnd, self, false)
end

function JieShenVsJiuGameView:setCellLinkState(cellInfo, isShow, linkState, param)
	if self._linkObject[cellInfo.row] and self._linkObject[cellInfo.row][cellInfo.col] then
		local go = self._linkObject[cellInfo.row][cellInfo.col]
		local linkGo = goutil.findChild(go, "linkGo")

		GameUtil.SetActive(linkGo, isShow)

		if isShow == true then
			for i = 1, linkGo.transform.childCount do
				stateGo = goutil.findChild(linkGo, "state" .. i)

				GameUtil.SetActive(stateGo, linkState == i)
			end

			GameUtil.setLocalRotation(linkGo, 0, 0, 90 * checknumber(param))
		end
	end
end

function JieShenVsJiuGameView:getCellSize()
	return {
		x = 104,
		y = 104
	}
end

function JieShenVsJiuGameView:getCellOffset()
	return {
		x = 4.4,
		y = 0
	}
end

function JieShenVsJiuGameView:_onLinkEffectEnd()
	for i, v in ipairs(self._curPath) do
		self:setCellLinkState(v, false, 1, 1)
	end

	LinkGamePlayView.super._onLinkEffectEnd(self)
end

function JieShenVsJiuGameView:_endGame()
	JieShenVsJiuGameView.super._endGame(self)

	local removePairs = self:_getCurRemovePairs()

	if self._isOnTime == true then
		local desc = string.format("成功消除对数%s", removePairs)

		TipsFacade.instance:openTipWindowNoX("游戏结束", desc, function()
			JieShenVsJiuController.instance:onThisGameTimesEnd(self._lastViewId, removePairs)

			local isPass = self._isOnTime == true

			self:_doFinfishCallBack(isPass, removePairs)
			self:close()
		end)
	else
		self:_doFinfishCallBack(false, removePairs)
		self:close()
	end
end

function JieShenVsJiuGameView:_doFinfishCallBack(isPass, removePairs)
	local info = {}

	info.isPass = isPass
	info.gameScore = removePairs

	settimer(1, function()
		GameUtil.callBack(self._finishCallBack, info)
	end, self, false)
end

function JieShenVsJiuGameView:_onClickClose()
	self:_pauseGame(self._gameTime)
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("退出将不会保存进度，是否退出"), function()
		self:_recoverGame()
		self:_endGame()
	end, function()
		self:_recoverGame()
	end)
end

function JieShenVsJiuGameView:_onClickRule()
	self:_pauseGame(self._gameTime)

	local ruleCfg = JieShenVsJiuConfig.instance:getGameRuleCfgs(self._ruleId or 1)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade:openImageRuleView(ruleList, "游戏规则")
end

function JieShenVsJiuGameView:_onClickStart()
	self:_startGame()
end

function JieShenVsJiuGameView:_pauseGame(defautTime)
	self._isPauseGame = true
	self._saveTime = checknumber(self._targetTime) > 0 and self._targetTime - ServerTime.now() or defautTime
end

function JieShenVsJiuGameView:_recoverGame()
	if checknumber(self._saveTime) > 0 then
		self._targetTime = self._saveTime + ServerTime.now()
	end

	self._isPauseGame = false
	self._saveTime = 0
end

function JieShenVsJiuGameView:_onClock()
	if self._isPauseGame == true then
		return
	end

	if ServerTime.now() > self._targetTime then
		self._isOnTime = true

		if self._isSelecting == false then
			self:_endGame()
		end

		removetimer(self._onClock, self)

		self._txtTime.text = langPara("倒计时剩余：" .. "%d", 0)
	else
		self._txtTime.text = langPara("倒计时剩余：" .. "%d", self._targetTime - ServerTime.now())
	end
end

function JieShenVsJiuGameView:_onCloseRuleView()
	if self._isFirstReadRule == true then
		self._isFirstReadRule = false

		self:_readyStartGame()
		self:_recoverGame()
	else
		self:_recoverGame()
	end
end

return JieShenVsJiuGameView

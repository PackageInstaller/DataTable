-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGamePlayView.lua

module("logic.extensions.linkgame.view.LinkGamePlayView", package.seeall)

local LinkGamePlayView = class("LinkGamePlayView", LinkGameBaseView)

LinkGamePlayView.DisappearTime = 0.1

function LinkGamePlayView:ctor()
	LinkGamePlayView.super.ctor(self)
end

function LinkGamePlayView:bindEvents()
	LinkGamePlayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function LinkGamePlayView:unbindEvents()
	LinkGamePlayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function LinkGamePlayView:buildUI()
	LinkGamePlayView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._txtStep = self:getTxt("txtStep")
end

function LinkGamePlayView:onEnter()
	self.addGEvent(self, GlobalNotify.handlePM_LinkGameStartGameRes, self._startGame, self)
	self.addGEvent(self, GlobalNotify.handlePM_LinkGameEndGameRes, self._PM_LinkGameEndGameRes, self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._stageId = params[2]
	self._actCfg = LinkGameConfig.instance:getActivityCfg(self._actId)
	self._stageCfg = LinkGameConfig.instance:getStageCfg(self._actId, self._stageId)

	LinkGamePlayView.super.onEnter(self)

	if not LinkGameModel.instance:getIsReadRule(self._actId) then
		self._isFirstReadRule = true

		self:_onClickRule()
		LinkGameModel.instance:setIsReadRule(self._actId)
	else
		self._isFirstReadRule = false
	end

	LinkGameController.instance:sendPM_LinkGameStartGameReq(self._actId, self._stageId)

	self._isWin = false
end

function LinkGamePlayView:onExit()
	LinkGamePlayView.super.onExit(self)
	removetimer(self._onLinkEffectEnd, self)
end

function LinkGamePlayView:_startGame()
	LinkGamePlayView.super._startGame(self)

	local step = LinkGameModel.instance:getRemovePairs()

	self._txtStep.text = langPara("当前已使用步数：%d", step)
end

function LinkGamePlayView:setMapData()
	self._miniGameCfg = LinkGameConfig.instance:getMiniGameCfg(self._stageCfg.gameId)
	self._iconCfg = LinkGameConfig.instance:getIconCfgs(self._miniGameCfg.iconPlan)

	if string.nilorempty(self._miniGameCfg.map) then
		FloatWordMgr.instance:show("未有地图数据")
		self:close()
	else
		local mapInfo = GameUtil.jsonToTable(self._miniGameCfg.map)

		LinkGameModel.instance:setMapData(mapInfo, true)
	end

	if self._miniGameCfg.isRandom == true then
		LinkGameController.instance:randomCurMap(self._stageCfg.specialTypeID)
	end
end

function LinkGamePlayView:_onDeadGame()
	TipsFacade.instance:openTipWindow(lang("提示"), lang("当前无操作空间，即将重新排列！"), function()
		LinkGameController.instance:randomCurMap(self._stageCfg.specialTypeID)
		self:_genarateMap()
		removetimer(self._onSelectEnd, self)
		settimer(1, self._onSelectEnd, self, false)
	end)
end

function LinkGamePlayView:_updateCell(cell, cellInfo)
	local go = cell.gameObject
	local cellInfoGo = goutil.findChild(go, "cellInfo")
	local iconChangeColor = goutil.findChildComponent(go, "cellInfo/imgIconColor", "UIImageColorChange")
	local imgIcon = goutil.findChild(go, "cellInfo/imgIcon/con")
	local linkGo = goutil.findChild(go, "linkGo")
	local btnClick = goutil.findChild(go, "cellInfo/btnClick")
	local selectGo = goutil.findChild(go, "cellInfo/imgSelect")
	local txtTarget = goutil.findChildTextComponent(go, "cellInfo/txtTarget")

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

	GameUtil.SetActive(txtTarget, false)

	if cellInfo.stateIdx == self._stageCfg.specialTypeID then
		GameUtil.SetActive(txtTarget, false)

		if cellInfo.index == self._stageCfg.specialID[#self._stageCfg.specialID] then
			MaterialMgr.resetAll(imgIcon)
			MaterialMgr.setIcon(imgIcon, MatType.Pet, self._stageCfg.exchangePetId)

			txtTarget.text = 2
		else
			txtTarget.text = 1
		end
	end
end

function LinkGamePlayView:getCellSize()
	return {
		x = 138,
		y = 138
	}
end

function LinkGamePlayView:getCellOffset()
	return {
		x = 8.4,
		y = 8.4
	}
end

function LinkGamePlayView:_showLinkEffect()
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
	settimer(math.min(0.05 * #self._curPath, 0.2), self._hideLinkEffect, self, false)
end

function LinkGamePlayView:_hideLinkEffect()
	for i, cellInfo in ipairs(self._curPath) do
		if self._linkObject[cellInfo.row] and self._linkObject[cellInfo.row][cellInfo.col] and i > 1 and i < #self._curPath then
			local go = self._linkObject[cellInfo.row][cellInfo.col]
			local linkGo = goutil.findChild(go, "linkGo")

			for j = 0, linkGo.transform.childCount - 1 do
				local stateGo = linkGo.transform:GetChild(j)

				for k = 0, stateGo.transform.childCount - 1 do
					local imageGO = stateGo.transform:GetChild(k)

					UnityTweens.UITweenFadeOut.StartTween(imageGO.gameObject, LinkGamePlayView.DisappearTime)
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

			UnityTweens.UITweenFadeOut.StartTween(bg, LinkGamePlayView.DisappearTime)
			UnityTweens.UITweenFadeOut.StartTween(imgSelect, LinkGamePlayView.DisappearTime)
			UnityTweens.UITweenFadeOut.StartTween(imgCon, LinkGamePlayView.DisappearTime)

			local effectHandle = UIEffectManager.instance:playEffect(self, (self._mapData[cellInfo.row][cellInfo.col].stateIdx == self._stageCfg.specialTypeID or nil) and "20230929/tianyanlianliankan/fx_ui_gezixiaoshi2.prefab", nil, 0, 0, false, nil, nil)

			effectHandle:setParent(imgIconGo.transform)
			effectHandle:setScale(0.7, 0.77, 0.7)
			effectHandle:setLocalPos(1, -8.5, 0)
		end
	end

	settimer(LinkGamePlayView.DisappearTime + 0.02, self._onLinkEffectEnd, self, false)
end

function LinkGamePlayView:setCellLinkState(cellInfo, isShow, linkState, param)
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

function LinkGamePlayView:_onLinkEffectEnd()
	for i, v in ipairs(self._curPath) do
		self:setCellLinkState(v, false, 1, 1)
	end

	LinkGamePlayView.super._onLinkEffectEnd(self)
end

function LinkGamePlayView:_onSelectEnd()
	LinkGamePlayView.super._onSelectEnd(self)

	local step = LinkGameModel.instance:getRemovePairs()

	self._txtStep.text = langPara("当前已使用步数：<color=#63EFF7FF>%d</color>", step)
end

function LinkGamePlayView:_checkGame()
	local countMap = LinkGameModel.instance:getStateCountMap()

	if checknumber(countMap[self._stageCfg.specialTypeID]) <= 0 then
		self._isWin = true
		self._isFirstWin = false
		self._newRecord = false

		local stateInfo = LinkGameModel.instance:getStageInfo(self._stageId)

		if checknumber(stateInfo) > 0 then
			if stateInfo > LinkGameModel.instance:getRemovePairs() then
				self._newRecord = true
			end
		else
			self._isFirstWin = true
			self._newRecord = true
		end

		LinkGameController.instance:sendPM_LinkGameEndGameReq(self._actId, self._stageId, true, LinkGameModel.instance:getRemovePairs())
		self:_endGame()
	end
end

function LinkGamePlayView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("退出将不会保存进度，是否退出"), function()
		self:_endGame()
		LinkGameController.instance:sendPM_LinkGameEndGameReq(self._actId, self._stageId, false, 0)
	end)
end

function LinkGamePlayView:_onClickRule()
	local ruleCfg = LinkGameConfig.instance:getRuleCfgs(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade:openImageRuleView(ruleList, "游戏规则")
end

function LinkGamePlayView:_PM_LinkGameEndGameRes(changeId)
	if self._isWin == true and changeId then
		UIStateManager.instance:push(ViewName.LinkGameOverView, changeId, LinkGameModel.instance:getRemovePairs(), self._newRecord, self._isFirstWin)
	else
		self:close()
	end
end

return LinkGamePlayView

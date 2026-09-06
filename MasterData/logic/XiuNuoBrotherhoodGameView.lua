-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/XiuNuoBrotherhoodGameView.lua

module("logic.extensions.xiunuobrotherhood.view.XiuNuoBrotherhoodGameView", package.seeall)

local XiuNuoBrotherhoodGameView = class("XiuNuoBrotherhoodGameView", SxGameNewView)

function XiuNuoBrotherhoodGameView:ctor()
	XiuNuoBrotherhoodGameView.super.ctor(self)

	self._buffMoveSpeed = 0.5
	self._enemyMoveSpeed = 0.2
	self._blockFlyEffectPath = {
		[SxGameCellType.Red] = "20220902/shenqiaruisi/fx_ui_sqars_lv.prefab",
		[SxGameCellType.Yellow] = "20220902/shenqiaruisi/fx_ui_sqars_lv.prefab",
		[SxGameCellType.Blue] = "20220902/shenqiaruisi/fx_ui_sqars_lv.prefab",
		[SxGameCellType.Green] = "20220902/shenqiaruisi/fx_ui_sqars_lv.prefab",
		[SxGameCellType.Purple] = "20220902/shenqiaruisi/fx_ui_sqars_lv.prefab"
	}
	self._levelUpEffectPath = "20220902/shenqiaruisi/fx_ui_sqars_jdlv.prefab"
	self._xiaochuEffectPath = "fx_ui_sanxiao/fx_ui_sanxiao_xiaochu.prefab"
	self._buffViewName = ViewName.XiuNuoBrotherhoodBuffView
end

function XiuNuoBrotherhoodGameView:buildUI()
	XiuNuoBrotherhoodGameView.super.buildUI(self)

	self._btnClose = GameUtil.asBtn(self:getGo("btnClose"))
	self._btnReset = self:getBtn("btnReset")
	self._btnTip = self:getBtn("btnTip")
	self._tableview = self:getGo("tableview")
	self._tableContent = self:getGo("tableview/Nego_Viewport/Nego_Content")
	self._pointCell = self:getGo("pointCell")
	self._scrollList = ScrollerList.create(self._tableview, self._pointCell, GameUtil.handler(self._updatePointCell, self), GameUtil.handler(self._clearPointCell, self))

	self._scrollList:regReloadFinish(GameUtil.handler(self._enemyLoadFinish, self))

	self._enemyCell = self:getGo("enemyCell")
	self._enemyContainer = self:getGo("tableview/Nego_Viewport/Nego_Content/enemyContainer")
	self._tableviewBuff = self:getGo("tableviewBuff")
	self._tableBuffCell = self:getGo("buffCell")
	self._scrollListBuff = ScrollerList.create(self._tableviewBuff, self._tableBuffCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._effectContainer = self:getGo("effectContainer")
	self._effectContainerPos = GameUtil.getAnchoredPos(self._effectContainer)
	self._effectCell = self:getGo("effectCell")

	local pointObj = goutil.findChild(self._pointCell, "point")

	self._pointOffset = self._tableview.transform.localPosition - self._effectContainer.transform.localPosition + pointObj.transform.localPosition
	self._txtGet = self:getTxt("txtGet")
	self._txtTotalScore = self:getTxt("txtTotalScore")
	self._txtName = self:getTxt("txtName")
	self._passGame = self:getGo("passGame")
	self._bubble = self:getGo("bubble")
	self._customInput = UICustomInput.Get(self._bubble)
	self._txtBubble = self:getTxt("bubble/tableview/Viewport/Content/txtDesc")
end

function XiuNuoBrotherhoodGameView:bindEvents()
	XiuNuoBrotherhoodGameView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	self._customInput:AddListener(self._onClickBubbleInput, self)
end

function XiuNuoBrotherhoodGameView:unbindEvents()
	XiuNuoBrotherhoodGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnTip)
	self._customInput:RemoveListener()
end

function XiuNuoBrotherhoodGameView:onEnter()
	self:addGlobalEvent()

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._gameActivityId = params[3]
	self._firstEnter = not XiuNuoBrotherhoodModel.instance:getInBattle()
	self._activityCfg = XiuNuoBrotherhoodConfig.instance:getActivityCfg(self._activityId)
	self._stageCfg = XiuNuoBrotherhoodConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._bossPlan = XiuNuoBrotherhoodConfig.instance:getBossPlanCfgs(self._stageCfg.bossPlanId)
	self._gameCfg = ThreeMatchesGameConfig.instance:getStageCfg(self._gameActivityId, self._stageId)

	GameUtil.SetActive(self._enemyCell, false)

	self._effectHandlers = {}
	self._resetCold = false

	self:_initView()
	XiuNuoBrotherhoodController.instance:sendPM_XiuNuoBrotherhoodInfoReq(self._activityId, self._stageId, self._gameActivityId)

	if not XiuNuoBrotherhoodModel.instance:getAutoShowTip() then
		self:_onClickTip()
		XiuNuoBrotherhoodModel.instance:saveAutoShowTip()
	end
end

function XiuNuoBrotherhoodGameView:onExit()
	XiuNuoBrotherhoodGameView.super.onExit(self)

	self._resetCold = false

	removetimer(self._canMove, self)
	removetimer(self._endTipsEnd, self)
	removetimer(self._refreshView, self)
	removetimer(self._moveEnemyList, self)
	removetimer(self._checkStalemate, self)
	removetimer(self._resetColdDown, self)
	self._scrollList:dispose()
	self._scrollListBuff:dispose()

	self._isCanFight = false

	XiuNuoBrotherhoodModel.instance:setInBattle(false)
end

function XiuNuoBrotherhoodGameView:onExitFinished()
	XiuNuoBrotherhoodGameView.super.onExitFinished(self)

	if self._effectPools then
		for i, v in pairs(self._effectPools) do
			v:clear()
		end

		self._effectPools = nil
	end
end

function XiuNuoBrotherhoodGameView:_initView()
	self._enemyPosList = {}

	for i = 1, self._stageCfg.endPos + 1 do
		table.insert(self._enemyPosList, {
			isEmpty = true,
			isPlayer = false,
			index = i
		})
	end

	table.insert(self._enemyPosList, {
		isEmpty = true,
		isPlayer = true,
		index = self._stageCfg.endPos + 2
	})
	GameUtil.SetActive(self._passGame, false)

	local matType, id

	self._activityItemType, id, _ = MaterialMgr.getMatParams(self._activityCfg.item)
	self._activityItem = id
	self._buffList = nil
	self._combo = 0
	self._addScore = 0
	self._txtTotalScore.text = langPara("当前分数：%d", XiuNuoBrotherhoodModel.instance:getTotalScore())
	self._txtName.text = langPara("%s", self._stageCfg.name)

	GameUtil.SetActive(self._bubble, false)

	if self._enemyDataList then
		for i, v in pairs(self._enemyDataList) do
			goutil.destroy(v.go)
		end
	end

	self._enemyDataList = {}
end

function XiuNuoBrotherhoodGameView:addGlobalEvent()
	XiuNuoBrotherhoodGameView.super.addGlobalEvent(self)
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._PM_ThreeMatchesGameInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._PM_XiuNuoBrotherhoodInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodStartMove, self._PM_XiuNuoBrotherhoodStartMove, self)
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodEndMove, self._PM_XiuNuoBrotherhoodEndMoveRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiuNuoBrotherhoodReset, self._PM_XiuNuoBrotherhoodResetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ThreeMathesComboFish, self._onComboFish, self)
	GlobalDispatcher:addListener(GlobalNotify.ThreeMathesTryDoAction, self._onMoveAction, self)
	GlobalDispatcher:addListener(GlobalNotify.Combo, self._onScoreCount, self)
end

function XiuNuoBrotherhoodGameView:rmGlobalEvent()
	XiuNuoBrotherhoodGameView.super.rmGlobalEvent(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._PM_ThreeMatchesGameInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodGetInfo, self._PM_XiuNuoBrotherhoodInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodStartMove, self._PM_XiuNuoBrotherhoodStartMove, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodEndMove, self._PM_XiuNuoBrotherhoodEndMoveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiuNuoBrotherhoodReset, self._PM_XiuNuoBrotherhoodResetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThreeMathesComboFish, self._onComboFish, self)
	GlobalDispatcher:removeListener(GlobalNotify.ThreeMathesTryDoAction, self._onMoveAction, self)
	GlobalDispatcher:removeListener(GlobalNotify.Combo, self._onScoreCount, self)
end

function XiuNuoBrotherhoodGameView:_refreshView()
	if self:_checkEnd() == false then
		self:_refreshViewPos()
		self:_refreshBuff()
		self:_onClickFight()
	end

	settimer(0.5, self._checkStalemate, self, false)
end

function XiuNuoBrotherhoodGameView:_refreshViewPos()
	self._isCanFight = false
	self._fightBossId = 0

	local countHave = 0
	local totalNum = 0
	local getNum = 0

	for i, v in ipairs(XiuNuoBrotherhoodModel.instance:getEnemyList(self._stageCfg.bossPlanId)) do
		if not string.nilorempty(self._bossPlan[v.bossId].prize) then
			local params = string.split(self._bossPlan[v.bossId].prize, "#")

			for j, k in ipairs(params) do
				local matType, id, matNum

				matType, id, matNum = MaterialMgr.getMatParams(k)

				if matType == self._activityItemType and id == self._activityItem then
					totalNum = totalNum + matNum

					if v.state == -1 then
						getNum = getNum + matNum
					end

					break
				end
			end
		end

		if v.state ~= -1 then
			if v.state == 1 then
				self._isCanFight = true
				self._fightBossId = v.bossId
			end
		else
			countHave = countHave + 1
		end

		if not self._enemyDataList[v.bossId] then
			self._enemyDataList[v.bossId] = {}
			self._enemyDataList[v.bossId].go = goutil.cloneAndSetParent(self._enemyCell, self._enemyContainer.transform)
		end

		self._enemyDataList[v.bossId].bossId = v.bossId
		self._enemyDataList[v.bossId].state = v.state
		self._enemyDataList[v.bossId].step = v.step
	end

	for i, v in pairs(self._enemyDataList) do
		self:_updateEnemyCell(v.go, v)
	end

	self._txtGet.text = langPara("当前获得券:%d/%d\n当前波数:%d/%d", getNum, totalNum, countHave, #self._bossPlan)

	for i, v in ipairs(self._enemyPosList) do
		v.isEmpty = true
	end

	self._scrollList:reloadData(self._enemyPosList)

	if self._isCanFight == true then
		SxGameModel.instance:waitMoveRes()
	else
		settimer(0.2, self._canMove, self, false)
	end

	self._enemyContainer.transform:SetAsLastSibling()
end

function XiuNuoBrotherhoodGameView:_refreshBuff()
	self._txtTotalScore.text = langPara("当前分数：%d", XiuNuoBrotherhoodModel.instance:getTotalScore() + self._addScore)

	local firstEnter

	if not self._buffList then
		firstEnter = true
		self._buffList = {}

		for i, v in ipairs(self._stageCfg.buffTypes) do
			table.insert(self._buffList, {
				exp = 0,
				isLevelUp = false,
				buffType = v,
				lv = self._activityCfg.initBuffLv
			})
		end
	end

	for i, v in ipairs(XiuNuoBrotherhoodModel.instance:getBuffInfo()) do
		for j, k in ipairs(self._buffList) do
			if k.buffType == v.buffType then
				k.isLevelUp = k.lv < v.lv and v.lv ~= 0 and not firstEnter
				k.lv = v.lv
				k.exp = v.exp

				break
			end
		end
	end

	self._scrollListBuff:reloadData(self._buffList)

	self._buffCellPos = {}

	for i = 0, #self._buffList - 1 do
		local cell = self._scrollListBuff:getView():GetCellByIndex(i)

		if cell ~= nil then
			local cellPos = GameUtil.getAnchoredPos(cell.gameObject) + GameUtil.getAnchoredPos(self._tableviewBuff)
			local buffCfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(self._buffList[i + 1].buffType, 1)

			self._buffCellPos[buffCfg.blockId] = {
				posX = cellPos.x - self._effectContainerPos.x,
				posY = cellPos.y - self._effectContainerPos.y
			}
		end
	end
end

function XiuNuoBrotherhoodGameView:_updateEnemyCell(cell, data)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local enemyCon = goutil.findChild(go, "enemyCon/con")
	local btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
	local receivedGo = goutil.findChild(go, "receivedGo")
	local enemyCfg = XiuNuoBrotherhoodConfig.instance:getBossPlanCfg(self._stageCfg.bossPlanId, data.bossId)
	local teamCfg = XiuNuoBrotherhoodConfig.instance:getEnemyTeam(enemyCfg.creepsMasterId)

	GameUtil.SetActive(go, data.state ~= -1)
	GameUtil.SetActive(receivedGo, data.state and data.state == -1)
	MaterialMgr.setIcon(enemyCon, MatType.Pet, teamCfg.showFaceId)

	if not string.nilorempty(enemyCfg.prize) then
		local params = string.split(enemyCfg.prize, "#")

		MaterialMgr.setCellByCfg(params[1], item)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(self._onClickFight, self)
end

function XiuNuoBrotherhoodGameView:_updatePointCell(view, cell, data, tag)
	local go = cell.gameObject
	local enemyGo = goutil.findChild(go, "enemyCon")
	local enemyCon = goutil.findChild(go, "enemyCon/con")
	local point = goutil.findChild(go, "point")
	local pointChange = goutil.findChildComponent(go, "point", "UIImageSpriteChange")

	if data.index == 1 then
		pointChange:SetState(2)
	elseif data.index == self._stageCfg.endPos + 2 then
		pointChange:SetState(0)
	else
		pointChange:SetState(1)
	end

	GameUtil.SetActive(point, true)
	GameUtil.SetActive(enemyGo, not data.isEmpty or data.isPlayer)
	GameUtil.SetActive(enemyCon, not data.isEmpty or data.isPlayer)

	if data.isEmpty == true and data.isPlayer then
		MaterialMgr.setIcon(enemyCon, MatType.Pet, self._activityCfg.raceId)
	end

	self._enemyContainer.transform:SetAsLastSibling()
end

function XiuNuoBrotherhoodGameView:_clearPointCell(cell)
	local go = cell.gameObject
	local enemyCon = goutil.findChild(go, "enemyCon")

	MaterialMgr.resetAll(enemyCon)
end

function XiuNuoBrotherhoodGameView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local img = goutil.findChildComponent(go, "img", "UIImageSpriteChange")
	local btn = GameUtil.asBtn(img)
	local txtExp = goutil.findChildTextComponent(go, "txt")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local buffCfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(data.buffType, data.lv)
	local nextCfg = XiuNuoBrotherhoodConfig.instance:getBuffTypeCfg(data.buffType, data.lv + 1)
	local buffACfg, buffBCfg

	if nextCfg then
		txtExp.text = string.format("%d/%d", data.exp, nextCfg.exp)
		txtLevel.text = string.format("Lv%d", data.lv)
	else
		txtExp.text = string.format("%d/%d", buffCfg.exp, buffCfg.exp)
		txtLevel.text = string.format("Lv%d", data.lv)
	end

	if buffCfg then
		if img then
			img:ChangeSprite(buffCfg.resName)
		end

		buffACfg = XiuNuoBrotherhoodConfig.instance:getBuff(buffCfg.buffA)
		buffBCfg = XiuNuoBrotherhoodConfig.instance:getBuff(buffCfg.buffB)
	elseif nextCfg then
		if img then
			img:ChangeSprite(nextCfg.resName)
		end

		buffACfg = XiuNuoBrotherhoodConfig.instance:getBuff(nextCfg.buffA)
		buffBCfg = XiuNuoBrotherhoodConfig.instance:getBuff(nextCfg.buffB)
	end

	if buffACfg and buffBCfg then
		btn:AddClickListener(function()
			local cellPos = GameUtil.getAnchoredPos(go) + GameUtil.getAnchoredPos(self._tableviewBuff)

			GameUtil.SetActive(self._bubble, true)

			self._txtBubble.text = langPara("可在挑战中，任选其一效果加成\n效果1：%s\n效果2：%s", buffACfg.des, buffBCfg.des)

			GameUtil.setAnchoredPos(self._bubble, cellPos.x, cellPos.y)
		end, self)
	end

	if data.isLevelUp == true then
		local handler = UIEffectManager.instance:playEffect(self, self._levelUpEffectPath, img, 0, 0, false, false, nil)

		handler:setParent(img.transform)
		handler:setLocalPos(0, 0, 0)
		handler:setScale(1)
	end
end

function XiuNuoBrotherhoodGameView:_clearBuffCell(cell)
	local go = cell.gameObject
	local img = goutil.findChild(go, "img")
	local btn = GameUtil.asBtn(img)

	btn:RemoveClickListener()
	uGuiUtil.clearImage(img)
end

function XiuNuoBrotherhoodGameView:_canMove()
	SxGameModel.instance:getMoveRes()
end

function XiuNuoBrotherhoodGameView:_checkStalemate()
	if SxGameModel.instance:JudgeAndGetProsible() == false then
		FloatWordMgr.instance:show(lang("当前游戏关卡已进入死局，已随机重新摆放局面"))
		self:_resetMap()
	end
end

function XiuNuoBrotherhoodGameView:_checkEnd()
	if XiuNuoBrotherhoodModel.instance:getPassStageIds() then
		for i, v in pairs(XiuNuoBrotherhoodModel.instance:getPassStageIds()) do
			if v == self._stageId then
				self:_endGame()

				return true
			end
		end
	end

	return false
end

function XiuNuoBrotherhoodGameView:_endGame()
	GameUtil.SetActive(self._passGame, true)

	local open = XiuNuoBrotherhoodModel.instance:getStageOpen(self._stageId + 1)

	SxGameModel.instance:waitMoveRes()
	settimer(3, self._endTipsEnd, self, false)
end

function XiuNuoBrotherhoodGameView:_endTipsEnd()
	local open = false

	if open then
		local size = SxGameModel.instance:getGameMapSize()

		for i = 1, size.y do
			for j = 1, size.x do
				local cell = self._cells[i][j]

				if cell then
					cell:onDestroy()
				end

				self._cells[i][j] = nil
			end
		end

		for k, v in pairs(self._cellPools) do
			v:clear()
		end

		self._cellPools = {}
		self._cells = nil

		SxGameController.instance:defaultState()
		SxGameModel.instance:reset()

		self._stageId = self._stageId + 1
		self._combo = 0
		self._stageCfg = XiuNuoBrotherhoodConfig.instance:getStageCfg(self._activityId, self._stageId)
		self._bossPlan = XiuNuoBrotherhoodConfig.instance:getBossPlanCfgs(self._stageCfg.bossPlanId)
		self._gameCfg = ThreeMatchesGameConfig.instance:getStageCfg(self._gameActivityId, self._stageId)
		self._firstEnter = true

		self:_initView()
		XiuNuoBrotherhoodController.instance:sendPM_XiuNuoBrotherhoodInfoReq(self._activityId, self._stageId, self._gameActivityId)
	else
		self:close()
	end
end

function XiuNuoBrotherhoodGameView:_disposeEffectFunc(obj)
	GameUtil.SetActive(obj.gameObject, false)

	if self._effectHandlers[obj] then
		UIEffectManager.instance:stopEffect(self._effectHandlers[obj])

		self._effectHandlers[obj] = nil
	end

	goutil.destroy(obj.gameObject)
end

function XiuNuoBrotherhoodGameView:_resetEffectFunc(obj)
	GameUtil.SetActive(obj.gameObject, false)
end

function XiuNuoBrotherhoodGameView:_onMoveAction()
	if self._isCanFight == true then
		self:_onClickFight()
	end
end

function XiuNuoBrotherhoodGameView:_onClickClose()
	if SxGameController.instance:isCanDoAction() then
		self:close()
	end
end

function XiuNuoBrotherhoodGameView:_onClickFight()
	if SxGameController.instance:getCurrStateName() == "SxGameDefaultState" and self._isCanFight == true and self._fightBossId > 0 then
		UIStateManager.instance:push(self._buffViewName, self._activityId, self._stageId, self._fightBossId, self._gameActivityId)
	end
end

function XiuNuoBrotherhoodGameView:_onClickReset()
	if SxGameController.instance:isCanDoAction() then
		if self._resetCold == true then
			FloatWordMgr.instance:show(lang("重置太快了，稍等一下吧"))

			return
		end

		TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否要重置本关进度"), function()
			XiuNuoBrotherhoodAgent.instance:sendPM_XiuNuoBrotherhoodResetReq(self._activityId, self._stageId)
		end)
	end
end

function XiuNuoBrotherhoodGameView:_onClickTip()
	UIStateManager.instance:open(ViewName.XiuNuoBrotherhoodTipView)
end

function XiuNuoBrotherhoodGameView:_onClickBubbleInput(hover)
	if not hover then
		GameUtil.SetActive(self._bubble, false)
	end
end

function XiuNuoBrotherhoodGameView:_onNormalEffect(cellGo, callback, type)
	UIEffectManager.instance:playEffect(self, self._xiaochuEffectPath, cellGo, 0, 0, false, false, nil, callback)

	if type == SxGameCellType.MoveForward then
		FloatWordMgr.instance:show(lang("受到道具影响，敌军前进了一步"))
	elseif type == SxGameCellType.MoveBack then
		FloatWordMgr.instance:show(lang("受到道具影响，敌军后退了一步"))
	end

	self:_onNormalMoveEffect(cellGo, type)
end

function XiuNuoBrotherhoodGameView:_onNormalMoveEffect(cellGo, type)
	if cellGo and SxGameModel.instance:isCanRemoveType(type) and self._buffCellPos[type] then
		local effectObj = self:_getEffectObj(SxGameCellType.Red)
		local cellPos = GameUtil.getAnchoredPos(cellGo)

		GameUtil.setAnchoredPos(effectObj, cellPos.x, cellPos.y)

		local tween = UnityTweens.TweenPosition.StartTween(effectObj, Vector3.New(cellPos.x, cellPos.y, 0), Vector3.New(self._buffCellPos[type].posX, self._buffCellPos[type].posY, 0), self._buffMoveSpeed)

		tween:RemoveListener()
		tween:AddListener(function()
			GameUtil.SetActive(effectObj.gameObject, false)
			self._effectPools[SxGameCellType.Red]:returnObject(effectObj)
		end)
	elseif cellGo and (type == SxGameCellType.MoveForward or type == SxGameCellType.MoveBack) then
		for i, v in pairs(self._enemyDataList) do
			local pointCell = self._scrollList:getView():GetCellAtIndex(v.step)

			if pointCell and v.state ~= -1 then
				local effectObj = self:_getEffectObj(SxGameCellType.Red)
				local endPos = self._pointOffset + self._tableContent.transform.localPosition + pointCell.transform.localPosition

				GameUtil.setAnchoredPos(effectObj, cellGo.transform.localPosition.x, cellGo.transform.localPosition.y)

				local tween = UnityTweens.TweenPosition.StartTween(effectObj, Vector3.New(cellGo.transform.localPosition.x, cellGo.transform.localPosition.y, 0), Vector3.New(endPos.x, endPos.y, 0), self._buffMoveSpeed)

				tween:RemoveListener()
				tween:AddListener(function()
					GameUtil.SetActive(effectObj.gameObject, false)
					self._effectPools[SxGameCellType.Red]:returnObject(effectObj)
				end)
			end
		end
	end
end

function XiuNuoBrotherhoodGameView:_getEffectObj(type)
	if not self._blockFlyEffectPath[type] then
		function resetFunc(obj)
			self:_resetEffectFunc(obj)
		end

		function disposeFunc(obj)
			self:_disposeEffectFunc(obj)
		end

		function effectLoadEnd(handler, eff)
			local trs = eff.effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

			for i = 0, trs.Length - 1 do
				trs[i].enabled = false
			end
		end

		self._effectPools = self._effectPools or {}
		self._effectPools[type] = self._effectPools[type] or ObjectPool.New(8, nil, disposeFunc, resetFunc)

		local cellObj

		if self._effectPools[type] then
			cellObj = self._effectPools[type]:fetchObject()
		end

		if not cellObj then
			cellObj = goutil.cloneAndSetParent(self._effectCell, self._effectContainer.gameObject.transform)

			if self._effectHandlers[cellObj] then
				UIEffectManager.instance:stopEffect(self._effectHandlers[cellObj])

				self._effectHandlers[cellObj] = nil
			end

			self._effectHandlers[cellObj] = UIEffectManager.instance:playEffect(self, self._blockFlyEffectPath[type], cellObj, 0, 0, true, false, nil, effectLoadEnd)

			self._effectHandlers[cellObj]:setParent(cellObj.transform)
			self._effectHandlers[cellObj]:setLocalPos(0, 0, 0)
			self._effectHandlers[cellObj]:setScale(1)
			GameUtil.SetActive(cellObj, false)
		end

		if self._effectHandlers[cellObj].effGo then
			local trs = self._effectHandlers[cellObj].effGo:GetComponentsInChildren(typeof(UnityEngine.TrailRenderer))

			for i = 0, trs.Length - 1 do
				trs[i].enabled = false
			end
		end

		GameUtil.SetActive(cellObj, true)

		return cellObj
	end
end

function XiuNuoBrotherhoodGameView:_onComboFish(combo)
	self:_moveEnemy(0)

	self._combo = combo

	SxGameModel.instance:waitMoveRes()
	XiuNuoBrotherhoodController.instance:sendPM_XiuNuoBrotherhoodStartMoveReq(self._activityId, self._stageId)
end

function XiuNuoBrotherhoodGameView:_onScoreCount()
	self:_moveEnemy(0)
end

function XiuNuoBrotherhoodGameView:_PM_XiuNuoBrotherhoodStartMove()
	local removeCells = SxGameModel.instance:getPreRemoveCell()
	local newBlocks = SxGameModel.instance:getMapArrList()
	local comboScore = 0

	for i, v in ipairs(ThreeMatchesGameConfig.instance:getComboCfg()) do
		if self._combo >= v.combo then
			comboScore = v.score
		end
	end

	local blockResult = {}
	local totalscore = 0

	for i, v in pairs(removeCells) do
		local result = ThreeMatchesGameExtension_pb.ThreeMatchesBlockResult()

		result.blockId = i
		result.num = v
		result.blockScore = ThreeMatchesGameConfig.instance:getBlockInfo(i).score > 0 and result.num * ThreeMatchesGameConfig.instance:getBlockInfo(i).score + comboScore or 0
		totalscore = totalscore + result.blockScore

		table.insert(blockResult, result)
	end

	self._preBossPosition = {}

	for i, v in ipairs(XiuNuoBrotherhoodModel.instance:getEnemyList(self._stageCfg.bossPlanId)) do
		if v.state == 0 then
			table.insert(self._preBossPosition, {
				bossId = v.bossId,
				step = v.step
			})
		end
	end

	self._addScore = self._addScore + totalscore

	self:_moveEnemy(1)
	XiuNuoBrotherhoodController.instance:sendPM_XiuNuoBrotherhoodEndMoveReq(self._activityId, self._stageId, newBlocks, blockResult, totalscore)
end

function XiuNuoBrotherhoodGameView:_moveEnemy(startMove)
	local totalMove = startMove

	for i, v in pairs(SxGameModel.instance:getPreRemoveCell()) do
		totalMove = totalMove + (ThreeMatchesGameConfig.instance:getBlockInfo(i).addStep - ThreeMatchesGameConfig.instance:getBlockInfo(i).cutStep) * v
	end

	for i, v in pairs(self._enemyDataList) do
		if v.state ~= -1 then
			local movePos = #self._enemyPosList - (v.step + totalMove)

			movePos = math.max(movePos, 0)
			movePos = math.min(movePos, #self._enemyPosList - 1)

			UnityTweens.TweenPosition.StopTween(v.go)
			UnityTweens.TweenPosition.StartTween(v.go, Vector3.New(GameUtil.getAnchoredPos(v.go).x, GameUtil.getAnchoredPos(v.go).y, 0), Vector3.New(self._scrollList:getView().cellOffset.x, self._scrollList:getView():GetOffsetByIndex(movePos) + self._pointCellOffset, 0), self._enemyMoveSpeed, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
		end
	end
end

function XiuNuoBrotherhoodGameView:_PM_XiuNuoBrotherhoodEndMoveRes()
	self:_refreshView()
end

function XiuNuoBrotherhoodGameView:_PM_XiuNuoBrotherhoodResetRes()
	settimer(2, self._resetColdDown, self, false)

	self._resetCold = true

	self:_removeAllCell()

	self._firstEnter = true

	self:_initView()
	XiuNuoBrotherhoodController.instance:sendPM_XiuNuoBrotherhoodInfoReq(self._activityId, self._stageId, self._gameActivityId)
end

function XiuNuoBrotherhoodGameView:_PM_XiuNuoBrotherhoodInfoRes()
	if self._preBossPosition then
		for i, v in ipairs(self._preBossPosition) do
			-- block empty
		end
	end

	self:_refreshView()
end

function XiuNuoBrotherhoodGameView:_moveEnemyList()
	self._scrollList:getView():MoveOffset(2 * self._scrollList:getView():GetCellSize(self.moveIndex), false, true)

	self.moveIndex = self.moveIndex + 1

	if self.moveIndex < #self._enemyPosList then
		if self._scrollList:getView():GetOffset() >= self._scrollList:getView():GetMaxOffset() then
			self._enemyContainer.transform:SetAsLastSibling()
			removetimer(self._moveEnemyList, self)
		end
	end
end

function XiuNuoBrotherhoodGameView:_enemyLoadFinish()
	self._pointCellOffset = self._scrollList:getView().cellOffset.y

	if self._scrollList:getView().cellOffset2.y ~= 0 then
		local gridHeight = GameUtil.getHeight(self._pointCell)
		local offset = gridHeight + self._scrollList:getView().cellOffset.y

		self._pointCellOffset = offset < 0 and self._scrollList:getView().cellOffset2.y - offset - gridHeight / 2 or self._scrollList:getView().cellOffset.y + self._scrollList:getView().cellOffset2.y * 2
	end

	if self._firstEnter == true then
		self._scrollList:MoveCellToCenter(1)

		self.moveIndex = 2

		settimer(0.1, self._moveEnemyList, self, true)

		self._firstEnter = false

		XiuNuoBrotherhoodModel.instance:setInBattle(false)

		for i, v in pairs(self._enemyDataList) do
			GameUtil.setAnchoredPos(v.go, self._scrollList:getView().cellOffset.x, self._scrollList:getView():GetOffsetByIndex(#self._enemyPosList - v.step) + self._pointCellOffset)
		end
	elseif XiuNuoBrotherhoodModel.instance:getInBattle() == true then
		self._scrollList:MoveCellToCenter(#self._enemyPosList)

		for i, v in pairs(self._enemyDataList) do
			GameUtil.setAnchoredPos(v.go, self._scrollList:getView().cellOffset.x, self._scrollList:getView():GetOffsetByIndex(#self._enemyPosList - v.step) + self._pointCellOffset)
		end
	else
		for i, v in pairs(self._enemyDataList) do
			if v.state ~= -1 then
				UnityTweens.TweenPosition.StopTween(v.go)
				UnityTweens.TweenPosition.StartTween(v.go, Vector3.New(GameUtil.getAnchoredPos(v.go).x, GameUtil.getAnchoredPos(v.go).y, 0), Vector3.New(self._scrollList:getView().cellOffset.x, self._scrollList:getView():GetOffsetByIndex(#self._enemyPosList - v.step) + self._pointCellOffset, 0), self._enemyMoveSpeed, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
			end
		end
	end

	self._enemyContainer.transform:SetAsLastSibling()
end

function XiuNuoBrotherhoodGameView:_resetColdDown()
	self._resetCold = false
end

return XiuNuoBrotherhoodGameView

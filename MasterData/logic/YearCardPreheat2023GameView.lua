-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023GameView.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023GameView", package.seeall)

local YearCardPreheat2023GameView = class("YearCardPreheat2023GameView", ViewComponent)

function YearCardPreheat2023GameView:buildUI()
	YearCardPreheat2023GameView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnCollate = self:getGo("btnCollate")
	self._chessBoard = self:getGo("chessboard")
	self._chessCell = goutil.findChild(self._chessBoard, "chesscell")
	self._chessCellList = {}

	goutil.setActive(self._chessCell, false)

	self._playerPos = self:getGo("playerPos")
	self._eventAction = {
		fight = 1,
		light = 4,
		gainPrize = 2,
		talk = 3
	}
	self._txtProgress = self:getTxt("txtProgress")
	self._clueCellParent = self:getGo("clues/tableview/Viewport/Content")
	self._clueCell = goutil.findChild(self._clueCellParent, "clueCell")
	self._clueCellList = {}

	goutil.setActive(self._clueCell, false)
end

function YearCardPreheat2023GameView:bindEvents()
	YearCardPreheat2023GameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnCollate, self._onClickCollate, self)
end

function YearCardPreheat2023GameView:unbindEvents()
	YearCardPreheat2023GameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollate)
end

function YearCardPreheat2023GameView:onEnter()
	YearCardPreheat2023GameView.super.onEnter(self)

	if YearCardPreheat2023Model.instance:isFirstShowRuleView() then
		self:_onClickTip()
	end

	self:_refreshViewByCfg()
	self:_buildChessBoard()
	self:_refreshChessBoard()
	self:_refreshCloe()
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheat2023Domove, self._onMove, self)
	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onEndStory, self)
	YearCardPreheat2023Model.instance:ShowCI()

	local path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._spine = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self._playerPos.transform)
		eff:setScale(0.2)
		eff:setLocalPos(0, -15, 0)
		RoleObjectPool.instance:playAnimation(eff.effGo, "idle", true)
	end)
	path = "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_jm.prefab"
	self._mainEff = UIEffectManager.instance:playEffect(self, "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_jm.prefab", nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
end

function YearCardPreheat2023GameView:onExit()
	YearCardPreheat2023GameView.super.onExit(self)

	for k, cell in ipairs(self._chessCellList) do
		self:_clearCell(cell)
	end

	for k, cell in ipairs(self._clueCellList) do
		self:_clearCell(cell)
	end

	removetimer(self._dealClueSc, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheat2023Domove, self._onMove, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onEndStory, self)

	if self._spine then
		UIEffectManager.instance:stopEffect(self._spine)

		self._spine = nil
	end

	if self._mainEff then
		UIEffectManager.instance:stopEffect(self._mainEff)

		self._mainEff = nil
	end

	if self._gameEff then
		UIEffectManager.instance:stopEffect(self._gameEff)

		self._gameEff = nil
	end

	if self._gameEff2 then
		UIEffectManager.instance:stopEffect(self._gameEff2)

		self._gameEff2 = nil
	end

	removetimer(self._endMove, self)

	if self._tweenList then
		for i, v in ipairs(self._tweenList) do
			v:Kill()
		end

		self._tweenList = nil
	end
end

function YearCardPreheat2023GameView:_onClickClose()
	if self._isMoving then
		return
	end

	if self._isAbleCollate then
		TipsFacade.instance:openTipWindowNoX(lang("提示"), lang("将立即为您进行线索整合，线索整合完毕后可退出本界面"), function()
			self:_onClickCollate()
		end)
	else
		self:close()
		UIStateManager.instance:push(ViewName.YearCardPreheat2023View, self._actId)
	end
end

function YearCardPreheat2023GameView:_onClickTip()
	UIStateManager.instance:push(ViewName.YearCardPreheat2023GameRuleView)
end

function YearCardPreheat2023GameView:_onClickCollate()
	if self._isTimeUsed then
		FloatWordMgr.instance:show(lang("今日探索次数已用尽"))

		return
	end

	if self._isAbleCollate then
		UIStateManager.instance:push(ViewName.YearCardPreheat2023ClueView)
	else
		FloatWordMgr.instance:show(lang("请集齐线索后再进行线索整合"))
	end
end

function YearCardPreheat2023GameView:_refreshViewByCfg()
	self._actId = YearCardPreheat2023Model.instance:getActId()

	local actCfg = YearCardPreheat2023Config.instance:getActCfgByActId(self._actId)
	local designId = YearCardPreheat2023Model.instance:getCurDesignId()
	local designCfgs = YearCardPreheat2023Config.instance:getDesignCfgsByPlanId(actCfg.designPlanId)

	self._designCfg = designCfgs and designCfgs[designId]

	local planId = self._designCfg.cluePlanId

	self._clueCfgs = YearCardPreheat2023Config.instance:getClueCfgsByPlanId(planId)
	self._dailyTimes = actCfg.dailyTimes or 0
end

function YearCardPreheat2023GameView:_buildChessBoard()
	for k, v in pairs(self._chessCellList) do
		self:_clearCell(v)
		goutil.setActive(v.go, false)
	end

	local chessId = 0

	for i_w = 1, checkint(self._designCfg.mapWidth) do
		for i_l = 1, checkint(self._designCfg.mapLength) do
			chessId = chessId + 1

			local cell = {}
			local goCell = goutil.findChild(self._chessBoard, "chesscell" .. chessId)

			cell.go = goCell or goutil.cloneAndSetParent(self._chessCell, self._chessBoard.transform, "chesscell" .. chessId)
			cell.posX = i_w - 1
			cell.posY = i_l - 1
			cell.info = nil
			cell.btnClick = goutil.findChild(cell.go, "btnClick")
			cell.icon = goutil.findChild(cell.go, "icon")
			cell.cover = goutil.findChild(cell.go, "cover")
			cell.txtIcon = goutil.findChildTextComponent(cell.icon, "txt")
			cell.txtShow = goutil.findChildTextComponent(cell.go, "txtShow")
			cell.txtShow.text = langPara("%s-%s", cell.posX, cell.posY)

			GameUtil.rmClickHandler(cell.btnClick)
			GameUtil.addClickHandler(cell.btnClick, GameUtil.handler(self._onClickMove, self, cell))
			goutil.setActive(cell.go, true)
			goutil.setActive(cell.icon, false)

			self._chessCellList[chessId] = cell
		end
	end

	for k, v in ipairs(self._clueCellList) do
		self:_clearCell(v)

		v.cfg = nil

		goutil.setActive(v.go, false)
	end

	self._clueCellList = {}

	for k, v in ipairs(self._clueCfgs) do
		local cell = {}
		local goCell = goutil.findChild(self._clueCellParent, "cluecell" .. k)

		cell.go = goCell or goutil.cloneAndSetParent(self._clueCell, self._clueCellParent.transform, "cluecell" .. k)
		cell.cfg = v
		cell.icon = goutil.findChild(cell.go, "item/icon")
		cell.cover = goutil.findChild(cell.go, "item/txtCover")
		cell.txtIcon = goutil.findChildTextComponent(cell.icon, "txt")
		cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
		cell.txtDesc.text = "??????"

		goutil.setActive(cell.cover, true)
		goutil.setActive(cell.icon, false)
		goutil.setActive(cell.go, true)
		table.insert(self._clueCellList, cell)
	end
end

function YearCardPreheat2023GameView:_refreshChessBoard()
	self:_refreshCellInfo()

	for i, v in ipairs(self._chessCellList) do
		goutil.setActive(v.cover, not v.info)

		local info = v.info

		if info and info.clueId ~= 0 then
			local cfg = self._clueCfgs[info.clueId]

			if not string.nilorempty(cfg.cluePicture) then
				uGuiUtil.clearImage(v.icon)
				uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", cfg.cluePicture))
				goutil.setActive(v.icon, true)

				v.txtShow.text = langPara("%s-%s-%s", v.posX, v.posY, info.clueId)
			end

			if info.gainClue then
				goutil.setActive(v.icon, false)
			end
		end

		if v.posX == self._curPosX and self._curPosY == v.posY then
			self._playerPos.transform.parent = v.go.transform

			GameUtil.setAnchoredPos(self._playerPos, 0, 0)
		end
	end
end

function YearCardPreheat2023GameView:_clearCell(cell)
	if cell and cell.go then
		uGuiUtil.clearImage(cell.icon)
	end
end

function YearCardPreheat2023GameView:_refreshCloe()
	for k, v in ipairs(self._clueCellList) do
		if table.keyof(self._curGainCloeIds, k) then
			v.txtDesc.text = v.cfg.content

			goutil.setActive(v.cover, false)
			goutil.setActive(v.icon, true)

			if not string.nilorempty(v.cfg.cluePicture) then
				uGuiUtil.clearImage(v.icon)
				uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", v.cfg.cluePicture))
			end
		end
	end

	self._txtProgress.text = langPara("已收集：%s/%s", self._totalGainCloeNum, #self._clueCfgs)

	removetimer(self._dealClueSc, self)
	settimer(0.1, self._dealClueSc, self, false)
end

function YearCardPreheat2023GameView:_dealClueSc()
	local curHeight = 0

	for k, v in ipairs(self._clueCellList) do
		GameUtil.setAnchoredPos(v.go, 0, -curHeight)

		curHeight = GameUtil.getHeight(v.go) + curHeight + 5
	end

	GameUtil.setHeight(self._clueCellParent, curHeight)
end

function YearCardPreheat2023GameView:_onClickMove(cell)
	if self._isMoving then
		return
	end

	if self._isAbleCollate then
		FloatWordMgr.instance:show(lang("已集齐全部线索，请前往整合"))

		return
	end

	local moveStep = math.abs(cell.posX - self._curPosX) + math.abs(cell.posY - self._curPosY)

	if moveStep == 1 then
		local moveToId = cell.posX * self._designCfg.mapLength + 1 + cell.posY

		if self._chessCellList[moveToId] then
			local info = self._chessCellList[moveToId].info

			self._isMoveToUnknow = not info
			self._needToDealEvent = info and not info.gainClue

			YearCardPreheat2023Controller.instance:move(self._actId, cell.posX, cell.posY)
		end
	elseif moveStep == 0 then
		local info = cell and cell.info

		if info then
			if not info.clueId then
				local clueId = 0

				if clueId == 0 then
					-- block empty
				end
			end
		end
	else
		FloatWordMgr.instance:show(lang("只能移动到相邻格子"))
	end
end

function YearCardPreheat2023GameView:_refreshCellInfo()
	self._curPosX, self._curPosY = YearCardPreheat2023Model.instance:getPos()
	self._totalGainCloeNum = 0
	self._curGainCloeIds = {}
	self._curPosCellId = 0

	for i, v in ipairs(self._chessCellList) do
		local info = YearCardPreheat2023Model.instance:getGridInfo(v.posX, v.posY)

		v.info = info

		if info and info.clueId ~= 0 then
			if info.gainClue then
				self._totalGainCloeNum = self._totalGainCloeNum + 1

				table.insert(self._curGainCloeIds, info.clueId)
			end
		end

		if v.posX == self._curPosX and self._curPosY == v.posY then
			self._curPosCellId = i
		end
	end

	self._isTimeUsed = YearCardPreheat2023Model.instance:getUsesGameTimes() >= self._dailyTimes
	self._isAbleCollate = self._totalGainCloeNum >= #self._clueCfgs and not self._isTimeUsed
end

function YearCardPreheat2023GameView:_onMove()
	self._lastY = self._curPosY

	self:_refreshCellInfo()

	local cell = self._chessCellList[self._curPosCellId]
	local info = cell and cell.info

	if info then
		if not info.clueId then
			local clueId = 0
			local clueCfg = self._clueCfgs[clueId]

			if self._isMoveToUnknow then
				if clueCfg and not string.nilorempty(clueCfg.cluePicture) then
					uGuiUtil.clearImage(cell.icon)
					uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", clueCfg.cluePicture))
					goutil.setActive(cell.icon, true)

					cell.txtShow.text = langPara("%s-%s-%s", cell.posX, cell.posY, info.clueId)
				end

				goutil.setActive(cell.cover, false)
			end

			self._isMoving = true

			removetimer(self._endMove, self)
			settimer(0.6, self._endMove, self, false)

			if self._spine then
				RoleObjectPool.instance:playAnimation(self._spine.effGo, "run", true)
			end

			if self._lastY > self._curPosY then
				self._spine:setLocalEulerAngle(0, 0, 0)
			else
				self._spine:setLocalEulerAngle(0, 180, 0)
			end

			local tween = self._playerPos.transform:DOMove(cell.go.transform.position, 0.5)

			self._tweenList = self._tweenList or {}

			table.insert(self._tweenList, tween)
		end
	end
end

function YearCardPreheat2023GameView:_endMove()
	self._isMoving = false

	local cell = self._chessCellList[self._curPosCellId]
	local info = cell and cell.info

	if info then
		if not info.clueId then
			local clueId = 0
			local clueCfg = self._clueCfgs[clueId]

			if self._spine then
				RoleObjectPool.instance:playAnimation(self._spine.effGo, "idle", true)
			end

			self._playerPos.transform.parent = cell.go.transform

			GameUtil.setAnchoredPos(self._playerPos, 0, 0)

			if clueId ~= 0 then
				if info.gainClue then
					goutil.setActive(cell.icon, false)
				end

				if self._isMoveToUnknow or self._needToDealEvent then
					if clueCfg.type == self._eventAction.fight then
						if clueCfg.plotId > 0 then
							GlobalDispatcher:dispatch(GlobalNotify.PushStory, clueCfg.plotId, StoryModel.StoryType.SCCopy)
						else
							self:_enterFight(clueId)
						end
					elseif clueCfg.type == self._eventAction.talk then
						if clueCfg.plotId > 0 then
							GlobalDispatcher:dispatch(GlobalNotify.PushStory, clueCfg.plotId, StoryModel.StoryType.SCCopy)
						else
							YearCardPreheat2023Model.instance:ShowCI()
						end
					elseif clueCfg.type == self._eventAction.light then
						local path = "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_deng.prefab"

						if self._gameEff then
							UIEffectManager.instance:stopEffect(self._gameEff)

							self._gameEff = nil
						end

						self._gameEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
							local path = "20221223/zhaohuanmiyu/fx_ui_zhaohuanmiyu_yun.prefab"

							if self._gameEff2 then
								UIEffectManager.instance:stopEffect(self._gameEff2)

								self._gameEff2 = nil
							end

							self._gameEff2 = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, false, nil, function()
								for i, v in ipairs(self._chessCellList) do
									goutil.setActive(v.cover, false)

									local info = v.info

									if info and info.clueId ~= 0 then
										local cfg = self._clueCfgs[info.clueId]

										if not string.nilorempty(cfg.cluePicture) then
											uGuiUtil.clearImage(v.icon)
											uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", cfg.cluePicture))
											goutil.setActive(v.icon, true)

											v.txtShow.text = langPara("%s-%s-%s", v.posX, v.posY, info.clueId)
										end

										if info.gainClue then
											goutil.setActive(v.icon, false)
										end
									end
								end

								YearCardPreheat2023Model.instance:ShowCI()
							end, function(finishHandlerTarget, eff)
								eff:setParent(self.mainGO.transform)
								eff:setScale(1)
								eff:setLocalPos(0, 0, 0)
							end)
						end, function(finishHandlerTarget, eff)
							eff:setParent(cell.go.transform)
							eff:setScale(1)
							eff:setLocalPos(0, 0, 0)
						end)
					elseif clueCfg.type == self._eventAction.gainPrize then
						YearCardPreheat2023Model.instance:ShowCI()
					else
						YearCardPreheat2023Model.instance:ShowCI()
					end
				end
			end

			self:_refreshCloe()
		end
	end
end

function YearCardPreheat2023GameView:_enterFight(clueId)
	local clueCfg = self._clueCfgs[clueId]

	if clueCfg then
		local mo = YearCardPreheat2023Model.instance:getCustomFmtMo()

		mo:initParams(clueCfg.creepsMasterId)
		CustomFmtController.instance:showMissionView(mo)
	end
end

function YearCardPreheat2023GameView:_onEndStory(storyId)
	local cell = self._chessCellList[self._curPosCellId]
	local info = cell and cell.info

	if info then
		if not info.clueId then
			local clueId = 0
			local clueCfg = self._clueCfgs[clueId]

			if clueCfg then
				if storyId ~= clueCfg.plotId then
					return
				end

				if clueCfg.type == self._eventAction.fight then
					self:_enterFight(clueId)
				elseif clueCfg.type == self._eventAction.talk then
					YearCardPreheat2023Model.instance:ShowCI()
				end
			end
		end
	end
end

return YearCardPreheat2023GameView

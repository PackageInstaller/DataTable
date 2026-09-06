-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectmainView.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectmainView", package.seeall)

local JigsawcollectmainView = class("JigsawcollectmainView", TableViewComponent)

function JigsawcollectmainView:ctor()
	JigsawcollectmainView.super.ctor(self)
end

function JigsawcollectmainView:buildUI()
	JigsawcollectmainView.super.buildUI(self)

	self._tipsBtn = self:getBtn("title/tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._rewardBtn = self:getBtn("rewardBtn")
	self._storyBtn = self:getBtn("storyBtn")
	self._sourceBtn = self:getBtn("sourceBtn")
	self._chipGroupGo = self:getGo("chipBg")
	self._chipCellGo = self:getGo("chipBg/chipCell")
	self._chipGroup = ItemGroup.New(self._chipGroupGo, self._chipCellGo, nil, nil, true)
	self._timeText = goutil.findChildTextComponent(self.mainGO, "timeText")
	self._maskGo = self:getGo("mask")
	self._effectGo = self:getGo("effect/con")
	self._effectTween = self:getGo("effect"):GetComponent(ComponentType.TweenPosition)
	self._rewardDotGo = self:getGo("rewardBtn/dot")
	self._sourceDotGo = self:getGo("sourceBtn/dot")
	self._roleConGo = self:getGo("roleCon")
	self._xiaonuoeffectPos = self:getGo("storyBtn/xiaonuoeffectPos").transform.position
	self._centerEffectPos = self:getGo("centerEffectPos").transform.position
	self._staticEffect1Go = self:getGo("staticEffect1")
	self._unlockAllEffectGo = self:getGo("unlockAllEffect")
	self._colorEggEffecGo = self:getGo("colorEggEffec/con")
	self._effectTween2 = self:getGo("colorEggEffec"):GetComponent(ComponentType.TweenPosition)
end

function JigsawcollectmainView:bindEvents()
	JigsawcollectmainView.super.bindEvents(self)
	self._effectTween:AddListener(self._effectTweenFinish, self)
	self._effectTween2:AddListener(self._effectTweenFinish, self)
	self._tipsBtn:AddClickListener(self._onClicktipsBtn, self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._rewardBtn:AddClickListener(self._onClickrewardBtn, self)
	self._storyBtn:AddClickListener(self._onClickstoryBtn, self)
	self._sourceBtn:AddClickListener(self._onClicksourceBtn, self)
end

function JigsawcollectmainView:unbindEvents()
	JigsawcollectmainView.super.unbindEvents(self)
	self._tipsBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._storyBtn:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
	self._effectTween:RemoveListener()
	self._effectTween2:RemoveListener()
end

function JigsawcollectmainView:destroyUI()
	JigsawcollectmainView.super.destroyUI(self)
end

function JigsawcollectmainView:onEnter()
	JigsawcollectmainView.super.onEnter(self)
	goutil.setActive(self._maskGo, false)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GetCurJigsawInfoRes, self._getInfoRes, self)
	GlobalDispatcher:addListener(JigsawcollectController.PlayCloseColorEggViewEffect, self._playCloseColorEggViewEffect, self)
	GlobalDispatcher:addListener(JigsawcollectController.PlayGetLastChipEffect, self._playGetLastChipEffect, self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_UnlockJigsawPieceRes, self._unlockRes, self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GainJigsawTaskPrizeRes, self._gainTaskRes, self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GainJigsawCollectPrizeRes, self.gainCollectRes, self)
	JigsawAgent.instance:sendPM_GetCurJigsawInfoReq()
	self:_updateView()
	self:_setRole()
	self:_playStaticEffect()
end

function JigsawcollectmainView:onEnterFinished()
	JigsawcollectmainView.super.onEnterFinished(self)
end

function JigsawcollectmainView:onExit()
	JigsawcollectmainView.super.onExit(self)
	removetimer(self._checkRefeshAct, self)
	goutil.setActive(self._maskGo, false)
	self._effectTween:Stop()
	self._effectTween2:Stop()
	GlobalDispatcher:removeListener(JigsawcollectController.PlayCloseColorEggViewEffect, self._playCloseColorEggViewEffect, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PlayGetLastChipEffect, self._playGetLastChipEffect, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GetCurJigsawInfoRes, self._getInfoRes, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_UnlockJigsawPieceRes, self._unlockRes, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GainJigsawTaskPrizeRes, self._gainTaskRes, self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GainJigsawCollectPrizeRes, self.gainCollectRes, self)
	self._chipGroup:dispose(function(item)
		local iconGo = goutil.findChild(item.mainGO, "icon")

		uGuiUtil.clearImage(iconGo)
	end)
	RoleObjectPool.instance:removeRole(self._roleObj)
	UIEffectManager.instance:stopEffect(self._effHandler)
	UIEffectManager.instance:stopEffect(self._statiEffectHandler1)
	UIEffectManager.instance:stopEffect(self._unlockAllEffectHandler)
	UIEffectManager.instance:stopEffect(self._colorEggEffHandler)
end

function JigsawcollectmainView:onExitFinished()
	JigsawcollectmainView.super.onExitFinished(self)
end

function JigsawcollectmainView:_onClicktipsBtn()
	TipsFacade.instance:openRulesView("jigsawcollectmainview")
end

function JigsawcollectmainView:_onClickcloseBtn()
	self:close()
end

function JigsawcollectmainView:_onClickrewardBtn()
	local isIntime = self:_isActInTime()

	if not isIntime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	UIStateManager.instance:push(ViewName.JigsawcollectrewardView)
end

function JigsawcollectmainView:_onClicksourceBtn()
	local isIntime = self:_isActInTime()

	if not isIntime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	if JigsawcollectModel.instance:checkPieceEnough(self._actId) then
		FloatWordMgr.instance:show("碎片已集齐")

		return
	end

	UIStateManager.instance:push(ViewName.JigsawcollectsourceView)
end

function JigsawcollectmainView:_onClickstoryBtn()
	UIStateManager.instance:push(ViewName.JigsawcollectsecretctView)
end

function JigsawcollectmainView:_getInfoRes(status, msg)
	if status == 0 then
		self:_updateView()
	end
end

function JigsawcollectmainView:_updateView()
	self:_updateBigBg()
	self:_updateActTime()
	self:_updateChipView()
	self:_updateUnlockChipView()
	self:_checkRedDot()
	self:_checkBtnState()
end

function JigsawcollectmainView:_updateBigBg()
	return
end

function JigsawcollectmainView:_updateActTime()
	self._actId = JigsawcollectModel.instance:getActId()
	self._actEndTime = ServerTime.now()

	removetimer(self._checkRefeshAct, self)

	if self._actId > 0 then
		local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.JigsawCollect, self._actId)

		self._actEndTime = etime

		local sdate = GameUtil.time2date(stime)
		local edate = GameUtil.time2date(etime)

		self._timeText.text = string.format("活动时间:%s月%s日-%s月%s日", sdate.month, sdate.day, edate.month, edate.day)

		if self:_isActInTime() then
			self._refreshTime = self._actEndTime - ServerTime.now()

			settimer(1, self._checkRefeshAct, self, true)
			self:_checkRefeshAct()
		end
	end
end

function JigsawcollectmainView:_checkRefeshAct()
	if self._actEndTime then
		self._actEndTime = self._actEndTime - 1

		if self._actEndTime <= 0 then
			removetimer(self._checkRefeshAct, self)
			self:_checkBtnState()

			return
		end
	else
		removetimer(self._checkRefeshAct, self)
	end
end

function JigsawcollectmainView:_updateUnlockChipView()
	local newList = {}

	for i, v in ipairs(self._curViewDatas) do
		table.insert(newList, v)
	end

	table.sort(newList, function(a, b)
		return a.id < b.id
	end)
	self._chipGroup:updateWithMoArray(newList, function(item, data)
		item.mainGO.name = "chip_" .. item.index

		local iconGo = goutil.findChild(item.mainGO, "icon")

		uGuiUtil.setSpriteToImage(iconGo, nil, GameUrl.getIconFolderUrl("jigsaw", data.icon))
		goutil.setActive(iconGo, data.is_unlock)

		local x, y = GameUtil.getPosWihtRowAndCol(53, 54, item.index, 4, 8)

		GameUtil.setAnchoredPos(item.mainGO, x, -y)
	end)
end

function JigsawcollectmainView:_updateChipView()
	local actId = JigsawcollectModel.instance:getActId()

	if actId <= 0 then
		return
	end

	local collectInfo = JigsawcollectModel.instance:getCollectInfos()
	local unlockList = {}
	local getButLockList = {}
	local notGetList = {}
	local collectedPiecesKv = {}

	for i, v in ipairs(collectInfo.collectedPieces) do
		collectedPiecesKv[v.collectedPiece] = v
	end

	local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(cfg.piecePlan)

	self._planCfgs = planCfgs

	for i, v in ipairs(planCfgs) do
		if collectedPiecesKv[v.pieceId] then
			if collectedPiecesKv[v.pieceId].isUnlock then
				table.insert(unlockList, {
					is_unlock = true,
					id = v.pieceId,
					icon = v.icon
				})
			else
				table.insert(getButLockList, {
					get_but_lock = true,
					id = v.pieceId,
					icon = v.icon
				})
			end
		else
			table.insert(notGetList, {
				not_get = true,
				id = v.pieceId,
				icon = v.icon
			})
		end
	end

	local finalList = {}

	self:_sortChip(unlockList)
	self:_sortChip(getButLockList)
	self:_sortChip(notGetList)
	table.insertto(finalList, getButLockList)
	table.insertto(finalList, unlockList)
	table.insertto(finalList, notGetList)

	self._curViewDatas = finalList

	self:reloadData()
end

function JigsawcollectmainView:_sortChip(tab)
	table.sort(tab, function(a, b)
		return a.id < b.id
	end)
end

function JigsawcollectmainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function JigsawcollectmainView:_cellSize(view, index)
	return 100, 100
end

function JigsawcollectmainView:_updateCell(view, cell, data)
	local iconGo = goutil.findChild(cell.gameObject, "icon")
	local bgGo = goutil.findChild(cell.gameObject, "bg")
	local btn = GameUtil.asBtn(bgGo)
	local tagGo = goutil.findChild(cell.gameObject, "tag")
	local tagText = goutil.findChildTextComponent(cell.gameObject, "tag/text")
	local indexText = goutil.findChildTextComponent(cell.gameObject, "image/indexText")
	local effectPosGo = goutil.findChild(cell.gameObject, "effectPos")

	indexText.text = data.id

	goutil.setActive(tagGo, data.is_unlock)
	uGuiUtil.setSpriteToImage(iconGo, nil, GameUrl.getIconFolderUrl("jigsaw", data.icon))
	GameUtil.SetGray(cell.gameObject, checkbool(data.not_get))
	btn:AddClickListener(function()
		if data.get_but_lock then
			self:_playMoveToCell(data.id, effectPosGo.transform.position)

			return
		end

		if data.not_get then
			FloatWordMgr.instance:show("未获得")

			return
		end

		if data.is_unlock then
			FloatWordMgr.instance:show("碎片已点亮")

			return
		end
	end)
end

function JigsawcollectmainView:_clearTableview(cell)
	local iconGo = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(iconGo)
end

function JigsawcollectmainView:_playMoveToCell(pieceId, position)
	goutil.setActive(self._maskGo, true)

	self._currUnlockPieceId = pieceId

	local go = goutil.findChild(self._chipGroupGo, "chip_" .. pieceId)

	JigsawcollectModel.instance:setNeedUnlockData(self._actId, self._currUnlockPieceId)
	JigsawAgent.instance:sendPM_UnlockJigsawPieceReq(self._actId, self._currUnlockPieceId)

	if go then
		self:_playMoveToCellEffct(position, go.transform.position)
	else
		goutil.setActive(self._maskGo, false)
	end
end

function JigsawcollectmainView:_playMoveToCellEffct(from, to)
	UIEffectManager.instance:stopEffect(self._colorEggEffHandler)

	self._isPlayTween = true
	self._effectTween.from = from
	self._effectTween.to = to
	self._effectTween.time = 0.5
	self._effectTween.gameObject.transform.position = from

	UIEffectManager.instance:stopEffect(self._effHandler)

	self._effHandler = UIEffectManager.instance:playEffect(self, "fx_ui_zaohuazhishen/fx_ui_trail_zaohuazhishen.prefab", self._effectGo, 0, 0, true)

	self._effHandler:setParent(self._effectGo.transform)
	self._effHandler:setScale(1)
	self._effHandler:setLocalPos(0, 0, 0)

	self._tweenState = 1

	self._effectTween:Begin()
end

function JigsawcollectmainView:_checkColorEgg()
	local cfg = self._planCfgs[self._currUnlockPieceId]

	if not string.nilorempty(cfg.title) then
		UIStateManager.instance:push(ViewName.JigsawcollectunlockView, cfg)
	end
end

function JigsawcollectmainView:_effectTweenFinish()
	if self._tweenState then
		if self._tweenState == 1 then
			UIEffectManager.instance:stopEffect(self._effHandler)

			local function finishCallBack()
				UIEffectManager.instance:stopEffect(self._effHandler)

				self._isPlayTween = false

				self:_checkColorEgg()
				goutil.setActive(self._maskGo, false)
				self:_playGetLastChipEffect()
			end

			self:_updateView()

			self._effHandler = UIEffectManager.instance:playEffect(self, "fx_ui_zaohuazhishen/fx_ui_trail_click_zaohuazhishen.prefab", self._effectGo, 0, 0, false, nil, finishCallBack)

			self._effHandler:setParent(self._effectGo.transform)
			self._effHandler:setScale(1)
			self._effHandler:setLocalPos(0, 0, 0)
		elseif self._tweenState == 2 then
			UIEffectManager.instance:stopEffect(self._colorEggEffHandler)
		end
	end

	self._tweenState = false
end

function JigsawcollectmainView:_playCloseColorEggViewEffect()
	UIEffectManager.instance:stopEffect(self._colorEggEffHandler)

	self._effectTween2.from = self._centerEffectPos
	self._effectTween2.to = self._xiaonuoeffectPos
	self._effectTween2.time = 0.5

	self._effectTween2:Begin()

	self._tweenState = 2
	self._colorEggEffHandler = UIEffectManager.instance:playEffect(self, "fx_ui_zaohuazhishen/fx_ui_trail_zaohuazhishen.prefab", self._colorEggEffecGo, 0, 0, true)

	self._colorEggEffHandler:setParent(self._colorEggEffecGo.transform)
	self._colorEggEffHandler:setScale(1)
	self._colorEggEffHandler:setLocalPos(0, 0, 0)
end

function JigsawcollectmainView:_playGetLastChipEffect(force)
	if not force and ViewMgr.instance:isOpen(ViewName.JigsawcollectunlockView) then
		return
	end

	local actId = JigsawcollectModel.instance:getActId()

	if actId <= 0 then
		return
	end

	local collectInfo = JigsawcollectModel.instance:getCollectInfos()
	local collectedPiecesKv = {}

	for i, v in ipairs(collectInfo.collectedPieces) do
		collectedPiecesKv[v.collectedPiece] = v
	end

	local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)
	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(cfg.piecePlan)
	local allUnlock = false

	for i, v in ipairs(planCfgs) do
		allUnlock = collectedPiecesKv[v.pieceId] and collectedPiecesKv[v.pieceId].isUnlock

		if not allUnlock then
			break
		end
	end

	if allUnlock then
		goutil.setActive(self._maskGo, true)

		local function finishCallBack()
			goutil.setActive(self._maskGo, false)

			local configs = {
				animName = "stroy_ui_zaohuazhishen",
				animFinishCallback = self._openLastChipTip,
				callbackTarget = self
			}

			ViewMgr.instance:open(ViewName.AnimationPlaying, configs)
		end

		self._unlockAllEffectHandler = UIEffectManager.instance:playEffect(self, "fx_ui_zaohuazhishen/fx_ui_pitu_loop_zaohuazhishen.prefab", nil, 0, 0, false, nil, finishCallBack)

		self._unlockAllEffectHandler:setParent(self._unlockAllEffectGo.transform)
		self._unlockAllEffectHandler:setScale(1)
		self._unlockAllEffectHandler:setLocalPos(0, 0, 0)
	end
end

function JigsawcollectmainView:_openLastChipTip()
	local content = "成功复原拼图！快去领取10连召唤券进度奖励吧！\n造化之神将于4月29日降临！"

	TipsFacade.instance:openTipWindow("提示", content, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function JigsawcollectmainView:_unlockRes(status)
	if status == 0 and not self._isPlayTween then
		self:_updateView()
	end
end

function JigsawcollectmainView:_checkRedDot()
	local isIntime = self:_isActInTime()

	goutil.setActive(self._rewardDotGo, isIntime and JigsawcollectModel.instance:checkCollectRewardDot(self._actId))
	goutil.setActive(self._sourceDotGo, isIntime and JigsawcollectModel.instance:checkTaskRewardDot(self._actId))
end

function JigsawcollectmainView:_gainTaskRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function JigsawcollectmainView:gainCollectRes(status)
	if status == 0 then
		self:_checkRedDot()
	end
end

function JigsawcollectmainView:_setRole()
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, 10140, self._roleConGo, 0.4, nil, false)
end

function JigsawcollectmainView:_playStaticEffect()
	self._statiEffectHandler1 = UIEffectManager.instance:playEffect(self, "fx_ui_zaohuazhishen/fx_ui_bg_zaohuazhishen.prefab", nil, 0, 0, true)

	self._statiEffectHandler1:setParent(self._staticEffect1Go.transform)
	self._statiEffectHandler1:setScale(1)
	self._statiEffectHandler1:setLocalPos(0, 0, 0)
end

function JigsawcollectmainView:_isActInTime()
	return self._actEndTime > ServerTime.now()
end

function JigsawcollectmainView:_checkBtnState()
	local isIntime = self:_isActInTime()

	GameUtil.SetGray(self._rewardBtn.gameObject, not isIntime)
	GameUtil.SetGray(self._sourceBtn.gameObject, not isIntime or JigsawcollectModel.instance:checkPieceEnough(self._actId))
end

return JigsawcollectmainView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023View.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023View", package.seeall)

local YearCardPreheat2023View = class("YearCardPreheat2023View", ViewComponent)

function YearCardPreheat2023View:buildUI()
	YearCardPreheat2023View.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnGoToGame = self:getGo("btnGoToGame")
	self._txtGoToGame = goutil.findChildTextComponent(self._btnGoToGame, "Text")
	self._redpoint = goutil.findChild(self._btnGoToGame, "redpoint")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._goClue = self:getGo("clue")
	self._goCellClue = goutil.findChild(self._goClue, "cell")
	self._goTableviewClue = goutil.findChild(self._goClue, "tableview")
	self._tableviewClue = ScrollerList.create(self._goTableviewClue, self._goCellClue, GameUtil.handler(self._updateCellClue, self), GameUtil.handler(self._clearCellClue, self))
	self._scrollRectClue = self._goTableviewClue:GetComponent(ComponentType.ScrollRect)
	self._goProgress = self:getGo("progress")
	self._goCellProgress = goutil.findChild(self._goProgress, "cell")
	self._goTableviewProgress = goutil.findChild(self._goProgress, "tableview")
	self._tableviewProgress = ScrollerList.create(self._goTableviewProgress, self._goCellProgress, GameUtil.handler(self._updateCellProgress, self), GameUtil.handler(self._clearCellProgress, self))
	self._scrollRectProgress = self._goTableviewProgress:GetComponent(ComponentType.ScrollRect)
	self._txtProgress = goutil.findChildTextComponent(self._goProgress, "txtProgress")
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		self._btnsSwitch[i] = btn
	end

	self._txtDesc = self:getTxt("bubble/txtDesc")
	self._imgShow_1 = self:getGo("imgShow_1")
	self._imgShow_2 = self:getGo("imgShow_2")
	self._fadeOut_1 = self._imgShow_1:GetComponent("UITweenFadeOut")
	self._fadeOut_2 = self._imgShow_2:GetComponent("UITweenFadeOut")
	self._con = self:getGo("con")
	self._isNeedShowImg = GameUtil.GetActive(self._imgShow_1) and GameUtil.GetActive(self._imgShow_2)
	self._isNeedCon = GameUtil.GetActive(self._con)
end

function YearCardPreheat2023View:bindEvents()
	YearCardPreheat2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGoToGame, self._onClickGotoGame, self)

	for i, v in ipairs(self._btnsSwitch) do
		GameUtil.addClickHandler(v.go, GameUtil.handler(self._onClickSwitch, self, i))
	end
end

function YearCardPreheat2023View:unbindEvents()
	YearCardPreheat2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoToGame)

	for _, v in ipairs(self._btnsSwitch) do
		GameUtil.rmClickHandler(v.go)
	end
end

function YearCardPreheat2023View:onEnter()
	YearCardPreheat2023View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardPreheat2023UpdateInfo, self._refreshViewByInfo, self)

	self._curActId = checkint(self:getFirstParam())

	if self._curActId <= 0 then
		self._curActId = YearCardPreheat2023Controller.instance:getActivityId()
	end

	self._activityType = YearCardPreheat2023Controller.instance:getActivityType()

	if YearCardPreheat2023Controller.instance:isInActivityTime(self._curActId) then
		self:_refreshViewByCfg()
		YearCardPreheat2023Controller.instance:getInfo(self._curActId)
	else
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动不在时间内"), GameUtil.handler(self.close, self))
	end

	self._switchId = 0

	self:_onClickSwitch(1)

	if self._isNeedCon then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, 16010, self._con, 1, nil, false)
	end

	RedPointController.instance:regRedPoint(self._redpoint, RedPointModel.ID_YEARCARD_PREHEAT2023_GAME)

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._curActId)
end

function YearCardPreheat2023View:onExit()
	YearCardPreheat2023View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardPreheat2023UpdateInfo, self._refreshViewByInfo, self)
	self._tableviewClue:dispose()
	self._tableviewProgress:dispose()
	removetimer(self._showNextImg, self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redpoint)
end

function YearCardPreheat2023View:_refreshViewByCfg()
	self._actCfg = YearCardPreheat2023Config.instance:getActCfgByActId(self._curActId)
	self._designCfgs = YearCardPreheat2023Config.instance:getDesignCfgsByPlanId(self._actCfg.designPlanId)
	self._progressCfgs = YearCardPreheat2023Config.instance:getProgressCfgsByPlanId(self._actCfg.progressPlanId)
end

function YearCardPreheat2023View:_refreshViewByInfo()
	self._curProgess = YearCardPreheat2023Model.instance:getCurProgress()
	self._curDesignId = YearCardPreheat2023Model.instance:getCurDesignId()

	self._tableviewClue:reloadData(self._designCfgs)

	local moveId = 0
	local ableToMoveId = 0

	for k, v in ipairs(self._progressCfgs) do
		if v.progress <= self._curProgess then
			ableToMoveId = k

			if not YearCardPreheat2023Model.instance:getIsHasGainWorldPrizeId(v.id) and moveId == 0 then
				moveId = k
			end
		end
	end

	if moveId == 0 then
		moveId = ableToMoveId
	end

	self._tableviewProgress:reloadData(self._progressCfgs)
	self._tableviewProgress:MoveCellInView(moveId)

	self._txtProgress.text = langPara("当前全服收集线索：%s", self._curProgess)
	self._curShowImgId = 0

	removetimer(self._showNextImg, self)

	if self._isNeedCon then
		goutil.setActive(self._con, false)
	end

	local txtBubble = lang("现在一点线索都没有呢")
	local txtGoToGame = lang("探索新区域")

	if self._curDesignId <= 1 then
		self._curShowImgId = 1

		self:_showNextImg()
		settimer(5, self._showNextImg, self)
	elseif self._curDesignId > #self._designCfgs then
		txtBubble = lang("原来敖九真正的样子是这样，也太帅了吧！")

		if self._isNeedCon then
			goutil.setActive(self._con, true)
		end

		txtGoToGame = lang("查看神域地图")
	else
		txtBubble = lang("根据当前线索…并不能真正了解敖九呢")
		self._curShowImgId = 1

		self:_showNextImg()
		settimer(5, self._showNextImg, self)
	end

	self._txtDesc.text = txtBubble
	self._txtGoToGame.text = txtGoToGame
end

function YearCardPreheat2023View:_showNextImg()
	if not self._isNeedShowImg then
		return
	end

	goutil.setActive(self._imgShow_1, false)
	goutil.setActive(self._imgShow_2, false)

	self._fadeOut_1.enabled = false
	self._fadeOut_2.enabled = false

	if self._curShowImgId == 1 then
		self._curShowImgId = 2

		goutil.setActive(self._imgShow_1, true)

		self._fadeOut_1.enabled = true
	else
		self._curShowImgId = 1

		goutil.setActive(self._imgShow_2, true)

		self._fadeOut_2.enabled = true
	end
end

function YearCardPreheat2023View:_updateCellClue(view, goCell, data)
	local cell = self:_clearCellClue(goCell)

	cell.txtDesc.text = data.content

	local isGain = YearCardPreheat2023Model.instance:getIsHasGainPersonPrizeId(data.id)

	goutil.setActive(cell.markGet, isGain)
	goutil.setActive(cell.cover, data.id >= self._curDesignId)
	goutil.setActive(cell.show, data.id < self._curDesignId)

	if not string.nilorempty(data.cluePicture) then
		uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", data.cluePicture))
	end

	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.item)

	if data.id < self._curDesignId and not isGain then
		self:_playCellEff(cell.item, self._scrollRectClue)
		proxy:setAutoTips(false)
		proxy:setCallBack(function()
			YearCardPreheat2023Controller.instance:gainPersonPrize(self._curActId, data.id)
		end)
	end
end

function YearCardPreheat2023View:_clearCellClue(goCell)
	local cell = {}

	cell.go = goCell
	cell.cover = goutil.findChild(cell.go, "cover")
	cell.show = goutil.findChild(cell.go, "show")
	cell.icon = goutil.findChild(cell.show, "icon")
	cell.txtIcon = goutil.findChildTextComponent(cell.icon, "txt")
	cell.item = goutil.findChild(cell.go, "item")
	cell.markGet = goutil.findChild(cell.go, "markGet")
	cell.txtDesc = goutil.findChildTextComponent(cell.show, "txtscrollContent/Viewport/Content")

	MaterialMgr.resetAll(cell.item)
	uGuiUtil.clearImage(cell.icon)
	self:_removeCellEff(cell.item)

	return cell
end

function YearCardPreheat2023View:_updateCellProgress(view, goCell, data)
	local cell = self:_clearCellProgress(goCell)

	cell.txtDesc.text = data.content
	cell.txtProgress.text = langPara("全服线索收集达<color=#c96800>%s</color>可解锁", data.progress)

	local isGain = YearCardPreheat2023Model.instance:getIsHasGainWorldPrizeId(data.id)

	goutil.setActive(cell.markGet, isGain)
	goutil.setActive(cell.cover, not isGain)
	goutil.setActive(cell.txtDesc.gameObject, isGain)
	GameUtil.addClickHandler(cell.btnGain, GameUtil.handler(self._onClickGetProgress, self, data))

	if self._curProgess >= data.progress then
		goutil.setActive(cell.btnGain, true)
		goutil.setActive(cell.txtProgress.gameObject, false)
	else
		goutil.setActive(cell.btnGain, false)
		goutil.setActive(cell.txtProgress.gameObject, true)
	end

	local proxy = MaterialMgr.setCellByCfg(data.prize, cell.item)

	if self._curProgess >= data.progress and not isGain then
		self:_playCellEff(cell.item, self._scrollRectProgress)
		proxy:setAutoTips(false)
		proxy:setCallBack(function()
			self:_onClickGetProgress(data)
		end)
	end
end

function YearCardPreheat2023View:_clearCellProgress(goCell)
	local cell = {}

	cell.go = goCell
	cell.cover = goutil.findChild(cell.go, "cover")
	cell.item = goutil.findChild(cell.go, "item")
	cell.markGet = goutil.findChild(cell.go, "markGet")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtscrollContent/Viewport/Content")
	cell.btnGain = goutil.findChild(cell.cover, "btnGain")
	cell.txtProgress = goutil.findChildTextComponent(cell.cover, "txtProgress")

	GameUtil.rmClickHandler(cell.btnGain)
	MaterialMgr.resetAll(cell.item)
	self:_removeCellEff(cell.item)

	return cell
end

function YearCardPreheat2023View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardpreheat2023rule")
end

function YearCardPreheat2023View:_onClickGotoGame()
	if self._curDesignId > #self._designCfgs then
		UIStateManager.instance:push(ViewName.YearCardPreheat2023ExploreView)
	else
		UIStateManager.instance:push(ViewName.YearCardPreheat2023GameView)
	end
end

function YearCardPreheat2023View:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		goutil.setActive(self._goClue, self._switchId == 1)
		goutil.setActive(self._goProgress, self._switchId == 2)

		for i, v in ipairs(self._btnsSwitch) do
			goutil.setActive(v.select, self._switchId == i)
		end
	end
end

function YearCardPreheat2023View:_onClickGetProgress(data)
	local isGain = YearCardPreheat2023Model.instance:getIsHasGainWorldPrizeId(data.id)

	if not isGain and self._curProgess >= data.progress then
		YearCardPreheat2023Controller.instance:gainProgressPrzie(self._curActId, data.id)
	end
end

function YearCardPreheat2023View:_playCellEff(go, scRect)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadCallBack()
		if scRect then
			self._effs[go]:setScrollRectClipping(scRect)
		end
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, true, nil, nil, loadCallBack)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScale(1)
	self._effs[go]:setLocalPos(0, 0, 0)

	self._effs[go].hideEffWhileNotOnTop = true
end

function YearCardPreheat2023View:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

return YearCardPreheat2023View

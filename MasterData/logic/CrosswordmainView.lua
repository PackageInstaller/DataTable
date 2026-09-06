-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/view/CrosswordmainView.lua

module("logic.extensions.crossword.view.CrosswordmainView", package.seeall)

local CrosswordmainView = class("CrosswordmainView", ViewComponent)
local gap = 120

function CrosswordmainView:ctor()
	CrosswordmainView.super.ctor(self)
end

function CrosswordmainView:unbindEvents()
	CrosswordmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnInput)
end

function CrosswordmainView:bindEvents()
	CrosswordmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnInput, self._onClickInput, self)
end

function CrosswordmainView:buildUI()
	CrosswordmainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._Content = self:getGo("scrollview/Viewport/Content")
	self._contentTrans = self._Content:GetComponent("RectTransform")
	self._txtTime = self:getTxt("txtTime/txt")
	self._scrollView = self:getGo("scrollview"):GetComponent("ScrollRect")
	self._viewportTrans = self:getGo("scrollview/Viewport"):GetComponent("RectTransform")
	self._cell = self:getGo("cell")
	self._txtCount = self:getTxt("txtCount")
	self._btnInput = self:getGo("btnInput")
	self._txtBubble = self:getTxt("bubble/txt")
	self._bubble = self:getGo("bubble")

	GameUtil.SetActive(self._cell, false)

	self._prizetableview = self:getGo("prizetableview")
	self._tablecell = self:getGo("prizetableview/tablecell")
	self._scrollList = ScrollerList.create(self._prizetableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CrosswordmainView:onExit()
	CrosswordmainView.super.onExit(self)
	self:_clearList()
	self._scrollList:dispose()
end

function CrosswordmainView:onEnter()
	CrosswordmainView.super.onEnter(self)

	self._activityId = 431001

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	self._cellEffects = {}

	self:_initUI()

	self._isFisrtEnter = true

	self.addGEvent(self, GlobalNotify.CROSSWROD_INFO_UPDATE, self._onRefreshUI, self)
	CrossWrodController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI(true)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:playViewEffect("fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab")
end

function CrosswordmainView:_clearList()
	if self._cellList then
		for i, obj in ipairs(self._cellList) do
			GameUtil.rmClickHandler(obj.container)
		end
	end

	goutil.clearChildren(self._contentTrans)
end

function CrosswordmainView:_initUI()
	self:_clearList()

	self._cellList = {}
	self._wordMap = {}
	self._lineMap = {}

	local maxW = 0
	local maxH = 0
	local cfgList = CrossWordConfig.instance:getGridCfgListById(self._activityId) or {}

	for i, v in ipairs(cfgList) do
		local go = goutil.cloneAndSetParent(self._cell, self._contentTrans.transform)

		GameUtil.SetActive(go, true)
		GameUtil.setAnchoredPos(go, v.x * gap, -v.y * gap)

		local container = goutil.findChild(go, "container")

		GameUtil.addClickHandler(container, GameUtil.handler(self._onClickTypeIn, self, v, i))

		local light = goutil.findChild(go, "container/light")
		local select = goutil.findChild(go, "container/select")
		local bg = goutil.findChild(go, "container/bg")
		local imgRow = goutil.findChild(go, "container/imgRow")
		local imgCol = goutil.findChild(go, "container/imgCol")
		local txt = goutil.findChildTextComponent(go, "container/txt")
		local txtRow = goutil.findChildTextComponent(go, "container/imgRow/txt")
		local txtCol = goutil.findChildTextComponent(go, "container/imgCol/txt")
		local obj = {}

		obj.go = go
		obj.cfg = v
		obj.container = container
		obj.light = light
		obj.bg = bg
		obj.select = select
		obj.imgRow = imgRow
		obj.imgCol = imgCol
		obj.txt = txt
		obj.txtRow = txtRow
		obj.txtCol = txtCol

		table.insert(self._cellList, obj)
		GameUtil.SetActive(light, false)
		GameUtil.SetActive(select, false)
		GameUtil.SetActive(imgRow, false)
		GameUtil.SetActive(imgCol, false)
		GameUtil.setUIImageSpriteIdx(bg, 1)

		txt.text = langPara("<color=#88888888>%s</color>", v.gridId)

		if v.originalFinish then
			GameUtil.setUIImageSpriteIdx(bg, 0)

			txt.text = v.word
		end

		if not v.startIdx then
			local startIdx = {}

			for _, idx in ipairs(startIdx) do
				if idx > 0 then
					GameUtil.SetActive(imgRow, true)

					txtRow.text = math.abs(idx)
				else
					GameUtil.SetActive(imgCol, true)

					txtCol.text = math.abs(idx)
				end

				self._lineMap[math.abs(idx)] = idx
			end

			maxW = math.max(maxW, v.x)
			maxH = math.max(maxH, v.y)

			if not v.sentenceIds then
				for _, id in ipairs(v.sentenceIds) do
					self._wordMap[id] = self._wordMap[id] or {}

					table.insert(self._wordMap[id], v.gridId)
				end
			end
		end
	end

	self._contentTrans.sizeDelta = Vector2.New(gap * (maxW + 2), gap * (maxH + 2))
	self._scrollView.verticalNormalizedPosition = 0.5
	self._scrollView.horizontalNormalizedPosition = 0.5
end

function CrosswordmainView:_onRefreshUI(noCheck)
	local info = CrossWordModel.instance:getInfo(self._activityId) or {}

	self._todayFinishGridTimes = info.todayFinishGridTimes or 0
	self._gainPrizeIds = info.gainPrizeIds or {}

	if not info.finishedGrids then
		local finishedGrids = {}
		local map = {}

		for i, v in ipairs(finishedGrids) do
			map[v] = true
		end

		self._finishGridsMap = map

		for i, obj in ipairs(self._cellList) do
			GameUtil.SetActive(obj.select, false)
			GameUtil.SetActive(obj.light, false)

			obj.txt.text = langPara("<color=#88888888>%s</color>", obj.cfg.gridId)

			GameUtil.setUIImageSpriteIdx(obj.bg, 1)

			if map[obj.cfg.gridId] then
				GameUtil.setUIImageSpriteIdx(obj.bg, 0)

				obj.txt.text = obj.cfg.word
			elseif not noCheck and self._isFisrtEnter then
				self._isFisrtEnter = false

				self:_moveTo(obj.cfg)
			end
		end

		GameUtil.SetActive(self._btnInput, false)
		GameUtil.SetActive(self._bubble, false)

		local cfg = CrossWordConfig.instance:getActCfgById(self._activityId) or {}

		self._txtCount.text = langPara("<color=#ffffff>今日剩余填字次数：</color>%s", math.max(0, checknumber(cfg.dailyTimes) - self._todayFinishGridTimes))

		local list = CrossWordConfig.instance:getPrizeCfgListById(self._activityId) or {}

		self._scrollList:reloadData(list)

		for i, data in ipairs(list) do
			local isCanGet = true

			if not self._wordMap[data.sentenceId] then
				for _, gridId in ipairs(self._wordMap[data.sentenceId]) do
					if not self._finishGridsMap[gridId] then
						isCanGet = false

						break
					end
				end

				local isGainPrize = table.indexof(self._gainPrizeIds, data.sentenceId) ~= false

				if isCanGet and not isGainPrize then
					self._scrollList:MoveCellInView(i - 1)

					break
				end
			end
		end
	end
end

function CrosswordmainView:_moveTo(cfg)
	local w = GameUtil.getWidth(self._contentTrans)
	local h = GameUtil.getHeight(self._contentTrans)
	local vw = GameUtil.getWidth(self._viewportTrans)
	local vh = GameUtil.getHeight(self._viewportTrans)
	local x = cfg.x * gap + gap * 0.5
	local y = cfg.y * gap + gap * 0.5

	self._scrollView.horizontalNormalizedPosition = Mathf.Clamp01((x - vw * 0.5) / (w - vw))
	self._scrollView.verticalNormalizedPosition = 1 - Mathf.Clamp01((y - vh * 0.5) / (h - vh))
end

function CrosswordmainView:_onClickTypeIn(cfg, idx)
	self._selectGridId = cfg.gridId

	if not cfg.sentenceIds then
		self._sentenceId = 0

		for i, id in ipairs(cfg.sentenceIds) do
			if not self._wordMap[id] then
				local hasType = false

				for _, gridId in ipairs(self._wordMap[id]) do
					if not self._finishGridsMap[gridId] then
						hasType = true
						self._sentenceId = id

						break
					end
				end

				if hasType then
					break
				end
			end
		end

		if not self._wordMap[self._sentenceId] then
			local arr = {}
			local temp = {}

			for _, gridId in ipairs(arr) do
				temp[gridId] = true
			end

			for i, obj in ipairs(self._cellList) do
				GameUtil.SetActive(obj.select, false)
				GameUtil.SetActive(obj.light, false)

				if self._sentenceId > 0 then
					if obj.cfg.gridId == self._selectGridId then
						GameUtil.SetActive(obj.select, true)
					elseif temp[obj.cfg.gridId] then
						GameUtil.SetActive(obj.light, true)
					end
				end
			end

			GameUtil.SetActive(self._btnInput, false)
			GameUtil.SetActive(self._bubble, true)

			if self._sentenceId > 0 then
				GameUtil.SetActive(self._btnInput, true)

				local pcfg = CrossWordConfig.instance:getPrizeCfgById(self._activityId, self._sentenceId) or {}

				self._txtBubble.text = pcfg.tips
			else
				self._txtBubble.text = "恭喜你，已经成功填入了这个句子了！"
			end
		end
	end
end

function CrosswordmainView:_onClickInput()
	local cfg = CrossWordConfig.instance:getActCfgById(self._activityId) or {}

	if checknumber(cfg.dailyTimes) - self._todayFinishGridTimes > 0 then
		UIStateManager.instance:push(ViewName.CrosswordinputView, self._activityId, self._sentenceId, self._selectGridId)
	else
		TipsFacade.instance:openCommonTips("今日次数剩余0，下次再来吧")
	end
end

function CrosswordmainView:_onClickTip()
	TipsFacade.instance:openRulesView("crosswordmainview_rule")
end

function CrosswordmainView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local received = goutil.findChild(cell, "received")
	local effect = goutil.findChild(cell, "effect")
	local top = goutil.findChild(cell, "top")
	local imgRow = goutil.findChild(cell, "imgRow")
	local imgCol = goutil.findChild(cell, "imgCol")
	local txtRow = goutil.findChildTextComponent(cell, "imgRow/txt")
	local txtCol = goutil.findChildTextComponent(cell, "imgCol/txt")

	MaterialMgr.setCellByCfg(data.prize, con)
	GameUtil.SetActive(imgRow, false)
	GameUtil.SetActive(imgCol, false)

	local idx = self._lineMap[data.sentenceId]

	if idx > 0 then
		GameUtil.SetActive(imgRow, true)

		txtRow.text = math.abs(idx)
	else
		GameUtil.SetActive(imgCol, true)

		txtCol.text = math.abs(idx)
	end

	self:_clearEffect(effect)

	if not self._wordMap[data.sentenceId] then
		local isCanGet = true

		for _, gridId in ipairs(self._wordMap[data.sentenceId]) do
			if not self._finishGridsMap[gridId] then
				isCanGet = false

				break
			end
		end

		GameUtil.rmClickHandler(top)

		local isGainPrize = table.indexof(self._gainPrizeIds, data.sentenceId) ~= false

		if isCanGet and not isGainPrize then
			self:_playEffect(effect)
			GameUtil.addClickHandler(top, GameUtil.handler(self._onClickGetPrize, self, data.sentenceId), self)
		end

		GameUtil.SetActive(received, isGainPrize)
	end
end

function CrosswordmainView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function CrosswordmainView:_onClickGetPrize(id)
	CrossWrodController.instance:sendGainPrize(self._activityId, id)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function CrosswordmainView:_playEffect(effGo)
	self:playViewEffectUniGo(effPath, effGo, self:getGo("prizetableview/viewport"), true)
end

function CrosswordmainView:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

return CrosswordmainView

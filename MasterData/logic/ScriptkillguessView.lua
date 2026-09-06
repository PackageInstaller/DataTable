-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkillguessView.lua

module("logic.extensions.scriptkill.view.ScriptkillguessView", package.seeall)

local ScriptkillguessView = class("ScriptkillguessView", ViewComponent)

function ScriptkillguessView:ctor()
	ScriptkillguessView.super.ctor(self)
end

function ScriptkillguessView:unbindEvents()
	ScriptkillguessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShow)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnGift)
end

function ScriptkillguessView:bindEvents()
	ScriptkillguessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnGift, self._onClickGift, self)
end

function ScriptkillguessView:buildUI()
	ScriptkillguessView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._final = self:getGo("final")
	self._btnShow = self:getGo("final/btnShow")
	self._finalItems = self:getGo("final/items")
	self._txtDesc = self:getTxt("final/txtDesc")
	self._ImgC_Icon = self:getGo("final/Nego_Icon/ImgC_Icon")
	self._btnGet = self:getGo("final/btnGet")
	self._btnGift = self:getGo("btnGift")
	self._namecell = self:getGo("namecell")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._item = self:getGo("item")

	GameUtil.SetActive(self._item, false)

	self._items = self:getGo("items")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ScriptkillguessView:onExit()
	ScriptkillguessView.super.onExit(self)
	self._scrollList:dispose()

	for k, v in pairs(self._scrollMap) do
		v:dispose()
	end

	self:_clearAllItem(self._items)
	self:_clearAllItem(self._finalItems)

	self._effectMap = nil
end

function ScriptkillguessView:onEnter()
	ScriptkillguessView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self._scrollMap = {}

	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	ScriptKillController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function ScriptkillguessView:_refreshUI()
	self._clueIds = ScriptKillModel.instance:getClueIds(self._activityId) or {}
	self._clueIdMap = {}
	self._chapterMap = {}

	for i, clueId in ipairs(self._clueIds) do
		self._clueIdMap[clueId] = true

		local cfg = ScriptKillConfig.instance:getClueCfgById(self._activityId, clueId)

		if cfg then
			self._chapterMap[cfg.chapterId] = checknumber(self._chapterMap[cfg.chapterId]) + 1
		end
	end

	self._selectNpcMap = {}

	local info = ScriptKillModel.instance:getInfo(self._activityId) or {}

	if not info.chapters then
		local chapters = {}
		local count = 0

		for i, v in ipairs(chapters) do
			self._selectNpcMap[v.chapterId] = checknumber(v.selectKiller)

			if checknumber(v.selectKiller) > 0 then
				count = count + 1
			end
		end

		GameUtil.SetActive(self._final, false)

		local list = ScriptKillConfig.instance:getChapterListById(self._activityId) or {}

		if count == #list then
			GameUtil.SetActive(self._final, true)
			self:_refreshFinal()
		end

		self._scrollList:reloadData(list)

		local cfg = ScriptKillConfig.instance:getSuspectPrizeCfgById(self._activityId, #list) or {}

		if not cfg.prize then
			local prize = ""

			self:_clearAllItem(self._items)

			local arr = string.split(prize or "", "#")

			self:_showItems(self._items, self._item, arr)
		end
	end
end

function ScriptkillguessView:_refreshFinal()
	local count = 0
	local list = ScriptKillConfig.instance:getChapterListById(self._activityId) or {}
	local len = #list

	for i, data in ipairs(list) do
		local npcId = checknumber(self._selectNpcMap[data.chapterId])
		local killerId = data.killerId

		if killerId == npcId then
			count = count + 1
		end
	end

	self._txtDesc.text = langPara("你的预测准确率为：<color=#ffe65a>%.2f%%</color>，请领取奖励", 100 * count / len)

	local cfg = ScriptKillConfig.instance:getSuspectPrizeCfgById(self._activityId, count) or {}

	if not cfg.prize then
		local prize = ""

		self:_clearAllItem(self._finalItems)

		local arr = string.split(prize or "", "#")
		local info = ScriptKillModel.instance:getInfo(self._activityId) or {}
		local isShowEffect = not info.gainedPrize

		self:_showItems(self._finalItems, self._item, arr, isShowEffect)
		GameUtil.SetActive(self._btnGet, isShowEffect)
	end
end

function ScriptkillguessView:_showItems(container, item, arr, isShowEffect)
	for i, v in ipairs(arr) do
		local go = goutil.clone(item, "item_" .. i)

		goutil.addChildToParent(go, container)
		GameUtil.SetActive(go, true)

		local con = goutil.findChild(go, "con")
		local eff = goutil.findChild(go, "eff")
		local receive = goutil.findChild(go, "receive")

		GameUtil.SetActive(receive, false)

		local proxy = MaterialMgr.setCellByCfg(v, con)

		if isShowEffect then
			self:_showEffect(eff)
		end

		if isShowEffect == false then
			GameUtil.SetActive(receive, true)
		end
	end
end

function ScriptkillguessView:_showEffect(cell)
	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect = UIEffectManager.instance:playEffect(self, effPath, cell.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	effect:setParent(cell.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	self._effectMap = self._effectMap or {}
	self._effectMap[cell] = effect

	return effect
end

function ScriptkillguessView:_clearAllItem(container)
	local childCount = container.transform.childCount

	for i = 1, childCount do
		local trans = container.transform:GetChild(i - 1)
		local go = trans.gameObject
		local con = goutil.findChild(go, "con")
		local eff = goutil.findChild(go, "eff")

		MaterialMgr.resetAll(con)

		if self._effectMap then
			local handler = self._effectMap[eff]

			if handler then
				UIEffectManager.instance:stopEffect(handler)

				self._effectMap[eff] = nil
			end
		end
	end

	goutil.clearChildren(container)
end

function ScriptkillguessView:_updateCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local tableview = goutil.findChild(cell, "tableview")
	local btnOK = goutil.findChild(cell, "btnOK")
	local finish = goutil.findChild(cell, "finish")
	local lock = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txt")
	local txtFinish = goutil.findChildTextComponent(cell, "finish/txtFinal")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnStroy = goutil.findChild(cell, "finish/btnStroy")
	local scrollList = self._scrollMap[cell]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableview, self._namecell, GameUtil.handler(self._updateNameCell, self), GameUtil.handler(self.clearNameCell, self))
		self._scrollMap[cell] = scrollList
	end

	txtTitle.text = data.name .. "预测"
	txtDesc.text = "？？？？？？"
	txtName.text = "？？？"

	local npcId = checknumber(self._selectNpcMap[data.chapterId])

	if npcId > 0 then
		local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, npcId) or {}

		txtName.text = npcCfg.name
	end

	txtLock.text = langPara("收集<color=#ffffff>%s</color>个线索\n且解出关键线索后\n可推测真凶", data.passNeedNum)

	local isLock = true

	GameUtil.SetActive(lock, true)

	local timeStart = GameUtil.string2time(data.openDateTime)
	local now = ServerTime.now()

	if timeStart <= now and ScriptKillModel.instance:checkFinishLast(self._activityId, data.chapterId) then
		local total = checknumber(self._chapterMap[data.chapterId])

		if total >= data.passNeedNum and self:_checkHasOneUnlock(data.unlockIds) then
			GameUtil.SetActive(lock, false)

			isLock = false
			txtDesc.text = data.target
		end
	end

	local isFinish = ScriptKillModel.instance:checkFinishCurr(self._activityId, data.chapterId)

	GameUtil.SetActive(finish, isFinish)
	GameUtil.SetActive(btnOK, not isFinish)

	local killerId = data.killerId
	local killerCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, killerId) or {}

	txtFinish.text = killerCfg.name

	local list = {}

	GameUtil.SetActive(btnOK, false)

	if not isFinish and not isLock then
		GameUtil.SetActive(btnOK, true)

		if not data.npcs then
			for i, v in ipairs(data.npcs) do
				local obj = {}

				obj.chapterId = data.chapterId
				obj.npcId = v
				obj.txtName = txtName
				obj.cell = cell

				table.insert(list, obj)
			end
		end
	end

	scrollList:reloadData(list)
	GameUtil.addClickHandler(btnOK, GameUtil.handler(self._onClickCellOK, self, data))
	GameUtil.addClickHandler(btnStroy, GameUtil.handler(self._onClickStroy, self, data))
end

function ScriptkillguessView:_checkHasOneUnlock(unlockIds)
	unlockIds = unlockIds or {}

	if #unlockIds == 0 then
		return true
	end

	for i, v in ipairs(unlockIds) do
		if self._clueIdMap[v] then
			return true
		end
	end

	return false
end

function ScriptkillguessView:_onClickStroy(data)
	local cfg = ScriptKillConfig.instance:getChapterCfgById(self._activityId, data.chapterId)

	if cfg and checknumber(cfg.endStoryId) > 0 then
		StoryController.instance:startStory(checknumber(cfg.endStoryId))
	end
end

function ScriptkillguessView:_onClickCellOK(data)
	local npcId = checknumber(self._selectNpcMap[data.chapterId])

	if npcId > 0 then
		local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, npcId) or {}
		local content = langPara("是否确认推测【<color=#20b376>%s</color>】为凶手？确定后不能更改哦~", npcCfg.name)

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			ScriptKillController.instance:sendSuspect(self._activityId, data.chapterId, npcCfg.npcId)
		end)
	else
		TipsFacade.instance:openCommonTips("请先选择一位怀疑对象")
	end
end

function ScriptkillguessView:_updateNameCell(view, cell, data, tag)
	local txt = goutil.findChildTextComponent(cell, "txt")
	local select = goutil.findChild(cell, "select")
	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, data.npcId) or {}

	txt.text = npcCfg.name

	local npcId = checknumber(self._selectNpcMap[data.chapterId])

	GameUtil.SetActive(select, data.npcId == npcId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickName, self, data))
end

function ScriptkillguessView:_onClickName(data)
	local txt = data.txtName
	local npcCfg = ScriptKillConfig.instance:getNpcCfgById(self._activityId, data.npcId) or {}

	txt.text = npcCfg.name
	self._selectNpcMap[data.chapterId] = data.npcId

	local scrollList = self._scrollMap[data.cell]

	if scrollList then
		scrollList:refresh()
	end
end

function ScriptkillguessView:clearNameCell(cell)
	return
end

function ScriptkillguessView:clearCell(cell)
	return
end

function ScriptkillguessView:_onClickCell(data)
	return
end

function ScriptkillguessView:_onClickTip()
	TipsFacade.instance:openRulesView("scriptkillmainview_rule")
end

function ScriptkillguessView:_onClickShow()
	UIStateManager.instance:push(ViewName.ScriptkillresultView, self._activityId)
end

function ScriptkillguessView:_onClickGet()
	ScriptKillController.instance:sendGetPrize(self._activityId)
end

function ScriptkillguessView:_onClickGift()
	UIStateManager.instance:push(ViewName.ScriptkillprizeView, self._activityId)
end

return ScriptkillguessView

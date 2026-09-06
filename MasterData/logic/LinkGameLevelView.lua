-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameLevelView.lua

module("logic.extensions.linkgame.view.LinkGameLevelView", package.seeall)

local LinkGameLevelView = class("LinkGameLevelView", ViewComponent)

function LinkGameLevelView:ctor()
	LinkGameLevelView.super.ctor(self)
end

function LinkGameLevelView:bindEvents()
	LinkGameLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function LinkGameLevelView:unbindEvents()
	LinkGameLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function LinkGameLevelView:buildUI()
	LinkGameLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._tableviewCell = self:getGo("cell")
	self._itemScrollercell = self:getGo("itemScrollercell")
	self._itemScrollListDic = {}
end

function LinkGameLevelView:onEnter()
	self.addGEvent(self, GlobalNotify.handlePM_LinkGameInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_LinkGameEndGameRes, self._PM_LinkGameEndGameRes, self)

	self._actId = self:getFirstParam()
	self._actCfg = LinkGameConfig.instance:getActivityCfg(self._actId)
	self._tableList = ScrollerList.create(self._tableview, self._tableviewCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	LinkGameAgent.instance:sendPM_LinkGameInfoReq(self._actId)

	self._firstEnter = true
end

function LinkGameLevelView:onExit()
	LinkGameLevelView.super.onExit(self)
	self._tableList:dispose()
end

function LinkGameLevelView:_refreshView()
	local stageCfgs = LinkGameConfig.instance:getStageCfgs(self._actId)

	self._tableList:reloadData(stageCfgs)
	self._tableList:MoveCellToCenter(math.max(LinkGameModel.instance:getCurStage() - 1, 0))

	if self._firstEnter == true then
		for i, v in ipairs(stageCfgs) do
			local time = GameUtil.string2time(v.openDateTime)

			if time >= ServerTime.now() and not LinkGameModel.instance:getNewLevel(v.activityId, v.stageId) then
				LinkGameModel.instance:setNewLevel(v.activityId, v.stageId)
			end
		end

		self._firstEnter = false

		LinkGameController.instance:checkRedPoint()
	end
end

function LinkGameLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnBegin")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local lockTip = goutil.findChild(go, "lockTip")
	local txtLockTip = goutil.findChildTextComponent(go, "lockTip/txt")
	local txtStep = goutil.findChildTextComponent(go, "txtStep")
	local passGo = goutil.findChild(go, "pass")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local isLock = ServerTime.now() < GameUtil.string2time(data.openDateTime)
	local openTime = GameUtil.string2date(data.openDateTime)

	GameUtil.SetActive(lockTip, isLock)

	if isLock == true then
		txtLockTip.text = langPara("%02d.%02d %d:%02d后开启", openTime.month, openTime.day, openTime.hour, openTime.min)
	end

	txtName.text = data.stageName

	GameUtil.addClickHandler(btn, function()
		self:_onLevelClick(data.stageId)
	end, self)

	local prizeList = string.split(data.prize, "#")

	if not self._itemScrollListDic[go] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[go] = self._itemScrollListDic[go]

		self._itemScrollListDic[go]:reloadData(prizeList)
		self._itemScrollListDic[go]:dragNotifyParent()

		local info = LinkGameModel.instance:getStageInfo(data.stageId)

		if checknumber(info) > 0 then
			GameUtil.SetActive(passGo, true)
			GameUtil.SetActive(txtStep, true)

			txtStep.text = langPara("所用步数：%d", info)
		else
			GameUtil.SetActive(passGo, false)
			GameUtil.SetActive(txtStep, false)
		end
	end
end

function LinkGameLevelView:_clearCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnBegin")

	GameUtil.rmClickHandler(btn)

	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function LinkGameLevelView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function LinkGameLevelView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function LinkGameLevelView:_onLevelClick(stageId)
	local stageCfg = LinkGameConfig.instance:getStageCfg(self._actId, stageId)
	local isLock = ServerTime.now() < GameUtil.string2time(stageCfg.openDateTime)
	local openTime = GameUtil.string2date(stageCfg.openDateTime)

	GameUtil.SetActive(lockTip, isLock)

	if isLock == true then
		FloatWordMgr.instance:show(langPara("%02d.%02d %d:%02d后开启", openTime.month, openTime.day, openTime.hour, openTime.min))
	else
		UIStateManager.instance:push(ViewName.LinkGamePlayView, self._actId, stageId)
	end
end

function LinkGameLevelView:_onClickRule()
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

function LinkGameLevelView:_PM_LinkGameEndGameRes()
	LinkGameAgent.instance:sendPM_LinkGameInfoReq(self._actId)
end

return LinkGameLevelView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldbossrewardtabView.lua

module("logic.extensions.worldboss.view.WorldbossrewardtabView", package.seeall)

local WorldbossrewardtabView = class("WorldbossrewardtabView", ViewComponent)

function WorldbossrewardtabView:ctor()
	WorldbossrewardtabView.super.ctor(self)
end

function WorldbossrewardtabView:unbindEvents()
	WorldbossrewardtabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function WorldbossrewardtabView:bindEvents()
	WorldbossrewardtabView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function WorldbossrewardtabView:buildUI()
	WorldbossrewardtabView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btns = self:getGo("btns")
	self.btnCell = self:getGo("btnCell")

	GameUtil.SetActive(self.btnCell, false)

	self.tableview = self:getGo("rank/tableview")
	self.cell = self:getGo("rank/cell")
	self.txtTip = self:getTxt("rank/txtTip")
	self.item = self:getGo("item")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function WorldbossrewardtabView:onExit()
	WorldbossrewardtabView.super.onExit(self)
	self.scrollList:dispose()
end

function WorldbossrewardtabView:onEnter()
	WorldbossrewardtabView.super.onEnter(self)
	self:createAllBtns()
end

function WorldbossrewardtabView:createAllBtns()
	local tab = {
		WorldBossConfig.instance:getWorldBossCommonConfigValueByKey("RANKING_REWARDS"),
		(WorldBossConfig.instance:getWorldBossCommonConfigValueByKey("DAMAGE_BONUS"))
	}

	self.txtTip.text = WorldBossConfig.instance:getWorldBossCommonConfigValueByKey("REWARDS_RULE")
	self.btnCellScrollList = {}
	self.btnList = {}

	goutil.clearChildren(self.btns)

	for i, v in ipairs(tab) do
		local btn = goutil.clone(self.btnCell, "tab_" .. i)
		local txt = goutil.findChildTextComponent(btn, "txt")

		txt.text = v

		GameUtil.SetActive(btn, true)
		goutil.addChildToParent(btn, self.btns)
		GameUtil.addClickHandler(btn, function()
			self:onClickTab(i)
		end)
		table.insert(self.btnList, btn)
	end

	self:onClickTab(1)
end

function WorldbossrewardtabView:onClickTab(idx)
	self._curPrizeMul = 1

	for i, v in ipairs(self.btnList) do
		if idx == i then
			GameUtil.setUIGroupIdx(v, 1)
		else
			GameUtil.setUIGroupIdx(v, 0)
		end
	end

	local data = {}

	if idx == 1 then
		data = WorldBossController.instance:getWorldBossRankPrize()
	else
		local isInTime, title, startTime, endTime, cfg = ActivityDefineController.instance:isInTimeForMultiplyReward(GameEnum.CampaignType.WorldBossPrize)

		if isInTime and cfg then
			self._curPrizeMul = math.max(checknumber(cfg.featureParam), 1)
		end

		data = WorldBossController.instance:getWorldBossDamagePrize()
	end

	self.scrollList:reloadData(data)
end

function WorldbossrewardtabView:_updateCell(view, cell, data, tag)
	local tableview = goutil.findChild(cell, "tableview")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local doubleGo = goutil.findChild(cell, "doubleGo")

	txtRank.text = data.desc

	local goContent = goutil.findChild(cell, "tableview/viewport/content")
	local arrProxy

	if checknumber(self._curPrizeMul) > 1 then
		GameUtil.SetActive(doubleGo, true)

		arrProxy = self:_getProgressPrizeMul(goContent, data.prize, self._curPrizeMul)
	else
		GameUtil.SetActive(doubleGo, false)

		arrProxy = MaterialMgr.setCellListByCfg(data.prize, goContent)
	end

	for i, v in ipairs(arrProxy or {}) do
		Framework.TransformUtil.SetLocalScale(v.view.transform, 0.7, 0.7, 0.7)
	end
end

function WorldbossrewardtabView:clearCell(cell)
	local goContent = goutil.findChild(cell, "tableview/viewport/content")

	MaterialMgr.resetAll(goContent)
end

function WorldbossrewardtabView:_getProgressPrizeMul(parent, prizes, mul)
	local list = MaterialMgr.changeItemStrArr(prizes)

	if list == nil or #list == 0 then
		return
	end

	local matStr = ""

	for _, str in ipairs(list) do
		local aa = string.split(str, "#")

		for _, v in pairs(aa or {}) do
			if not string.nilorempty(v) then
				local bb = string.split(v, ":")
				local count = checknumber(table.remove(bb))

				matStr = not string.nilorempty(matStr) and string.format("%s#%s:%s", matStr, table.concat(bb, ":"), count) or string.format("%s:%s", table.concat(bb, ":"), count)
			end
		end
	end

	return MaterialMgr.setCellListByCfg(matStr, parent)
end

return WorldbossrewardtabView

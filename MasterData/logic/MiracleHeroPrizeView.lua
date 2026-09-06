-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroPrizeView.lua

module("logic.extensions.miraclehero.view.MiracleHeroPrizeView", package.seeall)

local MiracleHeroPrizeView = class("MiracleHeroPrizeView", ViewComponent)

function MiracleHeroPrizeView:ctor()
	MiracleHeroPrizeView.super.ctor(self)
end

function MiracleHeroPrizeView:unbindEvents()
	MiracleHeroPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function MiracleHeroPrizeView:bindEvents()
	MiracleHeroPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function MiracleHeroPrizeView:buildUI()
	MiracleHeroPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._rewardListSR = self:getGo("rewardListBgGo/rewardListSR")
	self._rewardItemGo = self:getGo("rewardListBgGo/rewardItemGo")
	self._itemScrollercell = self:getGo("rewardListBgGo/itemScrollercell")
	self._rewardTableList = ScrollerList.create(self._rewardListSR, self._rewardItemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MiracleHeroPrizeView:onExit()
	MiracleHeroPrizeView.super.onExit(self)
	self._rewardTableList:dispose()
end

function MiracleHeroPrizeView:onEnter()
	MiracleHeroPrizeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._challengeCfg = MiracleHeroConfig.instance:getChallengeCfgs(self._activityId)
	self._itemScrollListDic = {}

	local list = {}

	for i, v in ipairs(self._challengeCfg) do
		local data = {}

		data.cfg = v
		data.prize = ""

		local prizeStrList = {}
		local stageCfgs = MiracleHeroConfig.instance:getStageCfgs(self._activityId, v.challengeId)

		for j, stageCfg in ipairs(stageCfgs) do
			table.insert(prizeStrList, stageCfg.prize)
		end

		local prizeList = MaterialMgr.combineItemsToList(prizeStrList)

		data.prize = table.concat(prizeList, "#")

		table.insert(list, data)
	end

	self._rewardTableList:reloadData(list)
end

function MiracleHeroPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")

	txtName.text = data.cfg.challengeName

	local prizeStr = data.prize

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = not string.nilorempty(prizeStr) and string.split(prizeStr, "#") or {}

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function MiracleHeroPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function MiracleHeroPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function MiracleHeroPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return MiracleHeroPrizeView

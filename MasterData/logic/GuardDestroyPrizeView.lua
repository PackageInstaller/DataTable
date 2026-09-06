-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/view/GuardDestroyPrizeView.lua

module("logic.extensions.guarddestroy.view.GuardDestroyPrizeView", package.seeall)

local GuardDestroyPrizeView = class("GuardDestroyPrizeView", ViewComponent)

function GuardDestroyPrizeView:ctor()
	GuardDestroyPrizeView.super.ctor(self)
end

function GuardDestroyPrizeView:unbindEvents()
	GuardDestroyPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuardDestroyPrizeView:bindEvents()
	GuardDestroyPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GuardDestroyPrizeView:buildUI()
	GuardDestroyPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._rankTablecell = self:getGo("ranktablecell")
	self._rankTableview = self:getGo("ranktableview")
	self._rankTableList = ScrollerList.create(self._rankTableview, self._rankTablecell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemTableCell = self:getGo("itemTablecell")
end

function GuardDestroyPrizeView:onExit()
	GuardDestroyPrizeView.super.onExit(self)

	for k, v in pairs(self._itemTableListDir) do
		v:dispose()

		self._itemTableListDir[k] = nil
	end

	self._rankTableList:dispose()
end

function GuardDestroyPrizeView:onEnter()
	GuardDestroyPrizeView.super.onEnter(self)

	self._itemTableListDir = {}
	self._activityId = checknumber(self:getFirstParam())

	local list = GuardDestroyConfig.instance:getRankPrizeCfgs(self._activityId)

	self._rankTableList:reloadData(list)
end

function GuardDestroyPrizeView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")

	txtRank.text = data.title

	if data.rankRange[1] == data.rankRange[2] then
		if not data.rankRange[2] then
			local singleRank = 0

			singleRank = checknumber(singleRank)

			if singleRank <= 3 and singleRank > 0 then
				imgChangeRank:SetState(singleRank - 1)
				GameUtil.SetActive(imgChangeRank, true)
				GameUtil.SetActive(txtRank, false)
			else
				GameUtil.SetActive(imgChangeRank, false)
				GameUtil.SetActive(txtRank, true)
			end

			local prizeArray = string.split(data.prize, "#")

			if itemTableView and self._itemTableCell then
				if not self._itemTableListDir[itemTableView] then
					local itemTableList = ScrollerList.create(itemTableView, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

					self._itemTableListDir[itemTableView]:dragNotifyParent()

					self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

					self._itemTableListDir[itemTableView]:reloadData(prizeArray)
				end
			end
		end
	end
end

function GuardDestroyPrizeView:_clearRankCell(cell)
	local go = cell.gameObject
	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function GuardDestroyPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function GuardDestroyPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return GuardDestroyPrizeView

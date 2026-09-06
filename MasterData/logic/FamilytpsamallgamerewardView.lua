-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/kjt/FamilytpsamallgamerewardView.lua

module("logic.extensions.familyteamplay.view.game.kjt.FamilytpsamallgamerewardView", package.seeall)

local FamilytpsamallgamerewardView = class("FamilytpsamallgamerewardView", TableViewComponent)

function FamilytpsamallgamerewardView:ctor()
	FamilytpsamallgamerewardView.super.ctor(self)
end

function FamilytpsamallgamerewardView:buildUI()
	FamilytpsamallgamerewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function FamilytpsamallgamerewardView:bindEvents()
	FamilytpsamallgamerewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FamilytpsamallgamerewardView:unbindEvents()
	FamilytpsamallgamerewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FamilytpsamallgamerewardView:destroyUI()
	FamilytpsamallgamerewardView.super.destroyUI(self)
end

function FamilytpsamallgamerewardView:onEnter()
	FamilytpsamallgamerewardView.super.onEnter(self)
	self:_updateView()
end

function FamilytpsamallgamerewardView:onEnterFinished()
	FamilytpsamallgamerewardView.super.onEnterFinished(self)
end

function FamilytpsamallgamerewardView:onExit()
	FamilytpsamallgamerewardView.super.onExit(self)
end

function FamilytpsamallgamerewardView:onExitFinished()
	FamilytpsamallgamerewardView.super.onExitFinished(self)
end

function FamilytpsamallgamerewardView:_onClickbtnClose()
	self:close()
end

function FamilytpsamallgamerewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilytpsamallgamerewardView:_cellSize(view, index)
	return 100, 100
end

function FamilytpsamallgamerewardView:_updateCell(view, cell, data)
	local itemcell = goutil.findChild(cell.gameObject, "rewardCon/cell")
	local cellCon = goutil.findChild(cell.gameObject, "rewardCon")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "text")
	local imgProgressChange = goutil.findChild(cell.gameObject, "progress/imgProgress"):GetComponent(ComponentType.UIImageColorChange)
	local rewards = string.split(data.prize, "#")

	goutil.setActive(itemcell, false)
	imgProgressChange:SetState(cell.data - 1)

	txtScore.text = data.score

	local itemList = {}
	local index = 1
	local itemNum = 0
	local item = goutil.findChild(cellCon, "item_" .. index)

	while item do
		goutil.setActive(item, false)

		itemList[index] = item
		itemNum = itemNum + 1

		MaterialMgr.resetAll(item)

		index = index + 1
		item = goutil.findChild(cellCon, "item_" .. index)
	end

	for index = itemNum + 1, #rewards do
		item = goutil.cloneAndSetParent(itemcell, cellCon.transform, "item_" .. index)
		itemList[index] = item
	end

	for index, cfgStr in ipairs(rewards) do
		local go = itemList[index]

		goutil.setActive(go, true)
		MaterialMgr.setCellByCfg(cfgStr, go)
		Framework.TransformUtil.SetLocalPos(go.transform, (index - 1) * 110, 0, 0)
	end
end

function FamilytpsamallgamerewardView:_clearTableview(cell)
	local cellCon = goutil.findChild(cell.gameObject, "rewardCon")
	local index = 1
	local item = goutil.findChild(cellCon, "item_" .. index)

	while item do
		MaterialMgr.resetAll(item)

		index = index + 1
		item = goutil.findChild(cellCon, "item_" .. index)
	end
end

function FamilytpsamallgamerewardView:_updateView()
	local gameId = self:getFirstParam()
	local tempList = FamilyteamplayConfig.instance:getSmallGamePrizeCfgs(gameId)
	local cfgs = {}

	for k, v in pairs(tempList) do
		table.insert(cfgs, v)
	end

	table.sort(cfgs, function(a, b)
		return a.score < b.score
	end)

	self._curViewDatas = cfgs

	self:reloadData()
end

return FamilytpsamallgamerewardView

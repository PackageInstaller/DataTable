-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/FamilytpscoretorewardView.lua

module("logic.extensions.familyteamplay.view.game.FamilytpscoretorewardView", package.seeall)

local FamilytpscoretorewardView = class("FamilytpscoretorewardView", TableViewComponent)

function FamilytpscoretorewardView:ctor()
	FamilytpscoretorewardView.super.ctor(self)
end

function FamilytpscoretorewardView:buildUI()
	FamilytpscoretorewardView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtTitle.text = lang("奖励预览")
	self._itemGroupList = {}
end

function FamilytpscoretorewardView:bindEvents()
	FamilytpscoretorewardView.super.bindEvents(self)
end

function FamilytpscoretorewardView:unbindEvents()
	FamilytpscoretorewardView.super.unbindEvents(self)
end

function FamilytpscoretorewardView:destroyUI()
	FamilytpscoretorewardView.super.destroyUI(self)

	self._itemGroupList = {}
end

function FamilytpscoretorewardView:onEnter()
	FamilytpscoretorewardView.super.onEnter(self)
	self:_updateView()
end

function FamilytpscoretorewardView:onEnterFinished()
	FamilytpscoretorewardView.super.onEnterFinished(self)
end

function FamilytpscoretorewardView:onExit()
	FamilytpscoretorewardView.super.onExit(self)

	for k, v in pairs(self._itemGroupList) do
		v:dispose(function(item)
			MaterialMgr.resetAll(item.mainGO)
		end)
	end
end

function FamilytpscoretorewardView:onExitFinished()
	FamilytpscoretorewardView.super.onExitFinished(self)
end

function FamilytpscoretorewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilytpscoretorewardView:_cellSize(view, index)
	return 100, 100
end

function FamilytpscoretorewardView:_updateCell(view, cell, data)
	local itemcon = goutil.findChild(cell.gameObject, "itemcon")
	local itemcell = goutil.findChild(itemcon, "item")
	local txtNeedScore = goutil.findChildTextComponent(cell.gameObject, "txtNeedScore")

	txtNeedScore.text = "积分达到" .. data.score .. "分"

	local itemGroup = self._itemGroupList[itemcon]

	if not itemGroup then
		itemGroup = ItemGroup.New(itemcon, itemcell, nil, nil, true)
		self._itemGroupList[itemcon] = itemGroup
	end

	local mos = string.split(data.prize, "#")

	itemGroup:updateWithMoArray(mos, function(item, cfgStr)
		MaterialMgr.setCellByCfg(cfgStr, item.mainGO)
	end)
end

function FamilytpscoretorewardView:_clearTableview(cell)
	local itemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(itemcon)
end

function FamilytpscoretorewardView:_updateView()
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

return FamilytpscoretorewardView

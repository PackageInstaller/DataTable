-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamibagTypeItem.lua

module("logic.extensions.hoshigami.view.HoshigamibagTypeItem", package.seeall)

local HoshigamibagTypeItem = class("HoshigamibagTypeItem", BaseLuaOnce)

function HoshigamibagTypeItem:ctor(go)
	HoshigamibagTypeItem.super.ctor(self, go)
end

function HoshigamibagTypeItem:buildUI()
	HoshigamibagTypeItem.super.buildUI(self)

	self._numText = self:getText("numText")
	self._iconGo = self:getGo("icon")
	self._listCell = self:getGo("tablecell")
	self._listCon = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._listCon, self._listCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._btn = self:getBtn("raycast")
end

function HoshigamibagTypeItem:bindEvents()
	HoshigamibagTypeItem.super.bindEvents(self)
	self._btn:AddClickListener(self._onClick, self)
end

function HoshigamibagTypeItem:unbindEvents()
	HoshigamibagTypeItem.super.unbindEvents(self)
	self._btn:RemoveClickListener()
end

function HoshigamibagTypeItem:onEnter(data, tipType, getHeightFunc, funcObj)
	HoshigamibagTypeItem.super.onEnter(self)

	self._data = data
	self._numText.text = data.num
	self._getHeightFunc = getHeightFunc
	self._funcObj = funcObj

	local cfgs = HoshigamiConfig.instance:getSuitCfg(data.typeId)

	self._currViewDatas = {}

	for k, v in pairs(cfgs) do
		table.insert(self._currViewDatas, v)
	end

	table.sort(self._currViewDatas, function(a, b)
		return a.count < b.count
	end)
	self._scrollList:reloadData(self._currViewDatas)
end

function HoshigamibagTypeItem:onExit()
	HoshigamibagTypeItem.super.onExit(self)
	self._scrollList:dispose()
end

function HoshigamibagTypeItem:_updateCell(view, cell, cfg)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local effectText = goutil.findChildTextComponent(cell.gameObject, "effectText")

	nameText.text = cfg.count .. "件套:"
	effectText.text = cfg.desc
end

function HoshigamibagTypeItem:_clearCell(cell)
	return
end

function HoshigamibagTypeItem:_getCellSize(view, index)
	local cfg = self._currViewDatas[index + 1]
	local height = self._getHeightFunc(self._funcObj, cfg.desc) + 20

	return 752, height > 50 and height or 50
end

function HoshigamibagTypeItem:_onClick()
	GlobalDispatcher:dispatch(HoshigamiController.FilterTypeToShow, self._data.typeId)
end

return HoshigamibagTypeItem

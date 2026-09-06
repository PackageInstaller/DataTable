-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongbuffView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongbuffView", package.seeall)

local KingwujinlongbuffView = class("KingwujinlongbuffView", ViewComponent)

function KingwujinlongbuffView:ctor()
	KingwujinlongbuffView.super.ctor(self)
end

function KingwujinlongbuffView:unbindEvents()
	KingwujinlongbuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function KingwujinlongbuffView:bindEvents()
	KingwujinlongbuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function KingwujinlongbuffView:buildUI()
	KingwujinlongbuffView.super.buildUI(self)

	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._btnSure = self:getGo("btnSure")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingwujinlongbuffView:onExit()
	KingwujinlongbuffView.super.onExit(self)
	self._scrollList:dispose()
end

function KingwujinlongbuffView:onEnter()
	KingwujinlongbuffView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}
	self._clgInfo = self._info.clgInfo or {}

	if not self._clgInfo.posId2Count then
		local posId2Count = {}
		local total = 0

		for i, v in ipairs(posId2Count) do
			local num = v.right

			if num > 0 then
				total = total + num
			end
		end

		local cfg = KingWujinlongConfig.instance:getBuffListById(self._activityId) or {}
		local list = {}

		for k, v in pairs(cfg) do
			table.insert(list, v)
		end

		ArraySort.sortOn(list, "count")

		self._selectCount = 0

		local idx = 0

		for i, v in ipairs(list) do
			if i == #list then
				if total >= v.count then
					self._selectCount = v.count
					idx = i - 1
				end
			elseif total >= v.count and total < list[i + 1].count then
				self._selectCount = v.count
				idx = i - 1
			end
		end

		self._scrollList:reloadData(list)
		self._scrollList:MoveCellToCenter(idx)
	end
end

function KingwujinlongbuffView:_updateCell(view, cell, data, tag)
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local imgSelect = goutil.findChild(cell, "imgSelect")

	txtCount.text = data.count
	txtDesc.text = data.desc

	GameUtil.SetActive(imgSelect, data.count == self._selectCount)
end

function KingwujinlongbuffView:_clearCell(cell)
	return
end

return KingwujinlongbuffView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongextView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongextView", package.seeall)

local KingwujinlongextView = class("KingwujinlongextView", ViewComponent)

function KingwujinlongextView:ctor()
	KingwujinlongextView.super.ctor(self)
end

function KingwujinlongextView:unbindEvents()
	KingwujinlongextView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function KingwujinlongextView:bindEvents()
	KingwujinlongextView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function KingwujinlongextView:buildUI()
	KingwujinlongextView.super.buildUI(self)

	self._itemList = {}

	for i = 1, 9 do
		local cell = self:getGo("fmtCol/itemNum_" .. i)

		table.insert(self._itemList, cell)
	end

	self._fmtCol = self:getGo("fmtCol")
	self._btnTip = self:getGo("btnTip")
	self._empty = self:getGo("fmtCol/empty")
end

function KingwujinlongextView:onExit()
	KingwujinlongextView.super.onExit(self)
end

function KingwujinlongextView:onEnter()
	KingwujinlongextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	local activityId = self._fmtMo.activityId

	self._info = KingWujinlongModel.instance:getInfo(activityId) or {}
	self._clgInfo = self._info.clgInfo or {}

	if not self._clgInfo.posId2Count then
		local posId2Count = {}

		self:_updateLeftFmt(posId2Count)
		goutil.setActive(self._fmtCol, false)
	end
end

function KingwujinlongextView:_updateLeftFmt(posId2Count)
	local map = {}
	local count = 0

	for i, v in ipairs(posId2Count) do
		local posId = v.left
		local num = v.right

		if num > 0 then
			map[posId] = num
			count = count + 1
		end
	end

	for i, go in ipairs(self._itemList) do
		GameUtil.SetActive(go, false)

		if map[i] ~= nil then
			GameUtil.SetActive(go, true)

			local txt = goutil.findChildTextComponent(go, "txtNum")

			txt.text = map[i]
		end
	end

	GameUtil.SetActive(self._empty, count == 0)
end

function KingwujinlongextView:_onClickTip()
	if GameUtil.GetActive(self._fmtCol) then
		goutil.setActive(self._fmtCol, false)
	else
		goutil.setActive(self._fmtCol, true)
	end
end

return KingwujinlongextView

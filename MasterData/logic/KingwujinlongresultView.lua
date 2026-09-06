-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/view/KingwujinlongresultView.lua

module("logic.extensions.kingwujinlong.view.KingwujinlongresultView", package.seeall)

local KingwujinlongresultView = class("KingwujinlongresultView", ViewComponent)

function KingwujinlongresultView:ctor()
	KingwujinlongresultView.super.ctor(self)
end

function KingwujinlongresultView:unbindEvents()
	KingwujinlongresultView.super.unbindEvents(self)
end

function KingwujinlongresultView:bindEvents()
	KingwujinlongresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function KingwujinlongresultView:buildUI()
	KingwujinlongresultView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._leftFmt = self:getGo("leftFmt")
	self._tableCell = self:getGo("tableCell")
	self._tableView = self:getGo("tableView")
	self._empty = self:getGo("empty")
	self._goEmpty = self:getGo("leftFmt/goEmpty")
	self._scrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function KingwujinlongresultView:onExit()
	KingwujinlongresultView.super.onExit(self)
	self._scrollList:dispose()
end

function KingwujinlongresultView:onEnter()
	KingwujinlongresultView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.KING_WUJINLONG_CLG_RES_GET, self._onCloseAndEnd, self)
	self:_onRefreshUI()
end

function KingwujinlongresultView:_onRefreshUI()
	local pb = KingWujinlongModel.instance:getFightPb(self._activityId)

	self._confirmNum = pb.confirmNum

	if not pb.curFightBanRace then
		if not pb.curFightAshPosId then
			local curFightAshPosId = {}

			self._info = KingWujinlongModel.instance:getInfo(self._activityId) or {}
			self._clgInfo = self._info.clgInfo or {}

			if not self._clgInfo.posId2Count then
				local posId2Count = {}

				self:_updateLeftFmt(posId2Count, curFightAshPosId)

				local list = {}

				for i, raceId in ipairs(pb.curFightBanRace) do
					table.insert(list, raceId)
				end

				self._scrollList:reloadData(list)
				GameUtil.SetActive(self._empty, #list == 0)
			end
		end
	end
end

function KingwujinlongresultView:_updateLeftFmt(posId2Count, curFightAshPosId)
	local posMap = {}
	local has = false

	for i, v in ipairs(curFightAshPosId) do
		posMap[v] = true
		has = true
	end

	local map = {}

	for i, v in ipairs(posId2Count) do
		local posId = v.left
		local num = v.right

		if num > 0 then
			map[posId] = num
			has = true
		end
	end

	GameUtil.SetActive(self._goEmpty, not has)

	for i = 1, 9 do
		local go = goutil.findChild(self._leftFmt, "formation/seatTag_" .. i)
		local txt = goutil.findChildTextComponent(go, "img/txt")

		GameUtil.SetActive(go, false)

		if map[i] ~= nil then
			GameUtil.SetActive(go, true)

			txt.text = posMap[i] and map[i] .. "<color=#73FCA6FF>+1</color>" or map[i]
		elseif posMap[i] then
			GameUtil.SetActive(go, true)

			txt.text = "0<color=#73FCA6FF>+1</color>"
		end
	end
end

function KingwujinlongresultView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function KingwujinlongresultView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function KingwujinlongresultView:_onClickCancel()
	KingWujinlongController.instance:sendConfirm(self._activityId, self._confirmNum, false)
end

function KingwujinlongresultView:_onClickSure()
	KingWujinlongController.instance:sendConfirm(self._activityId, self._confirmNum, true)
end

function KingwujinlongresultView:_onCloseAndEnd()
	self:close()
	BattleController.instance:endBattle()
end

return KingwujinlongresultView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalallplayerView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalallplayerView", package.seeall)

local MartialcontestfinalallplayerView = class("MartialcontestfinalallplayerView", ViewComponent)

function MartialcontestfinalallplayerView:ctor()
	MartialcontestfinalallplayerView.super.ctor(self)
end

function MartialcontestfinalallplayerView:unbindEvents()
	MartialcontestfinalallplayerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function MartialcontestfinalallplayerView:bindEvents()
	MartialcontestfinalallplayerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function MartialcontestfinalallplayerView:buildUI()
	MartialcontestfinalallplayerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._rankscrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function MartialcontestfinalallplayerView:onExit()
	MartialcontestfinalallplayerView.super.onExit(self)
	self._rankscrollerList:dispose()
end

function MartialcontestfinalallplayerView:onEnter()
	MartialcontestfinalallplayerView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._myUid = tostring(RoleModel.instance:getUserId())
	self._info = MartialContestModel.instance:getFinalsInfo()

	if self._info then
		if not self._info.allPlayers then
			local allPlayers = {}
			local newPlayers = {}

			table.insertto(newPlayers, allPlayers, 1)
			table.sort(newPlayers, function(a, b)
				if a.isActive ~= b.isActive then
					return a.isActive
				elseif a.totalScore ~= b.totalScore then
					return a.totalScore > b.totalScore
				else
					return a.headInfo.headInfo.userId < b.headInfo.headInfo.userId
				end
			end)
			self._rankscrollerList:reloadData(newPlayers)
		end
	end
end

function MartialcontestfinalallplayerView:_updateRankCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goMyTag = goutil.findChild(cell.gameObject, "myTag")
	local goOutTag = goutil.findChild(cell.gameObject, "out")
	local goGray = goutil.findChild(cell.gameObject, "gray")
	local txtKill = goutil.findChildTextComponent(cell.gameObject, "txtKill")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local headInfo = data.headInfo.headInfo

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, headInfo, true)

	txtName.text = headInfo.userName

	goutil.setActive(goMyTag, headInfo.userId == self._myUid)
	goutil.setActive(goOutTag, not data.isActive)
	goutil.setActive(goGray, not data.isActive)

	txtKill.text = string.format("积分:<color=#ffa251>%s</color>", data.totalScore)
end

function MartialcontestfinalallplayerView:_clearRankCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function MartialcontestfinalallplayerView:_onClickbtnClose()
	self:close()
end

return MartialcontestfinalallplayerView

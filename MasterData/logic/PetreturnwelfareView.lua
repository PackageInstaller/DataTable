-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/PetreturnwelfareView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.PetreturnwelfareView", package.seeall)

local PetreturnwelfareView = class("PetreturnwelfareView", SummarySubTabView)

function PetreturnwelfareView:ctor()
	PetreturnwelfareView.super.ctor(self)
end

function PetreturnwelfareView:unbindEvents()
	PetreturnwelfareView.super.unbindEvents(self)
end

function PetreturnwelfareView:bindEvents()
	PetreturnwelfareView.super.bindEvents(self)
end

function PetreturnwelfareView:buildUI()
	PetreturnwelfareView.super.buildUI(self)

	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function PetreturnwelfareView:onExit()
	PetreturnwelfareView.super.onExit(self)
	self.scrollList:dispose()
end

function PetreturnwelfareView:onEnter()
	PetreturnwelfareView.super.onEnter(self)

	local bg = string.split(self._cfgs[1].background, "#")
	local params = string.split(self._cfgs[1].params, "#")
	local data = {}

	for i = 1, #bg do
		data[i] = {}
		data[i].bg = bg[i]

		local arr = string.split(params[i], "&")

		data[i].name = arr[1]
		data[i].offsetY = checknumber(arr[2])
	end

	self.scrollList:reloadData(data)
end

function PetreturnwelfareView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "info")
	local txtName = goutil.findChildTextComponent(cell, "info/txtName")

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("bonus", data.bg))
	GameUtil.setAnchoredPos(icon, 0, data.offsetY)

	txtName.text = data.name
end

function PetreturnwelfareView:clearCell(cell)
	local icon = goutil.findChild(cell, "info")

	GameUtil.rmClickHandler(icon)
	uGuiUtil.clearImage(icon)
end

return PetreturnwelfareView

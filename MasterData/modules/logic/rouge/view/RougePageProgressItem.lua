-- chunkname: @modules/logic/rouge/view/RougePageProgressItem.lua

module("modules.logic.rouge.view.RougePageProgressItem", package.seeall)

local RougePageProgressItem = class("RougePageProgressItem", UserDataDispose)
local kItemEnum = {
	line2 = 3,
	line1 = 2,
	finished = 0,
	line3 = 4,
	unfinished = 1
}

RougePageProgressItem.LineStateEnum = {
	Edit = 2,
	Locked = 3,
	Done = 1
}

function RougePageProgressItem:ctor(parent)
	self:__onInit()

	self._parent = parent
end

function RougePageProgressItem:init(transform)
	self.viewGO = transform.gameObject
	self._transFinished = transform:GetChild(kItemEnum.finished)
	self._transUnFinished = transform:GetChild(kItemEnum.unfinished)
	self._transLine1 = transform:GetChild(kItemEnum.line1)
	self._transLine2 = transform:GetChild(kItemEnum.line2)
	self._transLine3 = transform:GetChild(kItemEnum.line3)
end

function RougePageProgressItem:setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function RougePageProgressItem:setHighLight(isActive)
	GameUtil.setActive01(self._transFinished, isActive)
	GameUtil.setActive01(self._transUnFinished, not isActive)
end

function RougePageProgressItem:setLineActive(index, isActive)
	GameUtil.setActive01(self["_transLine" .. index], isActive)
end

function RougePageProgressItem:setLineActiveByState(eState)
	GameUtil.setActive01(self._transLine1, eState == RougePageProgressItem.LineStateEnum.Done)
	GameUtil.setActive01(self._transLine2, eState == RougePageProgressItem.LineStateEnum.Edit)
	GameUtil.setActive01(self._transLine3, eState == RougePageProgressItem.LineStateEnum.Locked)
end

function RougePageProgressItem:onDestroy()
	self:onDestroyView()
end

function RougePageProgressItem:onDestroyView()
	self:__onDispose()
end

return RougePageProgressItem

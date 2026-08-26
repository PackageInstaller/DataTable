-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183BaseGroupEntranceItem.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183BaseGroupEntranceItem", package.seeall)

local Act183BaseGroupEntranceItem = class("Act183BaseGroupEntranceItem", LuaCompBase)

function Act183BaseGroupEntranceItem.Get(goroot, groupMo, index)
	return
end

function Act183BaseGroupEntranceItem:ctor(index)
	Act183BaseGroupEntranceItem.super.ctor(self)

	self._index = index
end

function Act183BaseGroupEntranceItem:init(go)
	self.go = go
end

function Act183BaseGroupEntranceItem:addEventListeners()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function Act183BaseGroupEntranceItem:removeEventListeners()
	return
end

function Act183BaseGroupEntranceItem:onUpdateMO(groupMo)
	self._actId = Act183Model.instance:getActivityId()
	self._groupMo = groupMo
	self._status = groupMo:getStatus()
	self._groupId = groupMo:getGroupId()
	self._groupType = groupMo:getGroupType()

	gohelper.setActive(self.go, true)
end

function Act183BaseGroupEntranceItem:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.Act183MainView then
		return
	end

	self:tryPlayUnlockAnim()
end

function Act183BaseGroupEntranceItem:_onCloseViewFinish(viewName)
	self:tryPlayUnlockAnim()
end

function Act183BaseGroupEntranceItem:tryPlayUnlockAnim()
	local canPlayAnim = self:checkCanPlayUnlockAnim()

	if not canPlayAnim then
		return
	end

	self:startPlayUnlockAnim()
end

function Act183BaseGroupEntranceItem:checkCanPlayUnlockAnim()
	local isTop = ViewHelper.instance:checkViewOnTheTop(ViewName.Act183MainView)

	if not isTop then
		return
	end

	if self._status == Act183Enum.GroupStatus.Locked then
		return
	end

	local hasPlayUnlockAnim = Act183Helper.isGroupHasPlayUnlockAnim(self._actId, self._groupId)

	return not hasPlayUnlockAnim
end

function Act183BaseGroupEntranceItem:startPlayUnlockAnim()
	self:onPlayUnlockAnimDone()
end

function Act183BaseGroupEntranceItem:onPlayUnlockAnimDone()
	Act183Helper.savePlayUnlockAnimGroupIdInLocal(self._actId, self._groupId)
end

return Act183BaseGroupEntranceItem

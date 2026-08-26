-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183MainGroupEntranceItem.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183MainGroupEntranceItem", package.seeall)

local Act183MainGroupEntranceItem = class("Act183MainGroupEntranceItem", Act183BaseGroupEntranceItem)

function Act183MainGroupEntranceItem.Get(goroot, groupType, index)
	local gopath = ""

	if groupType == Act183Enum.GroupType.NormalMain then
		gopath = "root/middle/#go_main/#go_normal"
	elseif groupType == Act183Enum.GroupType.HardMain then
		gopath = "root/middle/#go_main/#go_hard"
	end

	local go = gohelper.findChild(goroot, gopath)
	local cls = Act183Enum.GroupEntranceItemClsType[groupType]

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, index)
end

function Act183MainGroupEntranceItem:init(go)
	Act183MainGroupEntranceItem.super.init(self, go)

	self._goresult = gohelper.findChild(go, "go_result")
	self._txttitle = gohelper.findChildText(go, "txt_title")
	self._txttotalprogress = gohelper.findChildText(go, "go_result/txt_totalprogress")
	self._golock = gohelper.findChild(go, "go_lock")
	self._animlock = gohelper.onceAddComponent(self._golock, gohelper.Type_Animator)
end

function Act183MainGroupEntranceItem:onUpdateMO(groupMo)
	Act183MainGroupEntranceItem.super.onUpdateMO(self, groupMo)

	local status = groupMo:getStatus()
	local isUnlock = status ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(self._golock, not isUnlock)
	gohelper.setActive(self._goresult, isUnlock)

	if isUnlock then
		local groupId = groupMo:getGroupId()
		local allTaskCount, taskFinishCount = Act183Helper.getGroupEpisodeTaskProgress(self._actId, groupId)

		self._txttotalprogress.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_finished"), taskFinishCount, allTaskCount)
	end
end

function Act183MainGroupEntranceItem:startPlayUnlockAnim()
	if self._groupType == Act183Enum.GroupType.NormalMain or self._hasPlayUnlockAnim then
		return
	end

	gohelper.setActive(self._golock, true)
	self._animlock:Play("unlock", 0, 0)

	self._hasPlayUnlockAnim = true
end

function Act183MainGroupEntranceItem:onDestroy()
	if self._hasPlayUnlockAnim then
		Act183Helper.savePlayUnlockAnimGroupIdInLocal(self._actId, self._groupId)

		self._waitRecord = false
	end
end

return Act183MainGroupEntranceItem

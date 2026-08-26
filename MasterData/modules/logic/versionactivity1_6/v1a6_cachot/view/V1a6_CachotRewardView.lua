-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRewardView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardView", package.seeall)

local V1a6_CachotRewardView = class("V1a6_CachotRewardView", BaseView)

function V1a6_CachotRewardView:onInitView()
	self._goScroll = gohelper.findChild(self.viewGO, "scroll_view")
	self._scrollRect = gohelper.findChildScrollRect(self.viewGO, "scroll_view")
	self._rewarditem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/rewarditem")
	self._rewarditemParent = self._rewarditem.transform.parent.gameObject
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_exit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRewardView:addEvents()
	self._btnexit:AddClickListener(self._onClickExit, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, self._refreshView, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventRemove, self._onRemoveEvent, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnReceiveFightReward, self._checkCloseView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._playOpenAnim, self)
end

function V1a6_CachotRewardView:removeEvents()
	self._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventChange, self._refreshView, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventRemove, self._onRemoveEvent, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnReceiveFightReward, self._checkCloseView, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._playOpenAnim, self)
end

function V1a6_CachotRewardView:_editableInitView()
	return
end

function V1a6_CachotRewardView:onUpdateParam()
	return
end

function V1a6_CachotRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
	self:_refreshView()

	self._scrollRect.horizontalNormalizedPosition = 0
end

function V1a6_CachotRewardView:_onRemoveEvent(eventMo)
	if eventMo and eventMo ~= self.viewParam then
		return
	end

	local datas = self.viewParam:getDropList()

	if not datas or #datas == 0 then
		self._isAllRewardGeted = true
	end
end

function V1a6_CachotRewardView:_checkCloseView()
	if self._isAllRewardGeted then
		self:closeThis()
	end
end

function V1a6_CachotRewardView:_refreshView(eventMo)
	if eventMo and eventMo ~= self.viewParam then
		return
	end

	local datas = self.viewParam:getDropList()

	if not datas or #datas == 0 then
		self:closeThis()

		return
	end

	gohelper.CreateObjList(self, self._setitem, datas, self._rewarditemParent, self._rewarditem, V1a6_CachotRewardItem)
end

function V1a6_CachotRewardView:_setitem(obj, data, index)
	obj:updateMo(data, self._goScroll)
end

function V1a6_CachotRewardView:_onClickExit()
	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.CachotAbandonAward, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_abandon_award"), nil, nil, nil, self.abandonAward, nil, nil, self, nil, nil)
end

function V1a6_CachotRewardView:_playOpenAnim()
	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
end

function V1a6_CachotRewardView:abandonAward()
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)
end

function V1a6_CachotRewardView:onClose()
	return
end

function V1a6_CachotRewardView:onDestroyView()
	return
end

return V1a6_CachotRewardView

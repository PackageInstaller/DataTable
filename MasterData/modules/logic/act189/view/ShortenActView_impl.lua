-- chunkname: @modules/logic/act189/view/ShortenActView_impl.lua

module("modules.logic.act189.view.ShortenActView_impl", package.seeall)

local ShortenActView_impl = class("ShortenActView_impl", Activity189BaseView)

function ShortenActView_impl:_getStyleItem(styleId)
	return self._styleItemList[styleId]
end

function ShortenActView_impl:_getCurStyleId()
	self._curStyleId = self._curStyleId or self:getStyleCO().id

	return self._curStyleId
end

function ShortenActView_impl:_getCurStyleItem()
	return self:_getStyleItem(self:_getCurStyleId())
end

function ShortenActView_impl:_editableInitView()
	if isDebugBuild then
		assert(self._txttime)
	end

	self._styleItemList = {}

	self:_regStyleItem(self._go28days, ShortenAct_28days, Activity189Enum.Style._28)
	self:_regStyleItem(self._go35days, ShortenAct_35days, Activity189Enum.Style._35)
end

function ShortenActView_impl:_regStyleItem(go, clsDefine, styleId)
	local item = clsDefine.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(styleId)
	item:init(go)
	gohelper.setActive(go, self:_getCurStyleId() == styleId)

	self._styleItemList[styleId] = item

	return item
end

function ShortenActView_impl:onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	ShortenActView_impl.super.onOpen(self)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, self._onReceiveGetAct189OnceBonusReply, self)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_mln_page_turn_20260901)
end

function ShortenActView_impl:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	GameUtil.onDestroyViewMemberList(self, "_styleItemList")
	ShortenActView_impl.super:onDestroyView(self)
end

function ShortenActView_impl:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, self._onReceiveGetAct189OnceBonusReply, self)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	ShortenActView_impl.super.onClose(self)
end

function ShortenActView_impl:onUpdateParam()
	self:_refreshTimeTick()
	self:_refreshStyleItem()
	ShortenActView_impl.super.onUpdateParam(self)
end

function ShortenActView_impl:_refreshTimeTick()
	self._txttime.text = self:getRemainTimeStr()
end

function ShortenActView_impl:_refreshStyleItem()
	local item = self:_getCurStyleItem()

	item:onUpdateMO()
end

function ShortenActView_impl:_onReceiveGetAct189OnceBonusReply()
	self:_refreshStyleItem()
end

function ShortenActView_impl:_onReceiveGetAct189InfoReply()
	self:_refreshStyleItem()
end

function ShortenActView_impl:getStyleCO()
	return ShortenActConfig.instance:getStyleCO()
end

function ShortenActView_impl:getBonusList()
	return ShortenActConfig.instance:getBonusList()
end

function ShortenActView_impl:onItemClick()
	if self:isClaimable() then
		Activity189Controller.instance:sendGetAct189OnceBonusRequest(self:actId())

		return false
	end

	return true
end

function ShortenActView_impl:isClaimable()
	return ShortenActModel.instance:isClaimable()
end

return ShortenActView_impl

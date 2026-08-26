-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotFinishView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotFinishView", package.seeall)

local V1a6_CachotFinishView = class("V1a6_CachotFinishView", BaseView)

function V1a6_CachotFinishView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._txtsuccesstips = gohelper.findChildText(self.viewGO, "success/#txt_successtips")
	self._txtfailedtips = gohelper.findChildText(self.viewGO, "failed/#txt_failedtips")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_failed")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotFinishView:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
end

function V1a6_CachotFinishView:removeEvents()
	self._btnjump:RemoveClickListener()
end

function V1a6_CachotFinishView:_btnjumpOnClick()
	if self._isFinish then
		if self._rogueEndingInfo then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnFinishGame, self._rogueEndingInfo)
		end
	else
		self:_jump2ResultView()
	end

	self:closeThis()
end

function V1a6_CachotFinishView:_editableInitView()
	return
end

function V1a6_CachotFinishView:onUpdateParam()
	return
end

function V1a6_CachotFinishView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotFinishView, self._btnjumpOnClick, self)
	RogueRpc.instance:sendRogueReadEndingRequest(V1a6_CachotEnum.ActivityId)

	self._rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()
	self._isFinish = false

	if self._rogueEndingInfo then
		self._isFinish = self._rogueEndingInfo._isFinish

		self._rogueEndingInfo:onEnterEndingFlow()
	end

	self:refreshUI()
	self:playAudioEffect()
end

function V1a6_CachotFinishView:refreshUI()
	gohelper.setActive(self._gosuccess, self._isFinish)
	gohelper.setActive(self._gofailed, not self._isFinish)
end

function V1a6_CachotFinishView:_jump2ResultView()
	V1a6_CachotController.instance:openV1a6_CachotResultView()
end

function V1a6_CachotFinishView:playAudioEffect()
	if self._isFinish then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_victory_open)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_fail_open)
	end
end

function V1a6_CachotFinishView:onClose()
	return
end

function V1a6_CachotFinishView:onDestroyView()
	self._rogueEndingInfo = nil
end

return V1a6_CachotFinishView

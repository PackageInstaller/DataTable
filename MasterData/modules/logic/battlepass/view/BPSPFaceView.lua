-- chunkname: @modules/logic/battlepass/view/BPSPFaceView.lua

module("modules.logic.battlepass.view.BPSPFaceView", package.seeall)

local BPSPFaceView = class("BPSPFaceView", BaseView)

function BPSPFaceView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnSkin = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skin")
	self._btnGet = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_get")
end

function BPSPFaceView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnSkin:AddClickListener(self._openSkinPreview, self)
	self._btnGet:AddClickListener(self._openSpView, self)
end

function BPSPFaceView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSkin:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function BPSPFaceView:onClickModalMask()
	self:closeThis()
end

function BPSPFaceView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_youyu_liuxing_give)
end

function BPSPFaceView:_openSkinPreview()
	ViewMgr.instance:openView(ViewName.BpBonusSelectView)
end

function BPSPFaceView:_openSpView()
	BpModel.instance.firstShowSp = false

	BpRpc.instance:sendBpMarkFirstShowRequest(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
	BpController.instance:openBattlePassView(true, {
		isFirst = true
	})
end

function BPSPFaceView:_onViewClose(viewName)
	if viewName == ViewName.BpSPView then
		self:closeThis()
	end
end

return BPSPFaceView

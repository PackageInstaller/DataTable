-- chunkname: @modules/logic/battlepass/view/BpVideoView.lua

module("modules.logic.battlepass.view.BpVideoView", package.seeall)

local BpVideoView = class("BpVideoView", BaseView)

function BpVideoView:onInitView()
	self._videoGo = gohelper.findChild(self.viewGO, "#go_video")
end

function BpVideoView:onOpen()
	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGo)

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_admission)
	self._videoPlayer:play("bp_open", false, self._videoStatusUpdate, self)
end

function BpVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		if not ViewMgr.instance:isOpen(BpController.instance:getBpChargeView()) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.closeThis, self)
			ViewMgr.instance:openView(BpController.instance:getBpChargeView(), {
				first = true
			})
		else
			self:closeThis()
		end
	end
end

function BpVideoView:onDestroyView()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.closeThis, self)

	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

return BpVideoView

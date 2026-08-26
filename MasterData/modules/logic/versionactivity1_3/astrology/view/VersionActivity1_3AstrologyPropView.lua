-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyPropView.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPropView", package.seeall)

local VersionActivity1_3AstrologyPropView = class("VersionActivity1_3AstrologyPropView", BaseView)

function VersionActivity1_3AstrologyPropView:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._scrollitem = gohelper.findChild(self.viewGO, "#scroll_item")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_item/itemcontent")
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3AstrologyPropView:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
end

function VersionActivity1_3AstrologyPropView:removeEvents()
	self._bgClick:RemoveClickListener()
end

function VersionActivity1_3AstrologyPropView:_editableInitView()
	self._contentGrid = self._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._titleAni = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	local videoGo = gohelper.findChild(self.viewGO, "#go_video")

	self._videoPlayer = VideoPlayerMgr.instance:createVideoPlayer(videoGo)

	self._videoPlayer:play("commonprop", true, nil, nil)
end

function VersionActivity1_3AstrologyPropView:_onClickBG()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function VersionActivity1_3AstrologyPropView:onOpen()
	self._titleAni:Play()

	CommonPropListItem.hasOpen = false
	self._contentGrid.enabled = false

	self:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_3AstrologyPropView, self._onClickBG, self)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, nil, nil, nil, EaseType.Linear)

	TaskDispatcher.runDelay(self._setCanClose, self, 0.8)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end
end

function VersionActivity1_3AstrologyPropView:_setCanClose()
	self._cantClose = false
end

function VersionActivity1_3AstrologyPropView:onClose()
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function VersionActivity1_3AstrologyPropView:onClickModalMask()
	self:closeThis()
end

function VersionActivity1_3AstrologyPropView:_setPropItems()
	CommonPropListModel.instance:setPropList(self.viewParam)

	local list = CommonPropListModel.instance:getList()

	if #list < 6 then
		transformhelper.setLocalPosXY(self._scrollitem.transform, 0, -185)

		self._contentGrid.enabled = true
	else
		self._contentGrid.enabled = false

		transformhelper.setLocalPosXY(self._scrollitem.transform, 0, -47)
	end
end

function VersionActivity1_3AstrologyPropView:onDestroyView()
	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._setCanClose, self)
end

return VersionActivity1_3AstrologyPropView

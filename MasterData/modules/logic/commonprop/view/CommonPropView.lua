-- chunkname: @modules/logic/commonprop/view/CommonPropView.lua

module("modules.logic.commonprop.view.CommonPropView", package.seeall)

local CommonPropView = class("CommonPropView", BaseView)

if BootNativeUtil.isWindows() then
	module_views.CommonPropView.destroy = 1
end

function CommonPropView:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._scrollitem = gohelper.findChild(self.viewGO, "#scroll_item")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_item/itemcontent")
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPropView:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
end

function CommonPropView:removeEvents()
	self._bgClick:RemoveClickListener()
end

function CommonPropView:_editableInitView()
	self._contentGrid = self._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._titleAni = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	local parentGO = gohelper.findChild(self.viewGO, "#go_video")

	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(parentGO)
end

function CommonPropView:_onClickBG()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function CommonPropView:onOpen()
	self._titleAni:Play()

	CommonPropListItem.hasOpen = false
	self._contentGrid.enabled = false

	self:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.CommonPropView, self._onClickBG, self)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, nil, nil, nil, EaseType.Linear)

	TaskDispatcher.runDelay(self._setCanClose, self, 0.8)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	self._videoPlayer:play("commonprop", true, nil, nil)
end

function CommonPropView:_setCanClose()
	self._cantClose = false
end

function CommonPropView:onClose()
	if BootNativeUtil.isWindows() then
		self._videoPlayer:stop()
	end

	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	if self._videoPlayer and not BootNativeUtil.isIOS() then
		self._videoPlayer:stop()
	end
end

function CommonPropView:onClickModalMask()
	self:closeThis()
end

function CommonPropView:_setPropItems()
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

function CommonPropView:onDestroyView()
	if BootNativeUtil.isWindows() then
		self._videoPlayer = nil
		self._displauUGUI = nil
	end

	if self._videoPlayer then
		self._videoPlayer = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._setCanClose, self)
end

return CommonPropView

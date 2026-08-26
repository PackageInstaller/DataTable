-- chunkname: @modules/logic/battlepass/view/BpPropView.lua

module("modules.logic.battlepass.view.BpPropView", package.seeall)

local BpPropView = class("BpPropView", BaseView)

function BpPropView:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._scrollitem = gohelper.findChild(self.viewGO, "#scroll_item")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_item/itemcontent")
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")
	self._govideo = gohelper.findChild(self.viewGO, "#go_video")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpPropView:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
end

function BpPropView:removeEvents()
	self._bgClick:RemoveClickListener()
end

function BpPropView:_editableInitView()
	self._contentGrid = self._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	self._titleAni = self.viewGO:GetComponent(typeof(UnityEngine.Animation))
	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo)

	self._videoPlayer:play("commonprop", true, nil, nil)
end

function BpPropView:_onClickBG()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function BpPropView:onOpen()
	self._titleAni:Play()

	CommonPropListItem.hasOpen = false
	self._contentGrid.enabled = false

	self:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView, self._onClickBG, self)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, self._tweenFinish, self, nil, EaseType.Linear)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end
end

function BpPropView:_tweenFinish()
	self._cantClose = false
end

function BpPropView:onClose()
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function BpPropView:onClickModalMask()
	self:closeThis()
end

function BpPropView:_setPropItems()
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

function BpPropView:onDestroyView()
	if self._videoPlayer then
		self._videoPlayer:stop()
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

return BpPropView

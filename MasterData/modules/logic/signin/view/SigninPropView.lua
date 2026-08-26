-- chunkname: @modules/logic/signin/view/SigninPropView.lua

module("modules.logic.signin.view.SigninPropView", package.seeall)

local SigninPropView = class("SigninPropView", BaseView)

function SigninPropView:onInitView()
	self._bgClick = gohelper.getClick(self.viewGO)
	self._scrollitem = gohelper.findChild(self.viewGO, "#scroll_item")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_item/viewport/itemcontent")
	self._goeff = gohelper.findChild(self.viewGO, "#go_eff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SigninPropView:addEvents()
	self._bgClick:AddClickListener(self._onClickBG, self)
end

function SigninPropView:removeEvents()
	self._bgClick:RemoveClickListener()
end

function SigninPropView:_editableInitView()
	self._contentGrid = self._gocontent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
end

function SigninPropView:_onClickBG()
	if self._cantClose then
		return
	end

	self:closeThis()
end

function SigninPropView:onOpen()
	CommonPropListItem.hasOpen = false
	self._contentGrid.enabled = false

	self:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.SigninPropView, self._onClickBG, self)

	self._cantClose = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, nil, nil, nil, nil, EaseType.Linear)

	TaskDispatcher.runDelay(self._setCanClose, self, 0.8)
	AudioMgr.instance:trigger(AudioEnum3_2.play_ui_shengyan_pailian)
end

function SigninPropView:_setCanClose()
	self._cantClose = false
end

function SigninPropView:onClose()
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function SigninPropView:onClickModalMask()
	self:closeThis()
end

function SigninPropView:_setPropItems()
	CommonPropListModel.instance:setPropList(self.viewParam)

	local list = CommonPropListModel.instance:getList()

	if #list < 6 then
		transformhelper.setLocalPosXY(self._scrollitem.transform, 0, -185)

		self._contentGrid.enabled = true
	else
		self._contentGrid.enabled = false

		transformhelper.setLocalPosXY(self._scrollitem.transform, 0, -47)
	end

	self._gocontent.transform.pivot = CommonBuffTipEnum.Pivot.Center
	self._gocontent.transform.anchorMin = CommonBuffTipEnum.Pivot.Center
	self._gocontent.transform.anchorMax = CommonBuffTipEnum.Pivot.Center
end

function SigninPropView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._setCanClose, self)
end

return SigninPropView

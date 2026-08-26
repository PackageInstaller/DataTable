-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverView", package.seeall)

local V1a6_CachotRoleRecoverView = class("V1a6_CachotRoleRecoverView", BaseView)

function V1a6_CachotRoleRecoverView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._goleft = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	self._simageselect = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	self._gopresetcontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	self._goright = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	self._gopreparecontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gostart = gohelper.findChild(self.viewGO, "#go_start")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_start/#btn_start")
	self._gostartlight = gohelper.findChild(self.viewGO, "#go_start/#btn_start/#go_startlight")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRoleRecoverView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function V1a6_CachotRoleRecoverView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function V1a6_CachotRoleRecoverView:_btnstartOnClick()
	if not self._selectedMo or not self._selectedMo:getHeroMO() then
		GameFacade.showToast(ToastEnum.V1a6CachotToast10)

		return
	end

	local heroMo = self._selectedMo:getHeroMO()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, heroMo.heroId, self._onSelectEnd, self)
end

function V1a6_CachotRoleRecoverView:_onSelectEnd()
	V1a6_CachotController.instance:openV1a6_CachotRoleRecoverResultView({
		self._selectedMo
	})
end

function V1a6_CachotRoleRecoverView:_btncloseOnClick()
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)
end

function V1a6_CachotRoleRecoverView:_editableInitView()
	V1a6_CachotRoleRecoverPresetListModel.instance:initList()
	V1a6_CachotRoleRecoverPrepareListModel.instance:initList()

	self._contentSizeFitter = self._gocontent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	self._horizontal = self._gocontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self._limitedScrollRect = self._scrollview:GetComponent(typeof(ZProj.LimitedScrollRect))

	self:_initPresetItemList()
end

function V1a6_CachotRoleRecoverView:_initPresetItemList()
	if self._presetItemList then
		return
	end

	self._presetItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local childGO = self:getResInst(path, self._gopresetcontent, "item" .. tostring(i))

		self._presetItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRecoverPresetItem)
	end
end

function V1a6_CachotRoleRecoverView:_initPrepareItemList()
	if self._prepareItemList then
		return
	end

	self._prepareItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[2]
	local list = V1a6_CachotRoleRecoverPrepareListModel.instance:getList()

	for i, v in ipairs(list) do
		local childGO = self:getResInst(path, self._gopreparecontent, "item" .. tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRecoverPrepareItem)

		self._prepareItemList[i] = item

		item:hideEquipNone()
		item:onUpdateMO(v)
	end
end

function V1a6_CachotRoleRecoverView:onUpdateParam()
	return
end

function V1a6_CachotRoleRecoverView:onOpen()
	self:_updatePresetItemList()
	self:_initPrepareItemList()

	local list = V1a6_CachotRoleRecoverPrepareListModel.instance:getList()
	local num = #list

	if num <= 4 then
		self._limitedScrollRect.enabled = false
		self._contentSizeFitter.enabled = false

		recthelper.setWidth(self._goleft.transform, 800)
		recthelper.setWidth(self._goright.transform, 700)
	elseif num <= 8 then
		self._limitedScrollRect.enabled = false
		self._gocontent.transform.anchorMin = Vector2.New(0.5, 0.5)
		self._gocontent.transform.anchorMax = Vector2.New(0.5, 0.5)

		recthelper.setAnchorX(self._gocontent.transform, -1206)
	else
		recthelper.setWidth(self._goleft.transform, 720)

		local padding = self._horizontal.padding

		padding.right = 300
		self._horizontal.padding = padding
	end

	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function V1a6_CachotRoleRecoverView:_updatePresetItemList()
	local list = V1a6_CachotRoleRecoverPresetListModel.instance:getList()

	for i, item in ipairs(self._presetItemList) do
		local mo = list[i]

		item:onUpdateMO(mo)
	end
end

function V1a6_CachotRoleRecoverView:_onCloseView(viewName)
	if viewName == ViewName.V1a6_CachotRoleRecoverResultView then
		self:closeThis()
	end
end

function V1a6_CachotRoleRecoverView:_onClickTeamItem(mo)
	self._selectedMo = mo
end

function V1a6_CachotRoleRecoverView:onClose()
	return
end

function V1a6_CachotRoleRecoverView:onDestroyView()
	return
end

return V1a6_CachotRoleRecoverView

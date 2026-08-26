-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamPreView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreView", package.seeall)

local V1a6_CachotTeamPreView = class("V1a6_CachotTeamPreView", BaseView)

function V1a6_CachotTeamPreView:onInitView()
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content")
	self._goleft = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left")
	self._simageselect = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left/#simage_select")
	self._gopresetcontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_left/scroll_view/Viewport/#go_presetcontent")
	self._goright = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_right")
	self._gopreparecontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/#go_content/#go_right/scroll_view/Viewport/#go_preparecontent")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotTeamPreView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotTeamPreView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotTeamPreView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotTeamPreView:_editableInitView()
	self._contentSizeFitter = self._gocontent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	self._horizontal = self._gocontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self._limitedScrollRect = self._scrollview:GetComponent(typeof(ZProj.LimitedScrollRect))

	self:_initPresetItemList()
end

function V1a6_CachotTeamPreView:_initPresetItemList()
	if self._presetItemList then
		return
	end

	self._presetItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local childGO = self:getResInst(path, self._gopresetcontent, "item" .. tostring(i))

		self._presetItemList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamPreviewPresetItem)
	end
end

function V1a6_CachotTeamPreView:_initPrepareItemList()
	if self._prepareItemList then
		return
	end

	self._prepareItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[2]
	local list = V1a6_CachotTeamPreviewPrepareListModel.instance:getList()

	for i, v in ipairs(list) do
		local childGO = self:getResInst(path, self._gopreparecontent, "item" .. tostring(i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamPreviewPrepareItem)

		self._prepareItemList[i] = item

		item:hideEquipNone()
		item:onUpdateMO(v)
	end
end

function V1a6_CachotTeamPreView:onUpdateParam()
	return
end

function V1a6_CachotTeamPreView:onOpen()
	V1a6_CachotTeamModel.instance:clearSeatInfos()
	V1a6_CachotTeamPreviewPrepareListModel.instance:initList()
	self:_updatePresetItemList()
	self:_initPrepareItemList()

	local list = V1a6_CachotTeamPreviewPrepareListModel.instance:getList()
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
end

function V1a6_CachotTeamPreView:_updatePresetItemList()
	local list = V1a6_CachotTeamPreviewPresetListModel.instance:initList()

	for i, item in ipairs(self._presetItemList) do
		local mo = list[i]

		item:onUpdateMO(mo)
	end
end

function V1a6_CachotTeamPreView:onClose()
	return
end

function V1a6_CachotTeamPreView:onDestroyView()
	return
end

return V1a6_CachotTeamPreView

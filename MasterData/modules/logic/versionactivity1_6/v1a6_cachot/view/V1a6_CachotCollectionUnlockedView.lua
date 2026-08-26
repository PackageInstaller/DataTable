-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionUnlockedView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedView", package.seeall)

local V1a6_CachotCollectionUnlockedView = class("V1a6_CachotCollectionUnlockedView", BaseView)

function V1a6_CachotCollectionUnlockedView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetipsbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipsbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_info/#scroll_view")
	self._gounlockeditem = gohelper.findChild(self.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container")
	self._txtitem = gohelper.findChildText(self.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container/#txt_item")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_quit")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionUnlockedView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
end

function V1a6_CachotCollectionUnlockedView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquit:RemoveClickListener()
end

function V1a6_CachotCollectionUnlockedView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionUnlockedView:_btnquitOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionUnlockedView:_editableInitView()
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_info/#scroll_view/Viewport/Content")
	self._contentGrid = gohelper.onceAddComponent(self._goScrollContent, typeof(UnityEngine.UI.GridLayoutGroup))
	self._contentGrid.enabled = false
end

function V1a6_CachotCollectionUnlockedView:onUpdateParam()
	return
end

function V1a6_CachotCollectionUnlockedView:onOpen()
	V1a6_CachotCollectionUnlockController.instance:onOpenView()
	self:setInfoPos()
end

function V1a6_CachotCollectionUnlockedView:setInfoPos()
	local listCount = V1a6_CachotCollectionUnLockListModel.instance:getCount()
	local scrollParam = self.viewContainer:getListScrollParam()

	if scrollParam then
		if not scrollParam.lineCount then
			local lineCount = 0
			local isMultifyLine = lineCount < listCount

			self._contentGrid.enabled = not isMultifyLine
		end
	end
end

function V1a6_CachotCollectionUnlockedView:onClose()
	V1a6_CachotCollectionUnlockController.instance:onCloseView()
end

function V1a6_CachotCollectionUnlockedView:onDestroyView()
	return
end

return V1a6_CachotCollectionUnlockedView

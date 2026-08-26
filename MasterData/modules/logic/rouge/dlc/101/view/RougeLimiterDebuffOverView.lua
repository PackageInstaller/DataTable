-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterDebuffOverView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffOverView", package.seeall)

local RougeLimiterDebuffOverView = class("RougeLimiterDebuffOverView", BaseView)

function RougeLimiterDebuffOverView:onInitView()
	self._scrollviews = gohelper.findChildScrollRect(self.viewGO, "#scroll_views")
	self._godebuffitem = gohelper.findChild(self.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem")
	self._imagedebufficon = gohelper.findChildImage(self.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#image_debufficon")
	self._txtbufflevel = gohelper.findChildText(self.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_bufflevel")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#scroll_views/Viewport/Content/#go_debuffitem/#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterDebuffOverView:addEvents()
	return
end

function RougeLimiterDebuffOverView:removeEvents()
	return
end

function RougeLimiterDebuffOverView:_editableInitView()
	return
end

function RougeLimiterDebuffOverView:onUpdateParam()
	return
end

function RougeLimiterDebuffOverView:onOpen()
	self:initScroll()
end

function RougeLimiterDebuffOverView:initScroll()
	if not self._scrollView then
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "#scroll_views"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParam.prefabUrl = "#scroll_views/Viewport/Content/#go_debuffitem"
		scrollParam.cellClass = RougeLimiterDebuffOverListItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 2
		scrollParam.cellWidth = 756
		scrollParam.cellHeight = 200
		self._scrollView = LuaListScrollView.New(RougeLimiterDebuffOverListModel.instance, scrollParam)

		self:addChildView(self._scrollView)
	end

	if self.viewParam then
		local limiterIds = self.viewParam.limiterIds

		RougeLimiterDebuffOverListModel.instance:onInit(limiterIds)
	end
end

function RougeLimiterDebuffOverView:onClose()
	return
end

function RougeLimiterDebuffOverView:onDestroyView()
	return
end

return RougeLimiterDebuffOverView

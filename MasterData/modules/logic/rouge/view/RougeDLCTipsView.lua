-- chunkname: @modules/logic/rouge/view/RougeDLCTipsView.lua

module("modules.logic.rouge.view.RougeDLCTipsView", package.seeall)

local RougeDLCTipsView = class("RougeDLCTipsView", BaseView)

function RougeDLCTipsView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_root/#go_container")
	self._txtdlcname = gohelper.findChildText(self.viewGO, "#go_root/#go_container/#txt_dlcname")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_root/#go_container/#scroll_info")
	self._simagebanner = gohelper.findChildSingleImage(self.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	self._txtdlcdesc = gohelper.findChildText(self.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDLCTipsView:addEvents()
	return
end

function RougeDLCTipsView:removeEvents()
	return
end

function RougeDLCTipsView:_editableInitView()
	return
end

function RougeDLCTipsView:onUpdateParam()
	return
end

function RougeDLCTipsView:onOpen()
	self:refreshDLCContainer()
end

function RougeDLCTipsView:refreshDLCContainer()
	if self.viewParam then
		local dlcId = self.viewParam.dlcId
		local dlcCo = lua_rouge_season.configDict[dlcId]

		if dlcCo then
			self._txtdlcname.text = dlcCo.name
			self._txtdlcdesc.text = dlcCo.desc

			local bannerUrl = ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. dlcCo.id)

			self._simagebanner:LoadImage(bannerUrl)
		end
	end
end

function RougeDLCTipsView:onClose()
	return
end

function RougeDLCTipsView:onDestroyView()
	return
end

return RougeDLCTipsView

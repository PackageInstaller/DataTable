-- chunkname: @modules/logic/rouge/view/RougeDLCSelectView.lua

module("modules.logic.rouge.view.RougeDLCSelectView", package.seeall)

local RougeDLCSelectView = class("RougeDLCSelectView", BaseView)

function RougeDLCSelectView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._scrolldlcs = gohelper.findChildScrollRect(self.viewGO, "#go_root/#scroll_dlcs")
	self._godlcitem = gohelper.findChild(self.viewGO, "#go_root/#scroll_dlcs/Viewport/Content/#go_dlcitem")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_root/#go_container")
	self._txtdlcname = gohelper.findChildText(self.viewGO, "#go_root/#go_container/#txt_dlcname")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#go_root/#go_container/#scroll_info")
	self._simagebanner = gohelper.findChildSingleImage(self.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/bg/#simage_banner")
	self._txtdlcdesc = gohelper.findChildText(self.viewGO, "#go_root/#go_container/#scroll_info/Viewport/Content/#txt_dlcdesc")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_root/#go_container/#btn_add")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_root/#go_container/#btn_remove")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDLCSelectView:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
end

function RougeDLCSelectView:removeEvents()
	self._btnadd:RemoveClickListener()
	self._btnremove:RemoveClickListener()
end

function RougeDLCSelectView:_btnaddOnClick()
	RougeDLCController.instance:addDLC(self._selectVersionId)
end

function RougeDLCSelectView:_btnremoveOnClick()
	RougeDLCController.instance:removeDLC(self._selectVersionId)
end

function RougeDLCSelectView:_editableInitView()
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnSelectDLC, self._onSelectDLC, self)
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnGetVersionInfo, self._onGetVersionInfo, self)
end

function RougeDLCSelectView:onUpdateParam()
	return
end

function RougeDLCSelectView:onOpen()
	RougeDLCSelectListModel.instance:onInit()
end

function RougeDLCSelectView:_onSelectDLC(versionId)
	self._selectVersionId = versionId

	local dlcCO = lua_rouge_season.configDict[self._selectVersionId]

	self:refreshDLCContainer(dlcCO)
	self:refreshButtons(dlcCO)
end

function RougeDLCSelectView:refreshDLCContainer(dlcCO)
	if dlcCO then
		self._txtdlcname.text = dlcCO.name
		self._txtdlcdesc.text = dlcCO.desc

		local bannerUrl = ResUrl.getRougeDLCLangImage("rouge_dlc_banner_" .. dlcCO.id)

		self._simagebanner:LoadImage(bannerUrl)
	end
end

function RougeDLCSelectView:refreshButtons(dlcCO)
	local versions = RougeDLCSelectListModel.instance:getCurSelectVersions()
	local hasAddDLC = tabletool.indexOf(versions, dlcCO.id) ~= nil

	gohelper.setActive(self._btnadd, not hasAddDLC)
	gohelper.setActive(self._btnremove, hasAddDLC)
end

function RougeDLCSelectView:_onGetVersionInfo()
	if self._selectVersionId then
		local dlcCO = lua_rouge_season.configDict[self._selectVersionId]

		self:refreshButtons(dlcCO)
	end
end

function RougeDLCSelectView:onClose()
	RougeDLCController.instance:dispatchEvent(RougeEvent.UpdateRougeVersion)
end

function RougeDLCSelectView:onDestroyView()
	return
end

return RougeDLCSelectView

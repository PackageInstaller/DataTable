-- chunkname: @modules/logic/handbook/view/HandbookCGItem.lua

module("modules.logic.handbook.view.HandbookCGItem", package.seeall)

local HandbookCGItem = class("HandbookCGItem", ListScrollCellExtend)

function HandbookCGItem:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_title/#txt_time")
	self._txtmessycodetime = gohelper.findChildText(self.viewGO, "#go_title/#txt_messycodetime")
	self._txttitleName = gohelper.findChildText(self.viewGO, "#go_title/#txt_titleName")
	self._txttitleNameEN = gohelper.findChildText(self.viewGO, "#go_title/#txt_titleNameEN")
	self._gocg = gohelper.findChild(self.viewGO, "#go_cg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookCGItem:addEvents()
	return
end

function HandbookCGItem:removeEvents()
	return
end

function HandbookCGItem:_editableInitView()
	self.addEventCb(self, HandbookController.instance, HandbookEvent.OnReadInfoChanged, self._onReadInfoChanged, self)

	self._cgItemList = {}

	for i = 1, 3 do
		local cgItem = self:getUserDataTb_()

		cgItem.go = gohelper.findChild(self._gocg, "go_cg" .. i)
		cgItem.simagecgicon = gohelper.findChildSingleImage(cgItem.go, "mask/simage_cgicon")
		cgItem.gonew = gohelper.findChild(cgItem.go, "go_new")
		cgItem.btnclick = gohelper.findChildButtonWithAudio(cgItem.go, "btn_click", AudioEnum.UI.play_ui_screenplay_photo_open)

		cgItem.btnclick:AddClickListener(self._btnclickOnClick, self, i)
		table.insert(self._cgItemList, cgItem)
	end
end

function HandbookCGItem:_btnclickOnClick(index)
	local isTitle = self._mo.isTitle

	if isTitle then
		return
	end

	local cgList = self._mo.cgList
	local config = cgList[index]

	if not config then
		return
	end

	HandbookController.instance:openCGDetailView({
		id = config.id,
		cgType = self._cgType
	})

	local cgItem = self._cgItemList[index]

	gohelper.setActive(cgItem.gonew, false)
end

function HandbookCGItem:_refreshUI()
	gohelper.setActive(self._gotitle, self._mo.isTitle)
	gohelper.setActive(self._gocg, not self._mo.isTitle)

	if self._mo.isTitle then
		local storyChapterId = self._mo.storyChapterId
		local storyChapterConfig = HandbookConfig.instance:getStoryChapterConfig(storyChapterId)

		self._txttitleName.text = storyChapterConfig.name
		self._txttitleNameEN.text = storyChapterConfig.nameEn

		local isnum = GameUtil.utf8isnum(storyChapterConfig.year)

		gohelper.setActive(self._txttime.gameObject, isnum)
		gohelper.setActive(self._txtmessycodetime.gameObject, not isnum)

		if isnum then
			self._txttime.text = storyChapterConfig.year or ""
		end

		self._txtmessycodetime.text = isnum and "" or storyChapterConfig.year
	else
		local cgList = self._mo.cgList

		for i, config in ipairs(cgList) do
			local cgItem = self._cgItemList[i]

			cgItem.simagecgicon:LoadImage(ResUrl.getStorySmallBg(config.image))

			local isRead = HandbookModel.instance:isRead(HandbookEnum.Type.CG, config.id)

			gohelper.setActive(cgItem.gonew, not isRead)
			gohelper.setActive(cgItem.go, true)
		end

		for i = #cgList + 1, 3 do
			local cgItem = self._cgItemList[i]

			gohelper.setActive(cgItem.go, false)
		end
	end
end

function HandbookCGItem:_onReadInfoChanged(info)
	local isTitle = self._mo.isTitle

	if isTitle then
		return
	end

	local cgList = self._mo.cgList

	for i, config in ipairs(cgList) do
		if config.id == info.id and info.type == HandbookEnum.Type.CG then
			local cgItem = self._cgItemList[i]

			gohelper.setActive(cgItem.gonew, not info.isRead)
		end
	end
end

function HandbookCGItem:onUpdateMO(mo)
	self._mo = mo
	self._cgType = mo.cgType

	self:_refreshUI()
end

function HandbookCGItem:onDestroy()
	for i, cgItem in ipairs(self._cgItemList) do
		cgItem.simagecgicon:UnLoadImage()
		cgItem.btnclick:RemoveClickListener()
	end
end

return HandbookCGItem

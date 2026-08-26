-- chunkname: @modules/logic/udimo/view/UdimoChangeBgView.lua

module("modules.logic.udimo.view.UdimoChangeBgView", package.seeall)

local UdimoChangeBgView = class("UdimoChangeBgView", BaseView)
local EMPTY_BG_ID = -1

function UdimoChangeBgView:onInitView()
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_list/Viewport/Content")
	self._goItem = gohelper.findChild(self.viewGO, "#scroll_list/Viewport/Content/#go_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function UdimoChangeBgView:addEvents()
	self.addEventCb(self, UdimoController.instance, UdimoEvent.OnChangeBg, self._onChangeBg, self)
end

function UdimoChangeBgView:removeEvents()
	self.removeEventCb(self, UdimoController.instance, UdimoEvent.OnChangeBg, self._onChangeBg, self)
end

function UdimoChangeBgView:_btnDressOnClick(index)
	if self._bgItemList then
		local bgItem = self._bgItemList[index]
		local bgId = bgItem.id

		UdimoController.instance:useBg(bgId)
	end
end

function UdimoChangeBgView:_onChangeBg()
	self:refreshBgItem()
end

function UdimoChangeBgView:_editableInitView()
	self:setBgList()
end

function UdimoChangeBgView:setBgList()
	self:clearBgItemList()

	local bgList = UdimoConfig.instance:getAllBgList()

	bgList[#bgList + 1] = EMPTY_BG_ID

	gohelper.CreateObjList(self, self._onCreateBgItem, bgList, self._goContent, self._goItem)
end

function UdimoChangeBgView:_onCreateBgItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.go = obj
	item.id = data

	local txtIndex1 = gohelper.findChildText(item.go, "#go_UnSelected/#txt_Num")
	local txtIndex2 = gohelper.findChildText(item.go, "#go_Selected/#txt_Num")

	txtIndex1.text = index
	txtIndex2.text = index
	item.simageIcon1 = gohelper.findChildSingleImage(item.go, "#go_UnSelected/#simage_Icon")
	item.simageIcon2 = gohelper.findChildSingleImage(item.go, "#go_Selected/#simage_Icon")

	if item.id ~= EMPTY_BG_ID then
		local bgName = UdimoConfig.instance:getBgName(item.id)
		local txtName1 = gohelper.findChildText(item.go, "#go_UnSelected/image_Name/#txt_Name")
		local txtName2 = gohelper.findChildText(item.go, "#go_Selected/image_Name/#txt_Name")

		txtName1.text = bgName
		txtName2.text = bgName

		local img = UdimoConfig.instance:getBgImg(item.id)

		if not string.nilorempty(img) then
			local imgPath = ResUrl.getUdimoSingleBg(img)

			item.simageIcon1:LoadImage(imgPath)
			item.simageIcon2:LoadImage(imgPath)
		end
	end

	item.goLocked = gohelper.findChild(item.go, "#go_Locked")
	item.goUnSelected = gohelper.findChild(item.go, "#go_UnSelected")
	item.goSelected = gohelper.findChild(item.go, "#go_Selected")
	item.btnDress = gohelper.findChildButtonWithAudio(item.go, "#go_UnSelected/#btn_Dress")

	item.btnDress:AddClickListener(self._btnDressOnClick, self, index)

	self._bgItemList[index] = item
end

function UdimoChangeBgView:onUpdateParam()
	return
end

function UdimoChangeBgView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Udimo.play_ui_utim_beijing)
	self:refreshBgItem()
end

function UdimoChangeBgView:refreshBgItem()
	if not self._bgItemList then
		return
	end

	local useBg = UdimoItemModel.instance:getUseBg()

	for _, bgItem in ipairs(self._bgItemList) do
		local bgId = bgItem.id

		if bgId == EMPTY_BG_ID then
			gohelper.setActive(bgItem.goLocked, true)
			gohelper.setActive(bgItem.goUnSelected, false)
			gohelper.setActive(bgItem.goSelected, false)
		else
			gohelper.setActive(bgItem.goLocked, false)

			local isUse = useBg == bgId

			gohelper.setActive(bgItem.goSelected, isUse)
			gohelper.setActive(bgItem.goUnSelected, not isUse)
		end
	end
end

function UdimoChangeBgView:clearBgItemList()
	if self._bgItemList then
		for _, bgItem in ipairs(self._bgItemList) do
			bgItem.btnDress:RemoveClickListener()
			bgItem.simageIcon1:UnLoadImage()
			bgItem.simageIcon2:UnLoadImage()
		end
	end

	self._bgItemList = {}
end

function UdimoChangeBgView:onClose()
	self:clearBgItemList()
end

function UdimoChangeBgView:onDestroyView()
	return
end

return UdimoChangeBgView

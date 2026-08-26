-- chunkname: @modules/logic/room/view/building/RoomStrengthView.lua

module("modules.logic.room.view.building.RoomStrengthView", package.seeall)

local RoomStrengthView = class("RoomStrengthView", BaseView)

function RoomStrengthView:onInitView()
	self._simageproducticon = gohelper.findChildSingleImage(self.viewGO, "productdetail/#simage_producticon")
	self._txtnameEn = gohelper.findChildText(self.viewGO, "productdetail/#txt_nameEn")
	self._txtname = gohelper.findChildText(self.viewGO, "productdetail/#txt_name")
	self._txtlv = gohelper.findChildText(self.viewGO, "productdetail/#txt_name/#txt_lv")
	self._txtnosetting = gohelper.findChildText(self.viewGO, "productdetail/#txt_name/#txt_nosetting")
	self._goslotitem = gohelper.findChild(self.viewGO, "productdetail/scroll_productprop/viewport/content/#go_slotitem")
	self._golevelitem = gohelper.findChild(self.viewGO, "scroll_level/viewport/content/#go_levelitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomStrengthView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomStrengthView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RoomStrengthView:_btncloseOnClick()
	self:closeThis()
end

function RoomStrengthView:_btnclickOnClick(index)
	local levelItem = self._levelItemDict[index]

	self._level = levelItem.level

	self:_refreshLevel()
	self:_refreshStrength()
end

function RoomStrengthView:_editableInitView()
	self._levelItemDict = {}

	gohelper.setActive(self._golevelitem, false)

	self._slotItemList = {}

	gohelper.setActive(self._goslotitem, false)
end

function RoomStrengthView:_refreshUI()
	self:_refreshLevel()
	self:_refreshStrength()
end

function RoomStrengthView:_refreshLevel()
	local maxLevel = RoomConfig.instance:getLevelGroupMaxLevel(self._levelGroup)

	for i = 0, maxLevel do
		local level = i
		local levelItem = self._levelItemDict[i]

		if not levelItem then
			levelItem = self:getUserDataTb_()
			levelItem.index = i
			levelItem.go = gohelper.cloneInPlace(self._golevelitem, "item" .. i)
			levelItem.goselect = gohelper.findChild(levelItem.go, "go_beselect")
			levelItem.gounselect = gohelper.findChild(levelItem.go, "go_unselect")
			levelItem.txtlvselect = gohelper.findChildText(levelItem.go, "go_beselect/txt_lv")
			levelItem.txtlvunselect = gohelper.findChildText(levelItem.go, "go_unselect/txt_lv")
			levelItem.btnclick = gohelper.findChildButtonWithAudio(levelItem.go, "btn_click")

			levelItem.btnclick:AddClickListener(self._btnclickOnClick, self, levelItem.index)

			self._levelItemDict[i] = levelItem
		end

		levelItem.level = level

		if level > 0 then
			levelItem.txtlvselect.text = string.format("LV.%s", level)
			levelItem.txtlvunselect.text = string.format("LV.%s", level)
		else
			levelItem.txtlvselect.text = luaLang("roomtradeitemdetail_nosetting")
			levelItem.txtlvunselect.text = luaLang("roomtradeitemdetail_nosetting")
		end

		gohelper.setActive(levelItem.goselect, self._level == levelItem.level)
		gohelper.setActive(levelItem.gounselect, self._level ~= levelItem.level)
		gohelper.setActive(levelItem.go, true)
	end

	for i, levelItem in pairs(self._levelItemDict) do
		if maxLevel < i then
			gohelper.setActive(levelItem.go, false)
		end
	end
end

function RoomStrengthView:_refreshStrength()
	if not self._level then
		local level = 0
		local levelGroupInfo = RoomConfig.instance:getLevelGroupInfo(self._levelGroup, level)

		self._simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. levelGroupInfo.icon))

		self._txtname.text = levelGroupInfo.name
		self._txtnameEn.text = levelGroupInfo.nameEn

		gohelper.setActive(self._txtlv.gameObject, level > 0)
		gohelper.setActive(self._txtnosetting.gameObject, level <= 0)

		if level > 0 then
			self._txtlv.text = string.format("LV.%s", level)
		end

		local slotList = {}

		if level == 0 then
			if not string.nilorempty(levelGroupInfo.desc) then
				table.insert(slotList, {
					desc = string.format("<color=#57503B>%s</color>", levelGroupInfo.desc)
				})
			end
		else
			local levelGroupConfig = RoomConfig.instance:getLevelGroupConfig(self._levelGroup, level)

			table.insert(slotList, {
				desc = string.format("<color=#608C54>%s</color>", levelGroupConfig.desc)
			})

			if levelGroupConfig.costResource > 0 then
				table.insert(slotList, {
					desc = string.format("<color=#943330>%s+%s</color>", luaLang("roomstrengthview_costresource"), levelGroupConfig.costResource)
				})
			elseif levelGroupConfig.costResource < 0 then
				table.insert(slotList, {
					desc = string.format("<color=#608C54>%s-%s</color>", luaLang("roomstrengthview_costresource"), math.abs(levelGroupConfig.costResource))
				})
			end
		end

		for i, slot in ipairs(slotList) do
			local slotItem = self._slotItemList[i]

			if not slotItem then
				slotItem = self:getUserDataTb_()
				slotItem.go = gohelper.cloneInPlace(self._goslotitem, "item" .. i)
				slotItem.gopoint1 = gohelper.findChild(slotItem.go, "go_point1")
				slotItem.gopoint2 = gohelper.findChild(slotItem.go, "go_point2")
				slotItem.txtslotdesc = gohelper.findChildText(slotItem.go, "")

				gohelper.setActive(slotItem.gopoint1, i % 2 == 1)
				gohelper.setActive(slotItem.gopoint2, i % 2 == 0)
				table.insert(self._slotItemList, slotItem)
			end

			slotItem.txtslotdesc.text = slot.desc

			gohelper.setActive(slotItem.go, true)
		end

		for i = #slotList + 1, #self._slotItemList do
			local slotItem = self._slotItemList[i]

			gohelper.setActive(slotItem.go, false)
		end
	end
end

function RoomStrengthView:onOpen()
	self._levelGroup = self.viewParam.levelGroup
	self._level = self.viewParam.level

	self:_refreshUI()
end

function RoomStrengthView:onUpdateParam()
	self._levelGroup = self.viewParam.levelGroup
	self._level = self.viewParam.level

	self:_refreshUI()
end

function RoomStrengthView:onClose()
	return
end

function RoomStrengthView:onDestroyView()
	self._simageproducticon:UnLoadImage()

	for i, levelItem in pairs(self._levelItemDict) do
		levelItem.btnclick:RemoveClickListener()
	end
end

return RoomStrengthView

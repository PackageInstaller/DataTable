-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureCritterItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureCritterItem", package.seeall)

local RoomManufactureCritterItem = class("RoomManufactureCritterItem", ListScrollCellExtend)
local PRESS_TIME = 0.5
local NEXT_PRESS_TIME = 99999

function RoomManufactureCritterItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/#txt_name")
	self._imageskill = gohelper.findChildImage(self.viewGO, "#go_info/#go_skill/#image_skill")
	self._gosimageskill = self._imageskill.gameObject
	self._txtefficiency = gohelper.findChildText(self.viewGO, "#go_info/#go_layoutAttr/#go_efficiency/#txt_efficiency")
	self._txtmoodcostspeed = gohelper.findChildText(self.viewGO, "#go_info/#go_layoutAttr/#go_moodCostSpeed/#txt_moodCostSpeed")
	self._txtcrirate = gohelper.findChildText(self.viewGO, "#go_info/#go_layoutAttr/#go_criRate/#txt_criRate")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._gohighQuality = gohelper.findChild(self.viewGO, "#go_highQuality")
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_click")
	self._goskillTabLayout = gohelper.findChild(self.viewGO, "#go_info/#go_skillTabLayout")
	self._goskillTabItem = gohelper.findChild(self.viewGO, "#go_info/#go_skillTabLayout/#go_skillTabItem")
	self._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(self._btnclick.gameObject)

	self._btnlongPrees:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureCritterItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnlongPrees:AddLongPressListener(self._onLongPress, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, self._onCritterWorkInfoChange, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportCritterChanged, self._onCritterWorkInfoChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)
end

function RoomManufactureCritterItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnlongPrees:RemoveLongPressListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, self._onCritterWorkInfoChange, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.TransportCritterChanged, self._onCritterWorkInfoChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)
end

function RoomManufactureCritterItem:_btnclickOnClick()
	local critterUid = self:getCritterId()
	local pathId = self:getPathId()

	if pathId then
		ManufactureController.instance:clickTransportCritterItem(critterUid)
	else
		ManufactureController.instance:clickCritterItem(critterUid)
	end
end

function RoomManufactureCritterItem:_onLongPress()
	local isMaturity = self._mo:isMaturity()

	CritterController.instance:openRoomCritterDetailView(not isMaturity, self._mo)
end

function RoomManufactureCritterItem:_onCritterWorkInfoChange()
	self:refreshSelected()
end

function RoomManufactureCritterItem:_onAttrPreviewUpdate(critterUidDict)
	local critterUid = self:getCritterId()

	if critterUid and not critterUidDict[critterUid] then
		return
	end

	self:refreshPreviewAttr()
	self:refreshPreviewSkill()
end

function RoomManufactureCritterItem:_onCritterRenameReply(critterUid)
	local curUid = self:getCritterId()

	if curUid == critterUid then
		self:setCritter()
	end
end

function RoomManufactureCritterItem:_editableInitView()
	gohelper.setActive(self._goskillTabItem, false)
end

function RoomManufactureCritterItem:getViewBuilding()
	local viewBuildingUid, viewBuildingMO, viewBuildingId = self._view.viewContainer:getContainerViewBuilding()

	return viewBuildingUid, viewBuildingMO, viewBuildingId
end

function RoomManufactureCritterItem:getPathId()
	return self._view.viewContainer:getContainerPathId()
end

function RoomManufactureCritterItem:getCritterId()
	local critterUid, critterId

	if self._mo then
		critterUid = self._mo:getId()
		critterId = self._mo:getDefineId()
	end

	return critterUid, critterId
end

function RoomManufactureCritterItem:getPreviewAttrInfo()
	local critterUid = self:getCritterId()
	local isPreview = true
	local buildingId

	if not self:getPathId() then
		local crurBuildingUid, buildingMO, curBuildingId = self:getViewBuilding()

		if buildingMO and buildingMO:isCritterInSeatSlot(critterUid) then
			buildingId = curBuildingId
			isPreview = false
		end
	end

	return ManufactureCritterListModel.instance:getPreviewAttrInfo(critterUid, buildingId, isPreview)
end

function RoomManufactureCritterItem:onUpdateMO(mo)
	self._mo = mo

	self:setCritter()
	self:refresh()

	local _, _, curBuildingId = self:getViewBuilding()

	CritterController.instance:getNextCritterPreviewAttr(curBuildingId, self._index)
end

function RoomManufactureCritterItem:setCritter()
	local critterUid, critterId = self:getCritterId()

	self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._goicon)

	self.critterIcon:setMOValue(critterUid, critterId)
	self.critterIcon:showMood()

	if self._mo then
		self._txtname.text = self._mo:getName() or CritterConfig.instance:getCritterName(critterId)
	end

	if self._mo then
		local skillInfo = self._mo:getSkillInfo()

		if skillInfo then
			for _, tag in pairs(skillInfo) do
				local tagCo = CritterConfig.instance:getCritterTagCfg(tag)

				if tagCo and tagCo.type == CritterEnum.TagType.Race then
					UISpriteSetMgr.instance:setCritterSprite(self._imageskill, tagCo.skillIcon)

					break
				end
			end
		end

		local isHighQuality = self._mo:getIsHighQuality()

		gohelper.setActive(self._gohighQuality, isHighQuality)
	end
end

function RoomManufactureCritterItem:refresh()
	self:refreshSelected()
	self:refreshPreviewAttr()
	self:refreshPreviewSkill()
end

function RoomManufactureCritterItem:refreshSelected()
	if not self.critterIcon then
		return
	end

	local isSelected = false
	local critterUid = self:getCritterId()
	local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)
	local workingPathId = workingPathMO and workingPathMO.id
	local workingBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)
	local pathId = self:getPathId()

	if pathId then
		isSelected = workingPathId == pathId
	else
		local curBuildingUid = self:getViewBuilding()

		isSelected = curBuildingUid == workingBuildingUid
	end

	local isShowBuildingIcon = (workingPathId or workingBuildingUid) and not isSelected

	self.critterIcon:setIsShowBuildingIcon(isShowBuildingIcon)
	gohelper.setActive(self._goselected, isSelected)
end

function RoomManufactureCritterItem:refreshPreviewAttr()
	local attrInfo = self:getPreviewAttrInfo()

	ZProj.UGUIHelper.SetGrayscale(self._gosimageskill, not attrInfo.isSpSkillEffect)

	self._txtefficiency.text = attrInfo.efficiency or 0

	local var_18_0 = {}

	var_18_0[1] = attrInfo.moodCostSpeed or 0
	self._txtmoodcostspeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("critter_mood_cost_speed"), var_18_0)
	self._txtcrirate.text = string.format("%s%%", attrInfo.criRate or 0)
end

function RoomManufactureCritterItem:refreshPreviewSkill()
	self._skillTbList = self._skillTbList or {}

	if self._mo then
		local skillInfo = self._mo:getSkillInfo()
		local index = 0

		if skillInfo then
			local attrInfo = self:getPreviewAttrInfo()

			for _, tag in pairs(skillInfo) do
				local tagCo = CritterConfig.instance:getCritterTagCfg(tag)

				if tagCo and tagCo.type == CritterEnum.SkilTagType.Common then
					index = index + 1

					local itemTb = self._skillTbList[index]

					if not itemTb then
						local go = gohelper.cloneInPlace(self._goskillTabItem)

						itemTb = self:getUserDataTb_()
						itemTb.go = go
						itemTb.skillIcon = gohelper.findChildImage(go, "image_skillIcon")
						itemTb.goskillIcon = itemTb.skillIcon.gameObject
						self._skillTbList[index] = itemTb
					end

					UISpriteSetMgr.instance:setCritterSprite(itemTb.skillIcon, tagCo.skillIcon)
					ZProj.UGUIHelper.SetGrayscale(itemTb.goskillIcon, (attrInfo and attrInfo.skillTags and tabletool.indexOf(attrInfo.skillTags, tagCo.id) or nil) and false)
				end
			end
		end

		for i = 1, #self._skillTbList do
			gohelper.setActive(self._skillTbList[i].go, i <= index)
		end
	end
end

function RoomManufactureCritterItem:onDestroyView()
	return
end

return RoomManufactureCritterItem

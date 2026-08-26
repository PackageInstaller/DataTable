-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureCritterDetail.lua

module("modules.logic.room.view.manufacture.RoomManufactureCritterDetail", package.seeall)

local RoomManufactureCritterDetail = class("RoomManufactureCritterDetail", ListScrollCellExtend)

function RoomManufactureCritterDetail:onInitView()
	self._gocritter = gohelper.findChild(self.viewGO, "go_critterLayer/#go_critter")
	self._txtcritterName = gohelper.findChildText(self.viewGO, "go_critterLayer/#txt_critterName")
	self._gomood = gohelper.findChild(self.viewGO, "go_critterLayer/#go_mood")
	self._gohasMood = gohelper.findChild(self.viewGO, "go_critterLayer/#go_mood/#go_hasMood")
	self._simagemood = gohelper.findChildSingleImage(self.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_mood")
	self._simageprogress = gohelper.findChildSingleImage(self.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	self._txtmood = gohelper.findChildText(self.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#txt_mood")
	self._gonoMood = gohelper.findChild(self.viewGO, "go_critterLayer/#go_mood/#go_noMood")
	self._goskillItem = gohelper.findChild(self.viewGO, "#go_skillItem")
	self._txtskillname = gohelper.findChildText(self.viewGO, "#go_skillItem/title/#txt_skillname")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_skillItem/title/#txt_skillname/#image_icon")
	self._txtskilldec = gohelper.findChildText(self.viewGO, "#go_skillItem/#txt_skilldec")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_baseitem")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_baseitem/#txt_name")
	self._txtratio = gohelper.findChildText(self.viewGO, "#go_baseitem/#txt_ratio")
	self._gobaseLayer = gohelper.findChild(self.viewGO, "#go_baseLayer")
	self._goskill = gohelper.findChild(self.viewGO, "#go_skill")
	self._goskillActive = gohelper.findChild(self.viewGO, "#go_skillActive")
	self._btnyulan = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skillActive/#btn_yulan")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureCritterDetail:addEvents()
	self._btnyulan:AddClickListener(self._btnyulanOnClick, self)
end

function RoomManufactureCritterDetail:removeEvents()
	self._btnyulan:RemoveClickListener()
end

function RoomManufactureCritterDetail:_btnyulanOnClick()
	self:_setShowInvalidSkill(self._isShowInvalidSkill == false)
end

function RoomManufactureCritterDetail:_editableInitView()
	self._godark = gohelper.findChild(self.viewGO, "#go_skillActive/#btn_yulan/dark")
	self._golight = gohelper.findChild(self.viewGO, "#go_skillActive/#btn_yulan/light")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	self._Type_Canvas_Group = typeof(UnityEngine.CanvasGroup)
	self._skillTBList = {}
	self._skillTBInvalidList = {}

	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._goskillItem, false)

	local cfgMaxMood = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)

	self._maxMood = tonumber(cfgMaxMood) or 0
end

function RoomManufactureCritterDetail:_editableAddEvents()
	return
end

function RoomManufactureCritterDetail:_editableRemoveEvents()
	return
end

function RoomManufactureCritterDetail:onUpdateMO(mo)
	self._critterMO = mo
	self._tagsCfgList = {}
	self._tagsCfgInvalidList = {}
	self._preViewAttrInfo = {}
	self._buildingId = self:getBuildingId()
	self._previewAttrInfo = nil

	if self._critterMO and self._critterMO.skillInfo then
		local attrInfo = ManufactureCritterListModel.instance:getPreviewAttrInfo(self._critterMO:getId(), self._buildingId, false)

		if not self._critterMO.skillInfo.tags then
			local tagList = {}

			for i = 1, #tagList do
				local tagCfg = CritterConfig.instance:getCritterTagCfg(tagList[i])

				if tagCfg then
					if attrInfo and attrInfo.skillTags and tabletool.indexOf(attrInfo.skillTags, tagCfg.id) then
						table.insert(self._tagsCfgList, tagCfg)
					else
						table.insert(self._tagsCfgInvalidList, tagCfg)
					end
				end
			end
		end
	end

	self:_refreshCritterUI()
	self:_refreshAttr()
	self:_refreshTagTB(self._tagsCfgList, self._skillTBList, self._goskill)
	self:_refreshTagTB(self._tagsCfgInvalidList, self._skillTBInvalidList, self._goskillActive, 0.5)
	self:_setShowInvalidSkill(false)
	gohelper.setActive(self._btnyulan, #self._tagsCfgInvalidList > 0)
end

function RoomManufactureCritterDetail:onSelect(isSelect)
	return
end

function RoomManufactureCritterDetail:onDestroyView()
	for i = 1, #self._attrItems do
		self._attrItems[i]:onDestroy()
	end
end

function RoomManufactureCritterDetail:getBuildingId()
	local buildingId

	if self._critterMO then
		local buildingUid, slotId = self._critterMO:getWorkBuildingInfo()
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if buildingMO then
			buildingId = buildingMO.buildingId
		end
	end

	return buildingId
end

function RoomManufactureCritterDetail:_createTagTB(go)
	local tagTb = self:getUserDataTb_()

	tagTb.go = go
	tagTb._txtskillname = gohelper.findChildText(go, "title/#txt_skillname")
	tagTb._imageicon = gohelper.findChildImage(go, "title/#txt_skillname/#image_icon")
	tagTb._txtskilldec = gohelper.findChildText(go, "#txt_skilldec")

	return tagTb
end

function RoomManufactureCritterDetail:_refreshTagTB(tagCfgList, tbList, goPlace, alpha)
	local count = 0
	local tagTbList = tbList

	if not tagTbList then
		return
	end

	if tagCfgList and #tagCfgList > 0 then
		for i, tagCfg in ipairs(tagCfgList) do
			count = count + 1

			local tagTb = tagTbList[i]

			if not tagTb then
				local go = gohelper.clone(self._goskillItem, goPlace)

				tagTb = self:_createTagTB(go)

				table.insert(tagTbList, tagTb)

				if alpha then
					go:GetComponent(self._Type_Canvas_Group).alpha = alpha
				end
			end

			tagTb._txtskillname.text = tagCfg.name
			tagTb._txtskilldec.text = tagCfg.desc

			UISpriteSetMgr.instance:setCritterSprite(tagTb._imageicon, tagCfg.skillIcon)
		end
	end

	for i = 1, #tagTbList do
		gohelper.setActive(tagTbList[i].go, i <= count)
	end
end

function RoomManufactureCritterDetail:_setTagTBActive(tagTbList, count)
	for i = 1, #tagTbList do
		gohelper.setActive(tagTbList[i].go, i <= count)
	end
end

function RoomManufactureCritterDetail:_setShowInvalidSkill(pIsShow)
	local isShow = not not pIsShow

	self._isShowInvalidSkill = isShow

	gohelper.setActive(self._godark, isShow)
	gohelper.setActive(self._golight, not isShow)

	if isShow then
		if not #self._skillTBInvalidList then
			local count = 0

			self:_setTagTBActive(self._skillTBInvalidList, count)
		end
	end
end

function RoomManufactureCritterDetail:_refreshAttr()
	if not self._critterMO then
		return
	end

	local attrInfos = self._critterMO:getAttributeInfos()

	self._attrItems = self._attrItems or self:getUserDataTb_()

	local index = 1

	if attrInfos then
		local critterUid = self._critterMO.id

		for type, attrMO in pairs(attrInfos) do
			local item = self._attrItems[index]

			if not item then
				local go = gohelper.clone(self._gobaseitem, self._gobaseLayer)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailAttrItem)

				table.insert(self._attrItems, item)
			end

			local value = CritterHelper.getPreViewAttrValue(attrMO.attributeId, critterUid, self._buildingId, false)
			local formatStr = CritterHelper.formatAttrValue(attrMO.attributeId, value)

			item:onRefreshMo(attrMO, index, formatStr, formatStr, attrMO:getName())

			index = index + 1
		end
	end

	for i = 1, #self._attrItems do
		gohelper.setActive(self._attrItems[i].viewGO, i < index)
	end
end

function RoomManufactureCritterDetail:_refreshCritterUI()
	if not self._critterMO then
		return
	end

	self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocritter)

	self.critterIcon:setMOValue(self._critterMO:getId(), self._critterMO:getDefineId())

	self._txtcritterName.text = self._critterMO:getName()

	local isNoMood = self._critterMO:isNoMood()

	gohelper.setActive(self._gonoMood, isNoMood)
	gohelper.setActive(self._gohasMood, not isNoMood)

	if not isNoMood then
		local mood = self._critterMO:getMoodValue()

		self._txtmood.text = mood

		if self._maxMood ~= 0 then
			self._imageprogress.fillAmount = mood / self._maxMood
		end
	end
end

RoomManufactureCritterDetail.prefabPath = "ui/viewres/room/manufacture/roommanufacturecritterdetail.prefab"

return RoomManufactureCritterDetail

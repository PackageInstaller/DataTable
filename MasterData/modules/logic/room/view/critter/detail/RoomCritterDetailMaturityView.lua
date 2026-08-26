-- chunkname: @modules/logic/room/view/critter/detail/RoomCritterDetailMaturityView.lua

module("modules.logic.room.view.critter.detail.RoomCritterDetailMaturityView", package.seeall)

local RoomCritterDetailMaturityView = class("RoomCritterDetailMaturityView", RoomCritterDetailView)

function RoomCritterDetailMaturityView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gomaturity = gohelper.findChild(self.viewGO, "#go_maturity")
	self._txtbuilding = gohelper.findChildText(self.viewGO, "#go_maturity/Left/building/bg/#txt_building")
	self._imagebuildingicon = gohelper.findChildImage(self.viewGO, "#go_maturity/Left/building/#image_buildingicon")
	self._godetail = gohelper.findChild(self.viewGO, "#go_maturity/Left/#go_detail")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_maturity/Left/#go_detail/#txt_name")
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	self._btnnameedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#btn_nameedit")
	self._txttag1 = gohelper.findChildText(self.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag2")
	self._imagesort = gohelper.findChildImage(self.viewGO, "#go_maturity/Left/#go_detail/#image_sort")
	self._txtsort = gohelper.findChildText(self.viewGO, "#go_maturity/Left/#go_detail/#image_sort/#txt_sort")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_maturity/Left/#go_detail/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_maturity/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	self._btnreport = gohelper.findChildButtonWithAudio(self.viewGO, "#go_maturity/Left/#btn_report")
	self._gocritterlive2d = gohelper.findChild(self.viewGO, "#go_maturity/Middle/#go_critterlive2d")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "#go_maturity/Right/base/#scroll_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_maturity/Right/base/#scroll_base/viewport/content/#go_baseitem")
	self._scrolltipbase = gohelper.findChildScrollRect(self.viewGO, "#go_maturity/Right/base/basetips/#scroll_base")
	self._gobasetipsitem = gohelper.findChild(self.viewGO, "#go_maturity/Right/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "#go_maturity/Right/skill/#scroll_skill")
	self._goskillItem = gohelper.findChild(self.viewGO, "#go_maturity/Right/skill/#scroll_skill/viewport/content/#go_skillItem")
	self._scrollnormalskill = gohelper.findChildScrollRect(self.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill")
	self._gonormalskillitem = gohelper.findChild(self.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill/viewport/content/#go_normalskillitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gostar = gohelper.findChild(self.viewGO, "#go_maturity/Left/#go_detail/starList")
	self._gotipbase = gohelper.findChild(self.viewGO, "#go_maturity/Right/base/basetips")
	self._gobuilding = gohelper.findChild(self.viewGO, "#go_maturity/Left/building")
	self._goLock = gohelper.findChild(self.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	self._gonormalskill = gohelper.findChild(self.viewGO, "#go_maturity/Right/normalskill")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDetailMaturityView:addEvents()
	RoomCritterDetailMaturityView.super.addEvents(self)
	self._btnreport:AddClickListener(self._btnreportOnClick, self)
	self._btnnameedit:AddClickListener(self._btnnameeditOnClick, self)
end

function RoomCritterDetailMaturityView:removeEvents()
	RoomCritterDetailMaturityView.super.removeEvents(self)
	self._btnreport:RemoveClickListener()
	self._btnnameedit:RemoveClickListener()
end

function RoomCritterDetailMaturityView:_btnreportOnClick()
	RoomCritterController.instance:openTrainReporView(self._critterMo:getId(), self._critterMo.trainHeroId, self._critterMo.totalFinishCount)
end

function RoomCritterDetailMaturityView:_btnnameeditOnClick()
	if self._critterMo then
		RoomCritterController.instance:openRenameView(self._critterMo:getId())
	end
end

function RoomCritterDetailMaturityView:_editableInitView()
	RoomCritterDetailMaturityView.super._editableInitView(self)
end

function RoomCritterDetailMaturityView:onOpen()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)
	RoomCritterDetailMaturityView.super.onOpen(self)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function RoomCritterDetailMaturityView:_onCritterRenameReply(critterUid)
	if self._critterMo and self._critterMo.id == critterUid then
		self:showInfo()
	end
end

function RoomCritterDetailMaturityView:onRefresh()
	self._critterMo = self.viewParam.critterMo

	RoomCritterDetailMaturityView.super.onRefresh(self)
	self:refreshWordInfo()
	self:refreshTrainInfo()
end

function RoomCritterDetailMaturityView:getAttrRatio(type, attrMo)
	return attrMo:getValueNum()
end

function RoomCritterDetailMaturityView:refreshWordInfo()
	if not self._critterMo then
		return
	end

	local buildingName
	local critterUid = self._critterMo:getId()
	local hasBuildingShow = false
	local stayBuildingUid = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)

	stayBuildingUid = stayBuildingUid or ManufactureModel.instance:getCritterRestingBuilding(critterUid)

	local buildingIcon

	if stayBuildingUid then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(stayBuildingUid)

		if buildingMO then
			buildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(buildingMO.buildingId)
			buildingName = buildingMO.config.useDesc
			hasBuildingShow = true
		end
	else
		local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)

		if workingPathMO then
			local workingPathBuildingId = workingPathMO.buildingId
			local skinId = workingPathMO.buildingSkinId
			local vehicleCfg = RoomTransportHelper.getVehicleCfgByBuildingId(workingPathBuildingId, skinId)

			buildingIcon = vehicleCfg and vehicleCfg.buildIcon

			local siteType = RoomTransportHelper.fromTo2SiteType(workingPathMO.fromType, workingPathMO.toType)

			buildingName = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[siteType])
			hasBuildingShow = true
		end
	end

	if hasBuildingShow then
		local lang = luaLang("room_critter_working_in")

		self._txtbuilding.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, buildingName)

		UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingicon, buildingIcon)
	end

	gohelper.setActive(self._gobuilding, hasBuildingShow)
end

function RoomCritterDetailMaturityView:showSkill()
	RoomCritterDetailMaturityView.super.showSkill(self)

	if not self._critterMo then
		return
	end

	local skillInfo = self._critterMo:getSkillInfo()

	if skillInfo then
		gohelper.setActive(self._gonormalskill.gameObject, true)

		local index = 1

		for _, tag in pairs(skillInfo) do
			local tagCo = CritterConfig.instance:getCritterTagCfg(tag)

			if tagCo and tagCo.type ~= RoomCritterDetailView._exclusiveSkill then
				local item = self:getNormalSkillItem(index)

				item:onRefreshMo(tagCo)

				index = index + 1
			end
		end

		if self._normalSkillItems then
			for i = 1, #self._normalSkillItems do
				local item = self._normalSkillItems[i]

				gohelper.setActive(item.viewGO, i < index)
			end
		end
	else
		gohelper.setActive(self._gonormalskill.gameObject, false)
	end
end

function RoomCritterDetailMaturityView:refreshTrainInfo()
	gohelper.setActive(self._btnreport.gameObject, self:_isShowReport())
end

function RoomCritterDetailMaturityView:_isShowReport()
	if self._critterMo and self._critterMo:isMaturity() and self._critterMo.trainHeroId and tonumber(self._critterMo.trainHeroId) ~= 0 then
		return true
	end

	return false
end

function RoomCritterDetailMaturityView:getNormalSkillItem(index)
	self._normalSkillItems = self._normalSkillItems or self:getUserDataTb_()

	local item = self._normalSkillItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._gonormalskillitem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailSkillItem)
		self._normalSkillItems[index] = item
	end

	return item
end

return RoomCritterDetailMaturityView

-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainReportView.lua

module("modules.logic.room.view.critter.RoomCritterTrainReportView", package.seeall)

local RoomCritterTrainReportView = class("RoomCritterTrainReportView", BaseView)

function RoomCritterTrainReportView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagepage = gohelper.findChildSingleImage(self.viewGO, "page1/#simage_page")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "page1/top/#simage_title")
	self._goqualityhigh = gohelper.findChild(self.viewGO, "page1/top/#go_qualityhigh")
	self._goqualitylow = gohelper.findChild(self.viewGO, "page1/top/#go_qualitylow")
	self._txtname = gohelper.findChildText(self.viewGO, "page1/top/#txt_name")
	self._btnnameedit = gohelper.findChildButtonWithAudio(self.viewGO, "page1/top/#txt_name/#btn_nameedit")
	self._gocrittericon = gohelper.findChild(self.viewGO, "page1/top/critter/#go_crittericon")
	self._gostarList = gohelper.findChild(self.viewGO, "page1/top/#go_starList")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "page1/top/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "page1/top/#scroll_des/viewport/content/#txt_Desc")
	self._txttag1 = gohelper.findChildText(self.viewGO, "page1/top/tag/#txt_tag1")
	self._txttag2 = gohelper.findChildText(self.viewGO, "page1/top/tag/#txt_tag2")
	self._txtwork = gohelper.findChildText(self.viewGO, "page1/middle/work/#txt_work")
	self._imagelvwork = gohelper.findChildImage(self.viewGO, "page1/middle/work/#image_lv_work")
	self._txtheart = gohelper.findChildText(self.viewGO, "page1/middle/heart/#txt_heart")
	self._imagelvheart = gohelper.findChildImage(self.viewGO, "page1/middle/heart/#image_lv_heart")
	self._txtlucky = gohelper.findChildText(self.viewGO, "page1/middle/lucky/#txt_lucky")
	self._imagelvlucky = gohelper.findChildImage(self.viewGO, "page1/middle/lucky/#image_lv_lucky")
	self._scrollskill = gohelper.findChildScrollRect(self.viewGO, "page1/bottom/1/#scroll_skill")
	self._goskillItem = gohelper.findChild(self.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem")
	self._txtskillname = gohelper.findChildText(self.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	self._imageicon = gohelper.findChildImage(self.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	self._txtskilldec = gohelper.findChildText(self.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	self._btnsubtag1 = gohelper.findChildButtonWithAudio(self.viewGO, "page1/bottom/#btn_subtag1")
	self._btnsubtag2 = gohelper.findChildButtonWithAudio(self.viewGO, "page1/bottom/#btn_subtag2")
	self._btnsubtag3 = gohelper.findChildButtonWithAudio(self.viewGO, "page1/bottom/#btn_subtag3")
	self._goempty = gohelper.findChild(self.viewGO, "page1/bottom/#go_empty")
	self._simagesmallpage = gohelper.findChildSingleImage(self.viewGO, "page2/#simage_smallpage")
	self._imagequality = gohelper.findChildImage(self.viewGO, "page2/heroinfo/#image_quality")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "page2/heroinfo/#image_quality/#simage_heroicon")
	self._txtheroname = gohelper.findChildText(self.viewGO, "page2/heroinfo/#txt_heroname")
	self._txtherolevel = gohelper.findChildText(self.viewGO, "page2/heroinfo/#txt_herolevel")
	self._scrollcomments = gohelper.findChildScrollRect(self.viewGO, "page2/#scroll_comments")
	self._txtdec = gohelper.findChildText(self.viewGO, "page2/#scroll_comments/viewport/content/#txt_dec")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "page2/#simage_signature")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainReportView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnameedit:AddClickListener(self._btnnameeditOnClick, self)
	self._btnsubtag1:AddClickListener(self._btnsubtag1OnClick, self)
	self._btnsubtag2:AddClickListener(self._btnsubtag2OnClick, self)
	self._btnsubtag3:AddClickListener(self._btnsubtag3OnClick, self)
end

function RoomCritterTrainReportView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnnameedit:RemoveClickListener()
	self._btnsubtag1:RemoveClickListener()
	self._btnsubtag2:RemoveClickListener()
	self._btnsubtag3:RemoveClickListener()
end

function RoomCritterTrainReportView:_btnnameeditOnClick()
	RoomCritterController.instance:openRenameView(self._critterUid)
end

function RoomCritterTrainReportView:_btnsubtag1OnClick()
	self:_selectSubTag(CritterEnum.SkilTagType.Common)
end

function RoomCritterTrainReportView:_btnsubtag2OnClick()
	self:_selectSubTag(CritterEnum.SkilTagType.Base)
end

function RoomCritterTrainReportView:_btnsubtag3OnClick()
	self:_selectSubTag(CritterEnum.SkilTagType.Race)
end

function RoomCritterTrainReportView:_btncloseOnClick()
	self:closeThis()
end

function RoomCritterTrainReportView:_editableInitView()
	self._starTbList = self:getUserDataTb_()

	for i = 1, 6 do
		local go = gohelper.findChild(self._gostarList, "star" .. i)

		table.insert(self._starTbList, go)
	end

	self._tagsTbListDict = {}
	self._tagType2IdxDict = {}
	self._goskillItemDict = self:getUserDataTb_()
	self._goSubTagList = self:getUserDataTb_()
	self._tagTypeList = {
		CritterEnum.SkilTagType.Common,
		CritterEnum.SkilTagType.Base,
		CritterEnum.SkilTagType.Race
	}
	self._tagsCfgMap = {}

	for i = 1, #self._tagTypeList do
		local goSubTag = gohelper.findChild(self.viewGO, "page1/bottom/" .. i)

		self._goSubTagList[i] = goSubTag

		local go = gohelper.findChild(goSubTag, "#scroll_skill/viewport/content/#go_skillItem")
		local tagTyp = self._tagTypeList[i]

		self._tagType2IdxDict[tagTyp] = i
		self._goskillItemDict[tagTyp] = go
		self._tagsTbListDict[tagTyp] = {}

		table.insert(self._tagsTbListDict[tagTyp], self:_createTagTB(go))
	end
end

function RoomCritterTrainReportView:onUpdateParam()
	return
end

function RoomCritterTrainReportView:onOpen()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterRenameReply, self._onCritterRenameReply, self)

	self._critterUid = self.viewParam and self.viewParam.critterUid
	self._heroId = self.viewParam and self.viewParam.heroId

	if self.viewParam then
		self._trainNum = self.viewParam.tranNum or 1
	end

	self._critterMO = CritterModel.instance:getCritterMOByUid(self._critterUid)
	self._heroMO = HeroModel.instance:getByHeroId(self._heroId)
	self._tagsCfgMap = {}

	if self._critterMO and self._critterMO.skillInfo then
		if not self._critterMO.skillInfo.tags then
			local tagList = {}

			for i = 1, #tagList do
				local tagCfg = CritterConfig.instance:getCritterTagCfg(tagList[i])

				if tagCfg then
					self._tagsCfgMap[tagCfg.type] = self._tagsCfgMap[tagCfg.type] or {}

					table.insert(self._tagsCfgMap[tagCfg.type], tagCfg)
				end
			end
		end
	end

	self:refreshUI()

	local openTag

	for _, tagType in ipairs(self._tagTypeList) do
		local tagsList = self._tagsCfgMap[tagType]

		if tagsList and #tagsList > 0 then
			openTag = tagType

			break
		end
	end

	self:_selectSubTag(openTag or CritterEnum.SkilTagType.Base)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_dabiao)
end

function RoomCritterTrainReportView:onClose()
	self._simageheroicon:UnLoadImage()
end

function RoomCritterTrainReportView:onDestroyView()
	return
end

function RoomCritterTrainReportView:_onCritterRenameReply(critterUid)
	if self._critterMO and self._critterUid == critterUid then
		self._txtname.text = self._critterMO:getName()
	end
end

function RoomCritterTrainReportView:_createTagTB(go)
	local tagTb = self:getUserDataTb_()

	tagTb.go = go
	tagTb._txtskillname = gohelper.findChildText(go, "title/#txt_skillname")
	tagTb._imageicon = gohelper.findChildImage(go, "title/#txt_skillname/#image_icon")
	tagTb._txtskilldec = gohelper.findChildText(go, "#txt_skilldec")

	return tagTb
end

function RoomCritterTrainReportView:_selectSubTag(tagType)
	if self._tagType2IdxDict then
		if not self._tagType2IdxDict[tagType] then
			local index = 1

			for i, goSubTag in ipairs(self._goSubTagList) do
				gohelper.setActive(goSubTag, i == index)
			end

			local tagsList = self._tagsCfgMap[tagType]

			gohelper.setActive(self._goempty, not tagsList or #tagsList < 1)
		end
	end
end

function RoomCritterTrainReportView:refreshUI()
	self:_refreshCritterTagUI()
	self:_refreshHeroUI()
	self:_refreshCritterUI()
end

function RoomCritterTrainReportView:_refreshCritterTagUI()
	for i, tagType in ipairs(self._tagTypeList) do
		self:_refreshTagTBByTyp(tagType, self._tagsCfgMap[tagType])
	end
end

function RoomCritterTrainReportView:_refreshTagTBByTyp(tagType, tagCfgs)
	local count = 0
	local tagTbList = self._tagsTbListDict[tagType]

	if not tagTbList then
		return
	end

	if tagCfgs and #tagCfgs > 0 then
		for i, tagCfg in ipairs(tagCfgs) do
			count = count + 1

			local tagTb = tagTbList[i]

			if not tagTb then
				local go = gohelper.cloneInPlace(self._goskillItemDict[tagType])

				tagTb = self:_createTagTB(go)

				table.insert(tagTbList, tagTb)
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

function RoomCritterTrainReportView:_refreshCritterUI()
	if not self._critterMO then
		return
	end

	local cfg = self._critterMO:getDefineCfg()
	local isHighQuality = self._critterMO.isHighQuality
	local efficiency = self._critterMO.efficiency
	local patience = self._critterMO.patience
	local lucky = self._critterMO.lucky

	self._txtwork.text = efficiency
	self._txtheart.text = patience
	self._txtlucky.text = lucky

	UISpriteSetMgr.instance:setCritterSprite(self._imagelvwork, self:_getLevelIconName(efficiency))
	UISpriteSetMgr.instance:setCritterSprite(self._imagelvheart, self:_getLevelIconName(patience))
	UISpriteSetMgr.instance:setCritterSprite(self._imagelvlucky, self:_getLevelIconName(lucky))

	self._txtname.text = self._critterMO:getName()

	if cfg then
		self._txtDesc.text = cfg.desc or ""
	end

	gohelper.setActive(self._txttag2, self._critterMO.specialSkin)
	gohelper.setActive(self._goqualityhigh, isHighQuality)
	gohelper.setActive(self._goqualitylow, not isHighQuality)

	self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

	self.critterIcon:setMOValue(self._critterMO:getId(), self._critterMO:getDefineId())

	if cfg then
		if not cfg.rare then
			local rare = 3

			for i = 1, #self._starTbList do
				gohelper.setActive(self._starTbList[i], i <= rare + 1)
			end

			local langKey = self._critterMO:isMaturity() and "room_critter_adult" or "room_critter_child"

			self._txttag1.text = luaLang(langKey)

			local tags = self._tagsCfgMap[CritterEnum.SkilTagType.Common]
			local trainNum = self._trainNum
			local maxAttName = self:_getMaxAttrName()

			if tags then
				if not #tags then
					local skillNum = 0

					self._txtdec.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("critter_report_comment_txt"), trainNum, maxAttName, skillNum)
				end
			end
		end
	end
end

function RoomCritterTrainReportView:_getLevelIconName(value)
	local cfg = CritterConfig.instance:getCritterAttributeLevelCfgByValue(value)

	return (cfg or nil) and (cfg.icon or "")
end

function RoomCritterTrainReportView:_refreshHeroUI()
	if self._heroMO then
		local heroCfg = self._heroMO.config
		local skinCfg = SkinConfig.instance:getSkinCo(self._heroMO.skin)

		self._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(skinCfg.headIcon))

		self._txtheroname.text = heroCfg.name

		self._simagesignature:LoadImage(ResUrl.getSignature(heroCfg.signature))
		UISpriteSetMgr.instance:setCritterSprite(self._imagequality, CritterEnum.QualityImageNameMap[heroCfg.rare])

		self._txtherolevel.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	end
end

function RoomCritterTrainReportView:_getMaxAttrName()
	if not self._critterMO then
		return ""
	end

	local attrInfos = self._critterMO:getAttributeInfos()
	local maxInfo

	for i, info in pairs(attrInfos) do
		if maxInfo == nil or maxInfo.value < info.value then
			maxInfo = info
		end
	end

	if maxInfo then
		::label_23_0::

		local attrCfg = CritterConfig.instance:getCritterAttributeCfg(maxInfo.attributeId)

		return (attrCfg or nil) and (attrCfg.name or "")
	end
end

return RoomCritterTrainReportView

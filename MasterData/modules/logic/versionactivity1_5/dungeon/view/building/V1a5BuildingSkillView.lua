-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingSkillView.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillView", package.seeall)

local V1a5BuildingSkillView = class("V1a5BuildingSkillView", BaseView)

function V1a5BuildingSkillView:onInitView()
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_desc")
	self._gobuildskillitem = gohelper.findChild(self.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	self.goBuildItem = gohelper.findChild(self.viewGO, "right/#go_builditem")
	self._goArrow = gohelper.findChild(self.viewGO, "left/#go_Arrow")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5BuildingSkillView:addEvents()
	return
end

function V1a5BuildingSkillView:removeEvents()
	return
end

V1a5BuildingSkillView.BuildItemAnchorList = {
	220,
	-60,
	-340
}

function V1a5BuildingSkillView:onScrollValueChanged()
	gohelper.setActive(self._goArrow, self._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function V1a5BuildingSkillView:initPointItem()
	self.pointItemList = {}

	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.viewGO, "left/point_container/#go_pointitem1")))
	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.viewGO, "left/point_container/#go_pointitem2")))
	table.insert(self.pointItemList, self:createPointItem(gohelper.findChild(self.viewGO, "left/point_container/#go_pointitem3")))
end

function V1a5BuildingSkillView:createPointItem(pointGo)
	local pointItem = self:getUserDataTb_()

	pointItem.image = pointGo:GetComponent(gohelper.Type_Image)
	pointItem.effectGo1 = gohelper.findChild(pointGo, "#effect_green")
	pointItem.effectGo2 = gohelper.findChild(pointGo, "#effect_yellow")

	return pointItem
end

function V1a5BuildingSkillView:initBuildItem()
	self.buildItemList = {}

	for i = 1, VersionActivity1_5DungeonEnum.BuildCount do
		table.insert(self.buildItemList, self:createBuildItem(i))
	end
end

function V1a5BuildingSkillView:_editableInitView()
	self.skillContentRectTr = gohelper.findChildComponent(self.viewGO, "left/#scroll_desc/Viewport/Content", gohelper.Type_RectTransform)

	local viewPortTr = gohelper.findChildComponent(self.viewGO, "left/#scroll_desc/Viewport", gohelper.Type_RectTransform)

	self.viewPortHeight = recthelper.getHeight(viewPortTr)

	gohelper.setActive(self.goBuildItem, false)

	self.singleImageBg = gohelper.findChildSingleImage(self.viewGO, "bg")

	local txtbuildbasename = gohelper.findChildText(self.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/image_EffectBG/#txt_buildname")
	local txtbuildbaseskilldesc = gohelper.findChildText(self.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/#txt_buildskilldesc")

	txtbuildbasename.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	txtbuildbaseskilldesc.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")

	self._scrolldesc:AddOnValueChanged(self.onScrollValueChanged, self)

	self.labelList = {
		luaLang("p_versionactivity_1_5_build1_label"),
		luaLang("p_versionactivity_1_5_build2_label"),
		luaLang("p_versionactivity_1_5_build3_label")
	}
	self.skillItemDict = {}

	self:initPointItem()
	self:initBuildItem()
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, self.onUpdateSelectBuild, self)
end

function V1a5BuildingSkillView:onUpdateParam()
	return
end

function V1a5BuildingSkillView:onOpen()
	self:refreshUI()
end

function V1a5BuildingSkillView:refreshUI()
	self:refreshPointImage()
	self:refreshBuildSkill()
	self:refreshBuildIcon()
	self:onScrollValueChanged()
end

function V1a5BuildingSkillView:refreshPointImage()
	for i = 1, VersionActivity1_5DungeonEnum.BuildCount do
		local type = VersionActivity1_5BuildModel.instance:getSelectType(i)

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(self.pointItemList[i].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[type])
	end
end

function V1a5BuildingSkillView:refreshBuildSkill()
	local typeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for groupId, type in ipairs(typeList) do
		if type ~= VersionActivity1_5DungeonEnum.BuildType.None then
			local co = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(groupId, type)
			local skillItem = self.skillItemDict[groupId]

			skillItem = skillItem or self:createSkillItem(groupId)
			skillItem.txtbuildname.text = VersionActivity1_5BuildModel.getTextByType(type, co.name)
			skillItem.txtbuildnameEn.text = co.nameEn
			skillItem.txtbuildskilldesc.text = VersionActivity1_5BuildModel.getTextByType(type, co.skilldesc)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(skillItem.imagebuildnamebg, VersionActivity1_5DungeonEnum.BuildType2TitleBgImage[type])
		end
	end
end

function V1a5BuildingSkillView:refreshBuildIcon()
	for index, buildItem in ipairs(self.buildItemList) do
		buildItem.txtLabel.text = self.labelList[index]

		for _, subBuildItem in ipairs(buildItem.subBuildList) do
			local buildCo = subBuildItem.buildCo
			local buildId = buildCo.id

			subBuildItem.txtBuildName.text = buildCo.name

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(subBuildItem.icon, buildCo.icon)

			local isHad = VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildId)

			if isHad then
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(subBuildItem.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[buildCo.type])
			else
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(subBuildItem.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[VersionActivity1_5DungeonEnum.BuildType.None])
			end

			local isSelect = VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(buildId)

			gohelper.setActive(subBuildItem.goSelect, isSelect)

			subBuildItem.canvasGroup.alpha = isSelect and isHad and 1 or 0.5
		end
	end
end

function V1a5BuildingSkillView:createSkillItem(groupIndex)
	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._gobuildskillitem)
	skillItem.aniGo = gohelper.findChild(skillItem.go, "ani")
	skillItem.rectTr = skillItem.go:GetComponent(gohelper.Type_RectTransform)
	skillItem.imagebuildnamebg = gohelper.findChildImage(skillItem.aniGo, "image_EffectBG")
	skillItem.txtbuildname = gohelper.findChildText(skillItem.aniGo, "image_EffectBG/#txt_buildname")
	skillItem.txtbuildnameEn = gohelper.findChildText(skillItem.aniGo, "Line/#txt_En")
	skillItem.txtbuildskilldesc = gohelper.findChildText(skillItem.aniGo, "#txt_buildskilldesc")
	skillItem.animator = skillItem.go:GetComponent(gohelper.Type_Animator)
	self.skillItemDict[groupIndex] = skillItem

	return skillItem
end

function V1a5BuildingSkillView:createBuildItem(index)
	local go = gohelper.cloneInPlace(self.goBuildItem)

	gohelper.setActive(go, true)

	local buildItem = self:getUserDataTb_()

	buildItem.go = go
	buildItem.rectTr = buildItem.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorY(buildItem.rectTr, V1a5BuildingSkillView.BuildItemAnchorList[index])

	buildItem.txtLabel = gohelper.findChildText(buildItem.go, "header/#txt_buildlabel")
	buildItem.subBuildList = {}

	local goSubBuild1 = gohelper.findChild(buildItem.go, "content/build1")
	local goSubBuild2 = gohelper.findChild(buildItem.go, "content/build2")

	table.insert(buildItem.subBuildList, self:createBuildSubItem(goSubBuild1, index, 1))
	table.insert(buildItem.subBuildList, self:createBuildSubItem(goSubBuild2, index, 2))

	return buildItem
end

function V1a5BuildingSkillView:createBuildSubItem(go, groupIndex, index)
	local buildSubItem = self:getUserDataTb_()

	buildSubItem.go = go
	buildSubItem.canvasGroup = buildSubItem.go:GetComponent(gohelper.Type_CanvasGroup)
	buildSubItem.iconBg = gohelper.findChildImage(buildSubItem.go, "#image_BuildBG")
	buildSubItem.goSelect = gohelper.findChild(buildSubItem.go, "#image_BuildBG/#go_select")
	buildSubItem.icon = gohelper.findChildImage(buildSubItem.go, "#image_BuildBG/#image_TotemIcon")
	buildSubItem.txtBuildName = gohelper.findChildText(buildSubItem.go, "txt_buildname")
	buildSubItem.click = gohelper.findChildClickWithDefaultAudio(buildSubItem.go, "clickarea")
	buildSubItem.buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(groupIndex, index)

	buildSubItem.click:AddClickListener(self.onClickBuildSubItem, self, buildSubItem)

	return buildSubItem
end

function V1a5BuildingSkillView:onClickBuildSubItem(buildSubItem)
	local buildCo = buildSubItem.buildCo
	local buildId = buildCo.id

	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildId) then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(buildId) then
		return
	end

	self.changeGroupIndex = buildCo.group

	VersionActivity1_5BuildModel.instance:setSelectBuildId(buildCo)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function V1a5BuildingSkillView:onUpdateSelectBuild()
	self:setSkillContainerAnchorY()
	self:refreshPointImage()
	self:playPointAnimation()
	self:refreshBuildSkill()
	self:playBuildSkillAnimation()
	self:refreshBuildIcon()

	self.changeGroupIndex = nil
end

function V1a5BuildingSkillView:setSkillContainerAnchorY()
	local skillItem = self.skillItemDict[self.changeGroupIndex]

	if not skillItem then
		return
	end

	if not self.maxAnchorY then
		local contentHeight = recthelper.getHeight(self.skillContentRectTr)

		self.maxAnchorY = contentHeight - self.viewPortHeight
	end

	local anchorY = recthelper.getAnchorY(skillItem.rectTr)

	recthelper.setAnchorY(self.skillContentRectTr, Mathf.Min(-anchorY, self.maxAnchorY))
end

function V1a5BuildingSkillView:playPointAnimation()
	if not self.changeGroupIndex then
		return
	end

	local selectType = VersionActivity1_5BuildModel.instance:getSelectType(self.changeGroupIndex)
	local pointItem = self.pointItemList[self.changeGroupIndex]

	gohelper.setActive(pointItem.effectGo1, false)
	gohelper.setActive(pointItem.effectGo2, false)

	if selectType == VersionActivity1_5DungeonEnum.BuildType.First then
		gohelper.setActive(pointItem.effectGo1, true)
	else
		gohelper.setActive(pointItem.effectGo2, true)
	end
end

function V1a5BuildingSkillView:playBuildSkillAnimation()
	if not self.changeGroupIndex then
		return
	end

	local selectType = VersionActivity1_5BuildModel.instance:getSelectType(self.changeGroupIndex)
	local skillItem = self.skillItemDict[self.changeGroupIndex]

	skillItem.animator:Play(selectType == VersionActivity1_5DungeonEnum.BuildType.First and "switch_green" or "switch_orange", 0, 0)
end

function V1a5BuildingSkillView:onClose()
	return
end

function V1a5BuildingSkillView:onDestroyView()
	self.singleImageBg:UnLoadImage()
	self._scrolldesc:RemoveOnValueChanged()

	for _, buildItem in ipairs(self.buildItemList) do
		for _, subBuildItem in ipairs(buildItem.subBuildList) do
			subBuildItem.click:RemoveClickListener()
		end
	end
end

return V1a5BuildingSkillView

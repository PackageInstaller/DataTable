-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingView.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingView", package.seeall)

local V1a5BuildingView = class("V1a5BuildingView", BaseView)

function V1a5BuildingView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageRightMask = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/#simage_RightMask")
	self._simageRightMask2 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/#simage_RightMask2")
	self._simageUpMask = gohelper.findChildSingleImage(self.viewGO, "#simage_UpMask")
	self._simageUpMask2 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG/#simage_UpMask2")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._gopointitem1 = gohelper.findChild(self.viewGO, "Left/point_container/#go_pointitem1")
	self._gopointitem2 = gohelper.findChild(self.viewGO, "Left/point_container/#go_pointitem2")
	self._gopointitem3 = gohelper.findChild(self.viewGO, "Left/point_container/#go_pointitem3")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_desc")
	self._gobuildskillitem = gohelper.findChild(self.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	self._goArrow = gohelper.findChild(self.viewGO, "Left/#go_Arrow")
	self._gobuilditem = gohelper.findChild(self.viewGO, "Right/#go_builditem")
	self.slider = gohelper.findChildSlider(self.viewGO, "Right/Slider/Slider")
	self._txtSchedule = gohelper.findChildText(self.viewGO, "Right/Slider/Schedule/#txt_Schedule")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "Right/Slider/Prop/#simage_Icon")
	self.rewardEffect = gohelper.findChild(self.viewGO, "Right/Slider/Prop/#effect")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/Slider/Prop/#txt_Num")
	self._goHasGainedReward = gohelper.findChild(self.viewGO, "Right/Slider/Prop/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5BuildingView:addEvents()
	return
end

function V1a5BuildingView:removeEvents()
	return
end

function V1a5BuildingView:onClickReward()
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		MaterialTipController.instance:showMaterialInfo(self.rewardType, self.rewardId)

		return
	end

	local count = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	if count < 6 then
		MaterialTipController.instance:showMaterialInfo(self.rewardType, self.rewardId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140GainProgressRewardRequest()
end

function V1a5BuildingView:initBuildItem()
	self.buildItemList = {}

	for i = 1, VersionActivity1_5DungeonEnum.BuildCount do
		self:createBuildItem(i)
	end
end

function V1a5BuildingView:initSliderPointItem()
	self.sliderPointItemList = {}

	for i = 1, 5 do
		table.insert(self.sliderPointItemList, self:createSliderPointItem(i))
	end
end

function V1a5BuildingView:initBuildImageItem()
	self.buildImageList = self:getUserDataTb_()

	for i = 1, 3 do
		table.insert(self.buildImageList, gohelper.findChildImage(self.viewGO, "#simage_FullBG/#image_build" .. i))
	end
end

function V1a5BuildingView:initPointItem()
	self.pointItemList = {}

	table.insert(self.pointItemList, self:createPointItem(self._gopointitem1))
	table.insert(self.pointItemList, self:createPointItem(self._gopointitem2))
	table.insert(self.pointItemList, self:createPointItem(self._gopointitem3))
end

function V1a5BuildingView:createPointItem(pointGo)
	local pointItem = self:getUserDataTb_()

	pointItem.image = pointGo:GetComponent(gohelper.Type_Image)
	pointItem.effectGo1 = gohelper.findChild(pointGo, "#effect_green")
	pointItem.effectGo2 = gohelper.findChild(pointGo, "#effect_yellow")

	return pointItem
end

function V1a5BuildingView:onScrollValueChanged()
	gohelper.setActive(self._goArrow, self._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function V1a5BuildingView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_fullbg"))
	self._simageMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask"))
	self._simageRightMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	self._simageRightMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	self._simageUpMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	self._simageUpMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))

	self.goLeft = gohelper.findChild(self.viewGO, "Left")
	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.goBackBtn = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self.bgRectTr = gohelper.findChildComponent(self.viewGO, "#simage_FullBG", gohelper.Type_RectTransform)
	self.goMask = gohelper.findChild(self.viewGO, "#simage_Mask")

	self._scrolldesc:AddOnValueChanged(self.onScrollValueChanged, self)
	gohelper.setActive(self._gobuilditem, false)

	self.rewardClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Right/Slider/Prop/#simage_Icon")

	self.rewardClick:AddClickListener(self.onClickReward, self)

	local txtbuildbasename = gohelper.findChildText(self.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/image_EffectBG/#txt_buildname")
	local txtbuildbaseskilldesc = gohelper.findChildText(self.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/#txt_buildskilldesc")

	txtbuildbasename.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	txtbuildbaseskilldesc.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")
	self.skillItemDict = {}

	self:initPointItem()
	self:initBuildItem()
	self:initBuildImageItem()
	self:initSliderPointItem()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, self.onUpdateBuildInfo, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, self.onUpdateSelectBuild, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, self.onSwitchSelectGroupBuild, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, self.onUpdateGainedBuildReward, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function V1a5BuildingView:onUpdateParam()
	return
end

function V1a5BuildingView:onOpen()
	self.selectTypeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	self.slider:SetValue(VersionActivity1_5BuildModel.instance:getHadBuildCount())
	self:showUI()
	self:refreshUI()
	self:onScrollValueChanged()
end

function V1a5BuildingView:onOpenFinish()
	return
end

function V1a5BuildingView:refreshUI()
	self:refreshLeft()
	self:refreshRight()
end

function V1a5BuildingView:refreshLeft()
	self:refreshPoint()
	self:refreshBuildSkill()
end

function V1a5BuildingView:refreshRight()
	self:refreshBuildIcon()
	self:refreshSlider()
	self:refreshReward()
	self:refreshRewardEffect()
	self:refreshBuildImage()
end

function V1a5BuildingView:refreshPoint()
	for i = 1, VersionActivity1_5DungeonEnum.BuildCount do
		local type = self.selectTypeList[i]

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(self.pointItemList[i].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[type])
	end
end

function V1a5BuildingView:refreshBuildSkill()
	for groupId, type in ipairs(self.selectTypeList) do
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

function V1a5BuildingView:createSkillItem(groupIndex)
	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._gobuildskillitem)
	skillItem.imagebuildnamebg = gohelper.findChildImage(skillItem.go, "image_EffectBG/")
	skillItem.txtbuildname = gohelper.findChildText(skillItem.go, "image_EffectBG/#txt_buildname")
	skillItem.txtbuildnameEn = gohelper.findChildText(skillItem.go, "Line/#txt_En")
	skillItem.txtbuildskilldesc = gohelper.findChildText(skillItem.go, "#txt_buildskilldesc")
	self.skillItemDict[groupIndex] = skillItem

	return skillItem
end

function V1a5BuildingView:refreshBuildIcon()
	for index, buildItem in ipairs(self.buildItemList) do
		local buildCo = VersionActivity1_5BuildModel.instance:getBuildCoByGroupIndex(index)

		buildCo = buildCo or VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(index, 1)

		local pos = string.splitToNumber(buildCo.pos, "#")

		recthelper.setAnchor(buildItem.rectTr, pos[1], pos[2])

		local buildCount = VersionActivity1_5BuildModel.instance:getCanBuildCount(buildCo.group)
		local isHad = buildCount > 0

		gohelper.setActive(buildItem.goTips, not isHad)
		gohelper.setActive(buildItem.goBuildName, isHad)

		local canBuildCount = 2 - buildCount

		buildItem.txtCanBuild.text = string.format(luaLang("v1a5_builde_can_build"), canBuildCount)

		gohelper.setActive(buildItem.goCanBuild, canBuildCount > 0)

		local selectType = VersionActivity1_5BuildModel.instance:getSelectType(index)

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(buildItem.bgImage, VersionActivity1_5DungeonEnum.BuildType2Image[selectType])
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(buildItem.buildIconImage, buildCo.icon)

		if isHad then
			buildItem.txtBuildName.text = buildCo.name
		end
	end
end

function V1a5BuildingView:createBuildItem(index)
	local buildItem = self:getUserDataTb_()

	buildItem.groupIndex = index
	buildItem.go = gohelper.cloneInPlace(self._gobuilditem)

	gohelper.setActive(buildItem.go, true)

	buildItem.rectTr = buildItem.go:GetComponent(gohelper.Type_RectTransform)
	buildItem.bgImage = gohelper.findChildImage(buildItem.go, "Totem/#image_TotemBG")
	buildItem.buildIconImage = gohelper.findChildImage(buildItem.go, "Totem/#image_TotemBG/#image_TotemIcon")
	buildItem.goCanBuild = gohelper.findChild(buildItem.go, "#go_CanBuild")
	buildItem.txtCanBuild = gohelper.findChildText(buildItem.go, "#go_CanBuild/#txt_CanBuild")
	buildItem.goBuildName = gohelper.findChild(buildItem.go, "#go_Name")
	buildItem.txtBuildName = gohelper.findChildText(buildItem.go, "#go_Name/#txt_BuildName")
	buildItem.goTips = gohelper.findChild(buildItem.go, "#go_Tips")
	buildItem.goClick = gohelper.findChildClickWithDefaultAudio(buildItem.go, "clickarea")

	buildItem.goClick:AddClickListener(self.onClickBuild, self, buildItem)
	table.insert(self.buildItemList, buildItem)

	return buildItem
end

function V1a5BuildingView:createSliderPointItem(index)
	local sliderPointItem = self:getUserDataTb_()

	sliderPointItem.go = gohelper.findChild(self.viewGO, "Right/Slider/Layout/Point" .. index)
	sliderPointItem.goNormal = gohelper.findChild(sliderPointItem.go, "image_PointBG")
	sliderPointItem.goFinish = gohelper.findChild(sliderPointItem.go, "image_PointFG")

	return sliderPointItem
end

function V1a5BuildingView:refreshReward()
	local type, id, quantity = VersionActivity1_5DungeonConfig.instance:getBuildReward()
	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

	self._simageIcon:LoadImage(icon)

	self._txtNum.text = quantity
	self.rewardType, self.rewardId = type, id

	gohelper.setActive(self._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
end

function V1a5BuildingView:refreshRewardEffect()
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		gohelper.setActive(self.rewardEffect, false)

		return
	end

	local count = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	gohelper.setActive(self.rewardEffect, count == 6)
end

function V1a5BuildingView:refreshSlider()
	local hadBuildCount = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	for i = 1, 5 do
		local sliderPointItem = self.sliderPointItemList[i]
		local finish = i <= hadBuildCount

		gohelper.setActive(sliderPointItem.goNormal, not finish)
		gohelper.setActive(sliderPointItem.goFinish, finish)
	end

	self._txtSchedule.text = Mathf.Ceil(hadBuildCount / 6 * 100) .. "%"
end

function V1a5BuildingView:refreshBuildImage()
	for index, image in ipairs(self.buildImageList) do
		local selectBuildType = VersionActivity1_5BuildModel.instance:getSelectType(index)

		if VersionActivity1_5DungeonEnum.BuildType.None == selectBuildType then
			gohelper.setActive(image.gameObject, false)
		else
			local buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(index, selectBuildType)

			gohelper.setActive(image.gameObject, true)
			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(image, buildCo.previewImg)
		end
	end
end

function V1a5BuildingView:onUpdateGainedBuildReward()
	gohelper.setActive(self._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
	self:refreshRewardEffect()
end

function V1a5BuildingView:onClickBuild(buildItem)
	for _, pointItem in ipairs(self.pointItemList) do
		gohelper.setActive(pointItem.effectGo1, false)
		gohelper.setActive(pointItem.effectGo2, false)
	end

	self.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(buildItem.groupIndex, 1)
	self.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())
	self.preHadBuildCount = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	ViewMgr.instance:openView(ViewName.V1a5BuildingDetailView, {
		groupIndex = buildItem.groupIndex
	})
end

function V1a5BuildingView:onOpenView(viewName)
	if viewName ~= ViewName.V1a5BuildingDetailView then
		return
	end

	self:hideUI()
	self:playFocusAnim()
end

function V1a5BuildingView:onCloseView(viewName)
	if viewName ~= ViewName.V1a5BuildingDetailView then
		return
	end

	self:playRevertAnim(self.onRevertAnimDone)
end

function V1a5BuildingView:showUI()
	gohelper.setActive(self.goLeft, true)
	gohelper.setActive(self.goRight, true)
	gohelper.setActive(self.goBackBtn, true)
	gohelper.setActive(self.goMask, true)
end

function V1a5BuildingView:hideUI()
	gohelper.setActive(self.goLeft, false)
	gohelper.setActive(self.goRight, false)
	gohelper.setActive(self.goBackBtn, false)
	gohelper.setActive(self.goMask, false)
end

function V1a5BuildingView:playFocusAnim(finishCallback)
	self:killAnim()

	self.finishCallback = finishCallback
	self.startAnchorX = 0
	self.startAnchorY = 0
	self.targetAnchorX = self.focusBuildCo.focusPosX
	self.targetAnchorY = self.focusBuildCo.focusPosY
	self.startScale = 1
	self.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, self.frameCall, self.finishCall, self)
end

function V1a5BuildingView:playRevertAnim(finishCallback)
	self:killAnim()

	self.finishCallback = finishCallback
	self.startAnchorX = self.focusBuildCo.focusPosX
	self.startAnchorY = self.focusBuildCo.focusPosY
	self.targetAnchorX = 0
	self.targetAnchorY = 0
	self.startScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	self.targetScale = 1
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, self.frameCall, self.finishCall, self)
end

function V1a5BuildingView:frameCall(value)
	local anchorX = Mathf.Lerp(self.startAnchorX, self.targetAnchorX, value)
	local anchorY = Mathf.Lerp(self.startAnchorY, self.targetAnchorY, value)
	local scale = Mathf.Lerp(self.startScale, self.targetScale, value)

	recthelper.setAnchor(self.bgRectTr, anchorX, anchorY)
	transformhelper.setLocalScale(self.bgRectTr, scale, scale, scale)
end

function V1a5BuildingView:finishCall()
	recthelper.setAnchor(self.bgRectTr, self.targetAnchorX, self.targetAnchorY)
	transformhelper.setLocalScale(self.bgRectTr, self.targetScale, self.targetScale, self.targetScale)

	if self.finishCallback then
		self:finishCallback()

		self.finishCallback = nil
	end
end

function V1a5BuildingView:killAnim()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end

	self.finishCallback = nil
end

function V1a5BuildingView:onRevertAnimDone()
	self:showUI()
	self:playPointAnimation()
	self:playSliderAnimation()
end

function V1a5BuildingView:onUpdateBuildInfo()
	self:refreshLeft()
	self:playPointAnimation()
	self:playSliderAnimation()
	self:refreshBuildImage()
	self:refreshSlider()
	self:refreshRewardEffect()
	self:refreshBuildIcon()
end

function V1a5BuildingView:onUpdateSelectBuild()
	self:refreshLeft()
	self:playPointAnimation()
	self:refreshBuildIcon()
	self:refreshBuildImage()
end

function V1a5BuildingView:playPointAnimation()
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	if not self.preSelectTypeList then
		return
	end

	local currentSelectTypeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for groupIndex, type in ipairs(currentSelectTypeList) do
		if type ~= self.preSelectTypeList[groupIndex] then
			local pointItem = self.pointItemList[groupIndex]

			if type == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(pointItem.effectGo1, true)
			else
				gohelper.setActive(pointItem.effectGo2, true)
			end
		end
	end

	self.preSelectTypeList = nil
end

function V1a5BuildingView:playSliderAnimation()
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	local currentHadCount = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	if self.preHadBuildCount == currentHadCount then
		return
	end

	if self.sliderTweenId then
		ZProj.TweenHelper.KillById(self.sliderTweenId)
	end

	self.sliderTweenId = ZProj.TweenHelper.DOTweenFloat(self.preHadBuildCount, currentHadCount, VersionActivity1_5DungeonEnum.SliderAnimTime, self.sliderFrameCall, nil, self)
end

function V1a5BuildingView:sliderFrameCall(value)
	self.slider:SetValue(value)
end

function V1a5BuildingView:onSwitchSelectGroupBuild(groupIndex)
	self:killAnim()

	self.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(groupIndex, 1)
	self.startAnchorX, self.startAnchorY = recthelper.getAnchor(self.bgRectTr)
	self.targetAnchorX = self.focusBuildCo.focusPosX
	self.targetAnchorY = self.focusBuildCo.focusPosY
	self.startScale = transformhelper.getLocalScale(self.bgRectTr)
	self.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, self.frameCall, self.finishCall, self)
end

function V1a5BuildingView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, self.onUpdateBuildInfo, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, self.onUpdateSelectBuild, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, self.onSwitchSelectGroupBuild, self)
	self.removeEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, self.onUpdateGainedBuildReward, self)
	self:killAnim()

	if self.sliderTweenId then
		ZProj.TweenHelper.KillById(self.sliderTweenId)
	end
end

function V1a5BuildingView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageMask:UnLoadImage()
	self._simageRightMask:UnLoadImage()
	self._simageRightMask2:UnLoadImage()
	self._simageUpMask:UnLoadImage()
	self._simageUpMask2:UnLoadImage()

	for _, buildItem in ipairs(self.buildItemList) do
		buildItem.goClick:RemoveClickListener()
	end

	self._scrolldesc:RemoveOnValueChanged()
	self.rewardClick:RemoveClickListener()
end

return V1a5BuildingView

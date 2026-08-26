-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/building/V1a5BuildingDetailView.lua

module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailView", package.seeall)

local V1a5BuildingDetailView = class("V1a5BuildingDetailView", BaseView)

function V1a5BuildingDetailView:onInitView()
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._goItem = gohelper.findChild(self.viewGO, "#go_Item")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self.goBuildEffect = gohelper.findChild(self.viewGO, "image_Select/leveup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5BuildingDetailView:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function V1a5BuildingDetailView:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

V1a5BuildingDetailView.AnchorXList = {
	-15,
	570
}

function V1a5BuildingDetailView:_btnLeftOnClick()
	self.groupIndex = self.groupIndex - 1

	if self.groupIndex == 0 then
		self.groupIndex = VersionActivity1_5DungeonEnum.BuildCount
	end

	self:getBuildCoList()
	self:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, self.groupIndex)
end

function V1a5BuildingDetailView:_btnRightOnClick()
	self.groupIndex = self.groupIndex + 1

	if self.groupIndex > VersionActivity1_5DungeonEnum.BuildCount then
		self.groupIndex = 1
	end

	self:getBuildCoList()
	self:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, self.groupIndex)
end

function V1a5BuildingDetailView:_editableInitView()
	gohelper.setActive(self._goItem, false)

	self.itemList = {}

	table.insert(self.itemList, self:createItem(1))
	table.insert(self.itemList, self:createItem(2))
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, self.onUpdateBuildInfo, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, self.onUpdateSelectBuild, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function V1a5BuildingDetailView:createItem(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self._goItem)

	gohelper.setActive(item.go, true)

	item.goTr = item.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorX(item.goTr, V1a5BuildingDetailView.AnchorXList[index])

	item.simageItemBG = gohelper.findChildSingleImage(item.go, "#simage_ItemBG")

	item.simageItemBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_toteminfobg"))

	item.imageBuildBG = gohelper.findChildImage(item.go, "Totem/#image_BuildBG")
	item.imageTotemIcon = gohelper.findChildImage(item.go, "Totem/#image_BuildBG/#image_TotemIcon")
	item.imageBuildingPic = gohelper.findChildImage(item.go, "#image_BuildingPic")
	item.txtBuildName = gohelper.findChildText(item.go, "#txt_BuildName")
	item.txtBuildNameEn = gohelper.findChildText(item.go, "#txt_BuildNameEn")
	item.txtDesc = gohelper.findChildText(item.go, "Scroll View/Viewport/content/#txt_Desc")
	item.txtSkillDesc = gohelper.findChildText(item.go, "Scroll View/Viewport/content/#txt_skilldesc")
	item.goInEffect = gohelper.findChild(item.go, "#go_InEffect")
	item.goBuild = gohelper.findChild(item.go, "#go_Build")
	item.goUse = gohelper.findChild(item.go, "#go_use")
	item.txtPropNum = gohelper.findChildText(item.go, "#go_Build/#txt_PropNum")
	item.simageProp = gohelper.findChildSingleImage(item.go, "#go_Build/#txt_PropNum/#simage_Prop")
	item.btnBuild = gohelper.findChildButtonWithAudio(item.go, "#go_Build/#btn_Build")
	item.btnUse = gohelper.findChildButtonWithAudio(item.go, "#go_use/#btn_use")

	item.btnBuild:AddClickListener(self.onClickBuildBtn, self, index)
	item.btnUse:AddClickListener(self.onClickUseBtn, self, index)

	return item
end

function V1a5BuildingDetailView:onClickBuildBtn(index)
	local buildCo = self.buildCoList[index]
	local isHad = VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildCo.id)

	if isHad then
		return
	end

	local type, id, quantity = buildCo.costList[1], buildCo.costList[2], buildCo.costList[3]
	local hadQuantity = ItemModel.instance:getItemQuantity(type, id)
	local itemConfig = ItemConfig.instance:getItemConfig(type, id)

	if hadQuantity < quantity then
		GameFacade.showToastString(string.format(luaLang("store_currency_limit"), itemConfig.name))

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140BuildRequest(buildCo.id)
end

function V1a5BuildingDetailView:onClickUseBtn(index)
	local buildCo = self.buildCoList[index]
	local isHad = VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildCo.id)

	if not isHad then
		return
	end

	local isSelect = VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(buildCo.id)

	if isSelect then
		return
	end

	VersionActivity1_5BuildModel.instance:setSelectBuildId(buildCo)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function V1a5BuildingDetailView:onOpen()
	self.groupIndex = self.viewParam.groupIndex

	self:getBuildCoList()
	self:refreshUI()
end

function V1a5BuildingDetailView:getBuildCoList()
	self.buildCoList = VersionActivity1_5DungeonConfig.instance:getBuildCoList(self.groupIndex)
end

function V1a5BuildingDetailView:refreshUI()
	for index = 1, 2 do
		self:refreshItem(index)
	end
end

function V1a5BuildingDetailView:refreshItem(index)
	local buildCo = self.buildCoList[index]
	local buildItem = self.itemList[index]

	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(buildItem.imageBuildBG, VersionActivity1_5DungeonEnum.BuildType2Image[buildCo.type])
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(buildItem.imageTotemIcon, buildCo.icon)
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(buildItem.imageBuildingPic, buildCo.previewImg)

	buildItem.txtBuildName.text = buildCo.name
	buildItem.txtBuildNameEn.text = buildCo.nameEn
	buildItem.txtDesc.text = buildCo.desc
	buildItem.txtSkillDesc.text = buildCo.skilldesc

	self:refreshBtnStatus(index)

	local isHad = VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildCo.id)

	if not isHad then
		local _, icon = ItemModel.instance:getItemConfigAndIcon(buildCo.costList[1], buildCo.costList[2])

		buildItem.simageProp:LoadImage(icon)

		buildItem.txtPropNum.text = buildCo.costList[3]
	end
end

function V1a5BuildingDetailView:refreshBtnStatus(index)
	local buildCo = self.buildCoList[index]
	local buildItem = self.itemList[index]
	local buildId = buildCo.id
	local isHad = VersionActivity1_5BuildModel.instance:checkBuildIsHad(buildId)
	local isSelect = VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(buildId)

	if isSelect then
		gohelper.setActive(buildItem.goInEffect, true)
		gohelper.setActive(buildItem.goBuild, false)
		gohelper.setActive(buildItem.goUse, false)
	elseif isHad then
		gohelper.setActive(buildItem.goInEffect, false)
		gohelper.setActive(buildItem.goBuild, false)
		gohelper.setActive(buildItem.goUse, true)
	else
		gohelper.setActive(buildItem.goInEffect, false)
		gohelper.setActive(buildItem.goBuild, true)
		gohelper.setActive(buildItem.goUse, false)
	end
end

function V1a5BuildingDetailView:onUpdateBuildInfo(buildId)
	for index, buildCo in ipairs(self.buildCoList) do
		if buildCo.id == buildId then
			self:refreshItem(index)

			break
		end
	end

	for index = 1, 2 do
		self:refreshBtnStatus(index)
	end

	gohelper.setActive(self.goBuildEffect, false)
	gohelper.setActive(self.goBuildEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_build)
end

function V1a5BuildingDetailView:onUpdateSelectBuild()
	for index = 1, 2 do
		self:refreshBtnStatus(index)
	end
end

function V1a5BuildingDetailView:onClose()
	return
end

function V1a5BuildingDetailView:onDestroyView()
	self._simageMask:UnLoadImage()

	for _, item in ipairs(self.itemList) do
		item.simageItemBG:UnLoadImage()
		item.simageProp:UnLoadImage()
		item.btnBuild:RemoveClickListener()
		item.btnUse:RemoveClickListener()
	end
end

return V1a5BuildingDetailView

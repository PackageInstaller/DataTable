-- chunkname: @modules/logic/survival/view/shelter/ShelterBuildingManagerView.lua

module("modules.logic.survival.view.shelter.ShelterBuildingManagerView", package.seeall)

local ShelterBuildingManagerView = class("ShelterBuildingManagerView", BaseView)

function ShelterBuildingManagerView:onInitView()
	self.goBase = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Base")
	self.goTent = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Tent")
	self.goTentGrid = gohelper.findChild(self.goTent, "#go_GridExpand")
	self.goBaseItem = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Base/#go_BaseItem")
	self.goBaseSmallItem = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_baseSmallItem")
	self.goSmallItem = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_SmallItem")

	gohelper.setActive(self.goBaseItem, false)
	gohelper.setActive(self.goBaseSmallItem, false)
	gohelper.setActive(self.goSmallItem, false)

	self.baseItemList = {}
	self.smallItemList = {}
end

function ShelterBuildingManagerView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

function ShelterBuildingManagerView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

function ShelterBuildingManagerView:onBuildingInfoUpdate()
	self:refreshView()
end

function ShelterBuildingManagerView:onClickBaseSmallItem(item)
	if not item.data then
		return
	end

	local buildingId = item.data.id

	if SurvivalShelterBuildingListModel.instance:setSelectBuilding(buildingId) then
		self:refreshView()
	end
end

function ShelterBuildingManagerView:onClickSmallItem(item)
	if not item.data then
		return
	end

	local buildingId = item.data.id

	if SurvivalShelterBuildingListModel.instance:setSelectBuilding(buildingId) then
		self:refreshView()
	end
end

function ShelterBuildingManagerView:onOpen()
	SurvivalShelterBuildingListModel.instance:initViewParam()
	self:refreshView()
end

function ShelterBuildingManagerView:refreshView()
	self:refreshList()
	self:refreshInfoView()
end

function ShelterBuildingManagerView:refreshList()
	local baseList, tentList = SurvivalShelterBuildingListModel.instance:getShowList()

	for i = 1, math.max(#baseList, #self.baseItemList) do
		local item = self:getBaseItem(i)

		self:refreshBaseItem(item, baseList[i])
	end

	local tentCount = #tentList

	for i = 1, math.max(tentCount, #self.smallItemList) do
		local item = self:getSmallItem(i, self.goTentGrid)

		self:refreshSmallItem(item, tentList[i])
	end
end

function ShelterBuildingManagerView:getBaseItem(index)
	local item = self.baseItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.cloneInPlace(self.goBaseItem, tostring(index))
		item.goGrid = gohelper.findChild(item.go, "Grid")
		item.itemList = {}
		self.baseItemList[index] = item
	end

	return item
end

function ShelterBuildingManagerView:refreshBaseItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	for i = 1, math.max(#data, #item.itemList) do
		local smallItem = self:getBaseSmallItem(item, i)

		self:refreshSmallItem(smallItem, data[i])
	end
end

function ShelterBuildingManagerView:getBaseSmallItem(baseItem, index)
	local item = baseItem.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.clone(self.goBaseSmallItem, baseItem.goGrid, tostring(index))
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_BuildingName")
		item.txtLev = gohelper.findChildTextMesh(item.go, "#txt_BuildingLv")
		item.goSelect = gohelper.findChild(item.go, "#go_Selected")
		item.simageBuild = gohelper.findChildSingleImage(item.go, "#image_Building")
		item.imageBuild = gohelper.findChildImage(item.go, "#image_Building")
		item.goImageBuild = gohelper.findChild(item.go, "#image_Building")
		item.goLevUp = gohelper.findChild(item.go, "#go_LvUp")
		item.goDestroyed = gohelper.findChild(item.go, "#go_Destroyed")
		item.goAdd = gohelper.findChild(item.go, "#go_Add")
		item.goLock = gohelper.findChild(item.go, "#go_Locked")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickBaseSmallItem, self, item)

		item.goNew = gohelper.findChild(item.go, "#go_New")
		baseItem.itemList[index] = item
	end

	return item
end

function ShelterBuildingManagerView:refreshBaseSmallItem(item, data)
	self:refreshBuildingItem(item, data)
end

function ShelterBuildingManagerView:getSmallItem(index, parentGO)
	local item = self.smallItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.clone(self.goSmallItem, parentGO, tostring(index))
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_Name")
		item.txtLev = gohelper.findChildTextMesh(item.go, "#txt_Lv")
		item.goLevUp = gohelper.findChild(item.go, "#go_LvUp")
		item.goDestroyed = gohelper.findChild(item.go, "#go_Destroyed")
		item.goAdd = gohelper.findChild(item.go, "#go_Add")
		item.goLock = gohelper.findChild(item.go, "#go_Locked")
		item.goSelect = gohelper.findChild(item.go, "#go_Selected")
		item.simageBuild = gohelper.findChildSingleImage(item.go, "#image_Building")
		item.imageBuild = gohelper.findChildImage(item.go, "#image_Building")
		item.goImageBuild = gohelper.findChild(item.go, "#image_Building")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickSmallItem, self, item)

		item.goNew = gohelper.findChild(item.go, "#go_New")
		self.smallItemList[index] = item
	else
		gohelper.addChild(parentGO, item.go)
		gohelper.setAsLastSibling(item.go)
	end

	return item
end

function ShelterBuildingManagerView.onLoadedImage(item)
	item.imageBuild:SetNativeSize()
end

function ShelterBuildingManagerView:refreshSmallItem(item, data)
	self:refreshBuildingItem(item, data)
end

function ShelterBuildingManagerView:refreshBuildingItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	item.txtName.text = data.baseCo.name

	gohelper.setActive(item.goSelect, SurvivalShelterBuildingListModel.instance:isSelectBuilding(data.id))

	local isUnLock = weekInfo:isBuildingUnlock(data.buildingId, data.level + 1)
	local isUnBuild = data.level == 0
	local isGray = false
	local canLevUp = weekInfo:isBuildingCanLevup(data, data.level + 1, false)

	if isUnBuild then
		gohelper.setActive(item.goLevUp, false)
		gohelper.setActive(item.goDestroyed, false)

		if isUnLock then
			gohelper.setActive(item.goAdd, true)
			gohelper.setActive(item.goLock, false)

			item.txtLev.text = luaLang("survivalbuildingmanageview_unbuild_txt")
		else
			gohelper.setActive(item.goAdd, false)
			gohelper.setActive(item.goLock, true)

			item.txtLev.text = luaLang("survivalbuildingmanageview_buildinglock_txt")
		end

		isGray = true
	else
		gohelper.setActive(item.goLevUp, canLevUp)
		gohelper.setActive(item.goDestroyed, data.status == SurvivalEnum.BuildingStatus.Destroy)
		gohelper.setActive(item.goAdd, false)
		gohelper.setActive(item.goLock, false)

		item.txtLev.text = string.format("Lv.%s", data.level)
		isGray = data.status == SurvivalEnum.BuildingStatus.Destroy
	end

	item.simageBuild:LoadImage(data.baseCo.icon, ShelterBuildingManagerView.onLoadedImage, item)
	ZProj.UGUIHelper.SetGrayscale(item.goImageBuild, isGray)
	gohelper.setActive(item.goNew, isUnBuild and canLevUp)
end

function ShelterBuildingManagerView:refreshInfoView()
	if not self.infoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)
		local parentGO = gohelper.findChild(self.viewGO, "Panel/Right/go_manageinfo")

		self.infoView = ShelterManagerInfoView.getView(prefabRes, parentGO, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Building
	param.showId = SurvivalShelterBuildingListModel.instance:getSelectBuilding()

	self.infoView:refreshParam(param)
end

function ShelterBuildingManagerView:onClose()
	for _, v in pairs(self.baseItemList) do
		for _, vv in pairs(v.itemList) do
			vv.btn:RemoveClickListener()
			vv.simageBuild:UnLoadImage()
		end
	end

	for _, v in pairs(self.smallItemList) do
		v.btn:RemoveClickListener()
		v.simageBuild:UnLoadImage()
	end
end

return ShelterBuildingManagerView

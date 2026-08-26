-- chunkname: @modules/logic/survival/view/shelter/ShelterTentManagerView.lua

module("modules.logic.survival.view.shelter.ShelterTentManagerView", package.seeall)

local ShelterTentManagerView = class("ShelterTentManagerView", BaseView)

function ShelterTentManagerView:onInitView()
	self.goTentScroll = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_TentList")
	self.goTentContent = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content")
	self.goBigItem = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content/#go_BigItem")
	self.goSmallItem = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content/#go_item")

	gohelper.setActive(self.goBigItem, false)
	gohelper.setActive(self.goSmallItem, false)

	self.itemList = {}
	self.goSelectPanel = gohelper.findChild(self.viewGO, "Panel/#go_SelectPanel")
	self.selectPanelCanvasGroup = gohelper.onceAddComponent(self.goSelectPanel, typeof(UnityEngine.CanvasGroup))
	self.btnClose = gohelper.findChildButtonWithAudio(self.goSelectPanel, "#btn_Close")
	self.btnSelect = gohelper.findChildButtonWithAudio(self.goSelectPanel, "#btn_Select")
	self.goFilter = gohelper.findChild(self.goSelectPanel, "#btn_filter")
	self.goNpcInfoRoot = gohelper.findChild(self.viewGO, "Panel/#go_SelectPanel/go_manageinfo")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.isNpcPanelVisible = false

	gohelper.setActive(self.goSelectPanel, false)
end

function ShelterTentManagerView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnSelect, self.onClickBtnSelect, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterTentManagerView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnSelect)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
end

function ShelterTentManagerView:onShelterBagUpdate()
	self:refreshView()
end

function ShelterTentManagerView:onBuildingInfoUpdate()
	self:refreshView()
end

function ShelterTentManagerView:onNpcPostionChange()
	self:refreshView()
end

function ShelterTentManagerView:onClickBtnSelect()
	SurvivalShelterTentListModel.instance:changeQuickSelect()

	if SurvivalShelterTentListModel.instance:isQuickSelect() then
		SurvivalShelterTentListModel.instance:setSelectNpc(0)
	end

	self:refreshSelectPanel()
end

function ShelterTentManagerView:onClickBtnClose()
	SurvivalShelterTentListModel.instance:setSelectPos()
	self:refreshSelectPanel()
end

function ShelterTentManagerView:onClickBigItem(item)
	if not item.data then
		return
	end

	local buildingInfo = item.data.buildingInfo

	if SurvivalShelterTentListModel.instance:setSelectBuildingId(buildingInfo.id) then
		self:refreshView()
	end
end

function ShelterTentManagerView:onClickSmallItem(item)
	local buildingInfo = item.parentItem.data.buildingInfo
	local flag2 = SurvivalShelterTentListModel.instance:setSelectBuildingId(buildingInfo.id)
	local flag = false

	if not flag2 then
		local pos = item.index - 1

		flag = SurvivalShelterTentListModel.instance:setSelectPos(pos)
	end

	if flag or flag2 then
		self:refreshView()
	end
end

function ShelterTentManagerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	SurvivalShelterTentListModel.instance:initViewParam(self.viewParam)
	self:refreshFilter()
	self:refreshView()
	self:foucsTent()
end

function ShelterTentManagerView:foucsTent()
	local buildingId = SurvivalShelterTentListModel.instance:getSelectBuilding()

	if buildingId == 0 then
		return
	end

	local foucsIndex
	local dataCount = #self.tentDataList

	for i = 1, dataCount do
		local data = self.tentDataList[i]

		if data.buildingInfo.id == buildingId then
			foucsIndex = i

			break
		end
	end

	if foucsIndex then
		local itemHeight = 380
		local contentHeight = itemHeight * dataCount
		local scrollHeight = recthelper.getHeight(self.goTentScroll.transform)
		local heightOffset = contentHeight - scrollHeight
		local moveLimt = math.max(0, heightOffset)
		local anchorY = (foucsIndex - 1) * 380

		recthelper.setAnchorY(self.goTentContent.transform, math.min(moveLimt, anchorY))
	end
end

function ShelterTentManagerView:refreshView()
	self:refreshTentList()
	self:refreshInfoView()
	self:refreshSelectPanel()
end

function ShelterTentManagerView:refreshTentList()
	local list = SurvivalShelterTentListModel.instance:getShowList()

	for i = 1, math.max(#self.itemList, #list) do
		local item = self:getBigItem(i)

		self:refreshBigItem(item, list[i])
	end

	self.tentDataList = list
end

function ShelterTentManagerView:getBigItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index
		item.go = gohelper.cloneInPlace(self.goBigItem, tostring(index))
		item.txtName = gohelper.findChildTextMesh(item.go, "Title/Layout/#txt_Tent")
		item.txtLevel = gohelper.findChildTextMesh(item.go, "Title/Layout/#txt_Lv")
		item.txtNpcCount = gohelper.findChildTextMesh(item.go, "Title/Layout/#txt_MemberNum")
		item.scroll = gohelper.findChildComponent(item.go, "Scroll View", typeof(ZProj.LimitedScrollRect))
		item.scroll.parentGameObject = self.goTentScroll
		item.goGrid = gohelper.findChild(item.go, "Scroll View/Viewport/#go_content")
		item.goDestoryed = gohelper.findChild(item.go, "#go_Destoryed")
		item.goLocked = gohelper.findChild(item.go, "#go_Locked")
		item.txtLocked = gohelper.findChildTextMesh(item.go, "#go_Locked/#txt_Locked")
		item.goSelected = gohelper.findChild(item.go, "#go_Selected")
		item.goSelectFrame1 = gohelper.findChild(item.go, "#go_Selected/image_Frame1")
		item.goSelectFrame2 = gohelper.findChild(item.go, "#go_Selected/image_Frame2")
		item.smallItemList = {}
		item.btn = gohelper.findChildButtonWithAudio(item.go, "Scroll View/Viewport")

		item.btn:AddClickListener(self.onClickBigItem, self, item)

		self.itemList[index] = item
	end

	return item
end

function ShelterTentManagerView:refreshBigItem(item, data)
	item.data = data

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local buildingInfo = data.buildingInfo
	local isUnBuild = buildingInfo.level == 0
	local isDestory = buildingInfo.status == SurvivalEnum.BuildingStatus.Destroy

	gohelper.setActive(item.goLocked, isUnBuild)

	if isUnBuild then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local unlock, reason = weekInfo:isBuildingUnlock(buildingInfo.buildingId, 1, true)

		item.txtLocked.text = unlock and luaLang("survivalbuildingmanageview_unbuild_txt") or reason
	end

	gohelper.setActive(item.goDestoryed, isDestory)

	local isSelect = SurvivalShelterTentListModel.instance:isSelectBuilding(buildingInfo.id)

	gohelper.setActive(item.goSelected, isSelect)

	if isSelect then
		gohelper.setActive(item.goSelectFrame1, not isDestory)
		gohelper.setActive(item.goSelectFrame2, isDestory)
	end

	item.txtName.text = buildingInfo.baseCo.name
	item.txtLevel.text = isUnBuild and "" or string.format("Lv.%s", buildingInfo.level)
	item.txtNpcCount.text = string.format("%s/%s", data.npcNum, data.npcCount)

	for i = 1, math.max(#item.smallItemList, data.npcCount) do
		local smallItem = self:getSmallItem(item, i)

		self:refreshSmallItem(smallItem, data.npcList[i - 1], isUnBuild, isDestory)
	end
end

function ShelterTentManagerView:getSmallItem(item, index)
	local smallItem = item.smallItemList[index]

	if not smallItem then
		smallItem = self:getUserDataTb_()
		smallItem.index = index
		smallItem.go = gohelper.clone(self.goSmallItem, item.goGrid, tostring(index))
		smallItem.goNpc = gohelper.findChild(smallItem.go, "#go_HaveHero")
		smallItem.imageNpc = gohelper.findChildSingleImage(smallItem.go, "#go_HaveHero/#image_Chess")
		smallItem.txtName = gohelper.findChildTextMesh(smallItem.go, "#go_HaveHero/#txt_PartnerName")
		smallItem.goEmpty = gohelper.findChild(smallItem.go, "#go_Empty")
		smallItem.goDestoryed = gohelper.findChild(smallItem.go, "#go_Destoryed")
		smallItem.goLocked = gohelper.findChild(smallItem.go, "#go_Locked")
		smallItem.btn = gohelper.findChildButtonWithAudio(smallItem.go, "click")

		smallItem.btn:AddClickListener(self.onClickSmallItem, self, smallItem)

		smallItem.heroAnim = smallItem.goNpc:GetComponent(gohelper.Type_Animator)
		item.smallItemList[index] = smallItem
	end

	smallItem.parentItem = item

	return smallItem
end

function ShelterTentManagerView:refreshSmallItem(smallItem, npcId, isUnBuild, isDestory)
	smallItem.npcId = npcId

	if not npcId then
		smallItem.lastNpcId = npcId

		gohelper.setActive(smallItem.go, false)

		return
	end

	gohelper.setActive(smallItem.go, true)

	local isEmpty = npcId == 0

	if isEmpty then
		::label_18_0::

		local var_18_0 = smallItem.lastNpcId

		if smallItem.lastNpcId then
			local outNpc = smallItem.lastNpcId ~= 0
			local joinNpc = not isEmpty and smallItem.lastNpcId ~= npcId

			if outNpc then
				gohelper.setActive(smallItem.goNpc, true)
				smallItem.heroAnim:Play("out", 0, 0)
			elseif joinNpc then
				gohelper.setActive(smallItem.goNpc, true)
				smallItem.heroAnim:Play("in", 0, 0)
			else
				gohelper.setActive(smallItem.goNpc, not isEmpty and not isUnBuild and not isDestory)
			end

			gohelper.setActive(smallItem.goDestoryed, isUnBuild)
			gohelper.setActive(smallItem.goLocked, isDestory)
			gohelper.setActive(smallItem.goEmpty, isEmpty and not isUnBuild and not isDestory)

			smallItem.lastNpcId = npcId

			if isEmpty then
				return
			end

			local npcConfig = SurvivalConfig.instance:getNpcConfig(npcId)

			if npcConfig then
				smallItem.txtName.text = npcConfig.name

				SurvivalUnitIconHelper.instance:setNpcIcon(smallItem.imageNpc, npcConfig.headIcon)
			end
		end
	end
end

function ShelterTentManagerView:refreshInfoView()
	if not self.infoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)
		local parentGO = gohelper.findChild(self.viewGO, "Panel/go_manageinfo")

		self.infoView = ShelterManagerInfoView.getView(prefabRes, parentGO, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Building
	param.showId = SurvivalShelterTentListModel.instance:getSelectBuilding()

	self.infoView:refreshParam(param)
end

function ShelterTentManagerView:refreshSelectPanel()
	local buildingId = SurvivalShelterTentListModel.instance:getSelectBuilding()
	local pos = SurvivalShelterTentListModel.instance:getSelectPos()
	local isShow = not not (buildingId and pos)

	if isShow then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local buildingInfo = weekInfo:getBuildingInfo(buildingId)
		local isBuild = buildingInfo and buildingInfo:isBuild()

		isShow = not not isBuild
	end

	self:setNpcPanelVisible(isShow)

	if not isShow then
		return
	end

	self:refreshQuickSelect()
	self:refreshNpcInfoView()
	SurvivalShelterTentListModel.instance:refreshNpcList(self._filterList)
end

function ShelterTentManagerView:setNpcPanelVisible(isVisible)
	if self.isNpcPanelVisible == isVisible then
		return
	end

	self.isNpcPanelVisible = isVisible

	gohelper.setActive(self.goSelectPanel, true)

	if isVisible then
		self.animator:Play("panel_in")

		self.selectPanelCanvasGroup.interactable = true
		self.selectPanelCanvasGroup.blocksRaycasts = true
	else
		self.animator:Play("panel_out")

		self.selectPanelCanvasGroup.interactable = false
		self.selectPanelCanvasGroup.blocksRaycasts = false
	end
end

function ShelterTentManagerView:refreshFilter()
	local filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goFilter, SurvivalFilterPart)
	local filterOptions = {}
	local list = lua_survival_tag_type.configList

	for i, v in ipairs(list) do
		table.insert(filterOptions, {
			desc = v.name,
			type = v.id
		})
	end

	filterComp:setOptionChangeCallback(self._onFilterChange, self)
	filterComp:setOptions(filterOptions)
end

function ShelterTentManagerView:_onFilterChange(filterList)
	self._filterList = filterList

	self:refreshView()
end

function ShelterTentManagerView:refreshQuickSelect()
	local isGray = not SurvivalShelterTentListModel.instance:isQuickSelect()

	ZProj.UGUIHelper.SetGrayscale(self.btnSelect.gameObject, isGray)
end

function ShelterTentManagerView:refreshNpcInfoView()
	local selectNpcId = SurvivalShelterTentListModel.instance:getSelectNpc()

	if not selectNpcId or selectNpcId == 0 then
		gohelper.setActive(self.goNpcInfoRoot, false)

		return
	end

	gohelper.setActive(self.goNpcInfoRoot, true)

	if not self.npcInfoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)

		self.npcInfoView = ShelterManagerInfoView.getView(prefabRes, self.goNpcInfoRoot, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Npc
	param.showId = selectNpcId
	param.otherParam = {
		tentBuildingId = SurvivalShelterTentListModel.instance:getSelectBuilding(),
		tentBuildingPos = SurvivalShelterTentListModel.instance:getSelectPos()
	}

	self.npcInfoView:refreshParam(param)
end

function ShelterTentManagerView:onDestroyView()
	for _, v in pairs(self.itemList) do
		v.btn:RemoveClickListener()

		for _, vv in pairs(v.smallItemList) do
			vv.btn:RemoveClickListener()
		end
	end
end

return ShelterTentManagerView

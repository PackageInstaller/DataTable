-- chunkname: @modules/logic/fight/view/rouge2/FightRouge2TechniqueView.lua

module("modules.logic.fight.view.rouge2.FightRouge2TechniqueView", package.seeall)

local FightRouge2TechniqueView = class("FightRouge2TechniqueView", BaseView)
local DEFAULT_SHOW_INDEX = 1
local DEFAULT_MAIN_TAB_INDEX = 1
local DEFAULT_SUB_TAB_INDEX = 1
local TAB_TWEEN_TIME = 0.3
local MAIN_TAB_HEIGHT = 130

local function _sortTechniqueBySubTitleId(techniqueIdA, techniqueIdB)
	local subTitleIdA = Rouge2_Config.instance:getStealthTechniqueSubTitleId(techniqueIdA)
	local subTitleIdB = Rouge2_Config.instance:getStealthTechniqueSubTitleId(techniqueIdB)

	if subTitleIdA ~= subTitleIdB then
		return subTitleIdA < subTitleIdB
	end

	return techniqueIdA < techniqueIdB
end

local function _sortTechniqueByMainTitleId(mainTitleDictA, mainTitleDictB)
	local techniqueIdA = mainTitleDictA[1]
	local techniqueIdB = mainTitleDictB[1]
	local mainTitleIdA = Rouge2_Config.instance:getStealthTechniqueMainTitleId(techniqueIdA)
	local mainTitleIdB = Rouge2_Config.instance:getStealthTechniqueMainTitleId(techniqueIdB)

	if mainTitleIdA ~= mainTitleIdB then
		return mainTitleIdA < mainTitleIdB
	end

	return techniqueIdA < techniqueIdB
end

function FightRouge2TechniqueView:onInitView()
	self._gocenter = gohelper.findChild(self.viewGO, "#go_root/#go_center")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_root/#go_center/content/#simage_icon")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_root/#go_center/content/#txt_title")
	self.goDescItem = gohelper.findChild(self.viewGO, "#go_root/#go_center/content/#txt_dec")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_root/#btn_quit", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._goleft = gohelper.findChild(self.viewGO, "#go_root/left")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_root/left/scroll_category")
	self._gocategorycontent = gohelper.findChild(self.viewGO, "#go_root/left/scroll_category/viewport/#go_categorycontent")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "#go_root/left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")
	self.descItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightRouge2TechniqueView:addEvents()
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function FightRouge2TechniqueView:removeEvents()
	self._btnquit:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:clearTab()
end

function FightRouge2TechniqueView:_btnquitOnClick()
	if self._showTechniqueIdList and #self._showTechniqueIdList > 0 then
		self:_showNextTechnique()
	else
		self:closeThis()
	end
end

function FightRouge2TechniqueView:_showNextTechnique()
	local nextTechniqueId

	self.showIndex = not self.showIndex and DEFAULT_SHOW_INDEX or self.showIndex + 1

	if self._showTechniqueIdList and #self._showTechniqueIdList > 0 then
		nextTechniqueId = self._showTechniqueIdList[self.showIndex]
	end

	if nextTechniqueId then
		self:_refreshContentData(nextTechniqueId)
	else
		self:closeThis()
	end
end

function FightRouge2TechniqueView:_onMainTabClick(param)
	local index = param.index

	if not param.subIndex then
		if self.selectedMainTabIndex == index then
			self:killTween()

			self._btnTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, TAB_TWEEN_TIME, self._onBtnAniFrameCallback, self._btnTweenCloseFinish, self)
		else
			local lastSelectedMainTabItem = self.mainTabItemList[self.selectedMainTabIndex]

			if lastSelectedMainTabItem then
				recthelper.setHeight(lastSelectedMainTabItem.trans, MAIN_TAB_HEIGHT)
				recthelper.setHeight(lastSelectedMainTabItem.transSubTabContent, 0)
			end

			self.selectedMainTabIndex = index

			self:_detectBtnState()

			self.selectedSubTabIndex = nil

			self:_onSubBtnClick(param.subIndex)
			self:killTween()

			self._btnTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, TAB_TWEEN_TIME, self._onBtnAniFrameCallback, self._btnTweenOpenFinished, self)
		end
	end
end

function FightRouge2TechniqueView:_onBtnAniFrameCallback(value)
	local selectedMainTabItem = self.mainTabItemList[self.selectedMainTabIndex]

	if selectedMainTabItem then
		local height = self.subTabItemHeight[self.selectedMainTabIndex] * value

		recthelper.setHeight(selectedMainTabItem.trans, MAIN_TAB_HEIGHT + height)
		recthelper.setHeight(selectedMainTabItem.transSubTabContent, height)
	end
end

function FightRouge2TechniqueView:_btnTweenOpenFinished()
	local selectedMainTabItem = self.mainTabItemList[self.selectedMainTabIndex]

	if not selectedMainTabItem then
		return
	end

	local targetPosY = self._transscroll:InverseTransformPoint(selectedMainTabItem.trans.position).y + recthelper.getHeight(selectedMainTabItem.trans) / 2

	if targetPosY >= 65 or targetPosY <= -785 then
		recthelper.setAnchorY(self._gocategorycontent.transform, MAIN_TAB_HEIGHT * (self.selectedMainTabIndex - 1) - 60)
	end
end

function FightRouge2TechniqueView:_btnTweenCloseFinish()
	self.selectedMainTabIndex = nil

	self:_detectBtnState()
end

function FightRouge2TechniqueView:_detectBtnState()
	if not self.mainTabItemList then
		return
	end

	for index, mainTabItem in ipairs(self.mainTabItemList) do
		local isSelected = index == self.selectedMainTabIndex

		gohelper.setActive(mainTabItem.goSubTabContent, isSelected)
		gohelper.setActive(mainTabItem.goSelected, isSelected)
		gohelper.setActive(mainTabItem.goUnselected, not isSelected)
	end
end

function FightRouge2TechniqueView:_onSubBtnClick(index)
	if self.selectedSubTabIndex == index then
		return
	end

	self.selectedSubTabIndex = index

	self:_detectSubBtnState()
	self:_refreshContentData()
end

function FightRouge2TechniqueView:_detectSubBtnState()
	if self.subTabItemDict and self.subTabItemDict[self.selectedMainTabIndex] then
		for index, subTabItem in ipairs(self.subTabItemDict[self.selectedMainTabIndex]) do
			local isSelected = index == self.selectedSubTabIndex

			gohelper.setActive(subTabItem.goSelected, isSelected)
			gohelper.setActive(subTabItem.goUnselected, not isSelected)
		end
	end
end

function FightRouge2TechniqueView:_refreshContentData(techniqueId)
	local selectedTechniqueId

	if techniqueId then
		selectedTechniqueId = techniqueId
	else
		local subTabItemList = self.subTabItemDict[self.selectedMainTabIndex]
		local selectedSubTabItem = subTabItemList and subTabItemList[self.selectedSubTabIndex]

		if not selectedSubTabItem then
			return
		end

		selectedTechniqueId = selectedSubTabItem.data
	end

	self._txttitle.text = Rouge2_Config.instance:getStealthTechniqueSubTitle(selectedTechniqueId)

	local picture = Rouge2_Config.instance:getStealthTechniquePicture(selectedTechniqueId)

	self._simageicon:LoadImage(self:getImageUrl(picture), self._afterLoadPicture, self)

	local content = Rouge2_Config.instance:getStealthTechniqueContent(selectedTechniqueId)
	local pos = Rouge2_Config.instance:getStealthTechniquePos(selectedTechniqueId)

	self:refreshDescList(content, pos)
end

function FightRouge2TechniqueView:refreshDescList(descContent, pos)
	self:hideAllDescItem()

	if string.nilorempty(descContent) then
		return
	end

	local descList = string.split(descContent, "|")
	local posList = GameUtil.splitString2(pos, true, "|", "#")

	for i, desc in ipairs(descList) do
		local descItem = self.descItemList[i]

		if not descItem then
			descItem = self:getUserDataTb_()
			descItem.go = gohelper.cloneInPlace(self.goDescItem)
			descItem.txt = descItem.go:GetComponent(gohelper.Type_TextMesh)
			descItem.rectTr = descItem.go:GetComponent(gohelper.Type_RectTransform)

			table.insert(self.descItemList, descItem)
		end

		gohelper.setActive(descItem.go, true)

		descItem.txt.text = desc

		if posList[i] then
			if not posList[i][1] then
				local posX = 0

				if posList[i] then
					if not posList[i][2] then
						local posY = 0

						recthelper.setAnchor(descItem.rectTr, posX, posY)
					end
				end
			end
		end
	end
end

function FightRouge2TechniqueView:hideAllDescItem()
	for _, descItem in ipairs(self.descItemList) do
		gohelper.setActive(descItem.go, false)
	end
end

function FightRouge2TechniqueView:getImageUrl(picture)
	return string.format("singlebg/fight/rouge2/%s.png", picture)
end

function FightRouge2TechniqueView:_afterLoadPicture()
	self._imageicon:SetNativeSize()
end

function FightRouge2TechniqueView:_onOpenView(viewName)
	if viewName == ViewName.GuideView then
		self:closeThis()
	end
end

function FightRouge2TechniqueView:_editableInitView()
	gohelper.setActive(self.goDescItem, false)

	self._transscroll = self._goscroll.transform
	self._imageicon = self._simageicon:GetComponent(gohelper.Type_Image)
end

function FightRouge2TechniqueView:onUpdateParam()
	return
end

function FightRouge2TechniqueView:onOpen()
	self:setMainTabList()

	local selectMinTabIndex, selectSubTabIndex = self:getTabIndex()

	self.selectedMainTabIndex = nil
	self.selectedSubTabIndex = nil

	self:_onMainTabClick({
		index = selectMinTabIndex,
		subIndex = selectSubTabIndex
	})
end

function FightRouge2TechniqueView:getTabIndex()
	if self.viewParam then
		if not self.viewParam then
			return DEFAULT_MAIN_TAB_INDEX, DEFAULT_SUB_TAB_INDEX
		end

		for index, dataList in ipairs(self.mainTabDataList) do
			for subIndex, techniqueId in ipairs(dataList) do
				if techniqueId == self.viewParam then
					return index, subIndex
				end
			end
		end

		return DEFAULT_MAIN_TAB_INDEX, DEFAULT_SUB_TAB_INDEX
	end
end

function FightRouge2TechniqueView:clearTab()
	if self.mainTabItemList then
		for _, mainTabItem in ipairs(self.mainTabItemList) do
			mainTabItem.btnClick:RemoveClickListener()
		end
	end

	self.mainTabItemList = {}

	if self.subTabItemDict then
		for _, subTabItemList in pairs(self.subTabItemDict) do
			for _, subTabItem in ipairs(subTabItemList) do
				subTabItem.btnClick:RemoveClickListener()
			end
		end
	end

	self.subTabItemDict = {}
	self.subTabItemHeight = {}
end

function FightRouge2TechniqueView:setMainTabList()
	self:clearTab()

	local mainTabDataList = {}
	local mainTabDataDict = {}
	local techniqueIdList = Rouge2_Config.instance:getTechniqueIdList()

	for _, techniqueId in ipairs(techniqueIdList) do
		local mainTitleId = Rouge2_Config.instance:getStealthTechniqueMainTitleId(techniqueId)

		if mainTitleId ~= 0 then
			mainTabDataDict[mainTitleId] = mainTabDataDict[mainTitleId] or {}

			table.insert(mainTabDataDict[mainTitleId], techniqueId)
		end
	end

	for mainTitleId, _ in pairs(mainTabDataDict) do
		if #mainTabDataDict[mainTitleId] > 0 then
			table.sort(mainTabDataDict[mainTitleId], _sortTechniqueBySubTitleId)
			table.insert(mainTabDataList, mainTabDataDict[mainTitleId])
		end
	end

	table.sort(mainTabDataList, _sortTechniqueByMainTitleId)
	gohelper.CreateObjList(self, self._onMainTabShow, mainTabDataList, self._gocategorycontent, self._gostorecategoryitem)

	self.mainTabDataList = mainTabDataList
end

function FightRouge2TechniqueView:_onMainTabShow(obj, data, index)
	local mainTabItem = self:getUserDataTb_()

	mainTabItem.go = obj
	mainTabItem.trans = mainTabItem.go.transform
	mainTabItem.data = data
	mainTabItem.goSelected = gohelper.findChild(obj, "go_selected")
	mainTabItem.goUnselected = gohelper.findChild(obj, "go_unselected")
	mainTabItem.goSubTabContent = gohelper.findChild(obj, "go_childcategory")
	mainTabItem.transSubTabContent = mainTabItem.goSubTabContent.transform
	mainTabItem.btnClick = gohelper.findChildClickWithAudio(mainTabItem.go, "clickArea", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	mainTabItem.btnClick:AddClickListener(self._onMainTabClick, self, {
		index = index
	})

	local mainTitle = Rouge2_Config.instance:getStealthTechniqueMainTitle(data[1])
	local txtTitle1 = gohelper.findChildTextMesh(obj, "go_unselected/txt_itemcn1")
	local txtTitle2 = gohelper.findChildTextMesh(obj, "go_selected/txt_itemcn2")

	txtTitle1.text = mainTitle
	txtTitle2.text = mainTitle
	self.subTabPosY = -60
	self.subBelongMainTabIndex = index

	local goSubTab = gohelper.findChild(obj, "go_childcategory/go_childitem")

	gohelper.CreateObjList(self, self._onSubTabShow, data, mainTabItem.goSubTabContent, goSubTab)

	self.subTabItemHeight[index] = math.abs(self.subTabPosY + 70)

	table.insert(self.mainTabItemList, mainTabItem)
end

function FightRouge2TechniqueView:_onSubTabShow(obj, data, index)
	local subTabItem = self:getUserDataTb_()

	subTabItem.go = obj
	subTabItem.data = data
	subTabItem.goSelected = gohelper.findChild(obj, "go_selected")
	subTabItem.goUnselected = gohelper.findChild(obj, "go_unselected")
	subTabItem.btnClick = gohelper.findChildClickWithAudio(subTabItem.go, "clickArea", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	subTabItem.btnClick:AddClickListener(self._onSubBtnClick, self, index)

	local subTitle = Rouge2_Config.instance:getStealthTechniqueSubTitle(data)
	local txt_itemcn1 = gohelper.findChildTextMesh(obj, "go_unselected/txt_itemcn1")
	local txt_itemcn2 = gohelper.findChildTextMesh(obj, "go_selected/txt_itemcn2")

	txt_itemcn1.text = subTitle
	txt_itemcn2.text = subTitle

	recthelper.setAnchorY(obj.transform, self.subTabPosY)

	self.subTabPosY = self.subTabPosY - 120

	local subTabItemList = self.subTabItemDict[self.subBelongMainTabIndex]

	if not subTabItemList then
		subTabItemList = {}
		self.subTabItemDict[self.subBelongMainTabIndex] = subTabItemList
	end

	table.insert(subTabItemList, subTabItem)
end

function FightRouge2TechniqueView:killTween()
	if self._btnTweenId then
		ZProj.TweenHelper.KillById(self._btnTweenId)
	end

	self._btnTweenId = nil
end

function FightRouge2TechniqueView:onClose()
	self:killTween()
end

function FightRouge2TechniqueView:onDestroyView()
	self._simageicon:UnLoadImage()
end

return FightRouge2TechniqueView

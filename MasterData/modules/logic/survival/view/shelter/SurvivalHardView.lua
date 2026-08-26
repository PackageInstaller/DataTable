-- chunkname: @modules/logic/survival/view/shelter/SurvivalHardView.lua

module("modules.logic.survival.view.shelter.SurvivalHardView", package.seeall)

local SurvivalHardView = class("SurvivalHardView", BaseView)

function SurvivalHardView:onInitView()
	self.btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#btn_Next")
	self.btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self.btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self.goFrame1 = gohelper.findChild(self.viewGO, "#simage_Frame1")
	self.goFrame2 = gohelper.findChild(self.viewGO, "#simage_Frame2")
	self.goFrame3 = gohelper.findChild(self.viewGO, "#simage_Frame3")
	self.image_DifficultyBG = gohelper.findChild(self.viewGO, "Panel/Left/image_DifficultyBG")
	self.txtDifficulty = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/image_DifficultyBG/txt_Difficulty")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/#txt_Desc")
	self.simageLevelPic = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/#simage_LevelPic")
	self.goItemPanel = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel")
	self.selectPanelCanvasGroup = gohelper.onceAddComponent(self.goItemPanel, typeof(UnityEngine.CanvasGroup))
	self.btnEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#go_Empty")
	self.goScroll = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List")
	self.goDifficultyAssess = gohelper.findChild(self.viewGO, "Panel/Right/image_DifficultyAssessBG")
	self.txtDifficultyAssess = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/image_DifficultyAssessBG/txt_DifficultyAssess")
	self.customMask = gohelper.findChild(self.viewGO, "customMask")
	self.animCustomMask = self.customMask:GetComponent(gohelper.Type_Animator)
	self.btnTemplate = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_ItemPanel/btnTemplate")
	self.goBtnTemplate = self.btnTemplate.gameObject
	self.btnTemplateRed = gohelper.findChild(self.goBtnTemplate, "go_new")
	self.btn_closeTip = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_ItemPanel/#btn_closeTip")

	gohelper.setActive(self.btn_closeTip, false)

	self.image_DifficultyIcon = gohelper.findChildImage(self.goBtnTemplate, "image_DifficultyIcon")
	self.textTemplateTitle = gohelper.findChildTextMesh(self.goBtnTemplate, "textTitle")
	self.go_templateTitleNew = gohelper.findChild(self.goBtnTemplate, "go_new")
	self.go_templateList = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel/go_templateList")
	self.anim_templateList = self.go_templateList:GetComponent(typeof(UnityEngine.Animator))
	self.templateListContent = gohelper.findChild(self.go_templateList, "viewport/templateListContent")
	self.SurvivalDiffTempTab = gohelper.findChild(self.templateListContent, "SurvivalDiffTempTab")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalDiffTempTab
	param.lineCount = 1
	self.templateList = GameFacade.createSimpleListComp(self.go_templateList, param, self.SurvivalDiffTempTab, self.viewContainer)

	self.templateList:setOnClickItem(self.onClickTemplate, self)
	self.templateList:setOnSelectChange(self.onSelectTemplateChange, self)

	self.tabItems = {}

	for i = 1, 3 do
		self:createTab(i)
	end

	self.lineItems = {}
	self.goHardItem = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_SmallItem")
	self.goLineItem = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_Item")
	self.scrollContent = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List/Viewport/Content")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self:setPanelVisible(false)
end

function SurvivalHardView:addEvents()
	self.addClickCb(self, self.btnnext, self.onClickNext, self)
	self.addClickCb(self, self.btnleft, self.onClickLeft, self)
	self.addClickCb(self, self.btnright, self.onClickRight, self)
	self.addClickCb(self, self.btnEmpty, self.onClickEmpty, self)
	self.addClickCb(self, self.btnTemplate, self.onClickBtnTemplate, self)
	self.addClickCb(self, self.btn_closeTip, self.onClickCloseTip, self)
end

function SurvivalHardView:removeEvents()
	self:removeClickCb(self.btnnext)
	self:removeClickCb(self.btnleft)
	self:removeClickCb(self.btnright)
	self:removeClickCb(self.btnEmpty)
	TaskDispatcher.cancelTask(self.onCloseDiffList, self)
end

function SurvivalHardView:onClickNext()
	local difficultyId = SurvivalDifficultyModel.instance:getDifficultyId()

	ViewMgr.instance:openView(ViewName.SurvivalRoleSelectView, {
		difficultyId = difficultyId
	})
end

function SurvivalHardView:onClickLeft()
	local animName = SurvivalDifficultyModel.instance:changeDifficultyIndex(-1)

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickRight()
	local animName = SurvivalDifficultyModel.instance:changeDifficultyIndex(1)

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickEmpty()
	self.inSelectCustom = true

	self:refreshView()
end

function SurvivalHardView:onClickBtnTemplate()
	self.isDiffListShow = true

	local selectIndex2 = SurvivalDifficultyModel.instance:getCustomFragmentSelect()

	self.curDiffListSelect = selectIndex2

	gohelper.setActive(self.go_templateList, true)
	self.templateList:setSelect(selectIndex2)
	self:refreshTemplateList()
	gohelper.setActive(self.btn_closeTip.gameObject, true)
	TaskDispatcher.cancelTask(self.delayPlayUnLockAnim, self)
	TaskDispatcher.runDelay(self.delayPlayUnLockAnim, self, 0.2)
	SurvivalDifficultyModel.instance:markBtnDiff()
	gohelper.setActive(self.btnTemplateRed, false)
end

function SurvivalHardView:delayPlayUnLockAnim()
	local items = self.templateList:getItems()

	for i, v in ipairs(items) do
		v:playAnim()
	end

	SurvivalDifficultyModel.instance:markNewDiffs()
end

function SurvivalHardView:onClickCloseTip()
	self:closeDiffList()
end

function SurvivalHardView:closeDiffList()
	if not self.isDiffListShow then
		return
	end

	TaskDispatcher.cancelTask(self.delayPlayUnLockAnim, self)

	self.isDiffListShow = false

	self.anim_templateList:Play("out")

	self.curDiffListSelect = nil

	TaskDispatcher.runDelay(self.onCloseDiffList, self, 0.167)
end

function SurvivalHardView:onCloseDiffList()
	gohelper.setActive(self.go_templateList, false)
	gohelper.setActive(self.btn_closeTip.gameObject, false)
end

function SurvivalHardView:onClickTab(index)
	local flag = SurvivalDifficultyModel.instance:setCustomSelectIndex(index)

	if not flag then
		return
	end

	local animName = "switch_buff"

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickGrid(item)
	if not item.config.id then
		return
	end

	local info = SurvivalModel.instance:getOutSideInfo()
	local hasUnlock = info and info:isUnlockDifficulty(item.config.id) or false

	if not hasUnlock then
		if string.nilorempty(item.config.lockDesc) then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		else
			GameFacade.showToastString(item.config.lockDesc)
		end

		return
	end

	local isSelect = self:selectCustomDifficulty(item)

	if not isSelect then
		local scrollView = self.viewContainer.scrollView

		scrollView._csListScroll.VerticalScrollPixel = recthelper.getHeight(self.scrollContent.transform)
	end
end

function SurvivalHardView:selectCustomDifficulty(item)
	local v, isSelect = SurvivalDifficultyModel.instance:selectCustomDifficulty(item.config.id)

	if v then
		self:refreshNextBtn()
		self:refreshTab()
		self:refreshLine(item.line, item.line.data)
		self:refreshDifficultyList()
		self:refreshAssess()
	end

	return isSelect
end

function SurvivalHardView:createTab(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(self.viewGO, string.format("Panel/Left/#go_ItemPanel/Tab/#go_Tab%s", index))
	item.goSelect = gohelper.findChild(item.go, "#go_TabSelected")
	item.goUnSelect = gohelper.findChild(item.go, "#go_TabUnSelected")
	item.txtSelectNum = gohelper.findChildTextMesh(item.goSelect, "#txt_Num")
	item.txtUnSelectNum = gohelper.findChildTextMesh(item.goUnSelect, "#txt_Num")
	item.btn = gohelper.findButtonWithAudio(item.go)

	item.btn:AddClickListener(self.onClickTab, self, index)

	self.tabItems[index] = item
end

function SurvivalHardView:onOpen()
	SurvivalDifficultyModel.instance:refreshDifficulty()

	local data = {}
	local ids = SurvivalDifficultyModel.instance:getCustomTempDiffIds()

	for i, id in ipairs(ids) do
		table.insert(data, {
			id = id,
			onClickDiffTempBtnConfirm = self.onClickDiffTempBtnConfirm,
			context = self
		})
	end

	self.templateList:setData(data)
	gohelper.setActive(self.go_templateList, false)
	self:refreshView()
	self:refreshBtnTemplate()
	gohelper.setActive(self.btnTemplateRed, SurvivalDifficultyModel.instance:haveBtnNewDiff())
end

function SurvivalHardView:refreshView()
	gohelper.setActive(self.customMask, false)

	local isCustom = SurvivalDifficultyModel.instance:isCustomFragment()

	if isCustom then
		self:refreshCustomView()
	else
		self:refreshNormalView()
	end
end

function SurvivalHardView:refreshCustomView()
	local difficultyId = SurvivalDifficultyModel.instance:getDifficultyId()

	self.simageLevelPic:LoadImage("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_01.png")
	self:refreshCustomPanel()

	local info = SurvivalModel.instance:getOutSideInfo()
	local isUnlockCustom = info:isUnlockDifficultyMod(SurvivalConst.CustomDifficulty)

	if not isUnlockCustom then
		gohelper.setActive(self.customMask, true)
		self.animCustomMask:Play("lock", 0, 0)
	elseif SurvivalDifficultyModel.instance:isNewDiff(SurvivalConst.CustomDifficulty) then
		gohelper.setActive(self.customMask, true)
		self.animCustomMask:Play("unlock", 0, 0)
		SurvivalDifficultyModel.instance:markNewCustomDiff()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideCustomDiffOpen)
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_dispel)
	else
		gohelper.setActive(self.customMask, false)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideCustomDiffOpen)
	end

	self:refreshPanel(difficultyId)
end

function SurvivalHardView:onClickTemplate(survivalDiffTempTab)
	if not survivalDiffTempTab.isUnlock then
		GameFacade.showToastString(luaLang("SurvivalHardView_3"))

		return
	end

	self.templateList:setSelect(survivalDiffTempTab.itemIndex)
	self:changeFragment(survivalDiffTempTab.itemIndex, nil, false)

	self.curDiffListSelect = SurvivalDifficultyModel.instance:getCustomFragmentSelect()

	self:closeDiffList()
end

function SurvivalHardView:onSelectTemplateChange(survivalDiffTempTab)
	return
end

function SurvivalHardView:onClickDiffTempBtnConfirm(survivalDiffTempTab)
	return
end

function SurvivalHardView:changeFragment(index, callBackParam, isAnim)
	local flag = SurvivalDifficultyModel.instance:setCustomFragmentSelect(index)

	if not flag then
		return
	end

	isAnim = isAnim ~= false
	self.changeFragmentIndex = index
	self.callBackParam = callBackParam

	self:refreshBtnTemplate()

	if isAnim then
		local animName = "switch_buff"

		self:playAnim(animName)
		UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
		TaskDispatcher.runDelay(self.changeFragmentDelay, self, 0.167)
	else
		self:changeFragmentDelay()
	end
end

function SurvivalHardView:changeFragmentDelay()
	self:refreshCustomView()

	if self.callBackParam then
		self.callBackParam.callBack(self.callBackParam.context, self.callBackParam.param)
	end
end

function SurvivalHardView:refreshCustomPanel()
	local isEmpty = false

	self:setPanelVisible(not isEmpty)
	gohelper.setActive(self.btnEmpty, isEmpty)
	gohelper.setActive(self.goScroll, not isEmpty)
	self:refreshNextBtn()

	if not isEmpty then
		self:refreshTab()
		self:refreshGridList()
		self:refreshDifficultyList()
	end
end

function SurvivalHardView:refreshBtnTemplate()
	local selectIndex2 = SurvivalDifficultyModel.instance:getCustomFragmentSelect()
	local item = self.templateList:getItemByIndex(selectIndex2)

	self.textTemplateTitle.text = item.title
end

function SurvivalHardView:refreshTemplateList()
	local items = self.templateList:getItems()

	for i, v in ipairs(items) do
		v:refresh()
	end
end

function SurvivalHardView:refreshNextBtn()
	local isCustom = SurvivalDifficultyModel.instance:isCustomFragment()

	if not isCustom then
		ZProj.UGUIHelper.SetGrayscale(self.btnnext.gameObject, false)

		return
	end

	ZProj.UGUIHelper.SetGrayscale(self.btnnext.gameObject, false)
end

function SurvivalHardView:refreshNormalView()
	local difficultyId = SurvivalDifficultyModel.instance:getDifficultyId()

	self.simageLevelPic:LoadImage(string.format("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_0%s.png", difficultyId))
	self:setPanelVisible(false)
	gohelper.setActive(self.btnEmpty, false)
	gohelper.setActive(self.goScroll, true)
	self:refreshNextBtn()
	self:refreshDifficultyList()
	self:refreshPanel(difficultyId)
end

function SurvivalHardView:refreshPanel(difficultyId)
	local difficultyConfig = lua_survival_hardness_mod.configDict[difficultyId]
	local isCustom = SurvivalDifficultyModel.instance:isCustomFragment()

	if isCustom then
		gohelper.setActive(self.image_DifficultyBG, false)
	else
		gohelper.setActive(self.image_DifficultyBG, true)

		self.txtDifficulty.text = difficultyConfig.name
	end

	self.txtDesc.text = difficultyConfig.desc

	self:refreshFrame(difficultyId)
	self:refreshAssess()

	local left, right = SurvivalDifficultyModel.instance:getArrowStatus()

	gohelper.setActive(self.btnleft, left)
	gohelper.setActive(self.btnright, right)
end

function SurvivalHardView:refreshFrame(difficultyId)
	gohelper.setActive(self.goFrame1, difficultyId == 9999)
	gohelper.setActive(self.goFrame2, difficultyId == 3 or difficultyId == 4)
	gohelper.setActive(self.goFrame3, difficultyId == 5 or difficultyId == 6)
end

function SurvivalHardView:refreshAssess()
	local assess = SurvivalDifficultyModel.instance:getDifficultyAssess()

	self.txtDifficultyAssess.text = formatLuaLang("survivalselectdifficultyview_txt_assess", assess)
end

function SurvivalHardView:refreshDifficultyList()
	SurvivalDifficultyModel.instance:refreshDifficultyShowList()
end

function SurvivalHardView:refreshTab()
	local selectIndex = SurvivalDifficultyModel.instance:getCustomSelectIndex()
	local selectIndex2 = SurvivalDifficultyModel.instance:getCustomFragmentSelect()

	for i, v in ipairs(self.tabItems) do
		local isSelect = selectIndex == i

		gohelper.setActive(v.goSelect, isSelect)
		gohelper.setActive(v.goUnSelect, not isSelect)

		local assess = SurvivalDifficultyModel.instance:getCustomDifficultyAssess(i, selectIndex2)

		v.txtSelectNum.text = assess
		v.txtUnSelectNum.text = assess
	end
end

function SurvivalHardView:refreshGridList()
	local selectIndex = SurvivalDifficultyModel.instance:getCustomSelectIndex()
	local list = SurvivalDifficultyModel.instance.customDifficultyList[selectIndex]
	local dataList = {}

	for subtype, subList in pairs(list) do
		table.insert(dataList, {
			subtype = subtype,
			list = subList
		})
	end

	table.sort(dataList, SortUtil.keyLower("subtype"))

	for i = 1, math.max(#self.lineItems, #dataList) do
		local line = self.lineItems[i]

		if not line then
			line = self:getUserDataTb_()
			line.index = i
			line.go = gohelper.cloneInPlace(self.goLineItem, tostring(i))
			line.goEvent = gohelper.findChild(line.go, "#go_EvenBG")
			line.goGrid = gohelper.findChild(line.go, "Grid")
			line.items = self:getUserDataTb_()
			self.lineItems[i] = line
		end

		self:refreshLine(line, dataList[i])
	end
end

function SurvivalHardView:refreshLine(line, data)
	line.data = data

	if not data then
		gohelper.setActive(line.go, false)

		return
	end

	gohelper.setActive(line.go, true)

	local list = data.list

	gohelper.setActive(line.goEvent, line.index % 2 == 0)

	for i = 1, math.max(#line.items, #list) do
		local item = line.items[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.clone(self.goHardItem, line.goGrid, tostring(i))
			item.imageQuality = gohelper.findChildImage(item.go, "#image_Quality")
			item.goQuality = item.imageQuality.gameObject
			item.goSelected = gohelper.findChild(item.go, "#go_Selected")
			item.goIcon = gohelper.findChild(item.go, "image_Icon")
			item.simageIcon = gohelper.findChildSingleImage(item.go, "image_Icon")
			item.btn = gohelper.findButtonWithAudio(item.go)

			item.btn:AddClickListener(self.onClickGrid, self, item)

			item.line = line
			line.items[i] = item
		end

		self:refreshGridItem(line.items[i], list[i])
	end
end

function SurvivalHardView:refreshGridItem(item, config)
	local info = SurvivalModel.instance:getOutSideInfo()

	item.config = config

	local isEmpty = config.id == nil

	gohelper.setActive(item.go, true)

	if isEmpty then
		gohelper.setActive(item.goIcon, false)
		UISpriteSetMgr.instance:setSurvivalSprite(item.imageQuality, "survivalselectdifficulty_item_empty")
		gohelper.setActive(item.goSelected, false)

		return
	end

	gohelper.setActive(item.goIcon, true)

	local hasUnlock = info and info:isUnlockDifficulty(config.id) or false

	UISpriteSetMgr.instance:setSurvivalSprite(item.imageQuality, string.format("survivalselectdifficulty_item_quality_%s", config.level))

	local iconPath = string.format("singlebg/survival_singlebg/difficulty/difficulticon/%s.png", config.icon)

	item.simageIcon:LoadImage(iconPath)
	ZProj.UGUIHelper.SetGrayscale(item.goIcon, not hasUnlock)
	ZProj.UGUIHelper.SetGrayscale(item.goQuality, not hasUnlock)

	local isSelect = SurvivalDifficultyModel.instance:isSelectCustomDifficulty(config.id)

	gohelper.setActive(item.goSelected, hasUnlock and isSelect)
end

function SurvivalHardView:playAnim(animName)
	if not animName then
		return
	end

	self.animator:Play(animName, 0, 0)
end

function SurvivalHardView:setPanelVisible(isVisible)
	if self.isPanelVisible == isVisible then
		return
	end

	self.isPanelVisible = isVisible

	gohelper.setActive(self.goItemPanel, isVisible)
end

function SurvivalHardView:onClose()
	self.simageLevelPic:UnLoadImage()

	for i, v in ipairs(self.tabItems) do
		v.btn:RemoveClickListener()
	end

	for _, v in ipairs(self.lineItems) do
		for _, item in ipairs(v.items) do
			item.btn:RemoveClickListener()
			item.simageIcon:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(self.refreshView, self)
	TaskDispatcher.cancelTask(self.changeFragmentDelay, self)
	TaskDispatcher.cancelTask(self.delayPlayUnLockAnim, self)
end

return SurvivalHardView

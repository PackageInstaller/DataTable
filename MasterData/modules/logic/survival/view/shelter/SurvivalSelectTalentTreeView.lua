-- chunkname: @modules/logic/survival/view/shelter/SurvivalSelectTalentTreeView.lua

module("modules.logic.survival.view.shelter.SurvivalSelectTalentTreeView", package.seeall)

local SurvivalSelectTalentTreeView = class("SurvivalSelectTalentTreeView", BaseView)

function SurvivalSelectTalentTreeView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG")
	self._simagePanelBG2 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG2")
	self._goallClick = gohelper.findChild(self.viewGO, "#go_allClick")
	self._scrollcontentlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_contentlist")
	self._godec = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_dec")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_dec/#txt_dec")
	self._gomain = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main")
	self._txtmain = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#txt_main")
	self._gomainitem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/container/#go_mainitem")
	self._txttask = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/container/#go_mainitem/#txt_task")
	self._gosub = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_sub")
	self._txtsub = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#txt_sub")
	self._gosubitem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#go_subitem")
	self._txtnum = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#go_subitem/#txt_num")
	self._gocollection = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection")
	self._txtcollection = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection/#txt_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem")
	self._txtchoice = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem/#txt_choice")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem/#btn_check")
	self._txtbase = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_collection/#txt_base")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end

	self.goMainAnim = self._gomain:GetComponent(gohelper.Type_Animation)
	self.go_dec2 = gohelper.findChild(self._gomain, "#go_dec2")
	self.go_score = gohelper.findChild(self._gomain, "#go_score")
	self.go_rewardinherit = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewardinherit")
	self.txt_score = gohelper.findChildTextMesh(self.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_score/#txt_score")
	self.go_fixed_rewardinherititem = gohelper.findChild(self.go_rewardinherit, "#go_rewardinherititem")
	self.layout = gohelper.findChild(self.go_rewardinherit, "layout")
	self.go_rewardinherititem = gohelper.findChild(self.layout, "#go_rewardinherititem")

	gohelper.setActive(self.go_rewardinherititem, false)

	self.fixedSelectCell = MonoHelper.addNoUpdateLuaComOnceToGo(self.go_fixed_rewardinherititem, SurvivalRewardSelectCell, self.viewContainer)
	self.customItems = {}
	self.isNeedHandbookSelect = SurvivalRewardInheritModel.instance:isNeedHandbookSelect()

	gohelper.setActive(self.go_dec2, self.isNeedHandbookSelect)
	gohelper.setActive(self.go_score, self.isNeedHandbookSelect)
	gohelper.setActive(self.go_rewardinherit, self.isNeedHandbookSelect)
end

function SurvivalSelectTalentTreeView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnRewardInheritRefresh, self.onRewardInheritRefresh, self)
end

function SurvivalSelectTalentTreeView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btnenter:RemoveClickListener()
end

function SurvivalSelectTalentTreeView:_btnselectOnClick()
	return
end

local stepTime = {
	0.5,
	0.5
}
local maxStep = 2
local firstMaxStep = 2
local normalMaxStep = 2
local ZProj_TweenHelper = ZProj.TweenHelper

function SurvivalSelectTalentTreeView:_btncheckOnClick()
	return
end

function SurvivalSelectTalentTreeView:_btnenterOnClick()
	if self.isNeedHandbookSelect then
		local equipSelectList, npcSelectList = SurvivalRewardInheritModel.instance:getChooseList()

		SurvivalWeekRpc.instance:sendSurvivalChooseBooty(npcSelectList, equipSelectList, self._onEnterShelter, self, true)
	else
		SurvivalController.instance:startNewWeek()
		SurvivalController.instance:enterSurvivalShelterScene()
	end
end

function SurvivalSelectTalentTreeView:_editableInitView()
	self._allClick = gohelper.findChildClickWithAudio(self.viewGO, "#go_allClick")

	self._allClick:AddClickListener(self.enterNext, self)

	self._canvasGroupDec = self._godec:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupCollection = self._gocollection:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupSub = self._gosub:GetComponent(gohelper.Type_CanvasGroup)
	self._canvasGroupMainTask = self._gomain:GetComponent(gohelper.Type_CanvasGroup)

	local content = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content")

	self._contentRect = content.transform:GetComponent(gohelper.Type_RectTransform)

	local scrollContentTr = self._scrollcontentlist.transform:GetComponent(gohelper.Type_RectTransform)

	self._scrollHeight = recthelper.getHeight(scrollContentTr)
	self._allShowGO = self:getUserDataTb_()

	table.insert(self._allShowGO, self._godec)
	table.insert(self._allShowGO, self._gomain)

	self._allShowGroup = self:getUserDataTb_()

	table.insert(self._allShowGroup, self._canvasGroupDec)
	table.insert(self._allShowGroup, self._canvasGroupMainTask)
	table.insert(self._allShowGroup, self._canvasGroupCollection)

	self._allShowAnim = self:getUserDataTb_()
end

function SurvivalSelectTalentTreeView:onOpen()
	SurvivalRewardInheritModel.instance.selectMo:clear()

	self._isFirstPlayer = self.viewParam.isFirstPlayer
	maxStep = self._isFirstPlayer and firstMaxStep or normalMaxStep
	self._progress = 1

	self:_initView()
	self:_refreshCurProgress()
	self:refreshCost()
	self:refreshFixedItem()
	self:refreshHandbook()
end

function SurvivalSelectTalentTreeView:_initView()
	recthelper.setAnchorY(self._contentRect, 0)

	self._canvasGroupDec.alpha = 0

	self:_initTaskView()
	gohelper.setActive(self._gosub, false)
	gohelper.setActive(self._gocollection, false)
	gohelper.setActive(self._btnenter.gameObject, false)
end

function SurvivalSelectTalentTreeView:_initTaskView()
	self:_initTaskItem(SurvivalEnum.TaskModule.MainTask)

	self._canvasGroupMainTask.alpha = 0
end

function SurvivalSelectTalentTreeView:_initTaskItem(taskModule)
	local task = SurvivalTaskModel.instance:getTaskList(taskModule)

	if self._mainTaskItem == nil then
		self._mainTaskItem = self:getUserDataTb_()
	end

	if self._subTaskItem == nil then
		self._subTaskItem = self:getUserDataTb_()
	end

	local index = 1

	for i, taskInfo in pairs(task) do
		local taskItem = self._mainTaskItem[i]

		if taskModule == SurvivalEnum.TaskModule.SubTask then
			taskItem = self._subTaskItem[i]
		end

		if taskItem == nil then
			local taskPrefab

			if taskModule == SurvivalEnum.TaskModule.MainTask then
				taskPrefab = gohelper.cloneInPlace(self._gomainitem, taskInfo.id)
			end

			if taskModule == SurvivalEnum.TaskModule.SubTask then
				taskPrefab = gohelper.cloneInPlace(self._gosubitem, taskInfo.id)
			end

			taskItem = self:getUserDataTb_()
			taskItem.go = taskPrefab
			taskItem.animation = taskPrefab:GetComponent(gohelper.Type_Animation)
			taskItem.txtTask = gohelper.findChildText(taskItem.go, "#txt_task")
			taskItem.bg = gohelper.findChild(taskItem.go, "bg")

			if taskModule == SurvivalEnum.TaskModule.SubTask then
				taskItem.numTxt = gohelper.findChildText(taskItem.go, "#txt_num")
				taskItem.numTxt.text = index
			end

			gohelper.setActive(taskItem.go, true)

			if taskModule == SurvivalEnum.TaskModule.MainTask then
				self._mainTaskItem[i] = taskItem
			end

			if taskModule == SurvivalEnum.TaskModule.SubTask then
				self._subTaskItem[i] = taskItem
			end
		end

		if taskInfo.co ~= nil then
			taskItem.txtTask.text = taskInfo:getDesc()
		end

		gohelper.setActive(taskItem.bg, index == 1)

		index = index + 1
	end
end

function SurvivalSelectTalentTreeView:enterNext()
	if not self._canEnterNext then
		return
	end

	if self._progress == maxStep then
		return
	end

	self._progress = self._progress + 1

	self:_refreshCurProgress()
end

function SurvivalSelectTalentTreeView:getContentY()
	if self._allContentY == nil or #self._allContentY <= 0 then
		self._allContentY = {}

		for i = 1, maxStep do
			local go = self._allShowGO[i]
			local tr = go.transform

			ZProj.UGUIHelper.RebuildLayout(tr)

			local rectTr = tr:GetComponent(gohelper.Type_RectTransform)
			local height = recthelper.getHeight(rectTr)

			if height ~= 0 then
				table.insert(self._allContentY, height + 30)
			end
		end
	end

	local allHeight = 0
	local count = math.min(self._progress, #self._allContentY)

	for i = 1, count do
		allHeight = allHeight + self._allContentY[i]
	end

	return allHeight - self._scrollHeight
end

function SurvivalSelectTalentTreeView:_refreshCurProgress()
	self._canEnterNext = false

	local go = self._allShowGO[self._progress]
	local time = stepTime[self._progress]
	local contentY = self:getContentY()

	if contentY > 0 then
		self._moveTweenId = ZProj_TweenHelper.DOAnchorPosY(self._contentRect, contentY, time)
	end

	if go ~= nil then
		self._tweenId = ZProj_TweenHelper.DOFadeCanvasGroup(go, 0, 1, time, self._progressFinish, self)
	end

	local goName = go.name

	if goName == "#go_main" then
		for _, v in ipairs(self._mainTaskItem) do
			if v.animation then
				v.animation:Play()
			end
		end

		self.goMainAnim:Play()
	end

	if goName == "#go_collection" then
		for _, v in pairs(self._talentItems) do
			if v.animation then
				v.animation:Play()
			end
		end
	end
end

function SurvivalSelectTalentTreeView:_progressFinish()
	self._canEnterNext = true

	local canvasGroup = self._allShowGroup[self._progress]

	if canvasGroup then
		canvasGroup.blocksRaycasts = true
		canvasGroup.interactable = true
	end

	gohelper.setActive(self._goallClick, self._progress ~= maxStep)
	gohelper.setActive(self._btnenter.gameObject, self._progress == maxStep)
end

function SurvivalSelectTalentTreeView:onClose()
	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function SurvivalSelectTalentTreeView:onDestroyView()
	if self._talentItems then
		for _, v in pairs(self._talentItems) do
			if v.click then
				v.click:RemoveClickListener()
			end

			if v.btnCheck then
				v.btnCheck:RemoveClickListener()
			end
		end
	end

	if self._allClick then
		self._allClick:RemoveClickListener()

		self._allClick = nil
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self.inheritMoveTweenId then
		ZProj.TweenHelper.KillById(self.inheritMoveTweenId)

		self.inheritMoveTweenId = nil
	end
end

function SurvivalSelectTalentTreeView:_onEnterShelter(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function SurvivalSelectTalentTreeView:refreshInheritSelect()
	local amplifierSelectMo = SurvivalRewardInheritModel.instance.amplifierSelectMo
	local npcSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo
	local equipSelectList = amplifierSelectMo:getSelectList()
	local npcSelectList = npcSelectMo:getSelectList()
	local cfg = SurvivalConfig.instance:getHardnessCfg()
	local curScore = 0

	for i, id in ipairs(equipSelectList) do
		local cfg = lua_survival_equip.configDict[id]
		local extendCost = cfg.extendCost

		curScore = curScore + extendCost
	end

	for i, id in ipairs(npcSelectList) do
		local cfg = lua_survival_npc.configDict[id]
		local extendCost = cfg.extendCost

		curScore = curScore + extendCost
	end
end

function SurvivalSelectTalentTreeView:onRewardInheritRefresh()
	self:refreshCost()
	self:refreshHandbook()
	self:refreshFixedItem()
	ZProj.UGUIHelper.RebuildLayout(self._contentRect.transform)

	local h = -30 - self._scrollHeight

	for i = 1, 2 do
		local go = self._allShowGO[i]
		local tr = go.transform
		local rectTr = tr:GetComponent(gohelper.Type_RectTransform)
		local height = recthelper.getHeight(rectTr)

		h = h + height + 30
	end

	if h > recthelper.getAnchorY(self._contentRect.transform) then
		self.inheritMoveTweenId = ZProj_TweenHelper.DOAnchorPosY(self._contentRect, h, 0.3)
	end
end

function SurvivalSelectTalentTreeView:refreshFixedItem()
	local count = self.extendScore - self.curExtendScore

	self.fixedSelectCell:setData({
		itemId = 1,
		count = count
	})
end

function SurvivalSelectTalentTreeView:refreshCost()
	self.curExtendScore = SurvivalRewardInheritModel.instance:getCurExtendScore()
	self.extendScore = SurvivalRewardInheritModel.instance:getExtendScore()
	self.txt_score.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSelectTalentTreeView_1"), {
		self.curExtendScore,
		self.extendScore
	})
end

function SurvivalSelectTalentTreeView:refreshHandbook()
	local dataList = SurvivalRewardInheritModel.instance.selectMo.dataList
	local list = {}

	tabletool.addValues(list, dataList)
	table.insert(list, -10)

	local customItemAmount = #self.customItems
	local listLength = #list

	for i = 1, listLength do
		local value = list[i]

		if customItemAmount < i then
			local obj = gohelper.clone(self.go_rewardinherititem, self.layout)

			gohelper.setActive(obj, true)

			self.customItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalRewardSelectCell, self.viewContainer)
		end

		self.customItems[i]:setData({
			inheritId = value
		})
	end

	for i = listLength + 1, customItemAmount do
		self.customItems[i]:setData(nil)
	end
end

return SurvivalSelectTalentTreeView

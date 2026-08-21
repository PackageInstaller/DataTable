-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\ActivitySnowOrNightBPDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local DragTwoPages = require("UI/Control/DragTwoPages")
local strClassName = "ActivitySnowOrNightBPDlg"
local TaskContentInfoPanel = require("UI/OpActivity/SnowNightBP/TaskContentInfoPanel")
local SnowOrNightBPTabCell = require("UI/OpActivity/SnowNightBP/SnowOrNightBPTabCell")
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local ActivitySnowOrNightBPDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySnowOrNightBPDlg, ActivityPanelMixin)

function ActivitySnowOrNightBPDlg:initUI()
	self.live2DPlayer = UIControls.LazyLivePlayer(self, "MainInfoPanel/Live2DPanel/Live2D")
	self.btnLive2D = UIControls.Button(self, "MainInfoPanel/Live2DPanel/Live2D")

	self.btnLive2D:addEventClick(self.onLive2DClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.audioPanel = UIControls.Panel(self, "MainInfoPanel/AudioPanel")
	self.btnNext = UIControls.Button(self, "MainInfoPanel/BtnNext")
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.textNot = UIControls.Label(self, "MainInfoPanel/BigAward/BgTextRule/TextNot")
	self.btnPre = UIControls.Button(self, "MainInfoPanel/BtnPre")
	self.efxBigGift = UIControls.LazyEffectPlayer(self, "BgImage/EfxBigGift")
	self.efxSpecialBigGift = UIControls.LazyEffectPlayer(self, "BgImage/EfxSpecialBigGift")
	self.iconGiftNewOpen = UIControls.UIAni(self, "MainInfoPanel/BtnGift/IconNewOpen")
	self.textHave = UIControls.Label(self, "MainInfoPanel/BigAward/BgTextRule/TextHave")
	self.btnGift = UIControls.Button(self, "MainInfoPanel/BtnGift")

	self.btnGift:addEventClick(self.onBtnGiftClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/TaskContentPanel/ContentPanel1", "MainInfoPanel/TaskContentPanel/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.taskTabListContent = UIControls.Panel(self, "MainInfoPanel/TaskTabList/Content")
	self.tweenComFlag = self.taskTabListContent:getGameObject():GetComponent(DOTweenComponent)
	self.voiceIdx = 1
	self.tabCells = {}
	self.pages = {}
end

function ActivitySnowOrNightBPDlg:onLive2DClick()
	self.live2DPlayer:playState("click")

	local voiceList = utils.splitString(self.clientTemplateData.template_args[1] or "", ",")

	if voiceList and #voiceList > 0 then
		if self.voiceIdx >= #voiceList then
			self.voiceIdx = 1
		else
			self.voiceIdx = self.voiceIdx + 1
		end

		local playVoiceId = voiceList[self.voiceIdx]

		CueManager.playVocal(tonumber(playVoiceId))
	else
		MsgManager.clientNotice(139)
	end
end

function ActivitySnowOrNightBPDlg:updateActivityData(actObj)
	self.actObj = actObj

	self:_refreshActivityData()
end

function ActivitySnowOrNightBPDlg:_refreshActivityData()
	if self.curPage then
		self.groupAchieveInfo = self.actObj.actData.groupAchieveInfo
		self.clientAchieveGroup = self.actObj.actData.clientAchieveGroup

		self:refreshMainDlg()
		self.curPage:setTaskContentInfo(self.actObj.actData, self.currentPageIndex)
		self:refreshBPTabCell()
	end
end

function ActivitySnowOrNightBPDlg:refreshMainDlg()
	local getGroupAchieveDataList = self.actObj.actData:getGroupAchieveDataList()

	for idx, resAchieveGroup in ipairs(getGroupAchieveDataList) do
		if resAchieveGroup.big_award_flag then
			local groupAwardAchieveData = self.actObj.actData:getGroupAwardAchieveData(resAchieveGroup.group_id)
			local groupAwardAchieveState

			if groupAwardAchieveData then
				groupAwardAchieveState = self.actObj.actData:getAchieveState(groupAwardAchieveData.type, groupAwardAchieveData.index)
			end

			self.textHave:setVisible(groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_GOT)
			self.textNot:setVisible(groupAwardAchieveState ~= Const.ACT_ACHIEVE_STATE_GOT)

			break
		end
	end
end

function ActivitySnowOrNightBPDlg:_setData()
	if not self.actObj or not self.actObj:isValid() or not self.actObj.actData.groupAchieveInfo then
		return
	end

	self.atlasFolderPath = "Atlas/ActivityAtlas/ActivitySnowOrNightBP12204Atlas"

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.atlasFolderPath = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	end

	self.prefabFolderPath = "System/Activity/ActivitySnowOrNightBP12204"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.prefabFolderPath = "System/Activity/" .. self.replaceableCellPath[1]
	end

	local pagePrefabPath = self.prefabFolderPath .. "/TaskContentInfoPanel"

	for i = 1, 2 do
		if not self.pages[i] then
			self.pages[i] = TaskContentInfoPanel(self, "MainInfoPanel/TaskContentPanel/ContentPanel" .. i, pagePrefabPath, 0, 0, true)
		end
	end

	self.iconGiftNewOpen:setVisible(self.actObj.actData.cacheNewUnlockGift ~= nil)

	self.groupAchieveInfo = self.actObj.actData.groupAchieveInfo
	self.clientAchieveGroup = self.actObj.actData.clientAchieveGroup

	local isSelectedGroup = 1
	local groupAchieveDataList = self.actObj.actData:getGroupAchieveDataList()

	self:refreshMainDlg()

	if self.actObj.actData.cacheNewUnlockGroup then
		isSelectedGroup = self.actObj.actData.cacheNewUnlockGift or self.actObj.actData.cacheNewUnlockGroup

		local snowOrNightStarUnLockDlg = UIManager.getUI("snowOrNightStarUnLockDlg", true)

		snowOrNightStarUnLockDlg:setUnlockGroup(self.actObj, self.actObj.actData.cacheNewUnlockGroup)
	else
		local firstNotGotIdx = 0

		for idx, resData in ipairs(groupAchieveDataList) do
			local groupId = resData.group_id
			local groupAwardAchieveData = self.actObj.actData:getGroupAwardAchieveData(groupId)
			local groupAwardAchieveState

			if groupAwardAchieveData then
				groupAwardAchieveState = self.actObj.actData:getAchieveState(groupAwardAchieveData.type, groupAwardAchieveData.index)
			end

			if groupAwardAchieveState == Const.ACT_ACHIEVE_STATE_ENOUGH and self.actObj.actData:isAllCompleteFromGroup(groupId) then
				isSelectedGroup = idx

				break
			end

			if groupAwardAchieveState ~= Const.ACT_ACHIEVE_STATE_GOT and firstNotGotIdx == 0 then
				firstNotGotIdx = idx
			end
		end

		if isSelectedGroup < firstNotGotIdx then
			isSelectedGroup = firstNotGotIdx
		end
	end

	self.dragPages:initPage(#groupAchieveDataList, isSelectedGroup)
end

function ActivitySnowOrNightBPDlg:selectGroupTab(groupTab)
	for idx, tabCell in pairs(self.tabCells) do
		if tabCell == groupTab then
			local isBack = self.currentPageIndex and idx < self.currentPageIndex or false

			self.dragPages:_onToSomePage(idx, isBack)
		end
	end
end

local TAB_SPACE = 6
local TAB_WDITH = 340
local TAB_TOTAL_WIDTH = TAB_WDITH + TAB_SPACE
local LIST_WIDTH = 1890

function ActivitySnowOrNightBPDlg:refreshBPTabCell()
	local getGroupAchieveDataList = self.actObj.actData:getGroupAchieveDataList()

	for idx, resAchieveGroup in ipairs(getGroupAchieveDataList) do
		if not self.tabCells[idx] then
			self.tabCells[idx] = SnowOrNightBPTabCell(self, "MainInfoPanel/TaskTabList/Content", self.prefabFolderPath .. "/SnowOrNightBPTabCell", 0, 0, true)
		end

		self.tabCells[idx]:setGroupTabData(resAchieveGroup, idx)
		self.tabCells[idx].btnTask:setEnable(self.currentPageIndex ~= idx)
	end

	if self.currentPageIndex and #getGroupAchieveDataList > math.floor(LIST_WIDTH / TAB_WDITH) then
		local calPosX = LIST_WIDTH / 2 - (self.currentPageIndex - 0.5) * TAB_TOTAL_WIDTH
		local maxPosX = 0
		local minPosX = -(#getGroupAchieveDataList * TAB_TOTAL_WIDTH - TAB_SPACE - LIST_WIDTH)
		local finalPosX = math.max(calPosX, minPosX)

		finalPosX = math.min(finalPosX, maxPosX)

		local contentY = self.taskTabListContent:getPosition().y
		local moveTime = 0.4

		self.tweenComFlag:UITweenMove(Vector3(finalPosX, contentY, 0), moveTime, nil)
	end
end

function ActivitySnowOrNightBPDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	self.currentPageIndex = currentPageIndex
	self.curPage = self.pages[panelIndex]

	self.curPage:setTaskContentInfo(self.actObj.actData, self.currentPageIndex)
	self:refreshBPTabCell()
end

function ActivitySnowOrNightBPDlg:onBtnGiftClick(sender)
	if not self.actObj or not self.actObj:isValid() or not self.actObj.actData.groupAchieveInfo then
		return
	end

	local objGift
	local relateId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]

	if relateId then
		objGift = CurAvatar:getActivityObj(relateId)

		if objGift then
			CurAvatar:addActivityRelated(relateId, "activitySpeGiftDlg")
			UIManager.getUI("activitySpeGiftDlg", true):setData(self.actObj, "activitySnowOrNightBPDlg")
		end
	end
end

function ActivitySnowOrNightBPDlg:playEffectByGroupId(unlockGroup)
	local resAchieveGroup = self.actObj.actData.clientAchieveGroup[unlockGroup] or {}

	if resAchieveGroup.big_award_flag then
		self.efxSpecialBigGift:setVisible(true)
		self.efxSpecialBigGift:playEffect()
	else
		self.efxBigGift:setVisible(true)
		self.efxBigGift:playEffect()
	end

	for idx, tabCell in pairs(self.tabCells) do
		local groupId = tabCell.resAchieveGroup.group_id

		if unlockGroup == groupId then
			tabCell:playUnlock()
		end
	end

	self.audioPanel:setVisible(true)
	self.actObj.actData:setNewUnlockGroup()
end

function ActivitySnowOrNightBPDlg:onBtnCloseClick()
	self:setVisible(false)
end

function ActivitySnowOrNightBPDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_ONCETOWER)
end

return ActivitySnowOrNightBPDlg

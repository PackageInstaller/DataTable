-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalView.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalView", package.seeall)

local LanternFestivalView = class("LanternFestivalView", BaseView)

function LanternFestivalView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._goPuzzlePicClose = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose")
	self._goPuzzlePicOpen = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicOpen")
	self._imagePuzzlePic = gohelper.findChildImage(self.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanternFestivalView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function LanternFestivalView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function LanternFestivalView:_btnCloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:closeThis()
end

function LanternFestivalView:_editableInitView()
	self._goContentRoot = gohelper.findChild(self.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	self._goClose = gohelper.findChild(self.viewGO, "Close")
	self._bgClick = gohelper.getClickWithAudio(self._goClose)
	self._mapAnimator = self._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni.enabled = true
	self._items = {}
end

function LanternFestivalView:onUpdateParam()
	return
end

function LanternFestivalView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	self:addCustomEvents()
	LanternFestivalModel.instance:setCurPuzzleId(0)
	self:refreshItems()
	self:_getRemainTimeStr()
	TaskDispatcher.runRepeat(self._getRemainTimeStr, self, 1)
end

function LanternFestivalView:addCustomEvents()
	self._bgClick:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, self._showUnlockPuzzle, self)
end

function LanternFestivalView:_getRemainTimeStr()
	local actId = ActivityEnum.Activity.LanternFestival

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

function LanternFestivalView:_showUnlockPuzzle(puzzleId)
	LanternFestivalModel.instance:setCurPuzzleId(puzzleId)
	self:refreshItems()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_spools_open)
	self._mapAnimator:Play("open", 0, 0)
end

function LanternFestivalView:refreshItems()
	local path = self.viewContainer:getSetting().otherRes[1]
	local actCos = LanternFestivalConfig.instance:getAct154Cos()

	for index, v in ipairs(actCos) do
		if not self._items[v.puzzleId] then
			local go = self:getResInst(path, self._goContentRoot)
			local item = LanternFestivalItem.New()

			item:init(go, index, v.puzzleId)

			self._items[v.puzzleId] = item
		else
			self._items[v.puzzleId]:refresh(index, v.puzzleId)
		end
	end

	local picLock = LanternFestivalModel.instance:isAllPuzzleUnSolved()

	gohelper.setActive(self._goPuzzlePicClose, picLock)
	gohelper.setActive(self._goPuzzlePicOpen, not picLock)

	local curPuzzleId = LanternFestivalModel.instance:getCurPuzzleId()
	local state = LanternFestivalModel.instance:getPuzzleState(curPuzzleId)
	local puzzleCorrect = state == LanternFestivalEnum.PuzzleState.Solved or state == LanternFestivalEnum.PuzzleState.RewardGet

	if puzzleCorrect then
		local co = LanternFestivalConfig.instance:getPuzzleCo(curPuzzleId)

		UISpriteSetMgr.instance:setV1a7LanternSprite(self._imagePuzzlePic, co.puzzleIcon)
	end

	local actCo = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.LanternFestival)

	self._txtDescr.text = actCo.actDesc
end

function LanternFestivalView:onClose()
	self._viewAni.enabled = false

	self:removeCustomEvents()
end

function LanternFestivalView:removeCustomEvents()
	self._bgClick:RemoveClickListener()
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, self._showUnlockPuzzle, self)
end

function LanternFestivalView:onDestroyView()
	TaskDispatcher.cancelTask(self._getRemainTimeStr, self)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end
	end
end

return LanternFestivalView

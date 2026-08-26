-- chunkname: @modules/logic/versionactivity1_7/lantern/view/LanternFestivalActivityView.lua

module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalActivityView", package.seeall)

local LanternFestivalActivityView = class("LanternFestivalActivityView", BaseView)

function LanternFestivalActivityView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._goPuzzlePicClose = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose")
	self._goPuzzlePicOpen = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicOpen")
	self._imagePuzzlePic = gohelper.findChildImage(self.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanternFestivalActivityView:addEvents()
	return
end

function LanternFestivalActivityView:removeEvents()
	return
end

function LanternFestivalActivityView:_editableInitView()
	self._goContentRoot = gohelper.findChild(self.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	self._mapAnimator = self._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	self._items = {}
end

function LanternFestivalActivityView:onUpdateParam()
	return
end

function LanternFestivalActivityView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	LanternFestivalModel.instance:setCurPuzzleId(0)
	self:addCustomEvents()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_task_page)
	self:refreshItems()
	self:_getRemainTimeStr()
	TaskDispatcher.runRepeat(self._getRemainTimeStr, self, 1)
end

function LanternFestivalActivityView:_getRemainTimeStr()
	local actId = ActivityEnum.Activity.LanternFestival

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

function LanternFestivalActivityView:addCustomEvents()
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, self.refreshItems, self)
	self.addEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, self._showUnlockPuzzle, self)
end

function LanternFestivalActivityView:_showUnlockPuzzle(puzzleId)
	LanternFestivalModel.instance:setCurPuzzleId(puzzleId)
	self:refreshItems()
	AudioMgr.instance:trigger(AudioEnum.LanternFestival.play_ui_jinye_spools_open)
	self._mapAnimator:Play("open", 0, 0)
end

function LanternFestivalActivityView:refreshItems()
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

function LanternFestivalActivityView:onClose()
	self:removeCustomEvents()
end

function LanternFestivalActivityView:removeCustomEvents()
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.SelectPuzzleItem, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.PuzzleRewardGet, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.InfosRefresh, self.refreshItems, self)
	self.removeEventCb(self, LanternFestivalController.instance, LanternFestivalEvent.ShowUnlockNewPuzzle, self._showUnlockPuzzle, self)
end

function LanternFestivalActivityView:onDestroyView()
	TaskDispatcher.cancelTask(self._getRemainTimeStr, self)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end
	end
end

return LanternFestivalActivityView

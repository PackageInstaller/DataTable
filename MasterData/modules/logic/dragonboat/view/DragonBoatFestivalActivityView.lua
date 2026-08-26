-- chunkname: @modules/logic/dragonboat/view/DragonBoatFestivalActivityView.lua

module("modules.logic.dragonboat.view.DragonBoatFestivalActivityView", package.seeall)

local DragonBoatFestivalActivityView = class("DragonBoatFestivalActivityView", BaseView)

function DragonBoatFestivalActivityView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Layout/image_LimitTimeBG/#txt_LimitTime")
	self._goDescr = gohelper.findChild(self.viewGO, "Root/Layout/image_Descr")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/Layout/image_Descr/#txt_Descr")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._goPuzzlePicClose = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose")
	self._goPuzzlePicBG1 = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG1")
	self._goPuzzlePicBG2 = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicBG2")
	self._goPuzzlePicFG = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicClose/#go_PuzzlePicFG")
	self._goPuzzlePicOpen = gohelper.findChild(self.viewGO, "Root/Right/#go_PuzzlePicOpen")
	self._imagePuzzlePic = gohelper.findChildImage(self.viewGO, "Root/Right/#go_PuzzlePicOpen/#image_PuzzlePic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DragonBoatFestivalActivityView:addEvents()
	return
end

function DragonBoatFestivalActivityView:removeEvents()
	return
end

function DragonBoatFestivalActivityView:_editableInitView()
	self._goContentRoot = gohelper.findChild(self.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	self._mapAnimator = self._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	self._items = {}
	self._hasClickReward = false
end

function DragonBoatFestivalActivityView:onUpdateParam()
	return
end

function DragonBoatFestivalActivityView:onOpen()
	DragonBoatFestivalModel.instance:setCurDay(nil)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:addCustomEvents()
	self._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_dragonboat_panelbg"))
	self:_refreshItems()
	self:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
	self._mapAnimator:Play("open", 0, 0)
	self:_getRemainTimeStr()
	TaskDispatcher.runRepeat(self._getRemainTimeStr, self, 1)
end

function DragonBoatFestivalActivityView:addCustomEvents()
	self.addEventCb(self, DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshFestivalItem, self)
end

function DragonBoatFestivalActivityView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self._hasClickReward = true

		self:_onSelectItem()
	end
end

function DragonBoatFestivalActivityView:_getRemainTimeStr()
	local actId = ActivityEnum.Activity.DragonBoatFestival

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

function DragonBoatFestivalActivityView:_onSelectItem()
	local day = DragonBoatFestivalModel.instance:getCurDay()
	local dayUnlock = DragonBoatFestivalModel.instance:isGiftUnlock(day)

	self._hasClickReward = true

	if not self._goPuzzlePicOpen.activeSelf then
		self:_refreshItems()
		self:_refreshMap()

		if dayUnlock then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock("mapAni")
			self._mapAnimator:Play("open", 0, 0)
			TaskDispatcher.runDelay(self._openFinished, self, 2.33)
		end
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("mapAni")

		if dayUnlock then
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			self._mapAnimator:Play("switch", 0, 0)
			TaskDispatcher.runDelay(self._switchMap, self, 0.35)
		else
			AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_mln_details_open)
			self._mapAnimator:Play("close", 0, 0)
			self:_refreshItems()
			TaskDispatcher.runDelay(self._closeFinished, self, 1)
		end
	end
end

function DragonBoatFestivalActivityView:_closeFinished()
	self:_refreshMap()
	UIBlockMgr.instance:endBlock("mapAni")
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.ShowMapFinished)
end

function DragonBoatFestivalActivityView:_switchMap()
	self:_refreshItems()
	self:_refreshMap()
	TaskDispatcher.runDelay(self._openFinished, self, 0.59)
end

function DragonBoatFestivalActivityView:_openFinished()
	UIBlockMgr.instance:endBlock("mapAni")
end

function DragonBoatFestivalActivityView:_refreshItems()
	self:_refreshFestivalItem()

	local day = DragonBoatFestivalModel.instance:getCurDay()
	local actCo = DragonBoatFestivalConfig.instance:getDragonBoatCo(day)
	local loginCount = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local maxDayGet = DragonBoatFestivalModel.instance:isGiftGet(loginCount)

	if day == loginCount and not maxDayGet then
		gohelper.setActive(self._goDescr, false)

		self._txtDescr.text = ""
	else
		gohelper.setActive(self._goDescr, true)

		self._txtDescr.text = actCo.desc
	end
end

function DragonBoatFestivalActivityView:_refreshFestivalItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local actCos = ActivityConfig.instance:getNorSignActivityCos(ActivityEnum.Activity.DragonBoatFestival)

	for _, v in ipairs(actCos) do
		if not self._items[v.id] then
			local go = self:getResInst(path, self._goContentRoot)
			local item = DragonBoatFestivalItem.New()

			item:init(go, v.id)

			self._items[v.id] = item
		else
			self._items[v.id]:refresh(v.id)
		end
	end
end

function DragonBoatFestivalActivityView:_refreshMap()
	local day = DragonBoatFestivalModel.instance:getCurDay()
	local loginCount = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local maxDayGet = DragonBoatFestivalModel.instance:isGiftGet(loginCount)
	local actCo = DragonBoatFestivalConfig.instance:getDragonBoatCo(day)
	local dayUnlock = DragonBoatFestivalModel.instance:isGiftUnlock(day)

	if day == loginCount and not maxDayGet and not self._hasClickReward then
		dayUnlock = false
	end

	gohelper.setActive(self._goPuzzlePicClose, not dayUnlock)
	gohelper.setActive(self._goPuzzlePicOpen, dayUnlock)
	UISpriteSetMgr.instance:setDragonBoatSprite(self._imagePuzzlePic, actCo.dayicon)
end

function DragonBoatFestivalActivityView:onClose()
	self:removeCustomEvents()
end

function DragonBoatFestivalActivityView:removeCustomEvents()
	self.removeEventCb(self, DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshFestivalItem, self)
end

function DragonBoatFestivalActivityView:onDestroyView()
	TaskDispatcher.cancelTask(self._getRemainTimeStr, self)
	TaskDispatcher.cancelTask(self._closeToOpen, self)
	TaskDispatcher.cancelTask(self._openFinished, self)
	TaskDispatcher.cancelTask(self._closeFinished, self)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end
	end
end

return DragonBoatFestivalActivityView

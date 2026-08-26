-- chunkname: @modules/logic/dragonboat/view/DragonBoatFestivalView.lua

module("modules.logic.dragonboat.view.DragonBoatFestivalView", package.seeall)

local DragonBoatFestivalView = class("DragonBoatFestivalView", BaseView)

function DragonBoatFestivalView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageLogo = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Logo")
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

function DragonBoatFestivalView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function DragonBoatFestivalView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function DragonBoatFestivalView:_btnCloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:closeThis()
end

function DragonBoatFestivalView:_editableInitView()
	self._goContentRoot = gohelper.findChild(self.viewGO, "Root/#scroll_ItemList/Viewport/Content")
	self._mapAnimator = self._goPuzzlePicOpen:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._viewAni.enabled = true
	self._items = {}
	self._hasClickReward = false
end

function DragonBoatFestivalView:onUpdateParam()
	return
end

function DragonBoatFestivalView:onOpen()
	DragonBoatFestivalModel.instance:setCurDay(nil)
	self:addCustomEvents()
	self._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_dragonboat_panelbg"))
	self._simageLogo:LoadImage(ResUrl.getV1a9LogoSingleBg("v1a9_logo2"))
	self:_refreshItems()
	self:_refreshMap()
	AudioMgr.instance:trigger(AudioEnum.DragonBoatFestival.play_ui_jinye_spools_open)
	self._mapAnimator:Play("open", 0, 0)
	self:_getRemainTimeStr()
	TaskDispatcher.runRepeat(self._getRemainTimeStr, self, 1)
end

function DragonBoatFestivalView:addCustomEvents()
	self.addEventCb(self, DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshFestivalItem, self)
end

function DragonBoatFestivalView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self._hasClickReward = true

		self:_onSelectItem()
	end
end

function DragonBoatFestivalView:_getRemainTimeStr()
	local actId = ActivityEnum.Activity.DragonBoatFestival

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(actId)
end

function DragonBoatFestivalView:_onSelectItem()
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

function DragonBoatFestivalView:_closeFinished()
	self:_refreshMap()
	UIBlockMgr.instance:endBlock("mapAni")
	DragonBoatFestivalController.instance:dispatchEvent(DragonBoatFestivalEvent.ShowMapFinished)
end

function DragonBoatFestivalView:_switchMap()
	self:_refreshItems()
	self:_refreshMap()
	TaskDispatcher.runDelay(self._openFinished, self, 0.59)
end

function DragonBoatFestivalView:_openFinished()
	UIBlockMgr.instance:endBlock("mapAni")
end

function DragonBoatFestivalView:_refreshItems()
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

function DragonBoatFestivalView:_refreshFestivalItem()
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

function DragonBoatFestivalView:_refreshMap()
	local day = DragonBoatFestivalModel.instance:getCurDay()
	local loginCount = DragonBoatFestivalModel.instance:getMaxUnlockDay()
	local maxDayGet = DragonBoatFestivalModel.instance:isGiftGet(loginCount)
	local dayUnlock = DragonBoatFestivalModel.instance:isGiftUnlock(day)

	if day == loginCount and not maxDayGet and not self._hasClickReward then
		dayUnlock = false
	end

	local actCo = DragonBoatFestivalConfig.instance:getDragonBoatCo(day)

	gohelper.setActive(self._goPuzzlePicClose, not dayUnlock)
	gohelper.setActive(self._goPuzzlePicOpen, dayUnlock)
	UISpriteSetMgr.instance:setDragonBoatSprite(self._imagePuzzlePic, actCo.dayicon)
end

function DragonBoatFestivalView:onClose()
	self._viewAni.enabled = false

	self:removeCustomEvents()
end

function DragonBoatFestivalView:removeCustomEvents()
	self.removeEventCb(self, DragonBoatFestivalController.instance, DragonBoatFestivalEvent.SelectItem, self._onSelectItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshFestivalItem, self)
end

function DragonBoatFestivalView:onDestroyView()
	TaskDispatcher.cancelTask(self._getRemainTimeStr, self)
	TaskDispatcher.cancelTask(self._closeToOpen, self)
	TaskDispatcher.cancelTask(self._openFinished, self)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end
	end
end

return DragonBoatFestivalView

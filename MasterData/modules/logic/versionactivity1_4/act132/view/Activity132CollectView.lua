-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectView.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectView", package.seeall)

local Activity132CollectView = class("Activity132CollectView", BaseView)

function Activity132CollectView:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "root")
	self.rootRectTransform = self.goRoot.transform
	self._goContent = gohelper.findChild(self.viewGO, "root/Scroll View/Viewport/Content")
	self._goMask2d = gohelper.findChild(self._goContent, "bg")
	self._gobg = gohelper.findChild(self._goContent, "bg/#simage_bg")
	self._simagebg = gohelper.findChildSingleImage(self._goContent, "bg/#simage_bg")
	self._simagebgfull = gohelper.findChildSingleImage(self._goContent, "bg/bgfull")
	self._bgFullCanvasGroup = gohelper.findChildComponent(self._goContent, "bg/bgfull", gohelper.Type_CanvasGroup)
	self._gobgmask = gohelper.findChild(self._goContent, "#simagebg_mask")
	self._simagebgmask = gohelper.findChildSingleImage(self._goContent, "#simagebg_mask")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "root/canvas/#simage_mask")
	self._goChapterItem = gohelper.findChild(self.viewGO, "root/canvas/line/#scroll_chapterlist/viewport/content/#go_chapteritem")
	self._goClueItem = gohelper.findChild(self._goContent, "#go_clues/#go_clueitem")
	self._goMask = gohelper.findChild(self._goContent, "#go_mask")

	gohelper.setActive(self._goChapterItem, false)

	self.chapterItemList = {}
	self.clueItemList = {}
	self.tweenDuration = 0.6
	self.goSelect = gohelper.findChild(self.viewGO, "image_select")
	self.goCanvas = gohelper.findChild(self.viewGO, "root/canvas")
	self.selectPosX, self.selectPosY, self.selectPosZ = transformhelper.getPos(self.goSelect.transform)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity132CollectView:addEvents()
	self.addEventCb(self, Activity132Controller.instance, Activity132Event.OnChangeCollect, self.onChangeCollect, self)
	self.addEventCb(self, Activity132Controller.instance, Activity132Event.OnForceClueItem, self.onForceClueItem, self)
	self.addEventCb(self, Activity132Controller.instance, Activity132Event.OnUpdateInfo, self.onUpdateInfo, self)
end

function Activity132CollectView:removeEvents()
	self.removeEventCb(self, Activity132Controller.instance, Activity132Event.OnChangeCollect, self.onChangeCollect, self)
	self.removeEventCb(self, Activity132Controller.instance, Activity132Event.OnForceClueItem, self.onForceClueItem, self)
	self.removeEventCb(self, Activity132Controller.instance, Activity132Event.OnUpdateInfo, self.onUpdateInfo, self)
end

function Activity132CollectView:_editableInitView()
	self._simagemask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_shadow.png")
	self._simagebgmask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_img_fullmask.png")
	self._simagebgfull:LoadImage("singlebg/v1a4_collect_singlebg/seasonsecretlandentrance_mask.png")
end

function Activity132CollectView:onOpen()
	self.actId = self.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(self.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.actId
	})
	self:refreshChapterList()
end

function Activity132CollectView:onUpdateInfo()
	self:refreshChapterList()
end

function Activity132CollectView:onChangeCollect()
	local actMo = Activity132Model.instance:getActMoById(self.actId)

	if not actMo then
		return
	end

	local selectId = actMo:getSelectCollectId()

	if self.chapterItemList then
		for k, v in pairs(self.chapterItemList) do
			v:setSelectId(selectId)
		end
	end

	self:setSelect(selectId)
end

function Activity132CollectView:refreshChapterList()
	local actMo = Activity132Model.instance:getActMoById(self.actId)

	if not actMo then
		return
	end

	local selectId = actMo:getSelectCollectId()
	local list = actMo:getCollectList()

	for i = 1, math.max(#list, #self.chapterItemList) do
		local item = self.chapterItemList[i]

		if not item then
			item = self:createChapterItem(i)
			self.chapterItemList[i] = item
		end

		if selectId == nil then
			selectId = list[i] and list[i].collectId
		end

		item:setData(list[i], selectId)
	end

	actMo:setSelectCollectId(selectId)
	self:setSelect(selectId)
end

function Activity132CollectView:setSelect(selectId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)

	local cfg = Activity132Config.instance:getCollectConfig(self.actId, selectId)

	if cfg then
		self._simagebg:LoadImage(cfg.bg)
	end

	self:refreshClueList(selectId)
end

function Activity132CollectView:createChapterItem(index)
	local go = gohelper.cloneInPlace(self._goChapterItem, string.format("item%s", index))

	return Activity132CollectItem.New(go)
end

function Activity132CollectView:refreshClueList(collectId)
	self.curCollectId = collectId

	local actMo = Activity132Model.instance:getActMoById(self.actId)

	if not actMo then
		return
	end

	local contentX, contentY = recthelper.getAnchor(self._goContent.transform)

	recthelper.setAnchor(self._goContent.transform, 0, 0)

	local collectMo = actMo:getCollectMo(collectId)
	local list = collectMo and collectMo:getClueList() or {}

	for i = 1, math.max(#list, #self.clueItemList) do
		local item = self.clueItemList[i]

		if not item then
			item = self:createClueItem(i)
			self.clueItemList[i] = item
		end

		item:setData(list[i])
	end

	self:refreshMask()
	recthelper.setAnchor(self._goContent.transform, contentX, contentY)
end

function Activity132CollectView:refreshMask()
	local lastMaskGo, curMaskGo

	for i, v in ipairs(self.clueItemList) do
		if v.isVisible then
			curMaskGo = v:getMask()

			if lastMaskGo then
				gohelper.addChildPosStay(lastMaskGo, curMaskGo)
			else
				gohelper.addChildPosStay(self._goMask, curMaskGo)
			end

			lastMaskGo = curMaskGo
		end
	end

	gohelper.addChild(self._goMask, self._gobgmask)
	recthelper.setAnchor(self._gobgmask.transform, 0, 0)
	transformhelper.setLocalScale(self._gobgmask.transform, 1.5, 1.5, 1)

	if lastMaskGo then
		gohelper.addChildPosStay(lastMaskGo, self._gobgmask)
	end
end

function Activity132CollectView:createClueItem(index)
	local go = gohelper.cloneInPlace(self._goClueItem, string.format("item%s", index))

	return Activity132ClueItem.New(go, index)
end

function Activity132CollectView:onForceClueItem(index)
	local item = index and self.clueItemList[index]

	self.selectIndex = index

	UIBlockMgr.instance:startBlock("Activity132CollectView")

	if item and item.data then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

		local actId = item.data.activityId
		local clueId = item.data.clueId
		local collectId = Activity132Model.instance:getSelectCollectId(actId)

		ViewMgr.instance:openView(ViewName.Activity132CollectDetailView, {
			actId = actId,
			clueId = clueId,
			collectId = collectId
		})

		local posX, posY, posZ = item:getPos()
		local movePosX = self.selectPosX - posX * 2
		local movePosY = self.selectPosY - posY * 2
		local movePosZ = self.selectPosZ - posZ * 2

		self:playMoveTween(movePosX, movePosY, movePosZ)
		self:playScaleTween(2)
		self:playDoFade(0, 0.2)
		self:playBgFullFade(1)
	else
		self:playScaleTween(1)
		self:playMoveTween()
		self:playDoFade(1, 0.1)
		self:playBgFullFade(0)
	end
end

function Activity132CollectView:playScaleTween(to)
	if self._scaleTweenId then
		ZProj.TweenHelper.KillById(self._scaleTweenId)

		self._scaleTweenId = nil
	end

	self._scaleTweenId = ZProj.TweenHelper.DOScale(self.rootRectTransform, to, to, to, self.tweenDuration, self.onTweenFinish, self, nil, EaseType.OutQuart)
end

function Activity132CollectView:onTweenFinish()
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function Activity132CollectView:playMoveTween(x, y, z)
	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if x and y and z then
		local contentX = recthelper.getAnchorX(self._goContent.transform)
		local pos = recthelper.rectToRelativeAnchorPos(Vector3.New(x, y, z), self.viewGO.transform)
		local posX = pos.x - contentX * 2
		local posY = pos.y

		self._moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.rootRectTransform, posX, posY, self.tweenDuration, nil, nil, nil, EaseType.OutQuart)
	else
		self._moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.rootRectTransform, 0, 0, self.tweenDuration, nil, nil, nil, EaseType.OutQuart)
	end
end

function Activity132CollectView:playDoFade(endAlpha, time)
	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	local canvasGroup = self.goCanvas:GetComponent(typeof(UnityEngine.CanvasGroup))
	local startAlpha = canvasGroup.alpha

	self._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(self.goCanvas, startAlpha, endAlpha, time, nil, nil, nil, EaseType.OutQuart)

	for i, v in ipairs(self.clueItemList) do
		if self.selectIndex then
			v:resetMask()
			v:setActive(i == self.selectIndex)
			v:setRootVisible(false)
		else
			v:resetMask()
			v:setActive(v.data ~= nil)
			v:setRootVisible(true)
		end
	end

	self:refreshMask()
end

function Activity132CollectView:playBgFullFade(endAlpha)
	if self._fadeTweenId1 then
		ZProj.TweenHelper.KillById(self._fadeTweenId1)

		self._fadeTweenId1 = nil
	end

	local startAlpha = self._bgFullCanvasGroup.alpha

	self._fadeTweenId1 = ZProj.TweenHelper.DOFadeCanvasGroup(self._bgFullCanvasGroup.gameObject, startAlpha, endAlpha, self.tweenDuration, nil, nil, nil, EaseType.OutQuart)
end

function Activity132CollectView:onClose()
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function Activity132CollectView:onDestroyView()
	Activity132Model.instance:setSelectCollectId(self.actId)
	self._simagebg:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simagebgfull:UnLoadImage()

	if self.chapterItemList then
		for k, v in pairs(self.chapterItemList) do
			v:destroy()
		end

		self.chapterItemList = nil
	end

	if self.clueItemList then
		for k, v in pairs(self.clueItemList) do
			v:destroy()
		end

		self.clueItemList = nil
	end

	if self._scaleTweenId then
		ZProj.TweenHelper.KillById(self._scaleTweenId)

		self._scaleTweenId = nil
	end

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	if self._fadeTweenId1 then
		ZProj.TweenHelper.KillById(self._fadeTweenId1)

		self._fadeTweenId1 = nil
	end
end

return Activity132CollectView

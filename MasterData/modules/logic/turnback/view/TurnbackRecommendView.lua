-- chunkname: @modules/logic/turnback/view/TurnbackRecommendView.lua

module("modules.logic.turnback.view.TurnbackRecommendView", package.seeall)

local TurnbackRecommendView = class("TurnbackRecommendView", BaseView)

function TurnbackRecommendView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._gobanner = gohelper.findChild(self.viewGO, "#go_banner")
	self._gobannercontent = gohelper.findChild(self.viewGO, "#go_banner/#go_bannercontent")
	self._gobannerIcon = gohelper.findChild(self.viewGO, "#go_banner/#go_bannercontent/#go_bannerIcon")
	self._goslider = gohelper.findChild(self.viewGO, "#go_banner/#go_slider")
	self._goindexItem = gohelper.findChild(self.viewGO, "#go_banner/#go_slider/#go_indexItem")
	self._gobannerscroll = gohelper.findChild(self.viewGO, "#go_banner/#go_bannerscroll")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._btnleftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_leftArrow")
	self._btnrightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rightArrow")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackRecommendView:addEvents()
	self._btnbanner:AddClickListener(self._btnjumpOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnleftArrow:AddClickListener(self._btnleftArrowOnClick, self)
	self._btnrightArrow:AddClickListener(self._btnrightArrowOnClick, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyResetData, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self.dailyResetData, self)
end

function TurnbackRecommendView:removeEvents()
	self._btnbanner:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btnleftArrow:RemoveClickListener()
	self._btnrightArrow:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyResetData, self)
	self.removeEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self.dailyResetData, self)
end

TurnbackRecommendView.bannerWidth = 1332
TurnbackRecommendView.moveDistance = 100

function TurnbackRecommendView:_btnjumpOnClick()
	if self.scrollStartPos then
		return
	end

	local param = {
		config = self.bannerConfigTab[self.targetIndex]
	}

	self:onBannerClick(param)
end

function TurnbackRecommendView:_btnleftArrowOnClick()
	if self.configCount == 1 then
		return
	end

	self:slidePre()
	self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function TurnbackRecommendView:_btnrightArrowOnClick()
	if self.configCount == 1 then
		return
	end

	self:slideNext()
	self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function TurnbackRecommendView:slideNext()
	if self.configCount == 1 then
		return
	end

	self.targetIndex = self.targetIndex >= self.configCount and 1 or self.targetIndex + 1

	self:setBannerPos(true)
	self:autoMoveBanner()
end

function TurnbackRecommendView:slidePre()
	if self.configCount == 1 then
		return
	end

	self.targetIndex = self.targetIndex <= 1 and self.configCount or self.targetIndex - 1

	self:setBannerPos(false)
	self:autoMoveBanner()
end

function TurnbackRecommendView:_onScrollDragBegin(param, eventData)
	self.scrollStartPos = eventData.position
end

function TurnbackRecommendView:_onScrollDragEnd(param, eventData)
	local moveOffset = eventData.position - self.scrollStartPos
	local canMove = Mathf.Abs(moveOffset.x) - TurnbackRecommendView.moveDistance >= 0

	if moveOffset.x > 0 and canMove then
		self:slidePre()
		self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	elseif moveOffset.x < 0 and canMove then
		self:slideNext()
		self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	end

	self.scrollStartPos = nil

	self:autoMoveBanner()
end

function TurnbackRecommendView:_editableInitView()
	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRecommendModel.instance:initReommendShowState(self.turnbackId)

	self.bannerConfigTab = {}
	self.indexItemTab = self:getUserDataTb_()
	self.bannerTab = self:getUserDataTb_()

	gohelper.setActive(self._gobannerIcon, false)
	gohelper.setActive(self._goindexItem, false)

	self.targetIndex = 1
	self.configCount = 0
	self.layoutGroup = self._gobannercontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self.bannerContentTrans = self._gobannercontent:GetComponent(gohelper.Type_RectTransform)
	self._btnbanner = gohelper.getClickWithAudio(self._gobannerscroll)
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._gobannerscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)

	self.isMoving = false
end

function TurnbackRecommendView:onUpdateParam()
	return
end

function TurnbackRecommendView:onOpen()
	local parentGO = self.viewParam.parent

	self.actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
	self:refreshUI()
	self:initBannerItem()
	self:autoMoveBanner()
end

function TurnbackRecommendView:refreshUI()
	self:creatAndRefreshIndexItem()

	local actConfig = TurnbackConfig.instance:getTurnbackSubModuleCo(self.actId)

	self._txtdesc.text = actConfig.actDesc

	self:refreshIndexItem()
	gohelper.setActive(self._btnleftArrow.gameObject, self.configCount > 1)
	gohelper.setActive(self._btnrightArrow.gameObject, self.configCount > 1)
end

function TurnbackRecommendView:initBannerItem()
	if GameUtil.getTabLen(self.bannerConfigTab) == 0 then
		return
	end

	for i = 1, 2 do
		local bannerItem = self.bannerTab[i]

		if not bannerItem then
			bannerItem = {
				go = gohelper.clone(self._gobannerIcon, self._gobannercontent, "banner" .. i)
			}
			bannerItem.simage = gohelper.findChildSingleImage(bannerItem.go, "simage_bannerIcon")
			bannerItem.trans = bannerItem.go:GetComponent(gohelper.Type_RectTransform)

			gohelper.setActive(bannerItem.go, true)

			self.bannerTab[i] = bannerItem
		end
	end

	self.mainBanner = self.bannerTab[1]
	self.helpBanner = self.bannerTab[2]
	self.centerBannerPosX = 0
	self.leftBannerPosX = -(TurnbackRecommendView.bannerWidth + self.layoutGroup.spacing)
	self.rightBannerPosX = TurnbackRecommendView.bannerWidth + self.layoutGroup.spacing

	recthelper.setAnchorX(self.mainBanner.trans, self.centerBannerPosX)
	recthelper.setAnchorX(self.helpBanner.trans, self.rightBannerPosX)
	self.mainBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(self.bannerConfigTab[self.targetIndex].icon)))
	self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.First)
end

function TurnbackRecommendView:creatAndRefreshIndexItem()
	local canShowRecommends = TurnbackRecommendModel.instance:getCanShowRecommendList() or {}
	local limitCount = TurnbackConfig.instance:getAllRecommendList(self.turnbackId)[1].limitCount

	self.configCount = Mathf.Min(limitCount, #canShowRecommends)

	table.sort(canShowRecommends, TurnbackRecommendView.sortRecommend)

	for i = 1, self.configCount do
		self.bannerConfigTab[i] = canShowRecommends[i]

		local indexItem = self.indexItemTab[i]

		if not indexItem then
			indexItem = {
				go = gohelper.clone(self._goindexItem, self._goslider, "index" .. i)
			}
			indexItem.nomalstar = gohelper.findChild(indexItem.go, "go_nomalstar")
			indexItem.lightstar = gohelper.findChild(indexItem.go, "go_lightstar")
			self.indexItemTab[i] = indexItem
		end

		gohelper.setActive(indexItem.go, true)
	end

	for i = self.configCount + 1, #self.indexItemTab do
		gohelper.setActive(self.indexItemTab[i].go, false)
	end
end

function TurnbackRecommendView:onBannerClick(param)
	if param.config and param.config.jumpId > 0 then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Return,
			[StatEnum.EventProperties.RecommendPageId] = tostring(param.config.id),
			[StatEnum.EventProperties.RecommendPageName] = ""
		})
		GameFacade.jump(param.config.jumpId)
	end
end

function TurnbackRecommendView.sortRecommend(a, b)
	return a.order < b.order
end

function TurnbackRecommendView:autoMoveBanner()
	TaskDispatcher.cancelTask(self.autoSwitch, self)
	TaskDispatcher.runRepeat(self.autoSwitch, self, 5)
end

function TurnbackRecommendView:autoSwitch()
	self:slideNext()

	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Auto)
	end
end

function TurnbackRecommendView:setBannerPos(isShowNext)
	if GameUtil.getTabLen(self.bannerConfigTab) == 0 or self.configCount <= 1 then
		return
	end

	recthelper.setAnchorX(self.mainBanner.trans, self.centerBannerPosX)

	local targetConfig = self.bannerConfigTab[self.targetIndex]

	self:refreshIndexItem()

	if self.isMoving then
		self:killMoveTween()
		self:changeBanner()
		recthelper.setAnchorX(self.mainBanner.trans, self.centerBannerPosX)
		recthelper.setAnchorX(self.helpBanner.trans, (isShowNext or nil) and (self.rightBannerPosX or self.leftBannerPosX))
	end

	self.helpBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(targetConfig.icon)))
	recthelper.setAnchorX(self.helpBanner.trans, (isShowNext or nil) and (self.rightBannerPosX or self.leftBannerPosX))

	self.helpBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(self.helpBanner.trans, self.centerBannerPosX, 0.5, self.changeBanner, self)
	self.mainBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(self.mainBanner.trans, (isShowNext or nil) and (self.leftBannerPosX or self.rightBannerPosX), 0.5)
	self.isMoving = true
end

function TurnbackRecommendView:refreshIndexItem()
	for index, item in ipairs(self.indexItemTab) do
		gohelper.setActive(item.nomalstar, index ~= self.targetIndex)
		gohelper.setActive(item.lightstar, index == self.targetIndex)
	end

	local targetConfig = self.bannerConfigTab[self.targetIndex]

	gohelper.setActive(self._btnjump.gameObject, targetConfig and targetConfig.jumpId > 0)
end

function TurnbackRecommendView:changeBanner()
	self.mainBanner, self.helpBanner = self.helpBanner, self.mainBanner
	self.isMoving = false
end

function TurnbackRecommendView:dailyResetData()
	self.targetIndex = 1

	TurnbackRecommendModel.instance:initReommendShowState(self.turnbackId)
	self:refreshUI()
	self:initBannerItem()
	self:setBannerPos(true)
	self:autoMoveBanner()
end

function TurnbackRecommendView:killMoveTween()
	if self.mainBannerMoveTweenId then
		ZProj.TweenHelper.KillById(self.mainBannerMoveTweenId)
	end

	if self.helpBannerMoveTweenId then
		ZProj.TweenHelper.KillById(self.helpBannerMoveTweenId)
	end
end

function TurnbackRecommendView:onClose()
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	TaskDispatcher.cancelTask(self.autoSwitch, self)
end

function TurnbackRecommendView:onDestroyView()
	for _, v in pairs(self.bannerTab) do
		v.simage:UnLoadImage()
	end

	self:killMoveTween()
end

function TurnbackRecommendView:statRecommendPage(type, dragType)
	local targetConfig = self.bannerConfigTab[self.targetIndex]

	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = type,
		[StatEnum.EventProperties.ShowType] = dragType,
		[StatEnum.EventProperties.RecommendPageId] = tostring(targetConfig.id)
	})
end

return TurnbackRecommendView

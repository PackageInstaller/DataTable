-- chunkname: @modules/logic/main/view/MainThumbnailRecommendView.lua

module("modules.logic.main.view.MainThumbnailRecommendView", package.seeall)

local MainThumbnailRecommendView = class("MainThumbnailRecommendView", BaseView)

function MainThumbnailRecommendView:onInitView()
	self._goslider = gohelper.findChild(self.viewGO, "#go_banner/#go_slider")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_banner/#go_bannercontent")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_banner/#go_bannerscroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainThumbnailRecommendView:addEvents()
	return
end

function MainThumbnailRecommendView:removeEvents()
	return
end

function MainThumbnailRecommendView:_editableInitView()
	self._selectItems = {}
	self._helpItems = {}

	local parentWidth = recthelper.getWidth(self.viewGO.transform)

	self._space = 670
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)

	self._viewClick = gohelper.getClick(self._goscroll)

	self._viewClick:AddClickListener(self._onClickView, self)
end

function MainThumbnailRecommendView:_onScrollDragBegin(param, eventData)
	self._scrollStartPos = eventData.position
end

function MainThumbnailRecommendView:_onScrollDragEnd(param, eventData)
	if not self._scrollStartPos then
		return
	end

	local scrollEndPos = eventData.position
	local deltaX = scrollEndPos.x - self._scrollStartPos.x
	local deltaY = scrollEndPos.y - self._scrollStartPos.y

	self._scrollStartPos = nil

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	local targetPageIndex = self:getTargetPageIndex()
	local showRight = targetPageIndex <= #self._pagesCo
	local showLeft = targetPageIndex >= 1

	if deltaX > 100 and showLeft then
		self:setTargetPageIndex(targetPageIndex - 1, targetPageIndex)
		self:_updateSelectedItem()
		self:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	elseif deltaX < -100 and showRight then
		self:setTargetPageIndex(targetPageIndex + 1, targetPageIndex)
		self:_updateSelectedItem()
		self:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Manual)
	end

	self:_startAutoSwitch()
end

function MainThumbnailRecommendView:statRecommendPage(type, dragType)
	local pageCo = self._pagesCo[self:getTargetPageIndex()]

	if not pageCo then
		return
	end

	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = type,
		[StatEnum.EventProperties.ShowType] = dragType,
		[StatEnum.EventProperties.RecommendPageId] = tostring(pageCo.id)
	})
end

function MainThumbnailRecommendView:_startAutoSwitch()
	TaskDispatcher.cancelTask(self._onSwitch, self)
	TaskDispatcher.runRepeat(self._onSwitch, self, 5)
end

function MainThumbnailRecommendView:_onSwitch()
	if #self._pagesCo <= 1 then
		TaskDispatcher.cancelTask(self._onSwitch, self)

		return
	end

	local targetPageIndex = self:getTargetPageIndex()

	self:setTargetPageIndex(targetPageIndex + 1, targetPageIndex)
	self:_updateSelectedItem()

	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.Auto)
	end
end

function MainThumbnailRecommendView:setTargetPageIndex(index, prevIndex)
	self._targetPageIndex = index
	self._prevTargetPageIndex = prevIndex
end

function MainThumbnailRecommendView:getTargetPageIndex()
	if self._targetPageIndex < 1 then
		return #self._pagesCo
	end

	if self._targetPageIndex > #self._pagesCo then
		return 1
	end

	return self._targetPageIndex
end

function MainThumbnailRecommendView:_onClickView()
	if self._scrollStartPos then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_jump)

	local pageCfg = self._pagesCo[self:getTargetPageIndex()]

	if pageCfg and string.nilorempty(pageCfg.systemJumpCode) == false then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Main,
			[StatEnum.EventProperties.RecommendPageId] = tostring(pageCfg.id),
			[StatEnum.EventProperties.RecommendPageName] = pageCfg.name,
			[StatEnum.EventProperties.RecommendPageRank] = self:getTargetPageIndex()
		})
		GameFacade.jumpByAdditionParam(pageCfg.systemJumpCode)
	end
end

function MainThumbnailRecommendView:onUpdateParam()
	return
end

function MainThumbnailRecommendView:_checkExpire()
	local num = 0

	for i, v in ipairs(lua_store_recommend.configList) do
		if v.type == 1 and self:_inOpenTime(v) and self:_checkRelations(v.relations) then
			local jumpId = string.splitToNumber(v.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(v.systemJumpCode) or JumpConfig.instance:isOpenJumpId(jumpId) then
				num = num + 1
			end
		end
	end

	if num ~= self._totalPageCount then
		self:_clearPages()
		self:_initPages()
	end
end

function MainThumbnailRecommendView:_startCheckExpire()
	TaskDispatcher.cancelTask(self._checkExpire, self)
	TaskDispatcher.runRepeat(self._checkExpire, self, 1)
end

function MainThumbnailRecommendView:onOpen()
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._checkExpire, self)

	local relationStoreIdsDic = self:_initPages(true)

	if tabletool.len(relationStoreIdsDic) > 0 then
		local storeIds = {}

		for i, v in pairs(relationStoreIdsDic) do
			table.insert(storeIds, i)
		end

		StoreRpc.instance:sendGetStoreInfosRequest(storeIds)
	end
end

function MainThumbnailRecommendView:_initPages(checkRequest)
	recthelper.setAnchorX(self._gocontent.transform, 0)

	local tempPageCfgs = {}

	self._pagesCo = {}
	self._totalPageCount = 0

	local relationStoreIdsDic = {}
	local SummonPools = SummonMainModel.getValidPools()

	self._openSummonPoolDic = {}

	for i, v in ipairs(SummonPools) do
		self._openSummonPoolDic[v.id] = v
	end

	for i, v in ipairs(lua_store_recommend.configList) do
		local pass, _, storeIdsDic = self:_checkRelations(v.relations, nil, checkRequest)

		if v.type == 1 and self:_inOpenTime(v) and pass then
			local jumpId = string.splitToNumber(v.systemJumpCode, "#")[1]

			if VersionValidator.instance:isInReviewing() ~= true or string.nilorempty(v.systemJumpCode) or JumpConfig.instance:isOpenJumpId(jumpId) then
				table.insert(tempPageCfgs, v)

				self._totalPageCount = self._totalPageCount + 1
			end
		end

		if storeIdsDic then
			for storeId, _ in pairs(storeIdsDic) do
				relationStoreIdsDic[storeId] = true
			end
		end
	end

	local pageCount = CommonConfig.instance:getConstNum(ConstEnum.MainThumbnailRecommendItemCount) or 14

	self:sortPage(tempPageCfgs)

	for i = 1, pageCount do
		if tempPageCfgs[i] then
			self._pagesCo[#self._pagesCo + 1] = tempPageCfgs[i]
		end
	end

	local index = self:_getEnterPageIndex()

	self:setTargetPageIndex(index)
	self:setSelectItem()
	self:setContentItem()
	self:_startAutoSwitch()
	self:_startCheckExpire()
	self:_updateSelectedItem()
	self:statRecommendPage(StatEnum.RecommendType.Main, StatEnum.DragType.First)

	return relationStoreIdsDic
end

function MainThumbnailRecommendView._sort(a, b)
	return a.order < b.order
end

function MainThumbnailRecommendView:sortPage(tempConfigs)
	self:_cacheConfigGroupData(tempConfigs)
	table.sort(tempConfigs, function(a, b)
		return self:_tabSortGroupFunction(a, b)
	end)

	self._cacheConfigGroupDic = {}
	self._cacheConfigOrderDic = {}
end

function MainThumbnailRecommendView:_cacheConfigGroupData(list)
	self._cacheConfigGroupDic = {}
	self._cacheConfigOrderDic = {}

	if not list or #list <= 0 then
		return
	end

	for _, co in ipairs(list) do
		local group, order = StoreHelper.getRecommendStoreGroupAndOrder(co, false)

		self._cacheConfigGroupDic[co.id] = group
		self._cacheConfigOrderDic[co.id] = order
	end
end

function MainThumbnailRecommendView:_tabSortGroupFunction(xConfig, yConfig)
	local groupX = self._cacheConfigGroupDic[xConfig.id]
	local groupY = self._cacheConfigGroupDic[yConfig.id]

	if groupX == groupY then
		local orderX = self._cacheConfigOrderDic[xConfig.id]
		local orderY = self._cacheConfigOrderDic[yConfig.id]

		return orderX < orderY
	end

	return groupX < groupY
end

function MainThumbnailRecommendView:_checkRelations(relations, openSummonPoolDic, checkRequest)
	local arr = GameUtil.splitString2(relations, true)
	local needPackageInfo = false
	local show = false
	local relationStoreIdsDic

	if checkRequest then
		relationStoreIdsDic = {}
	end

	if string.nilorempty(relations) == false and arr and #arr > 0 then
		for i, v in ipairs(arr) do
			local pass = true
			local relationType = v[1]
			local relationId = v[2]

			if relationType == StoreEnum.RecommendRelationType.Summon then
				if self._openSummonPoolDic[relationId] == nil then
					pass = false
				end
			elseif relationType == StoreEnum.RecommendRelationType.PackageStoreGoods then
				local storePackageGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				pass = (storePackageGoodsMO == nil or storePackageGoodsMO:isSoldOut()) and false
				needPackageInfo = true
			elseif relationType == StoreEnum.RecommendRelationType.StoreGoods then
				local storeGoodsMO = StoreModel.instance:getGoodsMO(relationId)

				pass = (storeGoodsMO == nil or storeGoodsMO:isSoldOut() or storeGoodsMO:alreadyHas()) and false

				if checkRequest then
					local goodsConfig = StoreConfig.instance:getGoodsConfig(relationId)

					if goodsConfig then
						relationStoreIdsDic[goodsConfig.storeId] = true
					end
				end
			elseif relationType == StoreEnum.RecommendRelationType.OtherRecommendClose then
				local co = StoreConfig.instance:getStoreRecommendConfig(relationId)

				if co.type == 1 and self:_inOpenTime(co) and self:_checkRelations(co.relations) then
					pass = false
				end
			end

			show = show or pass
		end
	else
		show = true
	end

	return show, needPackageInfo, relationStoreIdsDic
end

function MainThumbnailRecommendView:_inOpenTime(co)
	local serverTime = ServerTime.now()
	local openTime = string.nilorempty(co.onlineTime) and serverTime or TimeUtil.stringToTimestamp(co.onlineTime) - ServerTime.clientToServerOffset()
	local endTime = string.nilorempty(co.offlineTime) and serverTime or TimeUtil.stringToTimestamp(co.offlineTime) - ServerTime.clientToServerOffset()

	return co.isOffline == 0 and openTime <= serverTime and serverTime <= endTime
end

function MainThumbnailRecommendView:onOpenFinish()
	return
end

function MainThumbnailRecommendView:setSelectItem()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #self._pagesCo do
		local child = self:getResInst(path, self._goslider)
		local selectItem = MainThumbnailBannerSelectItem.New()

		selectItem:init({
			go = child,
			index = i,
			config = self._pagesCo[i],
			pos = self:_getPos(i)
		})
		selectItem:updateItem(self:getTargetPageIndex(), #self._pagesCo)
		table.insert(self._selectItems, selectItem)
	end
end

function MainThumbnailRecommendView:_getPos(index)
	return 55 * (index - 0.5 * (#self._pagesCo + 1))
end

function MainThumbnailRecommendView:setContentItem()
	local path = self.viewContainer:getSetting().otherRes[2]

	for i = 1, #self._pagesCo do
		local child = self:getResInst(path, self._gocontent)
		local conItem = MainThumbnailBannerContent.New()

		conItem:init({
			go = child,
			index = i,
			config = self._pagesCo[i],
			pos = self:_getContentPos(-1)
		})
		conItem:updateItem()
		table.insert(self._helpItems, conItem)
	end
end

function MainThumbnailRecommendView:_getContentPos(index)
	return self._space * (index - 1)
end

function MainThumbnailRecommendView:_updateSelectedItem()
	for _, v in pairs(self._selectItems) do
		v:updateItem(self:getTargetPageIndex(), #self._pagesCo)
	end

	for i, v in ipairs(self._helpItems) do
		v:updateItem(self:getTargetPageIndex())
	end

	if not self._prevTargetPageIndex then
		self:_updateContentPos(self:getTargetPageIndex(), self:getTargetPageIndex(), true)

		return
	end

	self:_updateContentPos(self._prevTargetPageIndex, self._prevTargetPageIndex, true)
	self:_updateContentPos(self:getTargetPageIndex(), self._targetPageIndex, false)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local x = (1 - self._targetPageIndex) * self._space

	self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, x, 0.75, self._tweenPosFinish, self)
end

function MainThumbnailRecommendView:_updateContentPos(contentItemIndex, posIndex, focusContent)
	local content = self._helpItems[contentItemIndex]

	if not content then
		return
	end

	recthelper.setAnchorX(content._go.transform, self:_getContentPos(posIndex))

	if not focusContent then
		return
	end

	local curX = (1 - posIndex) * self._space

	recthelper.setAnchorX(self._gocontent.transform, curX)
end

function MainThumbnailRecommendView:_tweenPosFinish()
	return
end

function MainThumbnailRecommendView:_getEnterPageIndex()
	local str = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.MainThumbnailRecommendViewIndex, "")

	if string.nilorempty(str) then
		return 1
	else
		local split = string.split(str, "#")
		local version = split[1]
		local index = tonumber(split[2])

		if version ~= GameBranchMgr.instance:VHyphenA() then
			return 1
		elseif index >= #self._pagesCo then
			return 1
		else
			return index + 1
		end
	end
end

function MainThumbnailRecommendView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._initPages, self)

	local str = GameBranchMgr.instance:VHyphenA() .. "#" .. self._targetPageIndex

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.MainThumbnailRecommendViewIndex, str)
end

function MainThumbnailRecommendView:_clearPages()
	if self._selectItems then
		for _, v in pairs(self._selectItems) do
			v:destroy()
		end

		self._selectItems = {}
	end

	if self._helpItems then
		for _, v in pairs(self._helpItems) do
			v:destroy()
		end

		self._helpItems = {}
	end

	gohelper.destroyAllChildren(self._goslider)
	gohelper.destroyAllChildren(self._gocontent)
end

function MainThumbnailRecommendView:onDestroyView()
	self:_clearPages()
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	self._viewClick:RemoveClickListener()
	TaskDispatcher.cancelTask(self._onSwitch, self)
	TaskDispatcher.cancelTask(self._checkExpire, self)
end

return MainThumbnailRecommendView

-- chunkname: @modules/logic/activity/view/Activity101SignViewBaseContainer.lua

module("modules.logic.activity.view.Activity101SignViewBaseContainer", package.seeall)

local Activity101SignViewBaseContainer = class("Activity101SignViewBaseContainer", BaseViewContainer)

function Activity101SignViewBaseContainer:actId()
	return self.viewParam.actId
end

function Activity101SignViewBaseContainer:_getScrollView()
	local classType = self:onGetListScrollModelClassType()
	local scrollModel = classType.New()
	local listScrollParam = ListScrollParam.New()

	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	listScrollParam.scrollDir = ScrollEnum.ScrollDirH
	listScrollParam.sortMode = ScrollEnum.ScrollSortDown
	listScrollParam.lineCount = 1
	listScrollParam.cellSpaceV = 0
	listScrollParam.startSpace = 0
	listScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	listScrollParam.rectMaskSoftness = {
		0,
		0
	}

	self:onModifyListScrollParam(listScrollParam)
	assert(listScrollParam.cellClass)
	assert(listScrollParam.scrollGOPath)
	assert(listScrollParam.prefabUrl)

	return scrollModel, listScrollParam
end

function Activity101SignViewBaseContainer:_createMainView()
	local classType = self:onGetMainViewClassType()

	if classType then
		return classType.New()
	end
end

function Activity101SignViewBaseContainer:buildViews()
	local scrollModel, listScrollParam = self:_getScrollView()

	self.__scrollModel = scrollModel
	self.__listScrollParam = listScrollParam
	self.__mainView = self:_createMainView()

	return self:onBuildViews()
end

function Activity101SignViewBaseContainer:onContainerInit()
	Activity101SignViewBaseContainer.super.onContainerInit(self)

	local scrollRect = self:getScrollRect()
	local rectTransform = scrollRect:GetComponent(gohelper.Type_RectTransform)

	self.__scrollContentTrans = scrollRect.content
	self.__scrollContentGo = self.__scrollContentTrans.gameObject
	self.__viewPortHeight = recthelper.getHeight(rectTransform)
	self.__viewPortWidth = recthelper.getWidth(rectTransform)
	self.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function Activity101SignViewBaseContainer:onContainerClose()
	Activity101SignViewBaseContainer.super.onContainerClose(self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)

	self.__onceGotRewardFetch101Infos = false
end

function Activity101SignViewBaseContainer:getScrollModel()
	return self.__scrollModel
end

function Activity101SignViewBaseContainer:getScrollView()
	return self.__scrollView
end

function Activity101SignViewBaseContainer:getMainView()
	return self.__mainView
end

function Activity101SignViewBaseContainer:isLimitedScrollView()
	return self.__scrollView ~= nil
end

function Activity101SignViewBaseContainer:getCsListScroll()
	if not self:isLimitedScrollView() then
		local scrollRect = self:getScrollRect()

		if not scrollRect then
			return nil
		end

		local go = scrollRect.gameObject

		if gohelper.isNil(go) then
			return nil
		end

		return go:GetComponent(gohelper.Type_LimitedScrollRect)
	end

	local scrollView = self:getScrollView()

	return scrollView:getCsListScroll()
end

function Activity101SignViewBaseContainer:getScrollRect()
	if self.__scrollRect then
		return self.__scrollRect
	end

	local ret

	if self:isLimitedScrollView() then
		local csListView = self:getCsListScroll()

		ret = csListView:GetComponent(gohelper.Type_ScrollRect)
	else
		local mainView = self:getMainView()
		local viewGO = mainView.viewGO
		local listScrollParam = self:getListScrollParam()

		ret = gohelper.findChildScrollRect(viewGO, listScrollParam.scrollGOPath)
	end

	self.__scrollRect = ret

	return ret
end

function Activity101SignViewBaseContainer:getScrollContentTranform()
	return self.__scrollContentTrans
end

function Activity101SignViewBaseContainer:getListScrollParam()
	return self.__listScrollParam
end

function Activity101SignViewBaseContainer:getViewportWH()
	return self.__viewPortWidth, self.__viewPortHeight
end

function Activity101SignViewBaseContainer:getScrollContentGo()
	return self.__scrollContentGo
end

function Activity101SignViewBaseContainer:createItemInst()
	local listScrollParam = self:getListScrollParam()
	local itemClass = listScrollParam.cellClass
	local itemUrl = listScrollParam.prefabUrl
	local parentGo = self:getScrollContentGo()
	local go = self:getResInst(itemUrl, parentGo, itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
end

function Activity101SignViewBaseContainer:onGetListScrollModelClassType()
	return Activity101SignViewListModelBase
end

function Activity101SignViewBaseContainer:onGetMainViewClassType()
	assert(false, "please overeide this function!")
end

function Activity101SignViewBaseContainer:onModifyListScrollParam(refListScrollParam)
	assert(false, "please overeide this function!")
end

function Activity101SignViewBaseContainer:onBuildViews()
	local scrollModel, listScrollParam = self:_getScrollView()

	self.__scrollView = LuaListScrollView.New(scrollModel, listScrollParam)

	return {
		self.__scrollView,
		self.__mainView
	}
end

function Activity101SignViewBaseContainer:setOnceGotRewardFetch101Infos(bool)
	self.__onceGotRewardFetch101Infos = not not bool
end

function Activity101SignViewBaseContainer:_onRefreshNorSignActivity()
	if self.__onceGotRewardFetch101Infos then
		Activity101Rpc.instance:sendGet101InfosRequest(self:actId())

		self.__onceGotRewardFetch101Infos = false
	end
end

local kPrefix = "Activity101|"

function Activity101SignViewBaseContainer:getPrefsKeyPrefix()
	return kPrefix .. tostring(self:actId())
end

function Activity101SignViewBaseContainer:saveInt(key, value)
	GameUtil.playerPrefsSetNumberByUserId(key, value)
end

function Activity101SignViewBaseContainer:getInt(key, defaultValue)
	return GameUtil.playerPrefsGetNumberByUserId(key, defaultValue)
end

function Activity101SignViewBaseContainer:getMoonFestivalSignMaxDay()
	return ActivityType101Config.instance:getMoonFestivalSignMaxDay(self:actId())
end

function Activity101SignViewBaseContainer:getType101LoginCount()
	return ActivityType101Model.instance:getType101LoginCount(self:actId())
end

function Activity101SignViewBaseContainer:getLastGetIndex()
	return ActivityType101Model.instance:getLastGetIndex(self:actId())
end

function Activity101SignViewBaseContainer:isType101RewardCouldGetAnyOne()
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(self:actId())
end

function Activity101SignViewBaseContainer:isType101RewardCouldGet(index)
	return ActivityType101Model.instance:isType101RewardCouldGet(self:actId(), index)
end

function Activity101SignViewBaseContainer:isType101RewardGet(index)
	return ActivityType101Model.instance:isType101RewardGet(self:actId(), index)
end

function Activity101SignViewBaseContainer:getFirstAvailableIndex()
	return ActivityType101Model.instance:getFirstAvailableIndex(self:actId())
end

return Activity101SignViewBaseContainer

-- chunkname: @modules/logic/activity/view/Activity101SignViewBase.lua

module("modules.logic.activity.view.Activity101SignViewBase", package.seeall)

local Activity101SignViewBase = class("Activity101SignViewBase", BaseView)

Activity101SignViewBase.eOpenMode = {
	PaiLian = 2,
	ActivityBeginnerView = 1
}

function Activity101SignViewBase:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function Activity101SignViewBase:removeEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function Activity101SignViewBase:internal_set_actId(actId)
	self._actId = actId
end

function Activity101SignViewBase:internal_set_openMode(eOpenMode)
	self._eOpenMode = eOpenMode
end

function Activity101SignViewBase:actId()
	return assert(self._actId, "please call self:internal_set_actId(actId) first")
end

function Activity101SignViewBase:openMode()
	return assert(self._eOpenMode, "please call self:internal_set_openMode(eOpenMode) first")
end

function Activity101SignViewBase:actCO()
	local actId = self:actId()

	return lua_activity.configDict[actId]
end

function Activity101SignViewBase:internal_onOpen()
	local M = self:openMode()
	local E = Activity101SignViewBase.eOpenMode

	if M == E.ActivityBeginnerView then
		local actId = self.viewParam.actId
		local parentGO = self.viewParam.parent

		self:internal_set_actId(actId)
		gohelper.addChild(parentGO, self.viewGO)
		self:_internal_onOpen()
		self:_refresh()
	elseif M == E.PaiLian then
		self:_internal_onOpen()
		self:_refresh()
	else
		assert(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function Activity101SignViewBase:_internal_onOpen()
	self:onStart()
end

function Activity101SignViewBase:_internal_onDestroy()
	FrameTimerController.onDestroyViewMember(self, "__createTimer")
	GameUtil.onDestroyViewMemberList(self, "__itemList")
end

function Activity101SignViewBase:_refresh()
	self:onRefresh()
end

function Activity101SignViewBase:getHelpViewParam(goHelp)
	local co = self:getActivityCo()

	return {
		title = luaLang("rule"),
		desc = co.actTip,
		rootGo = goHelp
	}
end

function Activity101SignViewBase:getDataList()
	local res = {}
	local actId = self:actId()

	for id, v in pairs(lua_activity101.configDict[actId] or {}) do
		res[#res + 1] = {
			day = id,
			data = v
		}
	end

	table.sort(res, function(a, b)
		return a.day < b.day
	end)

	self._tempDataList = res

	return res
end

function Activity101SignViewBase:getTempDataList()
	return self._tempDataList
end

function Activity101SignViewBase:getRewardCouldGetIndex()
	local actId = self:actId()
	local dataList = self:getDataList()
	local index = #dataList

	for i, v in ipairs(dataList) do
		local id = v.day
		local alreadyGet = ActivityType101Model.instance:isType101RewardGet(actId, id)

		if not alreadyGet then
			return true, i
		end
	end

	return false, index
end

function Activity101SignViewBase:updateRewardCouldGetHorizontalScrollPixel(indexFomularFunc)
	local _, index = self:getRewardCouldGetIndex()

	if indexFomularFunc then
		index = indexFomularFunc(index)
	end

	self:focusByIndex(index)
end

function Activity101SignViewBase:_tweenByLimitedScrollView(index)
	local csListView = self:getCsListScroll()
	local listScrollParam = self:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH
	local rectMaskSoftness = listScrollParam.rectMaskSoftness

	if not rectMaskSoftness[1] then
		local rectMaskSoftnessX = 0
		local scrollPixel = (cellWidth + cellSpaceH) * math.max(0, index) + math.min(0, -rectMaskSoftnessX)

		csListView.HorizontalScrollPixel = math.max(0, scrollPixel)

		csListView:UpdateCells(true)
	end
end

function Activity101SignViewBase:_tweenByScrollContent(index)
	local scrollContentTran = self:getScrollContentTranform()
	local listScrollParam = self:getListScrollParam()
	local startSpace = listScrollParam.startSpace

	if index <= 1 then
		recthelper.setAnchorX(scrollContentTran, startSpace or 0)

		return
	end

	local rectMaskSoftness = listScrollParam.rectMaskSoftness

	if not rectMaskSoftness[1] then
		local rectMaskSoftnessX = 0
		local maxScrollX = self:getMaxScrollX()
		local cellWidth = listScrollParam.cellWidth
		local cellSpaceH = listScrollParam.cellSpaceH
		local scrollPixel = math.max(0, startSpace + (index - 1) * (cellWidth + cellSpaceH)) + math.min(0, -rectMaskSoftnessX)
		local posX = math.min(maxScrollX, scrollPixel)

		recthelper.setAnchorX(scrollContentTran, -posX)
	end
end

function Activity101SignViewBase:getRemainTimeStr()
	local actId = self:actId()
	local remainTimeSec = self:getRemainTimeSec()

	if remainTimeSec <= 0 then
		return luaLang("turnback_end")
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(remainTimeSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function Activity101SignViewBase:_createList()
	if self.__itemList then
		return
	end

	local dataList = self:getDataList()

	recthelper.setWidth(self:getScrollContentTranform(), self:calcContentWidth())

	local rectMask2d = self:_rectMask2d()

	if rectMask2d then
		rectMask2d.enabled = #dataList > 4
	end

	self.__itemList = {}

	if #dataList <= 7 then
		self:_createListDirectly()
	else
		self:_createListSplitFrame()
	end
end

function Activity101SignViewBase:_createListDirectly()
	local dataList = self:getDataList()

	for i, mo in ipairs(dataList) do
		local item = self.viewContainer:createItemInst()

		item._index = i
		item._view = self

		item:onUpdateMO(mo)
		item:playOpenAnim()
		table.insert(self.__itemList, item)
	end
end

function Activity101SignViewBase:_createListSplitFrame()
	local dataList = self:getDataList()

	self.__createTimer = FrameTimerController.instance:register(self.__createInner, self, 1, #dataList + 1)

	self.__createTimer:Start()
end

local kProcessCountPerTime = 3

function Activity101SignViewBase:__createInner()
	local dataList = self:getDataList()
	local count = #dataList
	local isDone = count == #self.__itemList

	if isDone then
		FrameTimerController.onDestroyViewMember(self, "__createTimer")

		return
	end

	local handleCount = kProcessCountPerTime
	local from = #self.__itemList + 1

	for i = from, count do
		if handleCount <= 0 and count - i >= kProcessCountPerTime then
			break
		end

		local mo = dataList[i]
		local item = self.viewContainer:createItemInst()

		item._index = i
		item._view = self

		item:onUpdateMO(mo)
		item:playOpenAnim()
		table.insert(self.__itemList, item)

		handleCount = handleCount - 1
	end
end

function Activity101SignViewBase:_refreshList(isUseCache)
	local dataList = isUseCache and self:getTempDataList() or self:getDataList()

	self:_setPinStartIndex(dataList)
	self:onRefreshList(dataList)
end

function Activity101SignViewBase:refreshListByLimitedScollRect(dataList)
	local scrollModel = self:getScrollModel()

	scrollModel:setList(dataList)
end

function Activity101SignViewBase:_updateScrollViewPos()
	self:updateRewardCouldGetHorizontalScrollPixel(function(index)
		return index
	end)
end

function Activity101SignViewBase:calcContentWidth()
	local dataList = self:getTempDataList() or self:getDataList()
	local listScrollParam = self:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth
	local cellSpaceH = listScrollParam.cellSpaceH
	local startSpace = listScrollParam.startSpace
	local endSpace = listScrollParam.endSpace

	if dataList then
		if not #dataList then
			local count = 0

			return (count - 1) * (cellWidth + cellSpaceH) + cellWidth + startSpace + endSpace
		end
	end
end

function Activity101SignViewBase:getMaxScrollX()
	local viewportW = self.viewContainer:getViewportWH()
	local maxContentW = self:calcContentWidth()

	return math.max(0, maxContentW - viewportW)
end

function Activity101SignViewBase:getScrollModel()
	return self.viewContainer:getScrollModel()
end

function Activity101SignViewBase:getCsListScroll()
	return self.viewContainer:getCsListScroll()
end

function Activity101SignViewBase:getListScrollParam()
	return self.viewContainer:getListScrollParam()
end

function Activity101SignViewBase:getScrollContentTranform()
	return self.viewContainer:getScrollContentTranform()
end

function Activity101SignViewBase:isLimitedScrollView()
	return self.viewContainer:isLimitedScrollView()
end

function Activity101SignViewBase:_rectMask2d()
	if self.__rectMask2d then
		return self.__rectMask2d
	end

	if self._scrollItemList then
		self.__rectMask2d = self._scrollItemList:GetComponent(gohelper.Type_RectMask2D)
	end

	return self.__rectMask2d
end

function Activity101SignViewBase:rectMask2dSoftnessV2()
	local listScrollParam = self:getListScrollParam()

	return listScrollParam.rectMaskSoftness
end

function Activity101SignViewBase:getRemainTimeSec()
	local actId = self:actId()
	local remainTimeSec = ActivityModel.instance:getRemainTimeSec(actId)

	return remainTimeSec or 0
end

function Activity101SignViewBase:_editableInitView()
	assert(false, "please override this function")
end

function Activity101SignViewBase:_setPinStartIndex(dataList)
	local ok, index = self:getRewardCouldGetIndex()
	local scrollModel = self:getScrollModel()

	scrollModel:setDefaultPinStartIndex(dataList, ok and index or 1)
end

function Activity101SignViewBase:onStart()
	if self:isLimitedScrollView() then
		return
	end

	self:_createList()
	self:_updateScrollViewPos()
end

function Activity101SignViewBase:onRefresh()
	self:_refreshList()
end

function Activity101SignViewBase:onRefreshList(dataList)
	if not dataList then
		return
	end

	local itemList = self.__itemList

	for i, mo in ipairs(dataList) do
		local item = itemList[i]

		if item then
			local oldMo = item._mo

			if oldMo then
				mo.__isPlayedOpenAnim = oldMo.__isPlayedOpenAnim
			end

			item:onUpdateMO(mo)
		end
	end
end

function Activity101SignViewBase:getItemByIndex(index)
	return self.__itemList[index]
end

function Activity101SignViewBase:focusByIndex(index)
	if self:isLimitedScrollView() then
		self:_tweenByLimitedScrollView(index)
	else
		self:_tweenByScrollContent(index)
	end
end

function Activity101SignViewBase:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self._actId)
end

return Activity101SignViewBase

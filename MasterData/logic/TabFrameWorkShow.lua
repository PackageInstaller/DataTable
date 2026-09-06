-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/common/TabFrameWorkShow.lua

module("logic.extensions.tabframework.view.common.TabFrameWorkShow", package.seeall)

local TabFrameWorkShow = class("TabFrameWorkShow")

function TabFrameWorkShow.create(view, containerGo, tablist, frameId, getParamsCallback)
	local tabFrameWorkShow = TabFrameWorkShow.New()

	tabFrameWorkShow:init(view, containerGo, tablist, frameId, getParamsCallback)

	return tabFrameWorkShow
end

function TabFrameWorkShow.pack(...)
	return {
		...
	}
end

function TabFrameWorkShow:init(view, containerGo, tablist, frameId, getParamsCallback)
	self._view = view
	self._containerGo = containerGo
	self._getParamsCallback = getParamsCallback
	self._commonTab = TabFrameCommonTab.create(tablist, GameUtil.handler(self._onUpdateCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setTabDataFilterCallBack(GameUtil.handler(self._onTabFilter, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onClickPre, self))

	frameId = checknumber(frameId)

	if frameId > 0 then
		self:initTabViewWithFrameId(frameId)
	end
end

function TabFrameWorkShow:getCommonTab()
	return self._commonTab
end

function TabFrameWorkShow:setUpdateCellExtCallBack(updateCellExtCallBack)
	self._updateCellExtCallBack = updateCellExtCallBack
end

function TabFrameWorkShow:setUpdateRightExtCallBack(updateRightExtCallBack)
	self._updateRightExtCallBack = updateRightExtCallBack
end

function TabFrameWorkShow:setShowByExCondAsHeadTabCallBack(callBack)
	self._showByExCondAsHeadTabCallBack = callBack
end

function TabFrameWorkShow:initTabViewWithFrameId(frameId)
	self._frameId = frameId

	self._commonTab:clearAllData()

	local tabCfg = TabFrameWorkConfig.instance:getFwTabCfg(frameId)

	if tabCfg == nil then
		if enableDebug then
			printError(">>>>>>>>>>错误： 检查  yk-运营-页签框架.xlsx 中配置  frameId：", frameId)
		end

		return
	end

	for i, data in ipairs(tabCfg) do
		local obj = self._commonTab:addTabData(data.tabName, data)
		local secTabCfg = TabFrameWorkConfig.instance:getFwSecTabCfg(frameId, data.headTabId)

		for j, secData in ipairs(secTabCfg or {}) do
			self._commonTab:addTabData(secData.tabName, secData, obj.root)
		end
	end
end

function TabFrameWorkShow:jumpTab(headTabId, secTabId)
	self._headTabId = checknumber(headTabId)
	self._secTabId = checknumber(secTabId)

	local cfg

	self._commonTab:jumpTabByData((self._headTabId > 0 or nil) and (self._secTabId == 0 and TabFrameWorkConfig.instance:getFwTabData(self._frameId, self._headTabId) or TabFrameWorkConfig.instance:getFwSecTabData(self._frameId, self._headTabId, self._secTabId)))
end

function TabFrameWorkShow:getHeadTabId()
	return self._headTabId
end

function TabFrameWorkShow:getSecTabId()
	return self._secTabId
end

function TabFrameWorkShow:_onUpdateCell(view, cell, tabData, tag)
	local redPoint = goutil.findChild(cell, "redpoint")
	local lock = goutil.findChild(cell, "lock")
	local data = tabData.data
	local isUnlock = true

	isUnlock = tabData.leaf == 0 and self:_isUnlockAsHeadTab(data.headTabId) or self:_isUnlockAsSecTab(data.headTabId, data.secTabId)

	GameUtil.SetActive(lock, not isUnlock)

	if not goutil.isNil(redPoint) then
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		if tabData.leaf > 0 then
			if TabFrameWorkController.instance:isNeedRedAsSecTab(self._frameId, data.headTabId, data.secTabId) then
				GameUtil.SetActive(redPoint, true)
			elseif isUnlock and data.redIdArray then
				RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdArray))
			end
		elseif TabFrameWorkController.instance:isNeedRedAsHeadTab(self._frameId, data.headTabId) then
			GameUtil.SetActive(redPoint, true)
		elseif isUnlock and data.redIdArray then
			RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdArray))
		end
	end

	GameUtil.callBack(self._updateCellExtCallBack, view, cell, tabData, tag)
end

function TabFrameWorkShow:_onClickPre(tabData)
	local data = tabData.data

	if not (tabData.leaf == 0 and self:_isUnlockAsHeadTab(data.headTabId) or self:_isUnlockAsSecTab(data.headTabId, data.secTabId)) then
		local tips = self:_getHeadTabLockTips(data)

		FloatWordMgr.instance:show(tips)

		return true
	end

	self._headTabId = checknumber(data.headTabId)
	self._secTabId = checknumber(data.secTabId)

	if checknumber(data.headTabId) > 0 and checknumber(data.secTabId) > 0 then
		TabFrameWorkController.instance:trySetRedAsSecTab(self._frameId, data.headTabId, data.secTabId)
	elseif checknumber(data.headTabId) > 0 then
		TabFrameWorkController.instance:trySetRedAsHeadTab(self._frameId, data.headTabId)
	end
end

function TabFrameWorkShow:_getHeadTabLockTips(data)
	local tips = ""
	local startUnlockTime, endUnlockTime = data.startUnlockTime, data.endUnlockTime

	if not string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local startDate, endDate = os.date("*t", GameUtil.string2time(startUnlockTime)), os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:%02d 至 %02d-%02d-%02d %02d:%02d 开放", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min, endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)
	elseif not string.nilorempty(startUnlockTime) and string.nilorempty(endUnlockTime) then
		local startDate = os.date("*t", GameUtil.string2time(startUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:%02d 开放", startDate.year, startDate.month, startDate.day, startDate.hour, startDate.min)
	elseif string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local endDate = os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:%02d 结束", endDate.year, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	if string.nilorempty(tips) then
		tips = "不在开放期内"
	end

	return tips
end

function TabFrameWorkShow:_onUpdateRight(tabData)
	self:_onClearContentCol()

	if tabData == nil then
		return
	end

	local data = tabData.data
	local viewName = data.viewName

	if string.nilorempty(viewName) then
		return
	end

	local params

	if not string.nilorempty(data.params) then
		params = string.split(data.params, "#")
	end

	local list

	if self._getParamsCallback then
		list = TabFrameWorkShow.pack(self._getParamsCallback(data))
	end

	if params then
		if list and #list > 0 then
			table.insertto(list, params)
			self._view:showTabAt(self._containerGo, viewName, unpack(list))
		else
			self._view:showTabAt(self._containerGo, viewName, unpack(params))
		end
	elseif list and #list > 0 then
		self._view:showTabAt(self._containerGo, viewName, unpack(list))
	else
		self._view:showTabAt(self._containerGo, viewName)
	end

	SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
	GameUtil.callBack(self._updateRightExtCallBack, tabData)
end

function TabFrameWorkShow:_onClearContentCol()
	self._view:showTabAt(self._containerGo, "")
end

function TabFrameWorkShow:_onTabFilter(tabData)
	local data = tabData.data

	if not self:_isShowAsHeadTab(data.headTabId) then
		return true
	end

	if tabData.leaf > 0 and not self:_isShowAsSecTab(data.headTabId, data.secTabId) then
		return true
	end
end

function TabFrameWorkShow:_isUnlockAsHeadTab(headTabId)
	return TabFrameWorkController.instance:isUnlockAsHeadTab(self._frameId, headTabId) and self:_isUnlockByExCondAsHeadTab(headTabId)
end

function TabFrameWorkShow:_isUnlockByExCondAsHeadTab(headTabId)
	return true
end

function TabFrameWorkShow:_isShowAsHeadTab(headTabId)
	return TabFrameWorkController.instance:isShowAsHeadTab(self._frameId, headTabId) and self:_isShowByExCondAsHeadTab(headTabId)
end

function TabFrameWorkShow:_isShowByExCondAsHeadTab(headTabId)
	if self._showByExCondAsHeadTabCallBack then
		return GameUtil.callBack(self._showByExCondAsHeadTabCallBack, headTabId)
	end

	return true
end

function TabFrameWorkShow:_isUnlockAsSecTab(headTabId, secTabId)
	return TabFrameWorkController.instance:isUnlockAsSecTab(self._frameId, headTabId, secTabId) and self:_isUnlockByExCondAsSecTab(headTabId, secTabId)
end

function TabFrameWorkShow:_isUnlockByExCondAsSecTab(headTabId, secTabId)
	return true
end

function TabFrameWorkShow:_isShowAsSecTab(headTabId, secTabId)
	return TabFrameWorkController.instance:isShowAsSecTab(self._frameId, headTabId, secTabId) and self:_isShowByExCondAsSecTab(headTabId, secTabId)
end

function TabFrameWorkShow:_isShowByExCondAsSecTab(headTabId, secTabId)
	return true
end

return TabFrameWorkShow

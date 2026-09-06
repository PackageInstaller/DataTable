-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/TabFrameWorkMainView.lua

module("logic.extensions.tabframework.view.TabFrameWorkMainView", package.seeall)

local TabFrameWorkMainView = class("TabFrameWorkMainView", ViewComponent)

function TabFrameWorkMainView:ctor()
	TabFrameWorkMainView.super.ctor(self)

	self._frameId = 0
	self._curHeadTabIndex = 0
	self._curSecTabIndex = 0
	self._headTabViewInfoList = {}
	self._secTabViewInfoList = {}
	self._spreadInfoList = {}
end

function TabFrameWorkMainView:buildUI()
	TabFrameWorkMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._tabScroContent = goutil.findChild(self.mainGO, "tabCol/tabScrollerview/Viewport/Content")
	self._tabScroView = goutil.findChild(self.mainGO, "tabCol/tabScrollerview/Viewport")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	GameUtil.SetActive(self._tabScrollercell, false)

	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
end

function TabFrameWorkMainView:bindEvents()
	TabFrameWorkMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function TabFrameWorkMainView:unbindEvents()
	TabFrameWorkMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function TabFrameWorkMainView:onEnter()
	TabFrameWorkMainView.super.onEnter(self)

	self._frameId = self:_getFrameId()
	self._headTabIdOfJump = self._headTabIdOfJump or self:_getDefaultHeadTabIdOfJump()
	self._secTabIdOfJump = self._secTabIdOfJump or self:_getDefaultSecTabIdOfJump()

	if self._frameId == 0 then
		TipsFacade.instance:openTipWindow("提示", "缺少传入参数页签框架ID", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, TabFrameWorkController.NotifyOpentabframeworkview, self._handleOpentabframeworkview, self)
	self.addGEvent(self, TabFrameWorkController.NotifyTabframeworkviewJump, self._handleNotifyTabframeworkviewJump, self)
	self.addGEvent(self, TabFrameWorkController.NotifyTabframeworkviewJumpByName, self._handleNotifyTabframeworkviewJumpByName, self)
	self:_onSetUI()
	self:_onUpdate()
end

function TabFrameWorkMainView:onExit()
	TabFrameWorkMainView.super.onExit(self)

	self._frameParams = nil

	self:_onClearTabCol()
	self:_onClearContentCol()
end

function TabFrameWorkMainView:destroyUI()
	TabFrameWorkMainView.super.destroyUI(self)
end

function TabFrameWorkMainView:_handleOpentabframeworkview(params)
	local frameId = checknumber(params[1])

	if self._frameId == frameId then
		self:_handleNotifyTabframeworkviewJump(unpack(params))
	else
		self:close()
		TabFrameWorkController.instance:gotoTabFrameWorkView(params)
	end
end

function TabFrameWorkMainView:_handleNotifyTabframeworkviewJumpByName(frameId, viewName)
	local frameId = checknumber(frameId)

	if frameId ~= self._frameId then
		return
	end

	local headTabId, secTabId = 0, 0

	for _, v in ipairs(self._headTabViewInfoList) do
		if v.data.viewName == viewName then
			headTabId = v.data.headTabId

			break
		end
	end

	if headTabId == 0 then
		for headTabIndex, v in ipairs(self._secTabViewInfoList) do
			for _, vv in ipairs(v) do
				if vv.data.viewName == viewName then
					headTabId = vv.data.headTabId
					secTabId = vv.data.secTabId

					break
				end
			end
		end
	end

	self:_handleNotifyTabframeworkviewJump(frameId, headTabId, secTabId)
end

function TabFrameWorkMainView:_handleNotifyTabframeworkviewJump(frameId, headTabId, secTabId)
	local frameId = checknumber(frameId)

	if frameId ~= self._frameId then
		return
	end

	self._headTabIdOfJump = checknumber(headTabId)
	self._secTabIdOfJump = checknumber(secTabId)

	self:_onUpdate()
end

function TabFrameWorkMainView:_onSetUI()
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)

	if self._txtTitle and not string.nilorempty(baseData.planName) then
		self._txtTitle.text = baseData.planName
	end
end

function TabFrameWorkMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TabFrameWorkMainView:_onUpdateData()
	self:_onUpdateTabColData()
	self:_onUpdateDataEx()
end

function TabFrameWorkMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateContentColUI()
	self:_onUpdateUIEx()
end

function TabFrameWorkMainView:_onUpdatePlaneUI()
	return
end

function TabFrameWorkMainView:_onUpdateDataEx()
	return
end

function TabFrameWorkMainView:_onUpdateUIEx()
	return
end

function TabFrameWorkMainView:_getFrameParams()
	if self._frameParams == nil then
		local params = self:getOpenParam() or {}

		self._frameParams = {}
		self._frameParams.frameId = checknumber(params[1])
		self._frameParams.headTabIdOfJump = checknumber(params[2])
		self._frameParams.secTabIdOfJump = checknumber(params[3])
	end

	return self._frameParams
end

function TabFrameWorkMainView:_getFrameId()
	return self:_getFrameParams().frameId
end

function TabFrameWorkMainView:_getDefaultHeadTabIdOfJump()
	return self:_getFrameParams().headTabIdOfJump
end

function TabFrameWorkMainView:_getDefaultSecTabIdOfJump()
	return self:_getFrameParams().secTabIdOfJump
end

function TabFrameWorkMainView:_onUpdateTabColData()
	local headTabViewInfoList = {}
	local secTabViewInfoList = {}
	local tabCfg = TabFrameWorkConfig.instance:getFwTabCfg(self._frameId)

	for _, data in ipairs(tabCfg) do
		local info = {
			isSpread = false,
			isUnlock = self:_isUnlockAsHeadTab(data.headTabId),
			isShow = self:_isShowAsHeadTab(data.headTabId),
			data = data
		}

		if info.isShow then
			table.insert(headTabViewInfoList, info)
		end
	end

	for headTabIndex, headTabViewInfo in ipairs(headTabViewInfoList) do
		local headTabId = headTabViewInfo.data.headTabId
		local secTabCfg = TabFrameWorkConfig.instance:getFwSecTabCfg(self._frameId, headTabId)

		secTabViewInfoList[headTabIndex] = {}

		if secTabCfg then
			for _, data in ipairs(secTabCfg) do
				local info = {
					isUnlock = self:_isUnlockAsSecTab(headTabId, data.secTabId),
					isShow = self:_isShowAsSecTab(headTabId, data.secTabId),
					data = data
				}

				if info.isShow then
					table.insert(secTabViewInfoList[headTabIndex], info)
				end
			end
		end
	end

	self._headTabViewInfoList = headTabViewInfoList
	self._secTabViewInfoList = secTabViewInfoList

	self:_updateCurTabIndex()
	self:_setSpread(self._curHeadTabIndex, true)
end

function TabFrameWorkMainView:_updateCurTabIndex()
	if self._headTabIdOfJump > 0 then
		for headTabIndex = 1, self:_getCurHeadTabCount() do
			local headInfo = self:_getHeadTabViewInfo(headTabIndex)

			if headInfo.isUnlock and headInfo.data.headTabId == self._headTabIdOfJump then
				self._curHeadTabIndex = headTabIndex
				self._curSecTabIndex = 0

				break
			end
		end

		if self._secTabIdOfJump > 0 then
			for secTabIndex = 1, self:_getSecTabTabCount(self._curHeadTabIndex) do
				local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, secTabIndex)

				if secInfo.isUnlock and secInfo.data.secTabId == self._secTabIdOfJump then
					self._curSecTabIndex = secTabIndex

					break
				end
			end
		end

		self._headTabIdOfJump = 0
		self._secTabIdOfJump = 0
	end

	local headInfo = self:_getHeadTabViewInfo(self._curHeadTabIndex)
	local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, self._curSecTabIndex)

	if headInfo == nil or not headInfo.isUnlock then
		for headTabIndex = 1, self:_getCurHeadTabCount() do
			local headInfo = self:_getHeadTabViewInfo(headTabIndex)

			if headInfo.isUnlock then
				self._curHeadTabIndex = headTabIndex
				self._curSecTabIndex = 0

				break
			end
		end

		self._curSecTabIndex = self:_getDefaultSecTabIndex(self._curHeadTabIndex)

		if self._curSecTabIndex > 0 then
			local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, self._curSecTabIndex)

			if not secInfo or not secInfo.isUnlock then
				self._curSecTabIndex = 0
			end
		end

		if self._curSecTabIndex <= 0 then
			for secTabIndex = 1, self:_getSecTabTabCount(self._curHeadTabIndex) do
				local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, secTabIndex)

				if secInfo.isUnlock then
					self._curSecTabIndex = secTabIndex

					break
				end
			end
		end
	elseif secInfo == nil or not secInfo.isUnlock then
		self._curSecTabIndex = self:_getDefaultSecTabIndex(self._curHeadTabIndex)

		if self._curSecTabIndex > 0 then
			local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, self._curSecTabIndex)

			if not secInfo or not secInfo.isUnlock then
				self._curSecTabIndex = 0
			end
		end

		if self._curSecTabIndex <= 0 then
			for secTabIndex = 1, self:_getSecTabTabCount(self._curHeadTabIndex) do
				local secInfo = self:_getSecTabViewInfo(self._curHeadTabIndex, secTabIndex)

				if secInfo.isUnlock then
					self._curSecTabIndex = secTabIndex

					break
				end
			end
		end
	end
end

function TabFrameWorkMainView:_isUnlockAsHeadTab(headTabId)
	return TabFrameWorkController.instance:isUnlockAsHeadTab(self._frameId, headTabId) and self:_isUnlockByExCondAsHeadTab(headTabId)
end

function TabFrameWorkMainView:_isUnlockByExCondAsHeadTab(headTabId)
	return true
end

function TabFrameWorkMainView:_isShowAsHeadTab(headTabId)
	return TabFrameWorkController.instance:isShowAsHeadTab(self._frameId, headTabId) and self:_isShowByExCondAsHeadTab(headTabId)
end

function TabFrameWorkMainView:_isShowByExCondAsHeadTab(headTabId)
	return true
end

function TabFrameWorkMainView:_setSpread(headTabIndex, isToSpread)
	for tabIndex, headTabViewInfo in ipairs(self._headTabViewInfoList) do
		headTabViewInfo.isSpread = not not (isToSpread and tabIndex == headTabIndex and self:_isUnlockAsHeadTab(headTabViewInfo.data.headTabId))
	end
end

function TabFrameWorkMainView:_getCurHeadTabCount()
	return #self._headTabViewInfoList
end

function TabFrameWorkMainView:_getHeadTabViewInfo(headTabIndex)
	return self._headTabViewInfoList[headTabIndex] or {}
end

function TabFrameWorkMainView:_isUnlockAsSecTab(headTabId, secTabId)
	return TabFrameWorkController.instance:isUnlockAsSecTab(self._frameId, headTabId, secTabId) and self:_isUnlockByExCondAsSecTab(headTabId, secTabId)
end

function TabFrameWorkMainView:_isUnlockByExCondAsSecTab(headTabId, secTabId)
	return true
end

function TabFrameWorkMainView:_isShowAsSecTab(headTabId, secTabId)
	return TabFrameWorkController.instance:isShowAsSecTab(self._frameId, headTabId, secTabId) and self:_isShowByExCondAsSecTab(headTabId, secTabId)
end

function TabFrameWorkMainView:_isShowByExCondAsSecTab(headTabId, secTabId)
	return true
end

function TabFrameWorkMainView:_getSecTabViewInfo(headTabIndex, secTabIndex)
	if self._secTabViewInfoList[headTabIndex] then
		return self._secTabViewInfoList[headTabIndex][secTabIndex]
	end
end

function TabFrameWorkMainView:_getSecTabTabCount(headTabIndex)
	return #(self._secTabViewInfoList[headTabIndex] or {})
end

function TabFrameWorkMainView:_onUpdateTabColUI()
	local parentTran = self._tabScroContent.transform
	local children = GameUtil.getChildren(parentTran)
	local tabCount = self:_getCurHeadTabCount()

	self._tabGoList = {}

	for headTabIndex = 1, tabCount do
		if not children[headTabIndex] then
			local mainGo = goutil.cloneAndSetParent(self._tabScrollercell, parentTran)

			self._tabGoList[headTabIndex] = self._tabGoList[headTabIndex] or {}
			self._tabGoList[headTabIndex][0] = children[headTabIndex]

			self:_updateTabCell(children[headTabIndex], headTabIndex)
		end
	end

	for idx = 1, parentTran.childCount do
		GameUtil.SetActive(parentTran:GetChild(idx - 1), idx <= tabCount)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tabScroContent:GetComponent(goutil.Type_RectTransform))
end

function TabFrameWorkMainView:_onClearTabCol()
	local parentTran = self._tabScroContent.transform
	local tabChildren = GameUtil.getChildren(parentTran)

	for _, mainGo in ipairs(tabChildren) do
		local children = GameUtil.getChildren(mainGo.transform)

		self:_clearHeadTabCell(children[2])

		for idx = 3, #children do
			self:_clearSecTabCell(children[idx])
		end
	end
end

function TabFrameWorkMainView:_updateTabCell(mainGo, headTabIndex)
	local info = self:_getHeadTabViewInfo(headTabIndex)
	local children = GameUtil.getChildren(mainGo.transform)
	local imgBg = children[1]
	local headTabCell = children[2]
	local secTabOrginIdx = 3
	local secTabCell = children[secTabOrginIdx]

	GameUtil.SetActive(secTabCell, false)

	if headTabCell then
		self:_updateHeadTabCell(headTabCell, headTabIndex)
	end

	if secTabCell then
		local parentTran = mainGo.transform
		local secTabCount = self:_getSecTabTabCount(headTabIndex)
		local secTabChildren = {}

		for idx = secTabOrginIdx + 1, #children do
			table.insert(secTabChildren, children[idx])
		end

		for idx, go in ipairs(secTabChildren) do
			if info.isSpread then
				GameUtil.SetActive(go, idx <= secTabCount)
			else
				GameUtil.SetActive(go, false)
			end
		end

		if info.isSpread then
			for secTabIndex = 1, secTabCount do
				if not secTabChildren[secTabIndex] then
					local go = goutil.cloneAndSetParent(secTabCell, parentTran)

					self._tabGoList[headTabIndex][secTabIndex] = go

					GameUtil.SetActive(go, true)
					self:_updateSecTabCell(go, headTabIndex, secTabIndex)
				end
			end
		end

		GameUtil.SetActive(imgBg, info.isSpread and secTabCount > 0)
	end
end

function TabFrameWorkMainView:_updateHeadTabCell(mainGo, headTabIndex)
	local info = self:_getHeadTabViewInfo(headTabIndex)
	local isUnlock = info.isUnlock
	local data = info.data
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if not goutil.isNil(redPoint) then
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		if self:_isNeedRedByExCondAsHeadTab(headTabIndex) then
			GameUtil.SetActive(redPoint, true)
		elseif TabFrameWorkController.instance:isNeedRedAsHeadTab(self._frameId, data.headTabId) then
			GameUtil.SetActive(redPoint, true)
		elseif isUnlock and data.redIdArray then
			RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdArray))
		end
	end

	if changeGroup then
		local isSelected = self._curHeadTabIndex == headTabIndex

		changeGroup:SetState(isSelected and 1 or 0)
	end

	GameUtil.SetActive(lock, not isUnlock)

	if txtName then
		txtName.text = data.tabName or ""
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickHeadTabCell, self, headTabIndex))
end

function TabFrameWorkMainView:_clickHeadTabCell(headTabIndex)
	local headInfo = self:_getHeadTabViewInfo(headTabIndex)

	if not headInfo.isUnlock then
		local tips = self:_getHeadTabLockTips(headTabIndex)

		FloatWordMgr.instance:show(tips)

		return
	end

	self:_setSpread(headTabIndex, not headInfo.isSpread)
	self:_trySetRed(headInfo.data.headTabId)

	if self._curHeadTabIndex ~= headTabIndex then
		self._curHeadTabIndex = headTabIndex
		self._curSecTabIndex = self:_getDefaultSecTabIndex(headTabIndex)

		if self._curSecTabIndex > 0 then
			local secInfo = self:_getSecTabViewInfo(headTabIndex, self._curSecTabIndex)

			if not secInfo or not secInfo.isUnlock then
				self._curSecTabIndex = 0
			end
		end

		if self._curSecTabIndex <= 0 and self:_getSecTabTabCount(headTabIndex) > 0 and string.nilorempty(headInfo.data.viewName) then
			for secTabIndex = 1, self:_getSecTabTabCount(headTabIndex) do
				local secInfo = self:_getSecTabViewInfo(headTabIndex, secTabIndex)

				if secInfo and secInfo.isUnlock then
					self._curSecTabIndex = secTabIndex

					break
				end
			end
		end

		self:_onUpdateUI()
	else
		self:_onUpdateTabColUI()
	end
end

function TabFrameWorkMainView:_getDefaultSecTabIndex(headTabIndex)
	return 0
end

function TabFrameWorkMainView:_getHeadTabLockTips(headTabIndex)
	local tips = ""
	local info = self:_getHeadTabViewInfo(headTabIndex)
	local startUnlockTime, endUnlockTime = info.data.startUnlockTime, info.data.endUnlockTime

	if not string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local startDate, endDate = os.date("*t", GameUtil.string2time(startUnlockTime)), os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 至 %02d-%02d-%02d %02d:00 开放", startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour)
	elseif not string.nilorempty(startUnlockTime) and string.nilorempty(endUnlockTime) then
		local startDate = os.date("*t", GameUtil.string2time(startUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 开放", startDate.year, startDate.month, startDate.day, startDate.hour)
	elseif string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local endDate = os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 结束", endDate.year, endDate.month, endDate.day, endDate.hour)
	else
		tips = self:_getHeadTabLockTipsByExCond(headTabIndex)
	end

	if string.nilorempty(tips) then
		tips = "不在开放期内"
	end

	return tips
end

function TabFrameWorkMainView:_getHeadTabLockTipsByExCond(headTabIndex)
	return ""
end

function TabFrameWorkMainView:_isNeedRedByExCondAsHeadTab(headTabIndex)
	return false
end

function TabFrameWorkMainView:_clearHeadTabCell(mainGo)
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function TabFrameWorkMainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	local info = self:_getSecTabViewInfo(headTabIndex, secTabIndex)
	local isUnlock = info.isUnlock
	local data = info.data
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local lock = goutil.findChild(mainGo, "lock")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if not goutil.isNil(redPoint) then
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		if self:_isNeedRedByExCondAsSecTab(secTabIndex) then
			GameUtil.SetActive(redPoint, true)
		elseif TabFrameWorkController.instance:isNeedRedAsSecTab(self._frameId, info.data.headTabId, info.data.secTabId) then
			GameUtil.SetActive(redPoint, true)
		elseif isUnlock and data.redIdArray then
			RedPointController.instance:regRedPoint(redPoint, unpack(data.redIdArray))
		end
	end

	if changeGroup then
		local isSelected = self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex

		changeGroup:SetState(isSelected and 1 or 0)
	end

	GameUtil.SetActive(lock, not isUnlock)

	if txtName then
		txtName.text = data.tabName or ""
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickSecTabCell, self, headTabIndex, secTabIndex))
end

function TabFrameWorkMainView:_clickSecTabCell(headTabIndex, secTabIndex)
	local headInfo = self:_getHeadTabViewInfo(headTabIndex)
	local secInfo = self:_getSecTabViewInfo(headTabIndex, secTabIndex)

	if not secInfo.isUnlock then
		local tips = FloatWordMgr.instance:show(self:_getSecTabLockTips(headTabIndex, secTabIndex))

		return
	end

	if self._curHeadTabIndex == headTabIndex and self._curSecTabIndex == secTabIndex then
		return
	end

	self:_setSpread(headTabIndex, true)

	self._curHeadTabIndex = headTabIndex
	self._curSecTabIndex = secTabIndex

	self:_trySetRed(headInfo.data.headTabId, secInfo.data.secTabId)
	self:_onUpdateUI()
end

function TabFrameWorkMainView:_getSecTabLockTips(headTabIndex, secTabIndex)
	local tips = ""
	local info = self:_getSecTabViewInfo(headTabIndex, secTabIndex)
	local startUnlockTime, endUnlockTime = info.data.startUnlockTime, info.data.endUnlockTime

	if not string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local startDate, endDate = os.date("*t", GameUtil.string2time(startUnlockTime)), os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 至 %02d-%02d-%02d %02d:00 开放", startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour)
	elseif not string.nilorempty(startUnlockTime) and string.nilorempty(endUnlockTime) then
		local startDate = os.date("*t", GameUtil.string2time(startUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 开放", startDate.year, startDate.month, startDate.day, startDate.hour)
	elseif string.nilorempty(startUnlockTime) and not string.nilorempty(endUnlockTime) then
		local endDate = os.date("*t", GameUtil.string2time(endUnlockTime))

		tips = string.format("%02d-%02d-%02d %02d:00 结束", endDate.year, endDate.month, endDate.day, endDate.hour)
	else
		tips = self:_getSecTabLockTipsByExCond(secTabIndex)
	end

	if string.nilorempty(tips) then
		tips = "不在开放期内"
	end

	return tips
end

function TabFrameWorkMainView:_getSecTabLockTipsByExCond(secTabIndex)
	return ""
end

function TabFrameWorkMainView:_isNeedRedByExCondAsSecTab(secTabIndex)
	return false
end

function TabFrameWorkMainView:_clearSecTabCell(mainGo)
	local redPoint = goutil.findChild(mainGo, "redPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	GameUtil.rmClickHandler(mainGo)
end

function TabFrameWorkMainView:_onUpdateContentColUI()
	local info

	if self._curHeadTabIndex > 0 then
		info = self._curSecTabIndex > 0 and self:_getSecTabViewInfo(self._curHeadTabIndex, self._curSecTabIndex) or self:_getHeadTabViewInfo(self._curHeadTabIndex)
	else
		return
	end

	local viewName = info.data.viewName

	if string.nilorempty(viewName) then
		return
	end

	if self._oldHeadTabIndex and self._oldHeadTabIndex == self._curHeadTabIndex and self._oldSecTabIndex and self._oldSecTabIndex == self._curSecTabIndex then
		return
	else
		self._oldHeadTabIndex = self._curHeadTabIndex
		self._oldSecTabIndex = self._curSecTabIndex
	end

	if viewName == self._oldViewName then
		self:_onClearContentCol()
	end

	self._oldViewName = viewName

	local params

	if not string.nilorempty(info.data.params) then
		params = string.split(info.data.params, "#")
	end

	if params then
		self:showTabAt(self._contentCol, viewName, unpack(params))
	else
		self:showTabAt(self._contentCol, viewName)
	end

	SurveyController.instance:reportBehavior(checknumber(info.data.reportBehavior))
end

function TabFrameWorkMainView:_onClearContentCol()
	self:showTabAt(self._contentCol, "")

	self._oldHeadTabIndex = nil
	self._oldSecTabIndex = nil
	self._oldViewName = nil
end

function TabFrameWorkMainView:_trySetRed(headTabId, secTabId)
	if checknumber(headTabId) > 0 and checknumber(secTabId) > 0 then
		TabFrameWorkController.instance:trySetRedAsSecTab(self._frameId, headTabId, secTabId)
	elseif checknumber(headTabId) > 0 then
		TabFrameWorkController.instance:trySetRedAsHeadTab(self._frameId, headTabId)
	end
end

function TabFrameWorkMainView:_onClickBtnTip()
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(self._frameId)

	if not string.nilorempty(baseData.ruleKey) then
		TipsFacade.instance:openRulesView(baseData.ruleKey)
	end
end

function TabFrameWorkMainView:moveToVerticalCenter(headTabId, secTabId)
	if self._tabGoList and self._tabGoList[headTabId] and self._tabGoList[headTabId][secTabId] then
		local pos = GameUtil.getAnchoredPos(self._tabGoList[headTabId][secTabId])
		local contentPos = GameUtil.getAnchoredPos(self._tabScroContent)
		local contentSize = GameUtil.getHeight(self._tabScroContent)
		local viewSize = GameUtil.getHeight(self._tabScroView)

		if viewSize > contentSize + pos.y then
			GameUtil.setAnchoredPos(self._tabScroContent, contentPos.x, contentSize - viewSize)
		else
			GameUtil.setAnchoredPos(self._tabScroContent, contentPos.x, -pos.y)
		end
	end
end

function TabFrameWorkMainView:_onClickBtnClose()
	self._headTabIdOfJump = nil
	self._secTabIdOfJump = nil

	self:close()
end

return TabFrameWorkMainView

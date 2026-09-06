-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastFeedView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastFeedView", package.seeall)

local DumplingFeastFeedView = class("DumplingFeastFeedView", ViewComponent)

function DumplingFeastFeedView:buildUI()
	DumplingFeastFeedView.super.buildUI(self)

	self._imgBg = self:getGo("imgBg")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnBoss = self:getGo("btnBoss")
	self._redBtnBoss = self:getGo("btnBoss/redPoint")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total = self:getGo("prizeCol/total")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeCol_total_icon = self:getGo("prizeCol/total/icon")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DumplingFeastFeedView:bindEvents()
	DumplingFeastFeedView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBtnBoss, self)
end

function DumplingFeastFeedView:unbindEvents()
	DumplingFeastFeedView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBoss)
end

function DumplingFeastFeedView:onEnter()
	DumplingFeastFeedView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)

	RedPointController.instance:regRedPoint(self._redBtnBoss, RedPointModel.ID_DUMMPLINGFEAST_BOSS_DAMAGE_PRIZE)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastGainIntimacyProgressRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastFeedRes, self._onUpdate, self)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	self:_onUpdate()
end

function DumplingFeastFeedView:onExit()
	DumplingFeastFeedView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnBoss)
	self:_onClearPrizeCol()
	self:_onClearPetCol()
end

function DumplingFeastFeedView:_onUpdate()
	self:_onUpdatePrizeCol()
	self:_onUpdatePetCol()
end

function DumplingFeastFeedView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = -1

	for idx, data in ipairs(dataList) do
		if not self:_isHasGainPrize(data) then
			index = idx

			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function DumplingFeastFeedView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
	MaterialMgr.clearIcon(self._prizeCol_total_icon)
end

function DumplingFeastFeedView:_getProgressDataList()
	return DumplingFeastConfig.instance:getIntimacyProgressDatas(self._activityId) or {}
end

function DumplingFeastFeedView:_getSliderComp()
	return self._sliderComp
end

function DumplingFeastFeedView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function DumplingFeastFeedView:_getCurProgress()
	return self._subMo:getTotalIntimacy()
end

function DumplingFeastFeedView:_getProgressByData(data)
	return data.intimacy
end

function DumplingFeastFeedView:_getPrizeIdByData(data)
	return data.progressId
end

function DumplingFeastFeedView:_getPrizeStrByData(data)
	return data.prize
end

function DumplingFeastFeedView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isHasGainPrizeInIntimacy(prizeId)
end

function DumplingFeastFeedView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isEnoughGetPrizeInIntimacy(prizeId)
end

function DumplingFeastFeedView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._subMo:isCanGetPrizeInIntimacy(prizeId)
end

function DumplingFeastFeedView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	if isCanGet then
		local function loadedHandler(handlerTarget, eff)
			eff:setScrollRectClipping(scrollRect)
		end

		self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effectRoot, nil, true, nil, loadedHandler)
	else
		self:stopViewEffectUniGo(effectRoot)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function DumplingFeastFeedView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	self:stopViewEffectUniGo(effectRoot)
end

function DumplingFeastFeedView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeId = self:_getPrizeIdByData(data)

	DumplingFeastController.instance:sendPM_DumplingFeastGainIntimacyProgressReq(self._activityId)
end

function DumplingFeastFeedView:_onUpdatePetCol()
	local datas = DumplingFeastConfig.instance:getSupportPetDatas(self._activityId)
	local dataList = {}

	for _, data in pairs(datas) do
		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		return a.creepsId < b.creepsId
	end)
	self._petScrollerList:reloadData(dataList)
end

function DumplingFeastFeedView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function DumplingFeastFeedView:_updatePetCell(view, cell, data, tag)
	local index = cell.data
	local intimacy = self._subMo:getCreepsIntimacy(data.raceId)
	local maxIntimacy = data.maxIntimacyLimit
	local isOverMax = maxIntimacy <= intimacy
	local skinId = checknumber(data.faceId)

	if skinId <= 0 then
		skinId = data.raceId
	end

	local mainGo = cell.gameObject
	local posA = goutil.findChild(mainGo, "posA")
	local posB = goutil.findChild(mainGo, "posB")
	local root = goutil.findChild(mainGo, "root")
	local icon = goutil.findChild(mainGo, "root/mask/icon")
	local txtName = goutil.findChildTextComponent(mainGo, "root/txtName")
	local intimacyGo = goutil.findChild(mainGo, "root/intimacy")
	local txtIntimacy = goutil.findChildTextComponent(mainGo, "root/intimacy/txt")
	local tagReached = goutil.findChild(mainGo, "root/tagReached")
	local tagLove = goutil.findChild(mainGo, "root/tagLove")
	local posGo = index % 2 == 0 and posA or posB
	local x, y, z = Framework.TransformUtil.GetLocalPos(posGo.transform, 0, 0, 0)

	GameUtil.setLocalPos(root, x, y, z)

	txtName.text = data.creepsName
	txtIntimacy.text = intimacy

	GameUtil.SetActive(intimacyGo, not isOverMax)
	GameUtil.SetActive(tagReached, isOverMax)

	local isShowTagLove = false

	if not isOverMax then
		local loveDumplingMap = {}

		for _, v in ipairs(data.loveDumpling) do
			loveDumplingMap[v] = true
		end

		local dumplings = self._subMo:getAllDumplings()

		for dumplingId, qualityMap in pairs(dumplings) do
			if loveDumplingMap[dumplingId] then
				for quality, num in pairs(qualityMap) do
					if num > 0 then
						isShowTagLove = true

						break
					end
				end
			end

			if isShowTagLove then
				break
			end
		end
	end

	GameUtil.SetActive(tagLove, isShowTagLove)
	MaterialMgr.setIcon(icon, MatType.Pet, skinId, nil, nil)
	GameUtil.addClickHandler(root, function()
		UIStateManager.instance:push(ViewName.DumplingFeastPetView, self._activityId, data.creepsId)
	end, self)
end

function DumplingFeastFeedView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local icon = goutil.findChild(mainGo, "root/mask/icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(root)
end

function DumplingFeastFeedView:_onClickBtnTip()
	local data = DumplingFeastConfig.instance:getActivityData(self._activityId)
	local key = data and data.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function DumplingFeastFeedView:_onClickBtnBoss()
	UIStateManager.instance:push(ViewName.DumplingFeastBossView, self._activityId)
end

return DumplingFeastFeedView

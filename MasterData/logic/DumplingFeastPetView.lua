-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/view/DumplingFeastPetView.lua

module("logic.extensions.dumplingfeast.view.DumplingFeastPetView", package.seeall)

local DumplingFeastPetView = class("DumplingFeastPetView", ViewComponent)

function DumplingFeastPetView:buildUI()
	DumplingFeastPetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._headIcon = self:getGo("info/mask/icon")
	self._txtName = self:getTxt("info/txtName")
	self._intimacyGo = self:getGo("info/intimacy")
	self._txtIntimacy = self:getTxt("info/intimacy/txt")
	self._tagReached = self:getGo("info/tagReached")

	local progressScrView = self:getGo("progressCol/scrView")
	local progressScrCell = self:getGo("progressCol/scrCell")

	self._progressScrollerList = ScrollerList.create(progressScrView, progressScrCell, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._sliderComp = self:getSlider("progressCol/scrView/viewport/content/progressBar")
	self._txtScore = self:getTxt("progressCol/score/txt")

	local foodScrView = self:getGo("foodCol/scrView")
	local foodScrCell = self:getGo("foodCol/scrCell")

	self._foodScrollerList = ScrollerList.create(foodScrView, foodScrCell, GameUtil.handler(self._updateFoodCell, self), GameUtil.handler(self._clearFoodCell, self))
	self._emptyFood = self:getGo("foodCol/empty")
end

function DumplingFeastPetView:bindEvents()
	DumplingFeastPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DumplingFeastPetView:unbindEvents()
	DumplingFeastPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DumplingFeastPetView:onEnter()
	DumplingFeastPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._creepsId = checknumber(params[2])
	self._subMo = DumplingFeastController.instance:getSubMo(self._activityId)
	self._petData = DumplingFeastConfig.instance:getSupportPetData(self._activityId, self._creepsId)
	self._maxIntimacyLimit = self._petData.maxIntimacyLimit
	self._raceId = self._petData.raceId
	self._loveDumpling = self._petData.loveDumpling
	self._buffPlanId = self._petData.buffPlanId
	self._skinId = checknumber(self._petData.faceId)

	if self._skinId <= 0 then
		self._skinId = self._raceId
	end

	local datas = DumplingFeastConfig.instance:getIntimacyDatas(self._buffPlanId)

	self._intimacyDataList = {}

	for _, data in pairs(datas) do
		table.insert(self._intimacyDataList, data)
	end

	table.sort(self._intimacyDataList, function(a, b)
		return a.intimacy < b.intimacy
	end)

	self._loveDumplingMap = {}

	for i, v in ipairs(self._loveDumpling) do
		self._loveDumplingMap[v] = true
	end

	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastGainIntimacyProgressRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DumplingFeastFeedRes, self._handlePM_DumplingFeastFeedRes, self)
	self:_onUpdate()
end

function DumplingFeastPetView:onExit()
	DumplingFeastPetView.super.onExit(self)
	self:_onClearProgressCol()
	self:_onClearFoodCol()
	MaterialMgr.clearIcon(self._headIcon)
end

function DumplingFeastPetView:_handlePM_DumplingFeastFeedRes()
	FloatWordMgr.instance:show("投喂成功")
	self:_onUpdate()
end

function DumplingFeastPetView:_onUpdate()
	local dumplings = self._subMo:getAllDumplings()

	self._dumplingMoList = {}
	self._dumplingMoMap = {}
	self._selectNumMap = {}

	local curMoId = 0

	for dumplingId, qualityMap in pairs(dumplings) do
		for quality, num in pairs(qualityMap) do
			if num > 0 then
				curMoId = curMoId + 1

				local mo = {}

				mo.id = curMoId
				mo.dumplingId = dumplingId
				mo.quality = quality
				mo.num = num
				self._dumplingMoList[mo.id] = mo
				self._dumplingMoMap[mo.id] = mo
				self._selectNumMap[mo.id] = 0
			end
		end
	end

	table.sort(self._dumplingMoList, function(a, b)
		if a.quality == b.quality then
			return a.num > b.num
		end

		return a.quality > b.quality
	end)
	self:_onUpdateProgressCol()
	self:_onUpdateFoodCol()
	self:_onUpdateBtnSureUI()
	MaterialMgr.setIcon(self._headIcon, MatType.Pet, self._skinId)

	self._txtName.text = self._petData.creepsName

	local intimacy = self._subMo:getCreepsIntimacy(self._raceId)
	local isOverMax = intimacy >= self._maxIntimacyLimit

	self._txtIntimacy.text = intimacy

	GameUtil.SetActive(self._intimacyGo, not isOverMax)
	GameUtil.SetActive(self._tagReached, isOverMax)
end

function DumplingFeastPetView:_onUpdateBtnSureUI()
	local result = self:_getTrySureResultAndTips(false)

	GameUtil.SetGray(self._btnSure, result ~= GameEnum.ResultCode.Success)

	local curProgress = self._subMo:getCreepsIntimacy(self._raceId)
	local addScore = self:_calculateSelectTotalIntimacy()

	self._txtScore.text = addScore > 0 and string.format("当前亲密度：%s <color=#20b376>+%s</color>", curProgress, addScore) or string.format("当前亲密度：%s", curProgress)
end

function DumplingFeastPetView:_onUpdateProgressCol()
	local scoreList = {}

	for _, data in ipairs(self._intimacyDataList) do
		table.insert(scoreList, data.intimacy)
	end

	local curProgress = self._subMo:getCreepsIntimacy(self._raceId)
	local index = 0

	for idx, data in ipairs(self._intimacyDataList) do
		if curProgress >= data.intimacy then
			index = idx - 1
		else
			break
		end
	end

	self._progressScrollerList:reloadData(self._intimacyDataList)
	self._progressScrollerList:updateUnderSlider(self._sliderComp, curProgress, scoreList)
	self._progressScrollerList:MoveCellToCenter(index)

	local addScore = self:_calculateSelectTotalIntimacy()

	self._txtScore.text = addScore > 0 and string.format("当前亲密度：%s <color=#20b376>+%s</color>", curProgress, addScore) or string.format("当前亲密度：%s", curProgress)
end

function DumplingFeastPetView:_onClearProgressCol()
	self._progressScrollerList:dispose()
end

function DumplingFeastPetView:_updateProgressCell(view, cell, data, tag)
	local curProgress = self._subMo:getCreepsIntimacy(self._raceId)
	local isReached = curProgress >= data.intimacy
	local mainGo = cell.gameObject
	local tagReached = goutil.findChild(mainGo, "tagReached")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtBuffName = goutil.findChildTextComponent(mainGo, "txtBuffName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtProgress.text = string.format("亲密度：%s", data.intimacy)
	txtBuffName.text = data.name
	txtDesc.text = data.desc

	GameUtil.SetActive(tagReached, isReached)
end

function DumplingFeastPetView:_clearProgressCell(cell)
	return
end

function DumplingFeastPetView:_onUpdateFoodCol()
	self._foodScrollerList:reloadData(self._dumplingMoList)
	GameUtil.SetActive(self._emptyFood, #self._dumplingMoList <= 0)
end

function DumplingFeastPetView:_onClearFoodCol()
	self._foodScrollerList:dispose()
end

function DumplingFeastPetView:_updateFoodCell(view, cell, mo, tag)
	local dumplingId = mo.dumplingId
	local num = mo.num
	local quality = mo.quality
	local data = DumplingFeastConfig.instance:getDumplingData(self._activityId, mo.dumplingId)
	local isLove = self:_isLoveDumpling(dumplingId)
	local selectNum = self._selectNumMap[mo.id]
	local mainGo = cell.gameObject
	local qualityBg = goutil.findChild(mainGo, "qualityBg")
	local icon = goutil.findChild(mainGo, "icon")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local tagLove = goutil.findChild(mainGo, "tagLove")
	local btnLess = goutil.findChild(mainGo, "btnLess")

	txtCount.text = string.format("x%s/%s", selectNum, num)

	GameUtil.SetActive(tagLove, isLove)
	GameUtil.SetActive(btnLess, selectNum > 0)
	GameUtil.setUIImageSpriteIdx(qualityBg, quality - 1)

	local spriteName = GameUrl.getBigbgPngUrl(data.itemPath)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	GameUtil.addClickHandler(mainGo, function()
		local curIntimacy = self._subMo:getCreepsIntimacy(self._raceId)
		local selectTotalIntimacy = self:_calculateSelectTotalIntimacy()

		if curIntimacy >= self._maxIntimacyLimit or curIntimacy + selectTotalIntimacy >= self._maxIntimacyLimit then
			FloatWordMgr.instance:show("亲密度已达上限")

			return
		end

		local selectNum = self._selectNumMap[mo.id]
		local nextSelectNum = selectNum + 1

		if nextSelectNum > num then
			return
		end

		self._selectNumMap[mo.id] = nextSelectNum
		txtCount.text = string.format("x%s/%s", nextSelectNum, num)

		GameUtil.SetActive(btnLess, true)
		self:_onUpdateBtnSureUI()
	end)
	GameUtil.addClickHandler(btnLess, function()
		local selectNum = self._selectNumMap[mo.id]
		local nextSelectNum = selectNum - 1

		if nextSelectNum < 0 then
			return
		end

		self._selectNumMap[mo.id] = nextSelectNum
		txtCount.text = string.format("x%s/%s", nextSelectNum, num)

		GameUtil.SetActive(btnLess, nextSelectNum > 0)
		self:_onUpdateBtnSureUI()
	end)
end

function DumplingFeastPetView:_clearFoodCell(cell)
	local mainGo = cell.gameObject
	local btnLess = goutil.findChild(mainGo, "btnLess")
	local icon = goutil.findChild(mainGo, "icon")

	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(btnLess)
	uGuiUtil.clearImage(icon)
end

function DumplingFeastPetView:_isLoveDumpling(dumplingId)
	return self._loveDumplingMap[dumplingId] ~= nil
end

function DumplingFeastPetView:_onClickBtnSure()
	local result = self:_getTrySureResultAndTips(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local infoList = {}

	for id, num in pairs(self._selectNumMap) do
		if num > 0 then
			local mo = self._dumplingMoMap[id]

			if mo then
				table.insert(infoList, {
					dumplingId = mo.dumplingId,
					quality = mo.quality,
					num = num
				})
			end
		end
	end

	DumplingFeastController.instance:sendPM_DumplingFeastFeedReq(self._activityId, self._raceId, infoList)
end

function DumplingFeastPetView:_getTrySureResultAndTips(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

		if not isInTime then
			result = GameEnum.ResultCode.Error
			tips = "不在活动时间范围内"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isHasSelectDumpling = false

		for k, v in pairs(self._selectNumMap) do
			if v > 0 then
				isHasSelectDumpling = true

				break
			end
		end

		if not isHasSelectDumpling then
			result = GameEnum.ResultCode.Error
			tips = "请选择汤圆"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local curIntimacy = self._subMo:getCreepsIntimacy(self._raceId)

		if curIntimacy >= self._maxIntimacyLimit then
			result = GameEnum.ResultCode.Error
			tips = "亲密度已达上限"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DumplingFeastPetView:_calculateSelectTotalIntimacy()
	local totalIntimacy = 0

	for id, num in pairs(self._selectNumMap) do
		if num > 0 then
			local mo = self._dumplingMoMap[id]

			if mo then
				local dumplingId = mo.dumplingId
				local quality = mo.quality
				local singleIntimacy = self._subMo:calculateSingleDumplingIntimacy(dumplingId, quality, self._creepsId)

				totalIntimacy = totalIntimacy + singleIntimacy * num
			end
		end
	end

	return totalIntimacy
end

return DumplingFeastPetView

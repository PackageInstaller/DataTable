-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OrimatGameResetSeasonView.lua

module("logic.extensions.orimatgame.view.OrimatGameResetSeasonView", package.seeall)

local OrimatGameResetSeasonView = class("OrimatGameResetSeasonView", ViewComponent)

function OrimatGameResetSeasonView:buildUI()
	OrimatGameResetSeasonView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local seasonScrView = self:getGo("seasonCol/scrView")
	local seasonScrCell = self:getGo("seasonCol/scrCell")

	self._itemScrCell = self:getGo("seasonCol/itemScrCell")
	self._seasonScrollList = ScrollerList.create(seasonScrView, seasonScrCell, GameUtil.handler(self._updateSeasonCell, self), GameUtil.handler(self._clearSeasonCell, self))
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)

	self._btnGetPrize = self:getGo("prizeTips/btnGetPrize")
	self._redBtnGetPrize = self:getGo("prizeTips/btnGetPrize/redPoint")

	local prizeTipsScrCell = self:getGo("prizeTips/scrCell")
	local prizeTipsScrView = self:getGo("prizeTips/scrView")

	self._prizeTipsScrollList = ScrollerList.create(prizeTipsScrView, prizeTipsScrCell, GameUtil.handler(self._updatePrizeTipsCell, self), GameUtil.handler(self._clearPrizeTipsCell, self))

	self._prizeTipsScrollList:setCenterMode(true)

	self._btnToggle = self:getGo("btnToggle")
	self._tagSelect = self:getGo("btnToggle/tagSelect")
	self._txtResetTimes = self:getTxt("resetTimes/txt")
end

function OrimatGameResetSeasonView:bindEvents()
	OrimatGameResetSeasonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnToggle, self._onClickBtnToggle, self)
	GameUtil.addClickHandler(self._btnGetPrize, self._onClickBtnGetPrize, self)
end

function OrimatGameResetSeasonView:unbindEvents()
	OrimatGameResetSeasonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnToggle)
	GameUtil.rmClickHandler(self._btnGetPrize)
end

function OrimatGameResetSeasonView:onEnter()
	OrimatGameResetSeasonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._newestSeasonId = OriMatGameController.instance:getSeasonId()

	local isInTime = OriMatGameController.instance:isInTime(self._newestSeasonId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._seasonId = OriMatGameController.instance:getCurSeasonId()
	self._subMo = OriMatGameController.instance:getSubMo(self._newestSeasonId)

	if self._isFilter == nil then
		self._isFilter = true
	end

	GameUtil.SetActive(self._tagSelect, self._isFilter)
	RedPointController.instance:regRedPoint(self._redBtnGetPrize, RedPointModel.ID_ORIMATGAMEALLSEASONPRIZE)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameReOpenSeasonRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameOneKeyGainPrizeRes, self._handlePM_OriginMaterialGameOneKeyGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameAllSeasonRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OriMatGameChangeSeason, self._oriMatGameChangeSeason, self)
	self:_onUpdate()
end

function OrimatGameResetSeasonView:onExit()
	OrimatGameResetSeasonView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnGetPrize)
	self:_onClearSeasonColUI()
	self:_onClearPrizeTipsUI()
end

function OrimatGameResetSeasonView:_handlePM_OriginMaterialGameOneKeyGainPrizeRes()
	OriMatGameController.instance:sendPM_OriginMaterialGameAllSeasonReq()
	OriMatGameController.instance:sendPM_OriginMaterialGameInfoReq(self._seasonId)
end

function OrimatGameResetSeasonView:_oriMatGameChangeSeason(seasonId)
	self:close()
end

function OrimatGameResetSeasonView:_onUpdate()
	local seasonDataList = OriMatGameConfig.instance:getSeasonDataList()

	self._seasonDataList = {}

	for _, data in ipairs(seasonDataList) do
		if data.id <= self._newestSeasonId then
			table.insert(self._seasonDataList, data)
		end
	end

	self._prizeMatLists = {}

	for _, data in ipairs(self._seasonDataList) do
		local seasonId = data.id
		local prizePlanId = data.prizePlanId

		self._prizeMatLists[seasonId] = {}

		local cfg = OriMatGameConfig.instance:getPrizeCfgs(prizePlanId)

		if cfg then
			local matDic = {}

			for _, v in ipairs(cfg) do
				local isHasGain = OriMatGameModel.instance:isHasGainPrizeInSeason(seasonId, v.prizeId)
				local isCanGain = OriMatGameModel.instance:isCanGainPrizeInSeason(seasonId, v.prizeId)

				if not string.nilorempty(v.prize) then
					local arr = string.split(v.prize, "#")

					for _, matStr in ipairs(arr) do
						local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
						local matKey = matType .. ":" .. matId

						if not matDic[matKey] then
							local mat = {}

							mat.matKey = matKey
							mat.matType = matType
							mat.matId = matId
							mat.matNum = (mat.matNum or 0) + matNum

							local addWithNum = isHasGain and matNum or 0

							mat.curNum = (mat.curNum or 0) + addWithNum

							local addCanGainNum = isCanGain and matNum or 0

							mat.canGainNum = (mat.canGainNum or 0) + addCanGainNum
							matDic[matKey] = mat
						end
					end
				end
			end

			for _, mat in pairs(matDic) do
				table.insert(self._prizeMatLists[seasonId], mat)
			end

			table.sort(self._prizeMatLists[seasonId], function(a, b)
				if a.matType == b.matType then
					return a.matId < b.matId
				end

				return a.matType < b.matType
			end)
		end
	end

	local matDic = {}

	for seasonId, matList in pairs(self._prizeMatLists) do
		for _, v in ipairs(matList) do
			if not matDic[v.matKey] then
				matDic[v.matKey] = matDic[v.matKey]
				matDic[v.matKey].matKey = v.matKey
				matDic[v.matKey].matType = v.matType
				matDic[v.matKey].matId = v.matId
				matDic[v.matKey].matNum = (matDic[v.matKey].matNum or 0) + v.matNum
				matDic[v.matKey].curNum = (matDic[v.matKey].curNum or 0) + v.curNum
				matDic[v.matKey].canGainNum = (matDic[v.matKey].canGainNum or 0) + v.canGainNum
			end
		end
	end

	self._matList = TableUtil.toList(matDic)

	table.sort(self._matList, function(a, b)
		if a.canGainNum ~= b.canGainNum then
			return a.canGainNum > b.canGainNum
		end

		if a.matType ~= b.matType then
			return a.matType < b.matType
		end

		if a.matId ~= b.matId then
			return a.matId < b.matId
		end

		return false
	end)
	self:_onUpdateSeasonColUI()
	self:_onUpdatePrizeTipsUI()
end

function OrimatGameResetSeasonView:_onUpdateSeasonColUI()
	local dataList = {}

	for _, data in ipairs(self._seasonDataList) do
		local seasonId = data.id

		if self._isFilter then
			if not OriMatGameModel.instance:isFinishSeason(seasonId) then
				table.insert(dataList, data)
			end
		else
			table.insert(dataList, data)
		end
	end

	table.sort(dataList, function(a, b)
		local seasonIdA = a.id
		local seasonIdB = b.id
		local isNewestA = seasonIdA == self._newestSeasonId and 1 or 0
		local isNewestB = seasonIdB == self._newestSeasonId and 1 or 0

		if isNewestA ~= isNewestB then
			return isNewestB < isNewestA
		end

		local reOpenA = self._subMo:isReOpenSeason(seasonIdA) and 1 or 0
		local reOpenB = self._subMo:isReOpenSeason(seasonIdB) and 1 or 0

		if reOpenA ~= reOpenB then
			return reOpenB < reOpenA
		end

		return seasonIdB < seasonIdA
	end)
	self._seasonScrollList:reloadData(dataList)

	local index = 0

	for i, data in ipairs(dataList) do
		if self._seasonId == data.id then
			index = i - 1

			break
		end
	end

	self._seasonScrollList:MoveCellInView(index, true)

	local max = self._subMo:getTotalReOpenTimes()
	local left = self._subMo:getLeftReOpenTimes()

	self._txtResetTimes.text = string.format("本赛季剩余回溯次数：%s/%s", left, max)
end

function OrimatGameResetSeasonView:_onClearSeasonColUI()
	self._seasonScrollList:dispose()
end

function OrimatGameResetSeasonView:_updateSeasonCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local seasonId = data.id
	local curTotalWave = OriMatGameModel.instance:getWaveInSeason(seasonId)
	local maxTotalWave = OriMatGameModel.instance:getMaxWaveInSeason(seasonId)
	local isCurrent = seasonId == self._seasonId
	local isNewest = seasonId == self._newestSeasonId
	local isReOpen = self._subMo:isReOpenSeason(seasonId)
	local isUnlock = isReOpen or isNewest
	local curTimes = self._subMo:getLeftReOpenTimes()
	local isWithTimes = curTimes > 0
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local tagCur = goutil.findChild(mainGo, "tagCur")
	local tagNoTimes = goutil.findChild(mainGo, "tagNoTimes")
	local btnUnlock = goutil.findChild(mainGo, "btnUnlock")
	local btnSure = goutil.findChild(mainGo, "btnSure")

	txtName.text = string.format("S%s", data.id)
	txtScore.text = maxTotalWave <= curTotalWave and string.format("%s/%s", curTotalWave, maxTotalWave) or string.format("<color=#eb4624>%s</color>/%s", curTotalWave, maxTotalWave)

	GameUtil.SetActive(tagCur, isCurrent)
	GameUtil.SetActive(tagNoTimes, not isUnlock and not isWithTimes)

	local unlockResult = self:_getTryUnlockSeasonResultAndTips(false, seasonId)

	GameUtil.SetGray(btnUnlock, unlockResult ~= GameEnum.ResultCode.Success)
	GameUtil.SetActive(btnUnlock, not isUnlock)
	GameUtil.addClickHandler(btnUnlock, function()
		local result = self:_getTryUnlockSeasonResultAndTips(true, seasonId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local leftTimes = self._subMo:getLeftReOpenTimes()
		local tipsContent = string.format("是否解锁该赛季的回溯，解锁后可随时切换赛季\n剩余次数：%s", leftTimes)
		local isFinish = OriMatGameModel.instance:isFinishSeason(seasonId)

		local function okFunc()
			OriMatGameController.instance:sendPM_OriginMaterialGameReOpenSeasonReq(self._newestSeasonId, seasonId)
		end

		TipsFacade.instance:openPopupWindow("提示", (isFinish or nil) and string.format("该赛季已达最大波次奖励，是否解锁该赛季的回溯，解锁后可随时切换赛季\n剩余次数：%s", leftTimes), okFunc, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
	end, self)
	GameUtil.SetActive(btnSure, (isReOpen or isNewest) and not isCurrent)
	GameUtil.addClickHandler(btnSure, function()
		OriMatGameController.instance:changeSeason(seasonId)
	end, self)

	if not self._prizeMatLists[seasonId] then
		if not self._itemScrollerListDic[mainGo] then
			local scrollerList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = scrollerList

			scrollerList:reloadData(self._prizeMatLists[seasonId])
			scrollerList:dragNotifyParent()
		end
	end
end

function OrimatGameResetSeasonView:_clearSeasonCell(cell)
	local mainGo = cell.gameObject
	local btnUnlock = goutil.findChild(mainGo, "btnUnlock")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local scrollerList = self._itemScrollerListDic[mainGo]

	if scrollerList then
		scrollerList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end

	GameUtil.SetGray(btnUnlock, false)
	GameUtil.rmClickHandler(btnUnlock)
	GameUtil.rmClickHandler(btnSure)
end

function OrimatGameResetSeasonView:_updateItemCell(view, cell, mat, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	MaterialMgr.setIcon(icon, mat.matType, mat.matId)

	txtNum.text = string.format("%s/%s", mat.curNum, mat.matNum)
end

function OrimatGameResetSeasonView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function OrimatGameResetSeasonView:_onUpdatePrizeTipsUI()
	local matList = {}
	local isHasCanGain = false

	for _, mat in ipairs(self._matList) do
		if mat.matNum - mat.curNum > 0 then
			table.insert(matList, mat)
		end

		if mat.canGainNum > 0 then
			isHasCanGain = true
		end
	end

	self._prizeTipsScrollList:reloadData(matList)
	GameUtil.SetGray(self._btnGetPrize, not isHasCanGain)
end

function OrimatGameResetSeasonView:_onClearPrizeTipsUI()
	self._prizeTipsScrollList:dispose()
end

function OrimatGameResetSeasonView:_updatePrizeTipsCell(view, cell, mat, tag)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	MaterialMgr.setIcon(icon, mat.matType, mat.matId)

	txtNum.text = string.format("%s", mat.canGainNum)
end

function OrimatGameResetSeasonView:_clearPrizeTipsCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
end

function OrimatGameResetSeasonView:_onClickBtnToggle()
	self._isFilter = not self._isFilter

	GameUtil.SetActive(self._tagSelect, self._isFilter)
	self:_onUpdateSeasonColUI()
end

function OrimatGameResetSeasonView:_onClickBtnGetPrize()
	local isHasCanGain = false

	for _, mat in ipairs(self._matList) do
		if mat.canGainNum > 0 then
			isHasCanGain = true
		end
	end

	if not isHasCanGain then
		FloatWordMgr.instance:show("无可领取的奖励")

		return
	end

	OriMatGameController.instance:sendPM_OriginMaterialGameOneKeyGainPrizeReq()
end

function OrimatGameResetSeasonView:_getTryUnlockSeasonResultAndTips(isShowTips, seasonId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if seasonId == self._newestSeasonId then
		result = GameEnum.ResultCode.Error
		tips = "该赛季无需回溯"
	end

	if result == GameEnum.ResultCode.Success then
		local isReOpen = self._subMo:isReOpenSeason(seasonId)

		if isReOpen then
			result = GameEnum.ResultCode.Error
			tips = "该赛季已回溯"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTime = self._subMo:getLeftReOpenTimes()

		if leftTime <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "剩余回溯次数不足"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return OrimatGameResetSeasonView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarDispatchPetView.lua

module("logic.extensions.ultimatewar.view.UltimateWarDispatchPetView", package.seeall)

local UltimateWarDispatchPetView = class("UltimateWarDispatchPetView", ViewComponent)
local _CurTabIdx = 0

function UltimateWarDispatchPetView:buildUI()
	UltimateWarDispatchPetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tabScrView = self:getGo("tabCol/tabScrView")
	local tabScrCell = self:getGo("tabCol/tabScrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._supView = self:getGo("supView")
	self._supCell = self:getGo("supCell")

	local norScrView = self:getGo("norScrView")
	local norScrCell = self:getGo("norScrCell")

	self._norScrollList = ScrollerList.create(norScrView, norScrCell, GameUtil.handler(self._updateNorCell, self), GameUtil.handler(self._clearNorCell, self))
	self._btnDispatch = self:getGo("btnDispatch")
	self._redBtnDispatch = self:getGo("btnDispatch/redPoint")
	self._txtTips = self:getTxt("tips/txt")
	self._strTxtTips = self._txtTips.text
	self._btnBubbleTips = self:getGo("tips/txt/btnBubbleTips")
	self._bubbleGo = self:getGo("tips/txt/btnBubbleTips/bubbleGo")
	self._txtDesc = self:getTxt("tips/txt/btnBubbleTips/bubbleGo/txtDesc")
	self._strTxtDesc = self._txtDesc.text
	self._addGo = self:getGo("tips/txt/floatRoot/addGo")
	self._txtAddGo = self:getTxt("tips/txt/floatRoot/addGo/txt")
	self._customInput = UICustomInput.Get(self._btnBubbleTips)

	GameUtil.SetActive(self._supCell, false)
	GameUtil.SetActive(self._bubbleGo, false)
	GameUtil.SetActive(self._addGo, false)
end

function UltimateWarDispatchPetView:bindEvents()
	UltimateWarDispatchPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDispatch, self._onClickBtnDispatch, self)
	GameUtil.addClickHandler(self._btnBubbleTips, self._onClickBtnBubbleTips, self)
	self._customInput:AddListener(function()
		GameUtil.SetActive(self._bubbleGo, false)
	end, self)
end

function UltimateWarDispatchPetView:unbindEvents()
	UltimateWarDispatchPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDispatch)
	GameUtil.rmClickHandler(self._btnBubbleTips)
	self._customInput:RemoveListener()
end

function UltimateWarDispatchPetView:onEnter()
	UltimateWarDispatchPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._jumpTowerId = checknumber(params[2])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._tabDataList = UltimateWarConfig.instance:getDefenceLineCfg(self._activityId) or {}

	local matStr = UltimateWarConfig.instance:getGoldMat(self._activityId)

	self._matName = MaterialMgr.getMaterialsNameByCfg(matStr)

	if self._jumpTowerId > 0 then
		for tabIdx, data in ipairs(self._tabDataList) do
			if data.pointId == self._jumpTowerId then
				_CurTabIdx = tabIdx

				break
			end
		end
	end

	_CurTabIdx = Mathf.Clamp(_CurTabIdx, 1, #self._tabDataList)
	self._score2Item = UltimateWarConfig.instance:getScore2Item(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarFirstStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGainHangingPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarDispatchRes, self._handlePM_UltimateWarDispatchRes, self)
	self.addGEvent(self, GlobalNotify.HandBookInit, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandBookAttributeChange, self._onUpdate, self)
	self:_onUpdate()
	settimer(0.5, self._onTicking, self, true)
	self:_onTicking()
end

function UltimateWarDispatchPetView:onExit()
	UltimateWarDispatchPetView.super.onExit(self)

	if self._sequence then
		self._sequence:Kill(true)
	end

	self._tabScrollList:dispose()
	removetimer(self._onTicking, self)
end

function UltimateWarDispatchPetView:_handlePM_UltimateWarDispatchRes()
	self:_onUpdate()

	local pointData = self._tabDataList[_CurTabIdx]
	local pointInfo = self._ultimateWarMo:getPointInfo(pointData.pointId)
	local curXiaolv = pointInfo:getXiaoLvOfSec(3600)
	local different = curXiaolv - self._oldXiaoLv

	self._oldXiaoLv = curXiaolv
	self._txtAddGo.text = different < 0 and string.format("%s", different) or string.format("+%s", different)

	if self._sequence then
		self._sequence:Kill(true)

		self._sequence = nil
	end

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequence = sequence

	local targeGo = self._addGo

	GameUtil.setLocalPos(targeGo, 0, 0, 0)
	GameUtil.SetActive(targeGo, true)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 34

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.2)

	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	sequence:Join(tweenerMove)
	sequence:AppendInterval(1)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
	end)
end

function UltimateWarDispatchPetView:_onTicking()
	local nowMs = ServerTime.nowMs()
	local pointData = self._tabDataList[_CurTabIdx]
	local pointInfo = self._ultimateWarMo:getPointInfo(pointData.pointId)
	local max = pointInfo:getCurMaxLimtItem()
	local cur = pointInfo:getLeftItemCount()
	local lastRefreshTime = pointInfo:getLastRefreshTime()

	if pointInfo:getCurDispatchCount() > 0 and lastRefreshTime > 0 then
		local leftSec = Mathf.Max(nowMs - lastRefreshTime, 0) / 1000
		local xiaoLv = pointInfo:getXiaoLvOfSec(leftSec)

		cur = cur + Mathf.Floor(xiaoLv / self._score2Item)
	else
		cur = 0
	end

	cur = Mathf.Min(cur, max)

	local xiaolv = pointInfo:getXiaoLvOfSec(3600)

	self._txtTips.text = string.format(self._strTxtTips, xiaolv, pointData.name, cur, max, self._matName)
end

function UltimateWarDispatchPetView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function UltimateWarDispatchPetView:_onUpdateData()
	self._raceIdLists = UltimateWarController.instance:getCanDispatchAllPets(self._activityId)
end

function UltimateWarDispatchPetView:_onUpdateUI()
	local pointData = self._tabDataList[_CurTabIdx]
	local pointId = pointData.pointId
	local pointInfo = self._ultimateWarMo:getPointInfo(pointId)

	self._tabScrollList:reloadData(self._tabDataList)

	if not pointData.specialRaceIds then
		GameUtil.updateCellsList(self._supView, self._supCell, pointData.specialRaceIds, self._updateSupCell, self)

		local list = {}

		for index = 1, pointData.normalPetCountLimit do
			table.insert(list, index)
		end

		self._norScrollList:reloadData(list)

		local n1 = UltimateWarConfig.instance:getScore2Item(self._activityId)
		local n2 = pointInfo:getSpecialScoreRatio()
		local n3 = pointInfo:getScoreRatio()
		local n4 = 0

		if n4 then
			local value1 = UltimateWarConfig.instance:getAddScoreRatioByAwaken(self._activityId, 1)
			local value2 = UltimateWarConfig.instance:getAddScoreRatioByAwaken(self._activityId, 2)

			n4 = Mathf.Max(value2 - value1, 0)
		end

		self._txtDesc.text = string.format(self._strTxtDesc, n1, 1, self._matName, n2, n3, n4)

		local result = self:getTryDispatchResultAndTips(false, self._activityId, pointId)

		GameUtil.SetGray(self._btnDispatch, result ~= GameEnum.ResultCode.Success)
		GameUtil.SetActive(self._redBtnDispatch, result == GameEnum.ResultCode.Success)
		self:_onTicking()
	end
end

function UltimateWarDispatchPetView:_updateTabCell(view, cell, data, tag)
	local pointId = data.pointId
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local tag = goutil.findChild(mainGo, "tag")
	local redPoint = goutil.findChild(mainGo, "redPoint")

	txtName.text = data.name

	GameUtil.setUIGroupIdx(mainGo, _CurTabIdx == tabIdx and 1 or 0)
	GameUtil.SetActive(tag, self:_isFullDispatch(pointId))

	local result = self:getTryDispatchResultAndTips(false, self._activityId, pointId)

	GameUtil.SetActive(redPoint, result == GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(mainGo, function()
		_CurTabIdx = tabIdx

		self:_onUpdateUI()
	end)
end

function UltimateWarDispatchPetView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function UltimateWarDispatchPetView:_updateSupCell(mainGo, raceId, index)
	local data = self._tabDataList[_CurTabIdx]

	if not data.pointId then
		local pointInfo = self._ultimateWarMo:getPointInfo(data.pointId)
		local isDispatching = pointInfo:isDispatchingTheRace(raceId) or false
		local con = goutil.findChild(mainGo, "mask/con")
		local awake = goutil.findChild(mainGo, "awake")
		local txtAwake = goutil.findChildTextComponent(mainGo, "awake/txt")
		local imgAdd = goutil.findChild(mainGo, "imgAdd")
		local rareRoot = goutil.findChild(mainGo, "rare/root")
		local txtName = goutil.findChildTextComponent(mainGo, "name/txt")
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

		if modelCo and not string.nilorempty(modelCo.cardName) then
			local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

			uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
		end

		if isDispatching then
			local awakenLv = HandbookModel.instance:getAwakenNum(raceId)

			txtAwake.text = awakenLv <= 0 and "未觉醒" or string.format("觉醒%s", GameUtil.toRomanNumber(awakenLv))
		end

		txtName.text = CharacterConfig.instance:getPetName(raceId)

		MaterialMgr.setCell(MatType.Rare, raceId, rareRoot)
		GameUtil.SetActive(awake, isDispatching)
		GameUtil.SetActive(imgAdd, not isDispatching)
		GameUtil.addClickHandler(imgAdd, function()
			if not isDispatching then
				if self:_isActivePet(raceId) then
					self:_onClickBtnDispatch()
				else
					TipsFacade.instance:openItemSourceView(string.format("%s:%s", MatType.Pet, raceId))
				end
			end
		end)
	end
end

function UltimateWarDispatchPetView:_clearSupCell(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local imgAdd = goutil.findChild(mainGo, "imgAdd")
	local rareRoot = goutil.findChild(mainGo, "rare/root")

	uGuiUtil.clearImage(con)
	MaterialMgr.resetAll(rareRoot)
	GameUtil.rmClickHandler(imgAdd)
end

function UltimateWarDispatchPetView:_updateNorCell(view, cell, index, tag)
	local data = self._tabDataList[_CurTabIdx]

	if not data.pointId then
		local pointInfo = self._ultimateWarMo:getPointInfo(data.pointId)
		local raceIdList = pointInfo:getNorRaceIdOfDispatching() or {}
		local raceId = checknumber(raceIdList[index])
		local isDispatching = raceId > 0
		local mainGo = cell.gameObject
		local con = goutil.findChild(mainGo, "con")
		local imgAdd = goutil.findChild(mainGo, "imgAdd")
		local awake = goutil.findChild(mainGo, "awake")
		local txtAwake = goutil.findChildTextComponent(mainGo, "awake/txt")

		if raceId > 0 then
			MaterialMgr.setIcon(con, MatType.Pet, raceId, nil, nil)
		else
			MaterialMgr.clearIcon(con)
		end

		if isDispatching then
			local awakenLv = HandbookModel.instance:getAwakenNum(raceId)

			txtAwake.text = awakenLv <= 0 and "未觉醒" or string.format("觉醒%s", GameUtil.toRomanNumber(awakenLv))
		end

		GameUtil.SetActive(awake, isDispatching)
		GameUtil.SetActive(imgAdd, not isDispatching)
		GameUtil.addClickHandler(mainGo, function()
			if isDispatching then
				FloatWordMgr.instance:show("已部署")
			else
				self:_onClickBtnDispatch()
			end
		end)
	end
end

function UltimateWarDispatchPetView:_clearNorCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(mainGo)
end

function UltimateWarDispatchPetView:_onClickBtnDispatch()
	local pointData = self._tabDataList[_CurTabIdx]
	local pointId = pointData.pointId
	local result = self:getTryDispatchResultAndTips(true, self._activityId, pointId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH)

	local pointInfo = self._ultimateWarMo:getPointInfo(pointId)

	self._oldXiaoLv = pointInfo:getXiaoLvOfSec(3600)

	if not self._raceIdLists[pointId] then
		UltimateWarController.instance:sendPM_UltimateWarDispatchReq(self._activityId, pointId, self._raceIdLists[pointId])
	end
end

function UltimateWarDispatchPetView:_onClickBtnBubbleTips()
	GameUtil.SetActive(self._bubbleGo, not GameUtil.GetActive(self._bubbleGo))
end

function UltimateWarDispatchPetView:_isFullDispatch(pointId)
	local pointInfo = self._ultimateWarMo:getPointInfo(pointId)
	local cur = pointInfo:getCurDispatchCount()
	local max = pointInfo:getMaxDispatchCount()
	local allRaceIds = pointInfo:getAllRaceIds()
	local awakeCount = UltimateWarController.instance:getTotalAwakeCount(allRaceIds)
	local maxAwakeCount = max * 6

	return max <= cur and maxAwakeCount <= awakeCount
end

function UltimateWarDispatchPetView:_isNeedReqispatch(pointId)
	if not self._raceIdLists[pointId] then
		local pointInfo = self._ultimateWarMo:getPointInfo(pointId)
		local oldRaceIdList = pointInfo:getAllRaceIds()

		if not self._raceIdLists[pointId] then
			return UltimateWarController.instance:isNeedDispatchInPointByList(oldRaceIdList, self._raceIdLists[pointId])
		end
	end
end

function UltimateWarDispatchPetView:getTryDispatchResultAndTips(isShowTips, activityId, pointId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local isFull = self:_isFullDispatch(pointId)
	local isNeedReq = self:_isNeedReqispatch(pointId)

	if not isNeedReq and not isFull then
		result = GameEnum.ResultCode.ErrorLevel
		tips = "当前无变化，可以再去觉醒一下精灵噢~"
	elseif not isNeedReq and isFull then
		result = GameEnum.ResultCode.IsMaxLimit
		tips = "已部署"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function UltimateWarDispatchPetView:_isActivePet(raceId)
	return HandbookController.instance:isActivePet(raceId)
end

return UltimateWarDispatchPetView

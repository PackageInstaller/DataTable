-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemPuzzleView.lua

module("logic.extensions.tutorsystem.view.TutorSystemPuzzleView", package.seeall)

local TutorSystemPuzzleView = class("TutorSystemPuzzleView", ViewComponent)

function TutorSystemPuzzleView:buildUI()
	TutorSystemPuzzleView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._mask = goutil.findChild(self.mainGO, "mask")
	self._btnGift = goutil.findChild(self.mainGO, "btnGift")
	self._txtDayCount = goutil.findChildTextComponent(self.mainGO, "txtDayCount")
	self._strTxtDayCount = self._txtDayCount.text
	self._puzzleCol = goutil.findChild(self.mainGO, "puzzleCol")
	self._puzzleView = goutil.findChild(self.mainGO, "puzzleCol/puzzleView")
	self._puzzleCell = goutil.findChild(self.mainGO, "puzzleCol/puzzleCell")
	self._rewardCol = goutil.findChild(self.mainGO, "rewardCol")
	self._descCell = goutil.findChild(self.mainGO, "bubble/descCell")
	self._descView = goutil.findChild(self.mainGO, "bubble/descView")

	GameUtil.SetActive(self._puzzleCell, false)

	self._rewardEff = {}
end

function TutorSystemPuzzleView:bindEvents()
	TutorSystemPuzzleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._mask, self.close, self)
end

function TutorSystemPuzzleView:unbindEvents()
	TutorSystemPuzzleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._mask)
end

function TutorSystemPuzzleView:onEnter()
	TutorSystemPuzzleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_TutorStudentNewPuzzleInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_TutorStudentNewPuzzleGainPrizeRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.HandlePM_TutorStudentNewPuzzleActiveRes, self._handleTutorActivePuzzleRes, self)
	self:_sendInfoReq()
	self:_onUpdate()
end

function TutorSystemPuzzleView:onExit()
	TutorSystemPuzzleView.super.onExit(self)
	self:_clearRewardColUI()
	self:_clearPuzzleColUI()
	self:_clearDescColUI()
end

function TutorSystemPuzzleView:_sendInfoReq()
	TutorSystemController.instance:sendPM_TutorStudentNewPuzzleInfoReq()
end

function TutorSystemPuzzleView:_handleTutorActivePuzzleRes(msg)
	self:_sendInfoReq()
end

function TutorSystemPuzzleView:_onUpdate()
	self:_updatePlaneUI()
	self:_updatePuzzleColUI()
	self:_updateRewardColUI()
	self:_updateDescColUI()
end

function TutorSystemPuzzleView:_updatePlaneUI()
	local leftTimes = TutorSystemModel.instance:getLeftCanOpTimes()

	self._txtDayCount.text = string.format(self._strTxtDayCount, leftTimes)
end

function TutorSystemPuzzleView:_updatePuzzleColUI()
	local puzzleMapCfg = TutorSystemConfig.instance:getTsPuzzleMapCfg() or {}
	local childList = GameUtil.getChildren(self._puzzleView)

	for pointId = 0, #puzzleMapCfg do
		if not childList[pointId + 1] then
			local mainGo = goutil.cloneAndSetParent(self._puzzleCell, self._puzzleView.transform, self._puzzleCell.name .. "_" .. pointId)

			GameUtil.SetActive(childList[pointId + 1], true)
			self:_updatePuzzleCell(childList[pointId + 1], puzzleMapCfg[pointId])
		end
	end
end

function TutorSystemPuzzleView:_clearPuzzleColUI()
	for idx = 1, self._puzzleView.transform.childCount do
		local mainGo = self._puzzleView.transform:GetChild(idx - 1).gameObject

		self:_clearPuzzleCell(mainGo)
	end
end

function TutorSystemPuzzleView:_updatePuzzleCell(mainGo, data)
	local pointId = data.pointId
	local isHasActive = TutorSystemController.instance:isTutorPuzzlePosActive(pointId)
	local imgItem = goutil.findChild(mainGo, "imgItem")
	local lockGo = goutil.findChild(mainGo, "lockGo")
	local path = data.imgPath
	local bgGo = imgItem

	if not string.nilorempty(path) then
		local spriteName = string.format("ui/icon/%s.png", path)

		uGuiUtil.setSpriteToImage(bgGo, uGuiUtil.SpriteType.BigBg, spriteName, nil)
	else
		uGuiUtil.clearImage(bgGo)
	end

	GameUtil.SetActive(lockGo, not isHasActive)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPuzzleCell, self, mainGo, data))
end

function TutorSystemPuzzleView:_clearPuzzleCell(mainGo)
	local imgItem = goutil.findChild(mainGo, "imgItem")

	uGuiUtil.clearImage(imgItem)
end

function TutorSystemPuzzleView:_onClickPuzzleCell(mainGo, data)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local isActive = TutorSystemController.instance:isTutorPuzzlePosActive(data.pointId)
	local isHaveLeftTimes = TutorSystemController.instance:isPlayerHaveLeftTimesInPuzzle()
	local puzzleActiveCount = TutorSystemController.instance:getTutorPuzzleActiveCount()
	local maxCount = TutorSystemConfig.instance:getTsPuzzleMaxActivePos()

	if isActive then
		result = GameEnum.ResultCode.Error
		tips = "你已激活"
	elseif maxCount <= puzzleActiveCount then
		result = GameEnum.ResultCode.Error
		tips = "剩余总次数为0，不可点亮"
	elseif not isHaveLeftTimes then
		result = GameEnum.ResultCode.Error
		tips = "当前次数不足,无法点亮"
	end

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	TutorSystemController.instance:sendPM_TutorStudentNewPuzzleActiveReq(data.pointId)
end

function TutorSystemPuzzleView:_updateRewardColUI()
	local puzzlePrizeCfg = TutorSystemConfig.instance:getTsPuzzlePrizeCfg() or {}

	for prizeId, data in ipairs(puzzlePrizeCfg) do
		local mainGo = goutil.findChild(self._rewardCol, "reward" .. prizeId)

		if mainGo == nil then
			printError(string.format("缺少预制体, prizeId = %d", prizeId))

			return
		end

		self:_updateRewardCell(mainGo, data)
	end
end

function TutorSystemPuzzleView:_clearRewardColUI()
	for idx = 1, self._rewardCol.transform.childCount do
		local mainGo = self._rewardCol.transform:GetChild(idx - 1).gameObject

		self:_clearRewardCell(mainGo)
	end
end

function TutorSystemPuzzleView:_updateRewardCell(mainGo, data)
	local node = goutil.findChild(mainGo, "node")
	local effGo = goutil.findChild(mainGo, "effGo")
	local geted = goutil.findChild(mainGo, "geted")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local isCanGet = TutorSystemController.instance:isTutorPuzzlePrizeCanGet(data.prizeId)
	local isHasGain = TutorSystemController.instance:isTutorPuzzlePrizeHasGain(data.prizeId)

	MaterialMgr.setCellByCfg(data.prize, node)

	local effParent = effGo
	local pathName = "fx_ui_juqingfuben/fx_ui_juqingfuben02"

	UIEffectManager.instance:stopEffect(self._rewardEff[mainGo])

	if isCanGet and effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function loadedHandler(handlerTarget, eff)
			eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._rewardEff[mainGo] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, nil, loadedHandler, nil)
	end

	GameUtil.SetActive(geted, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)
	GameUtil.addClickHandler(btnGet, function()
		if isCanGet then
			TutorSystemController.instance:sendPM_TutorStudentNewPuzzleGainPrizeReq(data.prizeId)
		end
	end)
end

function TutorSystemPuzzleView:_clearRewardCell(mainGo)
	local node = goutil.findChild(mainGo, "node")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(node)
	GameUtil.rmClickHandler(btnGet)
	UIEffectManager.instance:stopEffect(self._rewardEff[mainGo])

	self._rewardEff[mainGo] = nil
end

function TutorSystemPuzzleView:_updateDescColUI()
	local cfg = TutorSystemConfig.instance:getTsPuzzleTaskCfg() or {}

	GameUtil.updateCellsList(self._descView, self._descCell, cfg, self._updateDescCell, self)
end

function TutorSystemPuzzleView:_clearDescColUI()
	GameUtil.clearCells(self._descView, self._clearDescCell, self)
end

function TutorSystemPuzzleView:_updateDescCell(mainGo, data, index)
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local imgReach = goutil.findChild(mainGo, "imgReach")
	local cur = TutorSystemController.instance:getCurProgressInPuzzleTask(data.key)

	txtDesc.text = string.format(data.desc, cur, data.max)

	local isReach = TutorSystemController.instance:isReachInPuzzleTask(data.key)

	GameUtil.setUIImageSpriteIdx(imgReach, isReach and 0 or 1)
end

function TutorSystemPuzzleView:_clearDescCell(mainGo)
	return
end

return TutorSystemPuzzleView

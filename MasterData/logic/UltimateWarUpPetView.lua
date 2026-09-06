-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarUpPetView.lua

module("logic.extensions.ultimatewar.view.UltimateWarUpPetView", package.seeall)

local UltimateWarUpPetView = class("UltimateWarUpPetView", ViewComponent)

function UltimateWarUpPetView:buildUI()
	UltimateWarUpPetView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._petUpEffRoot = self:getGo("petUpEffRoot")
	self._btnUp = self:getGo("btnUp/btn")
	self._redUpPet = self:getGo("btnUp/btn/redPoint")
	self._tipsBtnUp = self:getGo("btnUp/costTips")
	self._iconUpPet = self:getGo("btnUp/costTips/icon")
	self._txtTipsUpPet = self:getTxt("btnUp/costTips/txt")
	self._condTips = self:getGo("btnUp/condTips")
	self._txtTipsCond = self:getTxt("btnUp/condTips/txt")
	self._strTxtTipsCond = self._txtTipsCond.text
	self._btnPlay = self:getGo("btnPlay/btn")
	self._redBtnPlay = self:getGo("btnPlay/btn/redPoint")
	self._txtTipsPlay = self:getTxt("btnPlay/tips/txt")
	self._puzzleView = self:getGo("puzzleCol/puzzleView")
	self._puzzleCell = self:getGo("puzzleCol/puzzleCell")
	self._descCol = self:getGo("descCol")
	self._imgSym = self:getGo("descCol/imgSym")

	local left = self:getGo("descCol/left")
	local right = self:getGo("descCol/right")
	local mid = self:getGo("descCol/mid")

	self._descCells = {
		left,
		right,
		mid
	}
end

function UltimateWarUpPetView:bindEvents()
	UltimateWarUpPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUp, self._onClickBtnUp, self)
	GameUtil.addClickHandler(self._btnPlay, self._onClickBtnPlay, self)
end

function UltimateWarUpPetView:unbindEvents()
	UltimateWarUpPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUp)
	GameUtil.rmClickHandler(self._btnPlay)
end

function UltimateWarUpPetView:onEnter()
	UltimateWarUpPetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._gameType = self._actData.gameType

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarUpPetLevelRes, self._handlePM_UltimateWarUpPetLevelRes, self)
	self:_onSetUI()
	self:_onUpdate()

	if self._gameType == UltimateWarEnum.GameType_Axmm then
		self.addGEvent(self, GlobalNotify.AixinmmGameUpdateInfo, self._onUpdateExUI, self)

		local arr = string.split(self._actData.gameJumpStr, "#")
		local activityId = checknumber(arr[3])

		AixinmmGameController.instance:getInfo(activityId)
	end

	RedPointController.instance:regRedPoint(self._redUpPet, RedPointModel.ID_ULTIMATEWAR_PET_UP)
end

function UltimateWarUpPetView:onExit()
	UltimateWarUpPetView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnPlay)
	RedPointController.instance:unregRedPoint(self._redUpPet)
	MaterialMgr.clearIcon(self._iconUpPet)
	self:_onClear()
end

function UltimateWarUpPetView:_handlePM_UltimateWarUpPetLevelRes()
	local effParent = self._petUpEffRoot
	local path = "20241220/zhongyanzhizhan/fx_ui_xuanwohuiju.prefab"

	UIEffectManager.instance:stopEffect(self._petUpEff)

	local function finishHandler(handlerTarget, eff)
		local level = self._ultimateWarMo:getPetLevel()

		if not self._ultimateWarMo:isFinishPlotId(UltimateWarEnum.Story_Plot_3) and level >= 4 then
			UltimateWarController.instance:sendPM_UltimateWarFinishPlotReq(self._activityId, UltimateWarEnum.Story_Plot_3)

			local storyId = UltimateWarConfig.instance:getPlotStoryId(self._activityId, UltimateWarEnum.Story_Plot_3)

			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		self:_onUpdate()
	end

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(effParent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	self._petUpEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, finishHandler, loadedHandler, nil)
end

function UltimateWarUpPetView:_onUpdateExUI()
	if self._gameType == UltimateWarEnum.GameType_Axmm then
		local arr = string.split(self._actData.gameJumpStr, "#")
		local activityId = checknumber(arr[3])
		local left = AixinmmGameModel.instance:getLeftGameTimes(activityId)
		local max = AixinmmGameModel.instance:getMaxGameTimes(activityId)

		self._txtTipsPlay.text = string.format("%s/%s", left, max)
	end
end

function UltimateWarUpPetView:_onSetUI()
	local result = UltimateWarController.instance:getTryUpPetLevelResultAndTips(false, self._activityId)

	if result ~= GameEnum.ResultCode.NotInTime and result ~= GameEnum.ResultCode.IsMaxLimit then
		local value = self._actData.gameReds

		if not string.nilorempty(value) then
			local redIdList = string.split(value, "#")

			RedPointController.instance:regRedPoint(self._redBtnPlay, unpack(redIdList))
		end
	end

	self:_onUpdateExUI()
end

function UltimateWarUpPetView:_onUpdate()
	self._curLevel = self._ultimateWarMo:getPetLevel()

	local maxLevel = self._ultimateWarMo:getMaxPetLevel()
	local nextLevel = self._curLevel + 1
	local cfg = UltimateWarConfig.instance:getPetLevelCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._puzzleView, self._puzzleCell, cfg, self._updatePuzzleCell, self)

	local nextLevelData = UltimateWarConfig.instance:getPetLevelData(self._activityId, nextLevel)
	local param = nextLevelData and nextLevelData.param
	local cond, value

	if not string.nilorempty(param) then
		local arr = string.split(param, "$")

		cond = arr[1]
		value = arr[2]
	end

	self._txtTipsUpPet.text = ""

	MaterialMgr.clearIcon(self._iconUpPet)
	GameUtil.SetActive(self._tipsBtnUp, false)
	GameUtil.SetActive(self._condTips, false)

	if cond == "COST" then
		local matStr = value

		if not string.nilorempty(matStr) then
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			local curNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			self._txtTipsUpPet.text = string.format("%s/%s", curNum, matNum)

			MaterialMgr.setIcon(self._iconUpPet, matType, matId, nil, nil)
			GameUtil.SetActive(self._tipsBtnUp, true)
		end
	elseif cond == "PLOT" then
		local plotId = checknumber(value)
		local plotData = UltimateWarConfig.instance:getPlotData(self._activityId, plotId)

		self._txtTipsCond.text = string.format(self._strTxtTipsCond, plotData.name)

		GameUtil.SetActive(self._condTips, true)
	end

	for _, mainGo in pairs(self._descCells) do
		self:_clearDescCell(mainGo)
	end

	if maxLevel <= self._curLevel then
		self:_updateDescCell(self._descCells[3], maxLevel)
		GameUtil.SetActive(self._imgSym, false)
	else
		self:_updateDescCell(self._descCells[1], self._curLevel)
		self:_updateDescCell(self._descCells[2], nextLevel)
		GameUtil.SetActive(self._imgSym, true)
	end
end

function UltimateWarUpPetView:_onClear()
	GameUtil.clearCells(self._puzzleView, self._clearPuzzleCell, self)
end

function UltimateWarUpPetView:_updatePuzzleCell(mainGo, data, index)
	local isUnlock = data.petLevel <= self._curLevel
	local imgPuzzle = goutil.findChild(mainGo, "imgPuzzle")

	if not data.puzzlePos then
		if not data.puzzlePos[3] then
			local x, y, scale = checknumber(data.puzzlePos[1]), checknumber(data.puzzlePos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, data.puzzlePos[3], data.puzzlePos[3], data.puzzlePos[3])

			if isUnlock then
				self:_loadBigBg(imgPuzzle, string.format("ui/bigbg/%s", data.puzzleImgUrl), true)
			else
				self:_unLoadBigBg(imgPuzzle)
			end

			GameUtil.SetActive(mainGo, isUnlock)
		end
	end
end

function UltimateWarUpPetView:_clearPuzzleCell(mainGo)
	local imgPuzzle = goutil.findChild(mainGo, "imgPuzzle")

	self:_unLoadBigBg(imgPuzzle)
end

function UltimateWarUpPetView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = path .. ".png"

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end
end

function UltimateWarUpPetView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function UltimateWarUpPetView:_updateDescCell(mainGo, level)
	local data = UltimateWarConfig.instance:getPetLevelData(self._activityId, level)
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	txtLevel.text = level
	txtDesc.text = data.desc

	GameUtil.SetActive(mainGo, true)
end

function UltimateWarUpPetView:_clearDescCell(mainGo)
	GameUtil.SetActive(mainGo, false)
end

function UltimateWarUpPetView:_onClickBtnUp()
	local result = UltimateWarController.instance:getTryUpPetLevelResultAndTips(true, self._activityId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UltimateWarController.instance:sendPM_UltimateWarUpPetLevelReq(self._activityId)
end

function UltimateWarUpPetView:_onClickBtnPlay()
	GotoMgr.gotoByString(self._actData.gameJumpStr)
end

function UltimateWarUpPetView:_onClickBtnTip()
	local key = self._actData.petUpRuleKey

	TipsFacade.instance:openRulesView(key)
end

return UltimateWarUpPetView

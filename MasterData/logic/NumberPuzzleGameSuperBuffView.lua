-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameSuperBuffView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameSuperBuffView", package.seeall)

local NumberPuzzleGameSuperBuffView = class("NumberPuzzleGameSuperBuffView", ViewComponent)

function NumberPuzzleGameSuperBuffView:ctor()
	NumberPuzzleGameSuperBuffView.super.ctor(self)
end

function NumberPuzzleGameSuperBuffView:buildUI()
	NumberPuzzleGameSuperBuffView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._closeMask = goutil.findChild(self.mainGO, "closeMask")

	local buffScrView = goutil.findChild(self.mainGO, "buffCol/scrView")
	local buffScrCell = goutil.findChild(self.mainGO, "buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

	self._buffScrollerList:setCenterMode(true)
end

function NumberPuzzleGameSuperBuffView:bindEvents()
	NumberPuzzleGameSuperBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._closeMask, self.close, self)
end

function NumberPuzzleGameSuperBuffView:unbindEvents()
	NumberPuzzleGameSuperBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._closeMask)
end

function NumberPuzzleGameSuperBuffView:onEnter()
	NumberPuzzleGameSuperBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = NumberPuzzleGameController.instance:getActivityType()

	local isInTime = NumberPuzzleGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = NumberPuzzleGameConfig.instance:getNpgActData(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_2048InfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_2048ExtremeGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_2048OpenHangingEfficiencyRes, self._onUpdate, self)
	self:_onUpdate()
end

function NumberPuzzleGameSuperBuffView:onExit()
	NumberPuzzleGameSuperBuffView.super.onExit(self)
	self._buffScrollerList:dispose()
end

function NumberPuzzleGameSuperBuffView:_onUpdate()
	local cfg = NumberPuzzleGameConfig.instance:getNpgSupStageCfg(self._activityId) or {}

	self._buffScrollerList:reloadData(cfg)

	local index = 0

	for idx, data in ipairs(cfg) do
		if self:_isHasUnlock(data.gbId) then
			index = idx
		else
			break
		end
	end

	self._buffScrollerList:MoveCellToCenter(index)
end

function NumberPuzzleGameSuperBuffView:_updateBuffCell(view, cell, data, tag)
	local gbId = data.gbId
	local skinId = data.skinId
	local gbData = NumberPuzzleGameConfig.instance:getNpgGridLibDataById(gbId)
	local isHasUnlock = self:_isHasUnlock(gbId)
	local isCanUnlock = self:_isCanUnlock(gbId)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")
	local imgLock = goutil.findChild(mainGo, "imgLock")
	local imgCanUnlock = goutil.findChild(mainGo, "imgCanUnlock")
	local txtMaxGb = goutil.findChildTextComponent(mainGo, "txtMaxGb")
	local txtSpeed = goutil.findChildTextComponent(mainGo, "txtSpeed")

	txtMaxGb.text = gbData.name
	txtSpeed.text = string.format("%s积分/分钟", gbData.hangingEfficiency)

	local modelCo = CharacterConfig.instance:getModelCo(skinId)
	local spriteName = GameUrl.getPetImgUrl(modelCo.cardName)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName, function()
		icon:GetComponent(goutil.Type_UIImage):SetNativeSize()
	end)
	GameUtil.SetActive(imgLock, not isHasUnlock and not isCanUnlock)
	GameUtil.SetActive(imgCanUnlock, isCanUnlock)
	GameUtil.addClickHandler(mainGo, function()
		if isHasUnlock then
			return
		elseif not isCanUnlock then
			FloatWordMgr.instance:show("未达成")

			return
		end

		NumberPuzzleGameController.instance:sendPM_2048OpenHangingEfficiencyReq(self._activityId, gbId)
	end)
end

function NumberPuzzleGameSuperBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "mask/icon")

	uGuiUtil.clearImage(icon)
end

function NumberPuzzleGameSuperBuffView:_isCanUnlock(gbId)
	return NumberPuzzleGameController.instance:isCanUnlock(gbId)
end

function NumberPuzzleGameSuperBuffView:_isEnoughUnlock(gbId)
	return NumberPuzzleGameController.instance:isEnoughUnlock(gbId)
end

function NumberPuzzleGameSuperBuffView:_isHasUnlock(gbId)
	return NumberPuzzleGameController.instance:isHasUnlock(gbId)
end

return NumberPuzzleGameSuperBuffView

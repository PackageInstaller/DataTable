-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalGameSelectView.lua

module("logic.extensions.landlords.view.FalGameSelectView", package.seeall)

local FalGameSelectView = class("FalGameSelectView", ViewComponent)

function FalGameSelectView:buildUI()
	FalGameSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._gameScrollerview = goutil.findChild(self.mainGO, "gameCol/gameScrollerview")
	self._gameScrollercell = goutil.findChild(self.mainGO, "gameCol/gameScrollercell")
	self._gameScrollList = ScrollerList.create(self._gameScrollerview, self._gameScrollercell, GameUtil.handler(self._updateGameCell, self), GameUtil.handler(self._clearGameCell, self))
end

function FalGameSelectView:bindEvents()
	FalGameSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FalGameSelectView:unbindEvents()
	FalGameSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function FalGameSelectView:onEnter()
	FalGameSelectView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()
	self._baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)

	self:_onUpdateGameColUI()
end

function FalGameSelectView:onExit()
	FalGameSelectView.super.onExit(self)
	self._gameScrollList:dispose()
end

function FalGameSelectView:_onUpdateGameColUI()
	local gameCfg = FightAgainstLandlordsConfig.instance:getFalGameCfg(self._activityId)

	self._gameScrollList:reloadData(gameCfg)
	GameUtil.SetGray(self._btnSure, checknumber(self._selectGameId) == 0)
end

function FalGameSelectView:_updateGameCell(view, cell, data, tag)
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local txtMinScoreLimit = MaterialMgr.findGraphicText(mainGo, "txtMinScoreLimit")
	local clickArea = goutil.findChild(mainGo, "clickArea")
	local item = goutil.findChild(mainGo, "item")
	local limitStr = "未配置"

	if not string.nilorempty("dadada") then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._baseData.scoreItem)
		local itemStr = string.format("<quad name=%s:%s|icon size=40 width=1 offsetY=-8/>", matType, matId)

		limitStr = string.format("%s%s", data.minScoreLimit, itemStr)
	end

	txtMinScoreLimit.text = limitStr

	GameUtil.setUIImageSpriteIdx(item, index - 1)
	GameUtil.SetActive(imgSelect, self._selectGameId == data.gameId)

	txtTitle.text = data.gameName

	GameUtil.addClickHandler(clickArea, function()
		if self._curImgSelectGo then
			GameUtil.SetActive(self._curImgSelectGo, false)
		end

		if self._selectGameId == data.gameId then
			self._selectGameId = 0
		else
			self._selectGameId = data.gameId
			self._curImgSelectGo = imgSelect

			GameUtil.SetActive(self._curImgSelectGo, true)
		end

		GameUtil.SetGray(self._btnSure, checknumber(self._selectGameId) == 0)
	end, self)
end

function FalGameSelectView:_clearGameCell(cell)
	local mainGo = cell.gameObject
	local clickArea = goutil.findChild(mainGo, "clickArea")

	GameUtil.rmClickHandler(clickArea)
end

function FalGameSelectView:_onClickSure()
	if checknumber(self._selectGameId) == 0 then
		FloatWordMgr.instance:show("未选择对应模式")

		return
	end

	local result, tips = FightAgainstLandlordsController.instance:getTryMathResult(self._activityId, self._selectGameId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:close()
	FightAgainstLandlordsController.instance:initFalGameMo(self._activityId, self._selectGameId)
	UIStateManager.instance:push(ViewName.FalMatchView)
end

return FalGameSelectView

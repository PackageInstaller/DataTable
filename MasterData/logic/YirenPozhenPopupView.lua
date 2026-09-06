-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/YirenPozhenPopupView.lua

module("logic.extensions.yirenpozhen.view.YirenPozhenPopupView", package.seeall)

local YirenPozhenPopupView = class("YirenPozhenPopupView", ViewComponent)

function YirenPozhenPopupView:ctor()
	YirenPozhenPopupView.super.ctor(self)
end

function YirenPozhenPopupView:buildUI()
	YirenPozhenPopupView.super.buildUI(self)

	self._btnGame = self:getBtn("btnGame")
	self._btnClose = self:getBtn("btnClose")
	self._cells = {}

	for i = 1, 3 do
		local obj = {}

		obj.btn = self:getBtn("cell_" .. i .. "/btnChall")
		obj.txt = self:getTxt("cell_" .. i .. "/txt")

		table.insert(self._cells, obj)
	end

	self._txtTitle = self:getTxt("txtTitle")
end

function YirenPozhenPopupView:bindEvents()
	YirenPozhenPopupView.super.bindEvents(self)
	self._btnGame:AddClickListener(self._openGame, self)

	for i = 1, 3 do
		self._cells[i].btn:AddClickListener(function()
			self:_clickChall(i)
		end)
	end

	self._btnClose:AddClickListener(self.close, self)
end

function YirenPozhenPopupView:unbindEvents()
	YirenPozhenPopupView.super.unbindEvents(self)
	self._btnGame:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for i = 1, 3 do
		self._cells[i].btn:RemoveClickListener()
	end
end

function YirenPozhenPopupView:destroyUI()
	YirenPozhenPopupView.super.destroyUI(self)
end

function YirenPozhenPopupView:onEnter()
	YirenPozhenPopupView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HexagramGameStart, self._startGameRes, self)

	self._diagramsId = self._viewPresentor:getFirstParam()
	self._diagramCfg = YirenPozhenConfig.instance:getDiagramsCfg(self._diagramsId)
	self._txtTitle.text = self._diagramCfg.name

	local maxStageId = self._diagramCfg.maxStageId

	self._stageData = {
		YirenPozhenConfig.instance:getStageCfg(maxStageId - 2),
		YirenPozhenConfig.instance:getStageCfg(maxStageId - 1),
		(YirenPozhenConfig.instance:getStageCfg(maxStageId))
	}

	local passStageId = YirenPozhenModel.instance:getPassStageId()

	for i = 1, 3 do
		local obj = self._cells[i]
		local data = self._stageData[i]

		obj.btn.gameObject:SetActive(data.stageId == passStageId + 1)

		obj.txt.text = data.stageName
	end

	self._btnGame.gameObject:SetActive(passStageId >= self._stageData[3].stageId)
end

function YirenPozhenPopupView:onEnterFinished()
	YirenPozhenPopupView.super.onEnterFinished(self)
end

function YirenPozhenPopupView:onExit()
	YirenPozhenPopupView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HexagramGameStart, self._startGameRes, self)
end

function YirenPozhenPopupView:onExitFinished()
	YirenPozhenPopupView.super.onExitFinished(self)
end

function YirenPozhenPopupView:_clickChall(i)
	local passStageId = YirenPozhenModel.instance:getPassStageId()
	local params = {}

	params.creepsMasterId = self._stageData[i].creepsMasterId
	params.stageId = self._stageData[i].stageId
	params.diagramId = self._diagramsId

	YirenPozhenModel.instance:setcreepsMasterId(params.creepsMasterId)
	UIStateManager.instance:push(ViewName.HexagramMissionView, params)
	self:close()
end

function YirenPozhenPopupView:_openGame()
	if checknumber(self._diagramsId) > 0 then
		local diagramCfg = YirenPozhenConfig.instance:getDiagramsCfg(self._diagramsId)

		self.gameId = checknumber(diagramCfg.gameId)

		local clientKey = ServerTime.nowServerLook()

		YirenPozhenModel.instance:setClientKey(clientKey)
		TheOutcastChallengeAgent.instance:sendPM_TheOutcastChallengeGameReq(self.gameId, clientKey)
	end
end

function YirenPozhenPopupView:_startGameRes()
	YirenPozhenController.instance:openHexagramGame(self.gameId)
	self:close()
end

return YirenPozhenPopupView

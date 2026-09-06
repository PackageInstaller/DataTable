-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsGameResultView.lua

module("logic.extensions.goddessglory.view.GuessPetsGameResultView", package.seeall)

local GuessPetsGameResultView = class("GuessPetsGameResultView", ViewComponent)

function GuessPetsGameResultView:buildUI()
	GuessPetsGameResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._rankNodes = {}
	self._rankNodes[1] = self:_buildRankNode(self:getGo("frist"))
	self._rankNodes[2] = self:_buildRankNode(self:getGo("second"))
	self._rankNodes[3] = self:_buildRankNode(self:getGo("third"))
end

function GuessPetsGameResultView:_buildRankNode(go)
	local rankNode = {}

	rankNode.go = go
	rankNode.headcell = goutil.findChild(go, "headcell")
	rankNode.txtName = goutil.findChildTextComponent(go, "txtName")
	rankNode.txtScore = goutil.findChildTextComponent(go, "txtScore")

	return rankNode
end

function GuessPetsGameResultView:bindEvents()
	GuessPetsGameResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function GuessPetsGameResultView:unbindEvents()
	GuessPetsGameResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GuessPetsGameResultView:onEnter()
	GuessPetsGameResultView.super.onEnter(self)
	self:_refreshPlayerView()
end

function GuessPetsGameResultView:onExit()
	GuessPetsGameResultView.super.onExit(self)

	for i = 1, #self._rankNodes do
		HeadItemController.instance:resetHeadCell(self._rankNodes[i].headcell)
	end
end

function GuessPetsGameResultView:_refreshPlayerView()
	local gameMO = GuessPetModel.instance:getGuessGameMo()
	local players = gameMO.players

	table.sort(players, function(x, y)
		if not gameMO.guessGameResult[x.playerHeadInfo.userId] then
			local scoresX = 0

			if not gameMO.guessGameResult[y.playerHeadInfo.userId] then
				local scoresY = 0

				return scoresY < scoresX
			end
		end
	end)

	local maxPlayerNum = #players

	for i = 1, maxPlayerNum do
		local rankNode = self._rankNodes[i]

		if not rankNode then
			break
		end

		local player = players[i]

		rankNode.go:SetActive(true)

		local scores = gameMO.guessGameResult[player.playerHeadInfo.userId]

		rankNode.txtName.text = player.playerHeadInfo.userName
		rankNode.txtScore.text = tostring(scores or 0)

		HeadItemController.instance:setHeadCellByInfo(rankNode.headcell, player.playerHeadInfo)
	end

	for i = maxPlayerNum + 1, #self._rankNodes do
		local rankNode = self._rankNodes[i]

		rankNode.go:SetActive(false)
	end
end

function GuessPetsGameResultView:_onClickClose()
	self:close()
	UIStateManager.instance:popByName(ViewName.GuessPetsGame)
end

return GuessPetsGameResultView

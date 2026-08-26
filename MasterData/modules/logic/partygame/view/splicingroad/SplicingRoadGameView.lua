-- chunkname: @modules/logic/partygame/view/splicingroad/SplicingRoadGameView.lua

module("modules.logic.partygame.view.splicingroad.SplicingRoadGameView", package.seeall)

local SplicingRoadGameView = class("SplicingRoadGameView", SceneGameCommonView)
local GameState = {
	ShowPlayerIcon = 3,
	PlayAnim = 4,
	PlayerMove = 5,
	PlayerOper = 2,
	RoundTips = 1,
	None = 0
}

function SplicingRoadGameView:onInitView()
	self._goround = gohelper.findChild(self.viewGO, "#go_roundTips")
	self._txtround = gohelper.findChildTextMesh(self.viewGO, "#go_playeranswers/#txt_round")
	self._goplayeranswers = gohelper.findChild(self.viewGO, "#go_playeranswers")
	self._animplayeranswers = gohelper.findComponentAnim(self._goplayeranswers)
	self._isAnswerActive = false

	self._animplayeranswers:Play("out", 0, 1)
	SplicingRoadGameView.super.onInitView(self)
end

function SplicingRoadGameView:onCreateCompData()
	self.partyGameCountDownData = {
		getCountDownFunc = self.getCountDownFunc,
		context = self
	}
end

function SplicingRoadGameView:onOpen()
	SplicingRoadGameView.super.onOpen(self)
	gohelper.setActive(self._goJoystick, false)
	self:initAnswers()
end

function SplicingRoadGameView:initAnswers()
	local item = gohelper.findChild(self._goplayeranswers, "item")

	self._answers = {}

	for i = 1, 4 do
		local go = gohelper.cloneInPlace(item, "item" .. i)

		self._answers[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SplicingRoadPlayerAnswerItem, {
			index = i
		})
	end

	gohelper.setActive(item, false)
end

function SplicingRoadGameView:viewUpdate()
	local curState = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurGameStatus()

	if curState ~= self._curState then
		self._curState = curState

		self:onStateChange(curState)
	end

	local showAnswers = curState == GameState.PlayerOper or curState == GameState.ShowPlayerIcon

	if curState == GameState.PlayerOper then
		local selectInfos = {}
		local playerList = PartyGameModel.instance:getCurGamePlayerList()

		for k, v in pairs(playerList) do
			if v:isMainPlayer() then
				local selectIndex = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetPlayerSelectIndex(v.uid)

				if selectIndex > 0 then
					selectInfos[selectIndex] = {
						v
					}
				end

				break
			end
		end

		for i, v in ipairs(self._answers) do
			v:updateSelects(selectInfos[i])
		end
	end

	gohelper.setActive(self._goplayerlist, not showAnswers)
	self:updateAnswerActive(showAnswers)
end

function SplicingRoadGameView:updateAnswerActive(isActive)
	if isActive == self._isAnswerActive then
		return
	end

	self._isAnswerActive = isActive

	self._animplayeranswers:Play(isActive and "in" or "out")
end

function SplicingRoadGameView:getCountDownFunc()
	local curState = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurGameStatus()

	if curState == GameState.PlayerOper then
		return (PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurRoundTime())
	end
end

function SplicingRoadGameView:onStateChange(curState)
	if curState == GameState.RoundTips then
		local curRound = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurRound()
		local maxRound = tonumber(PartyGameConfig.instance:getConstValue(190001)) or 0

		self.partyGameRoundTip:setRoundData(curRound, maxRound)

		return
	elseif curState == GameState.PlayerOper then
		local curRound = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurRound()
		local maxRound = tonumber(PartyGameConfig.instance:getConstValue(190001)) or 0

		self._txtround.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("PartyGameRoundTip_2"), curRound, maxRound)

		local cfgIds = {
			PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetCurMapCfgIds(0, 0, 0, 0)
		}

		for i, v in ipairs(self._answers) do
			v:updateAnswer(cfgIds[i])
		end
	elseif curState == GameState.ShowPlayerIcon then
		local selectInfos = {}
		local playerList = PartyGameModel.instance:getCurGamePlayerList()

		for k, v in pairs(playerList) do
			local selectIndex = PartyGameCSDefine.SplicingRoadGameInterfaceCs.GetPlayerSelectIndex(v.uid)

			if selectIndex > 0 then
				selectInfos[selectIndex] = selectInfos[selectIndex] or {}

				table.insert(selectInfos[selectIndex], v)
			end
		end

		for i, v in ipairs(self._answers) do
			v:updateSelects(selectInfos[i])
		end
	end

	self.partyGameRoundTip:setRoundData()
end

return SplicingRoadGameView

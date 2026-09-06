-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessGamePlayerView.lua

module("logic.extensions.goddessglory.view.GuessGamePlayerView", package.seeall)

local GuessGamePlayerView = class("GuessGamePlayerView")

function GuessGamePlayerView:ctor(playerNode, view)
	self._view = view
	self._playerNode = playerNode
	self._headCell = goutil.findChild(playerNode, "headcell")
	self._curScores = goutil.findChildTextComponent(playerNode, "score/txt")
	self._answerNode = goutil.findChild(playerNode, "answer")
	self._answerTxt = goutil.findChildTextComponent(playerNode, "answer/txt")
	self._resultTrue = goutil.findChild(playerNode, "true")
	self._resultFalse = goutil.findChild(playerNode, "false")
	self._txtName = goutil.findChildTextComponent(playerNode, "txtName")
	self._nodeOffline = goutil.findChild(playerNode, "txtState")
	self._firstTipNode = goutil.findChild(playerNode, "firstTip")
	self._firstTipTxt = goutil.findChildTextComponent(playerNode, "firstTip/txt")
end

function GuessGamePlayerView:setPlayer(playerInfo)
	self._playerInfo = playerInfo

	HeadItemController.instance:setHeadCellByInfo(self._headCell, playerInfo.playerHeadInfo)

	self._txtName.text = playerInfo.playerHeadInfo.userId == RoleModel.instance:getUserId() and string.format("<color=#62f6ff>%s</color>", playerInfo.playerHeadInfo.userName) or string.format("<color=#ffffff>%s</color>", playerInfo.playerHeadInfo.userName)

	self:setScores(playerInfo.scores)
	self:setFirstTips()
	self:setOffline(false)
	self:setAnswer()
	self:setResult()
end

function GuessGamePlayerView:getPlayerInfo()
	return self._playerInfo
end

function GuessGamePlayerView:setScores(scores)
	self._curScores.text = "积分：" .. scores
end

function GuessGamePlayerView:setFirstTips(firstTip)
	if string.nilorempty(firstTip) then
		if self._firstEff then
			self._firstEff:SetActive(false)
		end

		return
	end

	if self._firstTipTxt then
		self._firstTipTxt.text = firstTip
	end

	self:_playFirstEffect(firstTip)
end

function GuessGamePlayerView:setOffline(offline)
	self._nodeOffline:SetActive(offline)
end

function GuessGamePlayerView:setActive(active)
	self._playerNode:SetActive(active)
end

function GuessGamePlayerView:getPlayerNode()
	return self._playerNode
end

function GuessGamePlayerView:clear()
	removetimer(self._autoHideResult, self)
	HeadItemController.instance:resetHeadCell(self._headCell)

	if self._firstEff then
		goutil.destroy(_firstEff)

		self._firstEff = nil
	end

	self._firstTipTxt = nil
end

function GuessGamePlayerView:setAnswer(answer)
	if string.nilorempty(answer) then
		self._answerNode:SetActive(false)

		return
	end

	self._answerNode:SetActive(true)

	self._answerTxt.text = answer
end

function GuessGamePlayerView:setResult(result, isMine)
	removetimer(self._autoHideResult, self)

	if result == nil then
		self._resultTrue:SetActive(false)
		self._resultFalse:SetActive(false)

		return
	end

	self._resultTrue:SetActive(result and isMine)
	self._resultFalse:SetActive(not result and isMine)

	if not result then
		settimer(6, self._autoHideResult, self, false)
	end
end

function GuessGamePlayerView:_autoHideResult()
	removetimer(self._autoHideResult, self)
	self._resultTrue:SetActive(false)
	self._resultFalse:SetActive(false)
	self._answerNode:SetActive(false)
end

function GuessGamePlayerView:_playFirstEffect(firstTip)
	if not self._firstEff then
		local res = rescache:GetResourceNoLoadIfNotExists(GuessPetsGameViewPresentor.firstlyAnswerEff)
		local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self._view.mainGO)

		self._firstEff = goutil.clone(res:GetMainAsset())

		self._firstEff.transform:SetParent(self._firstTipNode.transform, false)
		GoUtil.SetSortingOrder(self._firstEff, sortingOrder)

		self._firstTipTxt = goutil.findChildTextComponent(self._firstEff, "qiangda/qiangda+/num")
		self._firstTipTxt.text = firstTip
	end

	self._firstEff:SetActive(true)
end

return GuessGamePlayerView

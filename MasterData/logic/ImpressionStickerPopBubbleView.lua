-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickerpopbubble/view/ImpressionStickerPopBubbleView.lua

module("logic.extensions.impressionstickerpopbubble.view.ImpressionStickerPopBubbleView", package.seeall)

local ImpressionStickerPopBubbleView = class("ImpressionStickerPopBubbleView", ViewComponent)

function ImpressionStickerPopBubbleView:buildUI()
	ImpressionStickerPopBubbleView.super.buildUI(self)

	self._txtTip = self:getTxt("bubble_2/bg/bg2/txtTip")
end

function ImpressionStickerPopBubbleView:bindEvents()
	ImpressionStickerPopBubbleView.super.bindEvents(self)
end

function ImpressionStickerPopBubbleView:unbindEvents()
	ImpressionStickerPopBubbleView.super.unbindEvents(self)
end

function ImpressionStickerPopBubbleView:onEnter()
	ImpressionStickerPopBubbleView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandBookPowerCheckRank, self._setUI, self)

	local params = self:getOpenParam() or {}

	self._raceId = params[1]
	self._rankId = params[2]
	self._rankType = params[3]

	if checknumber(self._raceId) == 0 then
		printError("ImpressionStickerPopBubbleView: 传入raceId为空或为0")

		return
	elseif self._raceId < 0 then
		printError("ImpressionStickerPopBubbleView: 传入非法raceId")

		return
	end

	self._maxImpressionStickerNum = HandbookConfig.instance:getImpressionStickerMaxNum(self._rankId)

	local serverParams = PetRankModel._ServerParams[self._rankType]

	PetManualAgent.instance:sendGetRaceZdlRankReq(self._raceId, serverParams.sRT, serverParams.sST, 0, false, true)
end

function ImpressionStickerPopBubbleView:onExit()
	ImpressionStickerPopBubbleView.super.onExit(self)
end

function ImpressionStickerPopBubbleView:_setUI()
	local _, _, _, hasGetStickNum = PetRankModel.instance:getRankData(self._rankType, self._raceId)

	self._txtTip.text = "印象贴数量:\n<color=#FFED00FF>" .. hasGetStickNum .. "/" .. self._maxImpressionStickerNum .. "</color>"

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getGo("bubble_2/bg/bg2"):GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self:getGo("bubble_2/bg"):GetComponent(goutil.Type_RectTransform))
end

return ImpressionStickerPopBubbleView

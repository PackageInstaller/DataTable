-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmoyanclg/view/OriginKingMoYanClgFailView.lua

module("logic.extensions.originkingmoyanclg.view.OriginKingMoYanClgFailView", package.seeall)

local OriginKingMoYanClgFailView = class("OriginKingMoYanClgFailView", BattleSettlementSuccessView)

function OriginKingMoYanClgFailView:buildUI()
	OriginKingMoYanClgFailView.super.buildUI(self)

	self._isSuccess = false
end

return OriginKingMoYanClgFailView

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmoonshadowking/view/OriginMoonShadowKingBossPassView.lua

module("logic.extensions.originmoonshadowking.view.OriginMoonShadowKingBossPassView", package.seeall)

local OriginMoonShadowKingBossPassView = class("OriginMoonShadowKingBossPassView", ShenJiBossPassView)

function OriginMoonShadowKingBossPassView:_initDescTxt()
	local isPassAll = ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId)

	self._txtDesc1.text = isPassAll and "恭喜通关" or "关卡解锁"

	local txt1 = "您已完成本次挑战所有关卡"
	local txt2 = ""

	self._txtDesc2.text = isPassAll and txt1 or txt2
end

return OriginMoonShadowKingBossPassView

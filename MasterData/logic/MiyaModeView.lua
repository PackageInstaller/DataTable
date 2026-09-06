-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaModeView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaModeView", package.seeall)

local MiyaModeView = class("MiyaModeView", TLChallengeTipView)

function MiyaModeView:buildUI()
	MiyaModeView.super.buildUI(self)

	self._txtModeName = self:getTxt("curMode/txtName")
	self._txtModeDesc = self:getTxt("curMode/txtDesc")
	self._imgIconChange = self:getGo("curMode/imgIcon"):GetComponent(typeof(UIImageSpriteChange))
end

function MiyaModeView:onEnter()
	MiyaModeView.super.onEnter(self)

	local curModeId = MiyaGameModel.instance:getCurModeId()
	local modeCfg = MiyaGameConfig.instance:getModeCfg(curModeId)
	local gameTime, passNeedNum = MiyaGameController.instance:getModeBubbleParams(curModeId)
	local hasParams = not string.nilorempty(modeCfg.smallBubble)

	if hasParams then
		self._txtModeDesc.text = string.format(modeCfg.smallBubble, gameTime, passNeedNum)
	else
		local curDifficulty = MiyaGameModel.instance:getCurDifficulty()
		local difficultyCfg = MiyaGameConfig.instance:getDifficultyCfg(curDifficulty)

		self._txtModeDesc.text = "推荐战力：" .. MiyaGameController.instance:getRecommendZdl(curDifficulty)
	end

	self._txtModeName.text = modeCfg.modeName

	self._imgIconChange:SetState(MathUtil.clamp(curModeId, 1, 5) - 1)
end

return MiyaModeView

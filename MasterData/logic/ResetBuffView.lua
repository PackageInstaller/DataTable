-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tlctip/ResetBuffView.lua

module("logic.extensions.timelimitedchallenge.view.ResetBuffView", package.seeall)

local ResetBuffView = class("ResetBuffView", TLChallengeTipView)

function ResetBuffView:onExit()
	ResetBuffView.super.onExit(self)
end

function ResetBuffView:buildUI()
	ResetBuffView.super.buildUI(self)

	self._buffCell = PanduolaBuffCell.New(self:getGo("buffCell"))
	self._imgChange = goutil.findChildComponent(self.mainGO, "bg", typeof(UIImageSpriteChange))
end

function ResetBuffView:onEnter()
	ResetBuffView.super.onEnter(self)

	local params = self._params

	self._buffCell:updateWithPanduolaBuffCfg(params.buffCfg)
	self._imgChange:SetState(params.challengeId - 1)
end

return ResetBuffView

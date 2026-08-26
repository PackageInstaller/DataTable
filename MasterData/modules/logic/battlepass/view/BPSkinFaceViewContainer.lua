-- chunkname: @modules/logic/battlepass/view/BPSkinFaceViewContainer.lua

module("modules.logic.battlepass.view.BPSkinFaceViewContainer", package.seeall)

local BPSkinFaceViewContainer = class("BPSkinFaceViewContainer", BaseViewContainer)

function BPSkinFaceViewContainer:buildViews()
	return {
		BPSkinFaceView.New()
	}
end

function BPSkinFaceViewContainer:openInternal(viewParam, isImmediate)
	local viewSetting = self:getSetting()

	if viewSetting then
		local skinId = viewParam and viewParam.skinId

		viewSetting.mainRes = self:_getMainResPath(skinId)
	end

	BPSkinFaceViewContainer.super.openInternal(self, viewParam, isImmediate)
end

function BPSkinFaceViewContainer:_getMainResPath(skinId)
	local bpsvpCo = BpConfig.instance:getBpSkinViewParamCO(skinId)

	if bpsvpCo and not string.nilorempty(bpsvpCo.storePrefab) then
		return string.format("ui/viewres/battlepass/%s.prefab", bpsvpCo.storePrefab)
	end

	return "ui/viewres/battlepass/bpfaceview2.prefab"
end

return BPSkinFaceViewContainer

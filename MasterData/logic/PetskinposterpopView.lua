-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinposterpopView.lua

module("logic.extensions.petskin.view.PetskinposterpopView", package.seeall)

local PetskinposterpopView = class("PetskinposterpopView", PetskinposterView)

function PetskinposterpopView:ctor()
	PetskinposterpopView.super.ctor(self)
end

function PetskinposterpopView:buildUI()
	PetskinposterpopView.super.buildUI(self)

	self._txtLock = self:getTxt("lockTip/txtLock")
end

function PetskinposterpopView:onEnter()
	PetskinposterpopView.super.onEnter(self)

	self._posterModelCfg = CharacterConfig.instance:getPosterModelCosNoHidden()

	if self._posterModelCfg then
		if not #self._posterModelCfg then
			local totalPosterNum = 0
			local hasPosterNum = self:_getActivePosterNum()
			local params = self:getOpenParam() or {}

			if not params[1] then
				local posterId = 0
				local posterCfg = CharacterConfig.instance:getPosterModelCo(posterId)
				local isNotHide = posterCfg and posterCfg.isHideInPreview == 0 or false

				self._txtLock.text = isNotHide and string.format("恭喜您，成功解锁海报，这是您获得的第%d/%d个海报", hasPosterNum, totalPosterNum) or string.format("恭喜您，成功解锁海报")
			end
		end
	end
end

function PetskinposterpopView:_getActivePosterNum()
	local posterNum = 0

	for i, posterCfg in ipairs(self._posterModelCfg) do
		local isHas = PetskinController.instance:getPosterActive(posterCfg)

		if isHas then
			posterNum = posterNum + 1
		end
	end

	return posterNum
end

return PetskinposterpopView

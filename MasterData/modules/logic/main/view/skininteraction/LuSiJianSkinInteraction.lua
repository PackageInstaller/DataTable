-- chunkname: @modules/logic/main/view/skininteraction/LuSiJianSkinInteraction.lua

module("modules.logic.main.view.skininteraction.LuSiJianSkinInteraction", package.seeall)

local LuSiJianSkinInteraction = class("LuSiJianSkinInteraction", CommonSkinInteraction)
local b_jiaohu_03 = "b_jiaohu_03"

function LuSiJianSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	if curBodyName == b_jiaohu_03 then
		self._musicValue = SettingsModel.instance:getMusicValue()

		SettingsModel.instance:setMusicValue(0)
	end

	if prevBodyName == b_jiaohu_03 then
		self:_resetMusicValue()
	end
end

function LuSiJianSkinInteraction:_resetMusicValue()
	if self._musicValue then
		if SettingsModel.instance:getMusicValue() == 0 then
			SettingsModel.instance:setMusicValue(self._musicValue)
		end

		self._musicValue = nil
	end
end

function LuSiJianSkinInteraction:_onDestroy()
	LuSiJianSkinInteraction.super._onDestroy(self)
	self:_resetMusicValue()
end

return LuSiJianSkinInteraction

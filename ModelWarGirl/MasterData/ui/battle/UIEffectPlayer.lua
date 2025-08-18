-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\UIEffectPlayer.lua

local strClassName = "UIEffectPlayer"
local UIEffectPlayer = Class(strClassName, UIControls.Window)

function UIEffectPlayer:ctor(...)
	self:initUI()
end

function UIEffectPlayer:initUI(...)
	self.efxPanel = UIControls.LazyEffectPlayer(self, "EfxUI")
end

function UIEffectPlayer:playUIEfx(efxPath, length, mirror)
	if self.efxPanel then
		return self.efxPanel:playEffectByPath(efxPath, length, mirror)
	end
end

return UIEffectPlayer

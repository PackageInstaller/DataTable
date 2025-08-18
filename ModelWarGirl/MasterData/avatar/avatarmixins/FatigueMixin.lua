-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\FatigueMixin.lua

local FatigueMixin = {}

function FatigueMixin:initFatigueMixin()
	if RegionUtils.isCN() then
		self:showUnderAgeTip()
	end
end

function FatigueMixin:destroyFatigueMixin()
	return
end

function FatigueMixin:onFatigueSwitchNotify(isOn)
	return
end

function FatigueMixin:showUnderAgeTip()
	if self.userAge and self.userAge < 18 then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(104), Lang.get(51881))
	end
end

return FatigueMixin

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ClientAchieves\\ClientAchieveBase.lua

local ClientAchieveBase = Class("ClientAchieveBase")

function ClientAchieveBase:ctor(clientAchieveMixin)
	self.parentMixin = clientAchieveMixin
end

function ClientAchieveBase:initAchieveData(achieveId, achieveValue, achieveExtraValue)
	return
end

return ClientAchieveBase

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ClientAchieves\\ClientAchieveTestClass.lua

local ClientAchieveBase = require("Avatar/AvatarMixins/ClientAchieves/ClientAchieveBase")
local ClientAchieveTestClass = Class("ClientAchieveTestClass", ClientAchieveBase)

function ClientAchieveTestClass:initAchieveData(achieveId, achieveValue, achieveExtraValue)
	self.parentMixin.achieveQualify[achieveId] = true
end

return ClientAchieveTestClass

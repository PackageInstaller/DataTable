-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Logo\\MvpLogo.lua

local strClassName = "MvpLogo"
local MvpLogo = Class(strClassName, UIControls.Logo)

function MvpLogo:ctor(entity, prefabPath, x, y)
	self.entity = entity
	self.name = ""

	self:initUI()
end

function MvpLogo:initUI(...)
	return
end

return MvpLogo

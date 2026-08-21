-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridHookContainerChild.lua

local ResGridSpecialImgConfig = require("ClientData/ResGridSpecialImgConfig")
local GridHookContainerChild = Class("GridHookContainerChild", UIControls.GridContainerChild)

function GridHookContainerChild:ctor()
	self.gridPath = "GridContainer"
end

function GridHookContainerChild:setHook(isHook)
	if not self.hookImage then
		self.hookImage = UIControls.Image(self, "IconHookAward")
	end

	self.hookImage:setVisible(isHook)

	self.isHook = isHook
end

function GridHookContainerChild:setHookIcon(gridSpecialConfig)
	if ResGridSpecialImgConfig[gridSpecialConfig] then
		if not self.hookImage then
			self.hookImage = UIControls.Image(self, "IconHookAward")
		end

		self.hookImage:setImage("Atlas/" .. ResGridSpecialImgConfig[gridSpecialConfig].icon_path, ResGridSpecialImgConfig[gridSpecialConfig].icon_name)
	end
end

return GridHookContainerChild

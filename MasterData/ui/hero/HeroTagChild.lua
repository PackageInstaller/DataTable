-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroTagChild.lua

local HeroTagChild = Class("HeroTagChild", UIControls.Child)

function HeroTagChild:ctor(...)
	self:initUI()
end

function HeroTagChild:initUI()
	self.imgMark = UIControls.Image(self, "ImgMark")
	self.txtName = UIControls.Label(self, "TxtName")
end

function HeroTagChild:setData(info)
	self.data = info

	self.txtName:setText(info.name)
	self.imgMark:setImage("Atlas/" .. info.color_path, info.color_icon)
end

return HeroTagChild

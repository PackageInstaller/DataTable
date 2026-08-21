-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroTagTipChild.lua

local HeroTagTipChild = Class("HeroTagTipChild", UIControls.Child)

function HeroTagTipChild:ctor()
	self.imgMark = UIControls.Image(self, "ImgMark")
	self.txtName = UIControls.Label(self, "TxtName")
	self.txtDis = UIControls.Label(self, "TxtDes")
end

function HeroTagTipChild:setData(data)
	self.txtName:setText(data.name)
	self.txtDis:setText(data.desc)
	self.imgMark:setImage("Atlas/" .. data.color_path, data.color_icon)
end

return HeroTagTipChild

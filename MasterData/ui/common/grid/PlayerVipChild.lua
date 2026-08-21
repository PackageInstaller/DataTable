-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\PlayerVipChild.lua

local ResVip = require("ClientData/ResVip")
local UIControls = UIControls
local PlayerVipChild = Class("PlayerVipChild", UIControls.Child)

function PlayerVipChild:ctor()
	self.imgVip = UIControls.Image(self, "IconVIP")
	self.textVip = UIControls.Label(self, "Text")
end

function PlayerVipChild:setData(value, needHide)
	needHide = 1

	local vipData = ResVip[value]

	if needHide == 1 or vipData == nil or value == 0 then
		self:setVisible(false)
	else
		self:setVisible(true)
		self.imgVip:setImage("Atlas/CommonAtlas/HeadFrameAtlas/HeadFrameAtlas", vipData.icon_name)
		self.textVip:setText(vipData.name or "")
	end
end

return PlayerVipChild

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\QQ\\QQPrivilegeBeginnerPart.lua

local ResQQBlueAchieveForeverGift = require("ClientData/ResQQBlueAchieveForeverGift")
local strClassName = "QQPrivilegeBeginnerPart"
local QQPrivilegeBeginnerPart = Class(strClassName, UIControls.Child)

function QQPrivilegeBeginnerPart:ctor()
	self:initUI()
end

function QQPrivilegeBeginnerPart:initUI()
	self.btnGet = UIControls.Button(self, "BtnFunc", "TextPrice")

	self.btnGet:addEventClick(self.onGetClick)

	local randId = ResQQBlueAchieveForeverGift[1].award_id

	self.awardItems = {}

	ClientUtils.CreateBonusGrid(self, self.awardItems, "GiftPanel", randId, true, 6, true)
	self:onRefresh()
end

function QQPrivilegeBeginnerPart:onRefresh()
	if CurAvatar.qqPrivilege.foreverAward[1] then
		self.btnGet:setEnable(false)
		self.btnGet:setText(Lang.get(74))

		for _, grid in ipairs(self.awardItems) do
			grid:setGet(true)
		end
	elseif CurAvatar:getQQBlueStep() > 0 then
		self.btnGet:setEnable(true)
		self.btnGet:setText(Lang.get(38))
	else
		self.btnGet:setEnable(false)
		self.btnGet:setText(Lang.get(99))
	end
end

function QQPrivilegeBeginnerPart:onGetClick()
	RPC.qQBlueGetForeverAward(0, 1)
end

return QQPrivilegeBeginnerPart

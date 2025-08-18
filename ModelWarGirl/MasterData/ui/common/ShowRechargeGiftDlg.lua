-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\ShowRechargeGiftDlg.lua

local ResRechargeShow = require("ClientData/ResRechargeShow")
local ShowRechargeGiftDlg = Class("ShowRechargeGiftDlg", UIControls.Window)

function ShowRechargeGiftDlg:ctor(...)
	self:initUI()
end

function ShowRechargeGiftDlg:initUI(...)
	self.iconPrivilege = UIControls.Image(self, "Bg/PrivilegePanel/IconPrivilege")
	self.textDec = UIControls.Label(self, "Bg/TxtDes")
	self.textTitle = UIControls.Label(self, "Bg/TextTitle")
end

function ShowRechargeGiftDlg:setShow(rechargeID)
	if ResRechargeShow and ResRechargeShow[rechargeID] then
		local resData = ResRechargeShow[rechargeID]

		self.textTitle:setText(resData.title)
		self.textDec:setText(resData.desc)
		self.iconPrivilege:setImage(resData.icon_path, resData.icon_name)

		local titleColor = resData.color_title ~= nil and resData.color_title or {
			255,
			255,
			255
		}

		self.textTitle:setColorByRGBA(titleColor[1], titleColor[2], titleColor[3])

		local descColor = resData.color_desc ~= nil and resData.color_desc or {
			255,
			255,
			255
		}

		self.textDec:setColorByRGBA(descColor[1], descColor[2], descColor[3])
	end
end

return ShowRechargeGiftDlg

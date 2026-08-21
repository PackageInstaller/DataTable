-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\DispatchExtraAwardDlg.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "DispatchExtraAwardDlg"
local DispatchExtraAwardDlg = Class(strClassName, UIControls.Window)

function DispatchExtraAwardDlg:ctor(...)
	self:initUI()
end

function DispatchExtraAwardDlg:initUI(...)
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
	self.award = UIControls.getGridAwardContainer(self, "BgPanel/GridMaterialItemPanel")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function DispatchExtraAwardDlg:setData(taskData, critNum)
	local descIds

	if taskData ~= nil then
		descIds = taskData:getCritDescIds()
	end

	local awardItem = RearHouseCommon.getDispatchCriAward()

	if awardItem then
		if critNum then
			awardItem.num = awardItem.num * critNum
		end

		self.award:setObj(awardItem)

		self.award.grid.mDisableWays = true

		self.award:setVisible(true)
	end

	local strIds = utils.splitString(descIds, ",")
	local randId = math.random(#strIds)
	local noticeId = tonumber(strIds[randId])

	if noticeId then
		local desc = ResClientNotice[noticeId].notice or ""

		self.txtRule:setText(desc)
	else
		self.txtRule:setText("You are a lucky guy!")
	end
end

function DispatchExtraAwardDlg:onBtnConfirmClick(...)
	self.award.grid:flyToCommonFuncEntryPanel()
	self:setVisible(false)
end

return DispatchExtraAwardDlg

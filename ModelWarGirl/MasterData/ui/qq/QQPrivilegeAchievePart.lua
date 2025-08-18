-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\QQ\\QQPrivilegeAchievePart.lua

local ResQQBlueAchieveForeverGift = require("ClientData/ResQQBlueAchieveForeverGift")
local QQPrivilegeAchieveCell = Class("QQPrivilegeAchieveCell", UIControls.Child)

function QQPrivilegeAchieveCell:ctor()
	self:initUI()
end

function QQPrivilegeAchieveCell:initUI()
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.confirmBtn:addEventClick(self.onBtnClick)

	self.stateLable = UIControls.Label(self, "Bg/TextState")
	self.ruleLable = UIControls.Label(self, "Bg/TextRule")
	self.awardItems = {}
end

function QQPrivilegeAchieveCell:onBtnClick()
	RPC.qQBlueGetForeverAward(0, self.achData.id)
end

function QQPrivilegeAchieveCell:setData(achData)
	ClientUtils.CreateBonusGrid(self, self.awardItems, "Bg/GridItemPanel", achData.award_id, true, 2, true)
	self.ruleLable:setText(achData.desc or "")

	self.achData = achData
end

function QQPrivilegeAchieveCell:refreshState()
	if CurAvatar.qqPrivilege.foreverAward and CurAvatar.qqPrivilege.foreverAward[self.achData.id] then
		self.confirmBtn:setVisible(false)
		self.stateLable:setVisible(true)
		self.stateLable:setText(Lang.get(74))

		for _, grid in ipairs(self.awardItems) do
			grid:setGet(true)
		end
	else
		for _, grid in ipairs(self.awardItems) do
			grid:setGet(false)
		end

		if CurAvatar:isBattlePassedServerMode(self.achData.check_param) and CurAvatar:getQQBlueStep() > 0 then
			self.confirmBtn:setVisible(true)
			self.stateLable:setVisible(false)
		else
			self.confirmBtn:setVisible(false)
			self.stateLable:setVisible(true)
			self.stateLable:setText(Lang.get(99))
		end
	end
end

local strClassName = "QQPrivilegeAchievePart"
local QQPrivilegeAchievePart = Class(strClassName, UIControls.Child)

function QQPrivilegeAchievePart:ctor()
	self:initUI()
end

function QQPrivilegeAchievePart:initUI()
	self.panelContent = UIControls.Panel(self, "FundList/Content")
	self.cells = {}

	local startIndex

	for index = 2, #ResQQBlueAchieveForeverGift do
		local newCell = QQPrivilegeAchieveCell(self, "FundList/Content", "System/QQ/QQPrivilegeAchieveCell")

		newCell:setVisible(true)
		newCell:setData(ResQQBlueAchieveForeverGift[index])
		table.insert(self.cells, newCell)

		if not startIndex and (not CurAvatar.qqPrivilege.foreverAward or not CurAvatar.qqPrivilege.foreverAward[index]) then
			startIndex = index - 1
		end
	end

	startIndex = math.min(startIndex or #ResQQBlueAchieveForeverGift, #ResQQBlueAchieveForeverGift - 6)

	local coordY = 124 * (startIndex - 1)

	self.panelContent:setPosition(0, coordY)
end

function QQPrivilegeAchievePart:onRefresh()
	for _, cell in ipairs(self.cells) do
		cell:refreshState()
	end
end

return QQPrivilegeAchievePart

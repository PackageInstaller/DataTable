-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainStageSpeedUpDlg.lua

local ResRandClient = require("ClientData/ResRandClient")
local MainStageSpeedUpCell = Class("MainStageSpeedUpCell", UIControls.Panel)

function MainStageSpeedUpCell:ctor()
	self.iconMoney = UIControls.Image(self, self.mPath .. "/Icon")
	self.textMoney1 = UIControls.Label(self, self.mPath .. "/TextNum1")
	self.textMoney2 = UIControls.Label(self, self.mPath .. "/TextNum2")
	self.panelEff = UIControls.Panel(self, self.mPath .. "/EfxUpgrade")
end

function MainStageSpeedUpCell:update()
	return
end

local strClassName = "MainStageSpeedUpDlg"
local MainStageSpeedUpDlg = Class(strClassName, UIControls.Window)
local SPEED_UP_MAX = 3

function MainStageSpeedUpDlg:ctor()
	self:initUI()
end

function MainStageSpeedUpDlg:initUI()
	self.cells = {}

	for index = 1, SPEED_UP_MAX do
		local newCell = MainStageSpeedUpCell(self, "BgPanel/Speed" .. index)

		table.insert(self.cells, newCell)
	end
end

function MainStageSpeedUpDlg:onShow()
	local curData = CurAvatar.mainStageCur
	local idx = CurAvatar.mainStageCur.idx
	local preData = CurAvatar.stageDatas[curData.idx - 1] or {}
	local curAwards = ResRandClient[curData.deposit_assgin_award] or {}
	local curAwardIDs = curAwards.show_ids or {}
	local curAwardNums = curAwards.show_nums or {}
	local preAwards = ResRandClient[preData.deposit_assgin_award] or {}
	local preAwardIDs = preAwards.show_ids or {}
	local preAwardNums = preAwards.show_nums or {}
	local bonus = {}

	for index, awardID in ipairs(curAwardIDs) do
		if awardID == 100001 or awardID == 100004 or awardID == 500000 then
			table.insert(bonus, {
				awardID,
				curAwardNums[index]
			})
		end
	end

	for i, cell in ipairs(self.cells) do
		local awardID = bonus[i][1]
		local awardNum = bonus[i][2]

		if awardID and awardNum then
			local preNum = 0

			for preIdx, preID in ipairs(preAwardIDs) do
				if preID == awardID then
					preNum = preAwardNums[preIdx] or 0

					break
				end
			end

			if awardID == Const.MONEY_ID_GOLD then
				preNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, preNum)
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_GOLD, awardNum)
			elseif awardID == Const.MONEY_ID_HERO_EXP then
				preNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, preNum)
				awardNum = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_HERO_EXP, awardNum)
			end

			cell:setVisible(true)

			local iconPath = BaseObject.getItemIconPath(awardID)

			if iconPath then
				cell.iconMoney:setImage(iconPath[1], iconPath[2])
			end

			cell.textMoney1:setText(string.format(Lang.get(30521), ClientUtils.getNumShortStr(math.floor(preNum * 10))))
			cell.textMoney2:setText(string.format(Lang.get(30521), ClientUtils.getNumShortStr(math.floor(awardNum * 10))))
			cell.panelEff:setVisible(true)
		else
			cell:setVisible(false)
		end
	end
end

function MainStageSpeedUpDlg:onOpenOver()
	MainStageSpeedUpDlg.super.onOpenOver(self)
	self:setVisible(false)
end

return MainStageSpeedUpDlg

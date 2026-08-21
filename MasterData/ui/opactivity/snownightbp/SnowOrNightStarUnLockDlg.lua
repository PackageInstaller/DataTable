-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\SnowOrNightStarUnLockDlg.lua

local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local strClassName = "SnowOrNightStarUnLockDlg"
local SnowOrNightStarUnLockDlg = Class(strClassName, UIControls.Window)

function SnowOrNightStarUnLockDlg:ctor()
	self:initUI()
end

function SnowOrNightStarUnLockDlg:initUI()
	self.imgStar = UIControls.Image(self, "MainInfoPanel/HeroPanel/ImgStar")
	self.textTitle = UIControls.Label(self, "MainInfoPanel/HeroPanel/BgTitle/TextTitle")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")
	self.textAchieveTitle = UIControls.Label(self, "MainInfoPanel/UnLockTaskPanel/BgText/Text")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.bounsGridCells = {}
end

function SnowOrNightStarUnLockDlg:setUnlockGroup(actObj, unlockGroup)
	self.actObj = actObj
	self.actData = actObj.actData
	self.unlockGroup = unlockGroup
	self.resAchieveGroup = self.actData.clientAchieveGroup[self.unlockGroup] or {}

	self.textAchieveTitle:setText(self.resAchieveGroup.title or "")

	local groupUnlockAchieveData = self.actData:getGroupUnlockAchieveData(self.unlockGroup)

	if groupUnlockAchieveData then
		local achieveType = groupUnlockAchieveData.type
		local achieveIndex = groupUnlockAchieveData.index
		local miscData = self.actData:getAchieveMiscDataByType(achieveType)

		if miscData and miscData.arg then
			local needStar = self.actData.clientData[achieveType][achieveIndex].param
			local fakeHero = BaseObject.GetObject(miscData.arg)

			if fakeHero then
				self.textTitle:setText(utils.format(ClientUtils.getClientNotice(434), fakeHero.name, UIConst.HERO_STAR_EMOJI_DIC[needStar]))

				local largeStarPath = fakeHero:getLargeStarPath(needStar)

				if largeStarPath then
					self.imgStar:setImage(largeStarPath[1], largeStarPath[2])
				end
			end
		end
	end

	local groupAwardAchieveData = self.actData:getGroupAwardAchieveData(self.unlockGroup)

	if groupAwardAchieveData then
		ClientUtils.CreateBonusGrid(self, self.bounsGridCells, "MainInfoPanel/UnLockTaskPanel/AwardPanel", groupAwardAchieveData.award, nil, nil, true)
	end
end

function SnowOrNightStarUnLockDlg:onBtnConfirmClick()
	self:setVisible(false)
end

function SnowOrNightStarUnLockDlg:onClose()
	SnowOrNightStarUnLockDlg.super.onClose(self)

	local activitySnowOrNightBPDlg = UIManager.getUI("activitySnowOrNightBPDlg", nil, false)

	if activitySnowOrNightBPDlg then
		activitySnowOrNightBPDlg:playEffectByGroupId(self.unlockGroup)
	end
end

return SnowOrNightStarUnLockDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleInheritDlg.lua

local SneakBattleInheritDlg = Class("SneakBattleInheritDlg", UIControls.Window)

function SneakBattleInheritDlg:ctor(...)
	self:initUI()
end

function SneakBattleInheritDlg:initUI(...)
	self.txtPreLevel = UIControls.Label(self, "BgDifficult/ImgCircle/IconDifficult/TextLevel")
	self.txtPreRound = UIControls.Label(self, "BgDifficult/ImgCircle/IconDifficult/TextRound")
	self.txtNowLevel = UIControls.Label(self, "BgDifficult/ImgCircle/IconDifficult1/TextLevel")
	self.txtNowRound = UIControls.Label(self, "BgDifficult/ImgCircle/IconDifficult1/TextRound")
	self.panel = UIControls.UIAni(self, "")
end

function SneakBattleInheritDlg:setData(...)
	local actData = CurAvatar:getSneakBattleActivityData()

	if actData then
		local persistentData = actData:getSneakBattlePersistentData()

		if persistentData then
			local passLevel = 1
			local passRound = 1

			if persistentData.passData then
				passLevel = persistentData.passData.pass_level
				passRound = persistentData.passData.pass_stage
			end

			local count = actData:getStageCount(passLevel)
			local newLevel = passLevel

			if passRound == count then
				newLevel = newLevel + 1
			end

			local levelCount = actData:getLevelCount()

			newLevel = math.max(math.min(newLevel, levelCount or 5), 1)
			passLevel = math.max(passLevel, 1)

			local levelNameNow = actData:getLevelName(newLevel)
			local levelNamePre = actData:getLevelName(passLevel)

			self.txtPreLevel:setText(levelNamePre)
			self.txtNowLevel:setText(levelNameNow)

			local showTxt = passRound

			if passRound < 10 then
				showTxt = utils.format("0%1s", passRound)
			end

			self.txtPreRound:setText(showTxt)
			self.txtNowRound:setText("01")
		end
	end

	self.panel:startAni("SneakBattleInheritDifficulty", true)
end

return SneakBattleInheritDlg

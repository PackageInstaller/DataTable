-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTaskWriteLetterDlg.lua

local strClassName = "RentTaskWriteLetterDlg"
local RentTaskWriteLetterDlg = Class(strClassName, UIControls.Window)
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")

RentTaskWriteLetterDlg.mvpId = -1
RentTaskWriteLetterDlg.teamInfos = {}
RentTaskWriteLetterDlg.imgMVPs = {}
RentTaskWriteLetterDlg.toggles = {}
RentTaskWriteLetterDlg.checkMarks = {}
RentTaskWriteLetterDlg.heros = {}
RentTaskWriteLetterDlg.heroPanels = {}
RentTaskWriteLetterDlg.countDownTime = 600
RentTaskWriteLetterDlg.enterTime = 0

function RentTaskWriteLetterDlg:ctor(...)
	self.enterTime = Time.time

	if RegionUtils.isSEA() then
		self.maxTextNum = 150
	else
		self.maxTextNum = 50
	end

	self:initUI()
end

function RentTaskWriteLetterDlg:initUI()
	self.sendBtn = UIControls.Button(self, "Bg/BtnSend")

	self.sendBtn:addEventClick(self._onClickSend)

	for i = 1, 5 do
		self.heros[i] = UIControls.GridHeroInfoChild(self, "Bg/CaseTaskChooseInfoCell/GridHero" .. i, "System/Common/Grid/GridHeroInfo")

		self.heros[i].btnHeroHead:clearEventClick()

		self.checkMarks[i] = UIControls.Panel(self, "Bg/CaseTaskChooseInfoCell/GridHero" .. i .. "/Background/Checkmark")
		self.heroPanels[i] = UIControls.Panel(self, "Bg/CaseTaskChooseInfoCell/GridHero" .. i)
		self.imgMVPs[i] = UIControls.Image(self, "Bg/CaseTaskChooseInfoCell/GridHero" .. i .. "/ImgMvp")

		self.imgMVPs[i]:getComObj().transform:SetSiblingIndex(self.heros[i]:getController().transform:GetSiblingIndex() + 1)

		self.toggles[i] = UIControls.Toggle(self, "Bg/CaseTaskChooseInfoCell/GridHero" .. i .. "/Background")
		self.toggles[i].togIndex = i

		self.toggles[i]:addEventValueChanged(self._onHeroToggle)
	end

	self.input = UIControls.Input(self, "Bg/InputContent")

	ClientUtils.checkInputValueChange(self.input)
	self.input:addEventValueChanged(self.onInputChanged)

	self.textNum = UIControls.Label(self, "Bg/TextNum")

	self.textNum:setText("00/" .. self.maxTextNum)

	self.textTime = UIControls.Label(self, "Bg/TextTime")
	self.defaultInput = UIControls.Label(self, "Bg/InputContent/Placeholder")

	self.defaultInput:setText(Lang.get(30729))
	self:setTextNum()
end

function RentTaskWriteLetterDlg:setData(rentData)
	local teamInfos = {}

	teamInfos.teamId = rentData.teamId
	teamInfos.teamUid = rentData.teamUid

	for _, info in pairs(rentData.fixedHeros or {}) do
		local hero = info[2]

		table.insert(teamInfos, {
			heroId = hero.id,
			heroLv = hero.level
		})
	end

	local mvpInfo = CurAvatar:getLastBattleMvp()

	if mvpInfo and mvpInfo.hero then
		self.mvpId = mvpInfo.hero.id
		self.defaultMvpId = mvpInfo.hero.id
	elseif teamInfos[1] then
		self.defaultMvpId = teamInfos[1].heroId
	end

	self.teamInfos = teamInfos
	self.letterData = RentTaskUtils.getRandomLetter()

	self:initLetterText()
	self:refresh()

	local leftTime = math.min(self.countDownTime + (CurAvatar.rentTaskCompletTime or 0) - Time.time, self.countDownTime)

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, leftTime, false, Lang.get(48692), Slot(self.onTimeOut, self))
end

function RentTaskWriteLetterDlg:initLetterText()
	if self.letterData then
		self.defaultContent = RentTaskUtils.parseLetter(self.letterData, self.mvpId)

		if self.defaultContent then
			self.input:setText(self.defaultContent)
			self.defaultInput:setText(self.defaultContent)
		end

		self:setTextNum()
	end
end

function RentTaskWriteLetterDlg:Update()
	local leftTime = self.countDownTime - (Time.time - self.enterTime)

	if leftTime <= 0 then
		self:setVisible(false)

		if self.closeCallback then
			self:closeCallback()
		end

		ClientTimerManager.RemoveSecondTickUI(self.textTime)
	else
		local leftH = math.modf(leftTime / 3600)

		leftTime = leftTime - leftH * 3600

		local leftM = math.modf(leftTime / 60)

		leftTime = leftTime - leftM * 60

		local leftS = math.modf(leftTime)

		self.textTime:setText(string.format(Lang.get(30731), leftH, leftM, leftS))
	end
end

function RentTaskWriteLetterDlg:destroy()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
end

function RentTaskWriteLetterDlg:onInputChanged()
	local letter = self.input:getText()

	if not Const.NAME_CONTAINS_SPACE then
		letter = string.gsub(letter, " ", "")
	end

	letter = string.gsub(letter, "\t", "")
	letter = string.gsub(letter, "\n", "")

	self.input:setText(letter)

	local enterNum = utils.utf8len(letter)

	if enterNum > self.maxTextNum then
		letter = self.preLetter
		enterNum = utils.utf8len(letter)

		self.input:setText(letter)
	else
		self.preLetter = letter
	end

	self:setTextNum()
end

function RentTaskWriteLetterDlg:markInputIllegal(hint)
	ClientUtils.markInputIllegal(self.input, hint)
end

function RentTaskWriteLetterDlg:setTextNum()
	local letter = self.input:getText()
	local enterNum = utils.utf8len(letter)

	if enterNum == 0 then
		local defaultLetter = self.defaultInput:getText()

		enterNum = utils.utf8len(defaultLetter)
	end

	self.textNum:setText(enterNum .. "/" .. self.maxTextNum)
end

function RentTaskWriteLetterDlg:onBtnGridHeroClick(heroId)
	local heroTips = UIManager.getUI("heroTips")

	heroTips:showObj(self, BaseObject.GetObject(heroId))
end

function RentTaskWriteLetterDlg:_onHeroToggle(sender)
	if sender:isOn() then
		if self.teamInfos[sender.togIndex] then
			self.mvpId = self.teamInfos[sender.togIndex].heroId
		else
			self.mvpId = nil
		end

		self:refresh()
		self:initLetterText()
	else
		self.imgMVPs[sender.togIndex]:setVisible(false)
	end
end

function RentTaskWriteLetterDlg:refresh()
	for i = 1, 5 do
		if self.teamInfos[i] then
			self.toggles[i]:setEnable(true)
			self.heroPanels[i]:setVisible(true)
			self.heros[i]:setHero(BaseObject.GetObject(self.teamInfos[i].heroId))
			self.heros[i]:setHeroRealLv(self.teamInfos[i].heroLv)
			self.heros[i].btnHeroHead:addEventClick(Functor(self.onBtnGridHeroClick, self, self.teamInfos[i].heroId))
		else
			self.heroPanels[i]:setVisible(false)
			self.toggles[i]:setEnable(false)
		end
	end

	for i = 1, 5 do
		if self.teamInfos[i] and self.teamInfos[i].heroId == self.mvpId then
			self.imgMVPs[i]:setVisible(true)
			self.checkMarks[i]:setVisible(true)

			if self.toggles[i] then
				self.toggles[i]:setOn(true)
			end
		else
			self.imgMVPs[i]:setVisible(false)
			self.checkMarks[i]:setVisible(false)
		end
	end

	self:setTextNum()
end

function RentTaskWriteLetterDlg:onTimeOut()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self:setVisible(false)
end

local SP_KEY = {
	"(",
	")",
	".",
	"%",
	"+",
	"-",
	"*",
	"?",
	"[",
	"^",
	"$",
	"/",
	";",
	"?",
	"@",
	"<",
	"=",
	">",
	"\\",
	"]",
	"_",
	"`",
	"{",
	"}",
	"|",
	"~",
	"!",
	"#",
	"&",
	":"
}
local lastSendTime = 0

function RentTaskWriteLetterDlg:_onClickSend()
	if self.btnLockFlag then
		return
	end

	if Time.time - lastSendTime < 3 then
		return
	end

	lastSendTime = Time.time

	local letter = self.input:getText()

	if not letter or letter == "" then
		letter = self.defaultContent
	end

	local letterId

	if letter == self.letterData.content then
		letterId = self.letterData.id
		letter = ""
	end

	local trueMvpId = self.mvpId

	if self.mvpId == nil or self.mvpId <= 0 then
		trueMvpId = self.defaultMvpId
	end

	self.btnLockFlag = true

	RPC.rentSendLetter(self.teamInfos.teamUid, letter, self.teamInfos.teamId, trueMvpId, letterId)
end

function RentTaskWriteLetterDlg:onRentSendLetterSuccess()
	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	self:setVisible(false)

	if self.closeCallback then
		self:closeCallback()
	end
end

return RentTaskWriteLetterDlg

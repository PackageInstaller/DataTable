-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MiniGame\\MiniGameInfoDlg.lua

local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local ResClimbTowerBigAward = require("ClientData/ResClimbTowerBigAward")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "MiniGameInfoCell"
local MiniGameInfoCell = Class(strClassName, UIControls.Child)

function MiniGameInfoCell:ctor(...)
	self:initUI()
end

function MiniGameInfoCell:initUI(...)
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self._onAniFinish)

	self.bigAwardBack = UIControls.Panel(self, "BigAwardBack")
	self.awardBack = UIControls.Panel(self, "AwardBack")
	self.sliderNum = UIControls.Label(self, "Slider/SliderNum")
	self.slider = UIControls.Slider(self, "Slider")
	self.itemGrids = {}
end

function MiniGameInfoCell:setData(data, isBig)
	self.data = data
	self.isBig = isBig

	self.sliderNum:setText(self.data.stage)
	self.awardBack:setVisible(not isBig)
	self.bigAwardBack:setVisible(isBig)

	local path = isBig and "BigAwardBack/AwardItem" or "AwardBack/AwardItem"
	local award = self.data.award

	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType == self.mParent.type then
		award = self.data.first_award
	end

	ClientUtils.CreateBonusGrid(self, self.itemGrids, path, award or 102, true, nil, true)

	local hasGot = CurAvatar:isPassChapterAndStage(self.mParent.type, self.data.chapter, self.data.stage)

	if hasGot then
		for index, grid in ipairs(self.itemGrids) do
			grid:setGet(true)
		end
	end

	local value = hasGot and 1 or 0

	self.slider:setValue(value)
end

function MiniGameInfoCell:playAni()
	self.aniSelf:startAni("Levelup")
end

function MiniGameInfoCell:_onAniFinish(aniCom, aniName)
	if aniName == "Levelup" then
		if self.isBig and self.data.chapter < #ResClimbTowerLevel then
			self.mParent:playNextChapterAni()
		else
			self.mParent:refreshPanel()
		end
	end
end

local strClassName = "MiniGameInfoDlg"
local MiniGameInfoDlg = Class(strClassName, UIControls.Window)

function MiniGameInfoDlg:ctor(...)
	self:initUI()
end

function MiniGameInfoDlg:initUI(...)
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self._onAniFinish)

	self.aniBigAward = UIControls.UIAni(self, "MainInfoPanel")

	self.aniBigAward:addEventFinish(self._onAniFinish)

	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnGet = UIControls.Button(self, "MainInfoPanel/BtnGet", "Text")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.btnGetBigAward = UIControls.Button(self, "MainInfoPanel/BigAward/BtnGet")

	self.btnGetBigAward:addEventClick(self.onBtnGetBigAwardClick)

	self.btnDetail = UIControls.Button(self, "MainInfoPanel/BigAward/BtnDetails")

	self.btnDetail:addEventClick(self.onBtnDetailClick)

	self.textBigAward = UIControls.Label(self, "MainInfoPanel/ImgGirl/Text")
	self.textLv = UIControls.Label(self, "MainInfoPanel/TextLv")
	self.textLock = UIControls.Label(self, "MainInfoPanel/BtnGet/TextLock")
	self.cells = {}
	self.bigAwardGrids = {}
end

function MiniGameInfoDlg:setData(type)
	self.type = type
	self.chapter, self.stage = CurAvatar:getChapterAndStage(type)

	self:setDataByChapterAndStage(self.type, self.chapter, self.stage)
end

function MiniGameInfoDlg:setDataByChapterAndStage(type, chapter, stage)
	self.type = type
	self.chapter = chapter
	self.stage = stage

	self.textLv:setText(string.format("%d-%d", self.chapter, self.stage))
	self.btnClose:setText(Const.MINI_GAME_INFO[self.type].name)

	for i, data in ipairs(ResClimbTowerLevel[self.chapter] or {}) do
		local cell = self.cells[i]

		cell = cell or MiniGameInfoCell(self, "MainInfoPanel/AwardList/Content", "System/MiniGame/MiniGameInfoCell", 0, 0, true)

		local isBig = i == #ResClimbTowerLevel[self.chapter]

		cell:setData(data, isBig)

		self.cells[i] = cell
	end

	local conditionId = ResClimbTowerLevel[self.chapter][self.stage].condition_id

	if ConditionLimitManager.inLimitState(conditionId) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(conditionId)

		self.textLock:setText(unlockDesc)
		self.textLock:setVisible(true)
		self.btnGet:setEnable(false)
	else
		self.textLock:setVisible(false)

		if CurAvatar:checkPassGame(self.type) then
			self.btnGet:setEnable(false)
			self.btnGet:setText(Lang.get(724))
		else
			self.btnGet:setEnable(true)
		end
	end

	self.btnClose:setVisible(not CurAvatar:checkHideCloseBtn())
	self:refreshBigAwardPanel()
end

function MiniGameInfoDlg:refreshBigAwardPanel()
	local bigAwardData, isPass, isAllPass = self:getShowBigAward()

	self.bigAwardId = bigAwardData.id

	local award = bigAwardData.award

	if CurAvatar.firstSelectGameType and CurAvatar.firstSelectGameType == self.type then
		award = bigAwardData.first_award
	end

	self.btnDetail:setVisible(false)

	self.bigAwardHero = nil

	ClientUtils.CreateBonusGrid(self, self.bigAwardGrids, "MainInfoPanel/BigAward/AwardItem", award or 102, true, nil, true)

	if ResRandClient[award] and ResRandClient[award].show_ids then
		local id = ResRandClient[award].show_ids[1]
		local item = BaseObject.GetObject(id)

		if item and item:isHero() then
			self.bigAwardHero = item

			self.btnDetail:setVisible(true)
		end
	end

	self.btnGetBigAward:setVisible(isPass)

	if isAllPass then
		for index, grid in ipairs(self.bigAwardGrids) do
			grid:setGet(true)
		end

		self.textBigAward:setText(Lang.get(98966))
	elseif isPass then
		self.textBigAward:setText(Lang.get(98967))
	else
		self.textBigAward:setText(string.format(Lang.get(98968), bigAwardData.pass_stage[1], bigAwardData.pass_stage[2]))
	end
end

function MiniGameInfoDlg:getShowBigAward()
	local miniGameData = CurAvatar.miniGameData[self.type] or {}
	local bigAwardGotList = miniGameData.bigAward or {}

	for i, data in ipairs(ResClimbTowerBigAward) do
		if not bigAwardGotList[i] then
			local passStage = data.pass_stage or {
				1 * i,
				10
			}
			local chapter = passStage[1]
			local stage = passStage[2]
			local isPass = CurAvatar:isPassChapterAndStage(self.type, chapter, stage)

			return data, isPass
		end
	end

	return ResClimbTowerBigAward[#ResClimbTowerBigAward], false, true
end

function MiniGameInfoDlg:playAni()
	self.btnGet:setEnable(false)

	local chapter, stage = CurAvatar:getPassChapterAndStage(self.type)

	for i, cell in ipairs(self.cells or {}) do
		if cell.data.chapter == chapter and cell.data.stage == stage then
			cell:playAni()

			break
		end
	end

	for i, data in ipairs(ResClimbTowerBigAward) do
		if chapter == data.pass_stage[1] and stage == data.pass_stage[2] then
			self.aniBigAward:startAni("UnLockAward")

			break
		end
	end
end

function MiniGameInfoDlg:playNextChapterAni()
	self.aniSelf:startAni("LevelRefresh")
end

function MiniGameInfoDlg:_onAniFinish(aniCom, aniName)
	if aniName == "LevelRefresh" then
		self:refreshPanel()
	end
end

function MiniGameInfoDlg:refreshPanel()
	self:setData(self.type)
end

function MiniGameInfoDlg:onBtnGetClick()
	UIManager.getUI("miniGamePlayDlg", true):setData(self.type)
	self:setVisible(false)

	local state = Const.MINI_GAME_INFO[self.type].state
	local classCenter = require(Const.MINI_GAME_INFO[self.type].dragCenter)

	if GameFsm.isInState(state) then
		classCenter.createWhenLoadend()
	end
end

function MiniGameInfoDlg:onBtnDetailClick()
	if self.bigAwardHero then
		UIManager.getUI("heroPreviewTips"):showObj(self, self.bigAwardHero)
	end
end

function MiniGameInfoDlg:onBtnGetBigAwardClick()
	RPC.relaxingGameGetBigAward(self.bigAwardId, Const.MINI_GAME_TYPE[self.type])
end

function MiniGameInfoDlg:onBtnCloseClick()
	GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
	self:setVisible(false)
end

function MiniGameInfoDlg:hideCloseBtn()
	self.btnClose:setVisible(false)
end

return MiniGameInfoDlg

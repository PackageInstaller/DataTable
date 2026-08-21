-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MiniGame\\MiniGameMainDlg.lua

local ResClimbTowerLevel = require("ClientData/ResClimbTowerLevel")
local UserData = require("Helper/UserData")
local strClassName = "MiniGameBtn"
local MiniGameBtn = Class(strClassName, UIControls.Panel)

function MiniGameBtn:ctor(...)
	self.openPanel = UIControls.Panel(self, self.mPath .. "/OpenPanel")
	self.textNum = UIControls.Label(self, self.mPath .. "/OpenPanel/TextNum")
	self.lockPanel = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.textLv = UIControls.Label(self, self.mPath .. "/LockPanel/TextLv")
	self.clearPanel = UIControls.Panel(self, self.mPath .. "/ClearPanel")
	self.textTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.iconNew = UIControls.Image(self, self.mPath .. "/IconNew")
	self.btnGame = UIControls.Button(self, self.mPath .. "")

	self.btnGame:addEventClick(self.onBtnGameClick)
end

function MiniGameBtn:setData(data)
	self.data = data

	self.textTitle:setText(data.name)

	self.chapter, self.stage = CurAvatar:getChapterAndStage(self.data.type)

	self.textNum:setText(string.format(Lang.get(98717), self.chapter, self.stage))

	local conditionId = ResClimbTowerLevel[self.chapter][self.stage].condition_id

	if ConditionLimitManager.inLimitState(conditionId) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(conditionId)

		self.textLv:setText(unlockDesc)
		self.lockPanel:setVisible(true)
	else
		self.lockPanel:setVisible(false)
	end

	self.clearPanel:setVisible(CurAvatar:checkPassGame(self.data.type))
	self.iconNew:setVisible(CurAvatar:checkHasBigAwardByType(self.data.type))
end

function MiniGameBtn:onBtnGameClick()
	GameFsm.translateState(self.data.state)
	self:recordCheckMiniGame()

	if CurAvatar.firstSelectGameType == nil or CurAvatar.firstSelectGameType == 0 then
		CurAvatar.firstSelectGameType = self.data.type

		RPC.relaxingGameChooseFirstGame(Const.MINI_GAME_TYPE[self.data.type])
	end
end

function MiniGameBtn:recordCheckMiniGame()
	local alreadyPlayStr = UserData.loadCommonData("MiniGamePlayType" .. CurAvatar.uid)
	local alreadyPlay = ClientUtils.string2Table(alreadyPlayStr)

	if not alreadyPlay[self.data.type] then
		alreadyPlay[self.data.type] = 1

		UserData.saveCommonData("MiniGamePlayType" .. CurAvatar.uid, ClientUtils.table2String(alreadyPlay))
	end
end

local strClassName = "MiniGameMainDlg"
local MiniGameMainDlg = Class(strClassName, UIControls.Window)

function MiniGameMainDlg:ctor(...)
	self:initUI()
end

function MiniGameMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.miniGameBtns = {}
end

function MiniGameMainDlg:setData(...)
	for i, info in ipairs(Const.MINI_GAME_INFO) do
		local miniGameBtn = self.miniGameBtns[i]

		miniGameBtn = miniGameBtn or MiniGameBtn(self, "MainInfoPanel/Content/BtnGame0" .. i)

		miniGameBtn:setData(info)

		self.miniGameBtns[i] = miniGameBtn
	end

	self.btnClose:setVisible(not CurAvatar:checkHideCloseBtn())
end

function MiniGameMainDlg:refreshPanel(...)
	self:setData()
end

function MiniGameMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function MiniGameMainDlg:enterDefaultMiniGame()
	self.miniGameBtns[1]:onBtnGameClick()
end

return MiniGameMainDlg

-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleTalentDlg.lua

local ResClanBattleTitle = require("ClientData/ResClanBattleTitle")
local ResClanExploreTalent = require("ClientData/ResClanExploreTalent")
local ResClanBattleTalent = require("ClientData/ResClanBattleTalent")
local CircleTalentCell = require("UI/Circle/CircleTalentCell")
local TAB_SEARCH = 1
local TAB_BATTLE = 2
local strClassName = "CircleBattleTalentDlg"
local CircleBattleTalentDlg = Class(strClassName, UIControls.Window)

function CircleBattleTalentDlg:ctor()
	self:initUI()
end

function CircleBattleTalentDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
	self.scrollCircleTalent = UIControls.ScrollViewLoopH(self, "Bg/TalentList")

	self.scrollCircleTalent:addEventCellChanged(self.onCircleTalentChanged)

	self.btnTabSearch = UIControls.Button(self, "Bg/TabPanel/TabSearch")

	self.btnTabSearch:addEventClick(self.onBtnTabSearchClick)

	self.imgHintTabSearch = UIControls.Image(self, "Bg/TabPanel/TabSearch/IconNew")
	self.txtSearchProficiency = UIControls.Label(self, "Bg/TabPanel/TabSearch/TextNum")
	self.btnTabBattle = UIControls.Button(self, "Bg/TabPanel/TabBattle")

	self.btnTabBattle:addEventClick(self.onBtnTabBattleClick)

	self.imgHintTabBattle = UIControls.Image(self, "Bg/TabPanel/TabBattle/IconNew")
	self.txtBattleProficiency = UIControls.Label(self, "Bg/TabPanel/TabBattle/TextNum")
	self.panelBgTitle = UIControls.Panel(self, "Bg/BgTitle")
	self.txtEmojiTitle = UIControls.Label(self, "Bg/BgTitle/EmojiText", true)
	self.txtTitleAttr = UIControls.Label(self, "Bg/BgTitle/TextAttr")
	self.txtTime = UIControls.Label(self, "Bg/TextTime")

	self:initTalentData()

	self.selectedTab = {}

	local explorCnt = utils.getTableElemCount(CurAvatar.hintExploreTalentDic, true)

	self.imgHintTabSearch:setVisible(explorCnt > 0)

	explorCnt = utils.getTableElemCount(CurAvatar.hintBattleTalentDic, true)

	self.imgHintTabBattle:setVisible(explorCnt > 0)
end

function CircleBattleTalentDlg:onOpen()
	CircleBattleTalentDlg.super.onOpen(self)
	self:onBtnTabSearchClick()
end

function CircleBattleTalentDlg:onOpenOver()
	CircleBattleTalentDlg.super.onOpenOver(self)

	self.refreshTabHintTimer = Timer.New(Slot(self.refreshTabHintTimerFunc, self), 0.5, 1)

	self.refreshTabHintTimer:Start()

	for _, cell in pairs(self.cells) do
		cell:playUnlock()
	end
end

function CircleBattleTalentDlg:initTalentData()
	if CurAvatar.myCircle then
		self.txtSearchProficiency:setText(CurAvatar.myCircle:getCurExploreProficiency())
		self.txtBattleProficiency:setText(CurAvatar.myCircle:getCurBattleProficiency())

		local leftTime = 0
		local actObj = CurAvatar:getCircleBattleActivity()

		if actObj then
			leftTime = actObj.actData:getLeftTimeToEnd()
		end

		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(30590), nil, nil)
	end
end

function CircleBattleTalentDlg:refreshTalentShow(hintDic, resTalent, curProficiency)
	if self.refreshTabHintTimer then
		self.refreshTabHintTimer:Stop()

		self.refreshTabHintTimer = nil
	end

	local startIdx

	for idx, talentData in ipairs(self.circleTalentDataList) do
		if hintDic[talentData.resData.id] then
			startIdx = math.max(1, idx - 1)

			break
		end
	end

	local titleTalentId, titleId

	for idx, resData in ipairs(resTalent) do
		if curProficiency < resData.proficiency then
			if not startIdx then
				startIdx = math.max(1, idx - 1)
			end

			break
		elseif resData.unlock_title then
			titleId = resData.unlock_title
			titleTalentId = resData.id
		end
	end

	startIdx = startIdx or #self.circleTalentDataList

	if not self.mOpening and utils.getTableElemCount(hintDic, true) > 0 then
		self.refreshTabHintTimer = Timer.New(Slot(self.refreshTabHintTimerFunc, self), 0.5, 1)

		self.refreshTabHintTimer:Start()
	end

	self.scrollCircleTalent:setTotalCount(#self.circleTalentDataList, startIdx)

	if titleId and ResClanBattleTitle[titleId] then
		self.panelBgTitle:setVisible(true)
		self.txtEmojiTitle:setText(ResClanBattleTitle[titleId].icon)
		self.txtTitleAttr:setText(resTalent[titleTalentId].simple_desc or "")
	else
		self.panelBgTitle:setVisible(false)
	end

	self:refreshTabHint()
end

function CircleBattleTalentDlg:refreshTabHintTimerFunc()
	self:refreshTabHint()
end

function CircleBattleTalentDlg:onBtnTabSearchClick()
	if CurAvatar.myCircle then
		self.btnTabSearch:setEnable(false)
		self.btnTabBattle:setEnable(true)

		self.circleTalentDataList = CurAvatar:getAllCircleTalent(true)

		self:refreshTalentShow(CurAvatar.hintExploreTalentDic, ResClanExploreTalent, CurAvatar.myCircle:getCurExploreProficiency())

		self.selectedTab[TAB_SEARCH] = 1
	end
end

function CircleBattleTalentDlg:onBtnTabBattleClick()
	if CurAvatar.myCircle then
		self.btnTabSearch:setEnable(true)
		self.btnTabBattle:setEnable(false)

		self.circleTalentDataList = CurAvatar:getAllCircleTalent(false, true)

		self:refreshTalentShow(CurAvatar.hintBattleTalentDic, ResClanBattleTalent, CurAvatar.myCircle:getCurBattleProficiency())

		self.selectedTab[TAB_BATTLE] = 1
	end
end

function CircleBattleTalentDlg:refreshTabHint()
	if self.selectedTab[TAB_SEARCH] then
		CurAvatar.hintExploreTalentDic = {}

		self.imgHintTabSearch:setVisible(false)
	end

	if self.selectedTab[TAB_BATTLE] then
		CurAvatar.hintBattleTalentDic = {}

		self.imgHintTabBattle:setVisible(false)
	end

	CurAvatar:refreshCircleBattleMainShow()
end

function CircleBattleTalentDlg:onCircleTalentChanged(sender, targetCell, newIdx)
	targetCell = targetCell or CircleTalentCell(sender, "System/CircleBattle/TalentCell", newIdx)

	if not self.circleTalentDataList or #self.circleTalentDataList == 0 then
		return
	end

	if self.circleTalentDataList[newIdx] ~= nil then
		targetCell:setCircleTalentData(self.circleTalentDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function CircleBattleTalentDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattleTalentDlg:onClose()
	self:refreshTabHint()

	if self.refreshTabHintTimer then
		self.refreshTabHintTimer:Stop()

		self.refreshTabHintTimer = nil
	end

	for _, cell in pairs(self.cells) do
		cell:clearCoroutine()
	end

	CircleBattleTalentDlg.super.onClose(self)
end

return CircleBattleTalentDlg

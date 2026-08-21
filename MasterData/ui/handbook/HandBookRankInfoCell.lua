-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankInfoCell.lua

local OtherPlayer = require("Common/Object/OtherPlayer")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local strClassName = "HandBookRankInfoCell"
local HandBookRankInfoCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function HandBookRankInfoCell:ctor()
	self:initUI()
end

function HandBookRankInfoCell:initUI()
	self.imgSelf = UIControls.Image(self, "")
	self.imgBg = UIControls.Image(self, "Bg")
	self.txtTitle = UIControls.Label(self, "TextRuleTitle")
	self.txtContent = UIControls.Label(self, "TextRule")
	self.panelProgress = UIControls.Panel(self, "ProgressPanel")
	self.imgIconCup = UIControls.Image(self, "ProgressPanel/BgCup/IconCup")
	self.imgIconCupS = UIControls.Image(self, "BtnPlayer/IconCupS")
	self.txtProgress = UIControls.Label(self, "ProgressPanel/TextProgress")
	self.panelBtnPlayer = UIControls.Panel(self, "BtnPlayer")
	self.txtPlayerName = UIControls.Label(self, "BtnPlayer/TextPlayer")
	self.imgPlayerCheck = UIControls.Image(self, "BtnPlayer/TextPlayer/ImgCheck")
	self.txtPlayerTime = UIControls.Label(self, "BtnPlayer/TextTime")
	self.txtState = UIControls.Label(self, "TextState")
	self.txtTime = UIControls.Label(self, "BtnPlayer/TextTime")
	self.efxGrid = UIControls.Panel(self, "EfxGridItem")
	self.btnPlayer = UIControls.Button(self, "BtnPlayer")

	self.btnPlayer:addEventClick(self.onBtnPlayerClick)

	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

local STATUS_CELL_STATE = {
	[Const.TASK_STATUS.IN_PROCESS] = "RankInfoListCellNml",
	[Const.TASK_STATUS.COMPLETE] = "RankInfoListCellHigh",
	[Const.TASK_STATUS.AWARD_GOT] = "RankInfoListCellDis"
}

function HandBookRankInfoCell:setData(data, idx)
	self.data = data
	self.idx = idx

	self:setStatusShow(self.data.svrData.status)
	self.efxGrid:setVisible(false)
	self.txtTitle:setText(self.data.resData.title)
	self.txtContent:setText(self.data.resData.des)
	self.panelBtnPlayer:setVisible(self.data.svrData.status ~= Const.TASK_STATUS.IN_PROCESS)
	self.imgIconCupS:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", self.data.resData.cup_sprite .. "S")
	self.txtState:setVisible(self.data.svrData.status ~= Const.TASK_STATUS.COMPLETE)
	self.btnConfirm:setVisible(self.data.svrData.status == Const.TASK_STATUS.COMPLETE)
	self.panelProgress:setVisible(self.data.svrData.status == Const.TASK_STATUS.IN_PROCESS)

	local randInfo = ResRandClient[self.data.resData.awardid]
	local fakeItem = BaseObject.GetObject(randInfo.show_ids[1], randInfo.show_nums[1])

	if not self.awardGrid then
		self.awardGrid = UIControls.getGridChild(fakeItem, self, "GridItemPanel")
	end

	self.awardGrid:setVisible(true)
	self.awardGrid:setObj(fakeItem)

	self.awardGrid.mEventClick = nil
	self.awardGrid.mEnableTips = true
	self.awardGrid.mDisableWays = true

	self.awardGrid:setIconGray(self.data.svrData.status == Const.TASK_STATUS.AWARD_GOT)

	local curPage = self.mWindow.curPage
	local curTopPlayerInfo = curPage.contentPanel.playerInfo

	if self.data.svrData.status == Const.TASK_STATUS.IN_PROCESS then
		self.txtState:setText(Lang.get(99))
		self.imgIconCup:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", self.data.resData.cup_sprite)

		local curTopPlayerScore = curTopPlayerInfo and curTopPlayerInfo.score or 0
		local curProgress = math.min(curTopPlayerScore, self.data.resData.param)

		self.txtProgress:setText(utils.format(Lang.get(30307), UIConst.getRankScoreStr(curPage.data.rankType, curProgress), UIConst.getRankScoreStr(curPage.data.rankType, self.data.resData.param)))
	else
		self.txtState:setText(Lang.get(74))
		self.txtProgress:setText(UIConst.getRankScoreStr(curPage.data.rankType, self.data.resData.param) .. "/" .. UIConst.getRankScoreStr(curPage.data.rankType, self.data.resData.param))

		local roleCommData = self.data.svrData.comm

		if not self.playerHead then
			self.playerHead = UIControls.PlayerHeadGridChild(self, "BtnPlayer/GridPlayer", "System/Common/Grid/GridPlayerCommon")

			self.playerHead:hideLevel()
		end

		self.playerHead:setEnable(self.data.svrData.comm.uid ~= CurAvatar.uid)
		self.playerHead:setCommInfo(roleCommData, true, self)

		local playerName = utils.GetPlayerName(roleCommData.name)

		self.txtPlayerName:setText(playerName)
		self.imgPlayerCheck:setVisible(self.data.svrData.comm.uid ~= CurAvatar.uid)
		self.txtTime:setText(string.format(Lang.get(30308), utils.getDeadlineStr(self.data.svrData.tick, true)))
	end
end

function HandBookRankInfoCell:setStatusShow(status)
	if status == Const.TASK_STATUS.IN_PROCESS then
		self.imgSelf:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgBottomNml")
		self.imgBg:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgMonumentNml")
		self.txtTitle:setFontColor(ResColor.GREYMIDDLE)
		self.txtPlayerName:setFontColor(ResColor.GREYMIDDLE)
	elseif status == Const.TASK_STATUS.COMPLETE then
		self.imgSelf:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgBottomNml")
		self.imgBg:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgMonumentSel")
		self.txtTitle:setFontColor(ResColor.GREYMIDDLE)
		self.txtPlayerName:setFontColor(ResColor.GREYMIDDLE)
	elseif status == Const.TASK_STATUS.AWARD_GOT then
		self.imgSelf:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgBottomDis")
		self.imgBg:setImage("Atlas/HandBookAtlas/HandBookRankAtlas", "BgMonumentDis")
		self.txtTitle:setFontColor(ResColor.GREYLIGHT)
		self.txtPlayerName:setFontColor(ResColor.GREYLIGHT)
	end
end

function HandBookRankInfoCell:onBtnPlayerClick()
	local otherPlayer = OtherPlayer()

	otherPlayer:initDataByCommonData(self.data.svrData.comm)
	CurAvatar:showPlayerTips(otherPlayer.uid, self)
end

local AWARD_EFX_TIME = 0.5

function HandBookRankInfoCell:onBtnConfirmClick()
	if self.getAwardTimer then
		return
	end

	self.efxGrid:setVisible(true)

	self.getAwardTimer = Timer.New(Slot(self._delayGetAward, self), AWARD_EFX_TIME)

	self.getAwardTimer:Start()
end

function HandBookRankInfoCell:_delayGetAward()
	self.efxGrid:setVisible(false)

	self.getAwardTimer = nil

	RPC.monumentMsgGetAward({
		self.data.resData.id
	})
	self.awardGrid:flyToCommonFuncEntryPanel()

	if ClientUtils.getServerTime() - self.data.svrData.tick <= Const.MONUMENT_AWARD_GET_MSG_CD and self.data.svrData.comm.uid ~= CurAvatar.uid then
		local playerName = utils.GetPlayerName(self.data.svrData.comm.name)
		local colorfulPlayerName = utils.getColorfulStr(playerName, ResColor.BLUE)
		local congratulationsIdx = math.random(1, 3)
		local congratulationsStr = ""

		if congratulationsIdx == 1 then
			congratulationsStr = string.format(Lang.get(30309), colorfulPlayerName)
		elseif congratulationsIdx == 2 then
			congratulationsStr = string.format(Lang.get(30310), colorfulPlayerName)
		else
			congratulationsStr = string.format(Lang.get(30311), colorfulPlayerName)
		end

		MsgManager.sendBySystem(congratulationsStr, Const.CHANNEL_SERVER)
	end
end

function HandBookRankInfoCell:destroy()
	if self.getAwardTimer then
		self.getAwardTimer:Stop()

		self.getAwardTimer = nil
	end

	HandBookRankInfoCell.super.destroy(self)
end

return HandBookRankInfoCell

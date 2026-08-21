-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleProgressDlg.lua

local strClassName = "ProgressConditionPanel"
local ProgressConditionPanel = Class(strClassName, UIControls.Panel)

function ProgressConditionPanel:ctor()
	self:initUI()
end

function ProgressConditionPanel:initUI()
	self.imgFinish = UIControls.Panel(self, self.mPath .. "/ImgFinish")
	self.imgPoint = UIControls.Image(self, self.mPath .. "/ImgPoint")
	self.txtCondition = UIControls.Label(self, self.mPath .. "/TextCondition")
	self.txtNum = UIControls.Label(self, self.mPath .. "/TextNum")
end

function ProgressConditionPanel:setConditionData(conditionData)
	self.conditionData = conditionData

	self.txtCondition:setText(self.conditionData.name)
	self.txtNum:setText("(" .. self.conditionData.curNum .. "/" .. self.conditionData.totalNum .. ")")

	if self.conditionData.curNum == self.conditionData.totalNum then
		self.imgPoint:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas2", "BgDotSel")
		self.imgFinish:setVisible(true)
		self.txtNum:setFontColor(ResColor.GREEN)
	else
		self.imgPoint:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas2", "BgDotNml")
		self.imgFinish:setVisible(false)
		self.txtNum:setFontColor(ResColor.BLACK)
	end
end

local strClassName = "CircleBattleProgressDlg"
local CircleBattleProgressDlg = Class(strClassName, UIControls.Window)

function CircleBattleProgressDlg:ctor()
	self:initUI()
end

function CircleBattleProgressDlg:initUI()
	self.progressTotal = UIControls.MaterialProgress(self, "Bg/ProgressMainPanel/ImgBar")
	self.txtProgressTotal = UIControls.Label(self, "Bg/ProgressMainPanel/ProgressPanel/TextProgress")
	self.panelImgBarLight = UIControls.Panel(self, "Bg/ProgressMainPanel/ImgBarLight")
	self.txtCurLayer = UIControls.Label(self, "Bg/ProgressMainPanel/TextNum")
	self.txtProgressTitle = UIControls.Label(self, "Bg/ProgressMainPanel/ProgressPanel/TextProgressTitle")
	self.conditionPanelList = {}

	for i = 1, 3 do
		local conditionPanel = ProgressConditionPanel(self, "Bg/ProgressMainPanel/ConditionPanel/Condition" .. i)

		self.conditionPanelList[i] = conditionPanel
	end

	self.progressSearch = UIControls.MaterialProgress(self, "Bg/ProgressSearchPanel/BgBar/ImgBar")
	self.imgSearchFinish = UIControls.Panel(self, "Bg/ProgressSearchPanel/ImgFinish")
	self.txtProgressSearch = UIControls.Label(self, "Bg/ProgressSearchPanel/BgBar/TextProgress")
	self.txtSearchCondition = UIControls.Label(self, "Bg/ProgressSearchPanel/Condition/TextCondition")
	self.txtProgressSearchTitle = UIControls.Label(self, "Bg/ProgressSearchPanel/BgBar/TextProgressTitle")
	self.txtSearchConditionNum = UIControls.Label(self, "Bg/ProgressSearchPanel/Condition/TextNum")
	self.txtSearchTips = UIControls.Label(self, "Bg/ProgressSearchPanel/TextTips")
	self.progressRune = UIControls.MaterialProgress(self, "Bg/ProgressRunePanel/BgBar/ImgBar")
	self.imgRuneFinish = UIControls.Panel(self, "Bg/ProgressRunePanel/ImgFinish")
	self.txtProgressRune = UIControls.Label(self, "Bg/ProgressRunePanel/BgBar/TextProgress")
	self.txtRuneCondition = UIControls.Label(self, "Bg/ProgressRunePanel/Condition/TextCondition")
	self.txtRuneConditionNum = UIControls.Label(self, "Bg/ProgressRunePanel/Condition/TextNum")
	self.txtRuneTips = UIControls.Label(self, "Bg/ProgressRunePanel/TextTips")
	self.txtProgressRuneTitle = UIControls.Label(self, "Bg/ProgressRunePanel/BgBar/TextProgressTitle")
	self.btnRune = UIControls.Button(self, "BtnRune")

	self.btnRune:addEventClick(self.onBtnRuneClick)

	self.btnConfirm = UIControls.Button(self, "BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
	self:initProgressShow()
end

function CircleBattleProgressDlg:onBtnCloseClick()
	self:setVisible(false)
end

function CircleBattleProgressDlg:initProgressShow()
	self:refreshTotalProgress()
	self:refreshSearchProgress()
	self:refreshRuneProgress()
end

function CircleBattleProgressDlg:refreshTotalProgress()
	if CurAvatar.myCircle then
		local circle = CurAvatar.myCircle
		local battleData = circle:getBattleData()

		if battleData then
			self.txtProgressTitle:setText(ClientUtils.getClientNotice(501))
			self.txtCurLayer:setText(circle:getCurBattleLayer())

			local conditionDataList = circle:getLayerProConditionDataList()
			local totalProgress = CurAvatar:calTotalConditionProgress(conditionDataList)

			self.progressTotal:setValue(totalProgress / 100)
			self.txtProgressTotal:setText(totalProgress .. "%")

			if totalProgress >= 4 and totalProgress < 100 then
				self.panelImgBarLight:setVisible(true)
				self.panelImgBarLight:setRotateByXYZ(nil, nil, totalProgress / 100 * 360 - 7.5)
			else
				self.panelImgBarLight:setVisible(false)
			end

			for i, _ in ipairs(conditionDataList) do
				if Const.CIRCLE_BATTLE_LAYER_TARGET_INFO[i] then
					self.conditionPanelList[i]:setConditionData(conditionDataList[i])
				end
			end
		end
	end
end

function CircleBattleProgressDlg:refreshSearchProgress()
	if CurAvatar.myCircle then
		local circle = CurAvatar.myCircle
		local battleData = circle:getBattleData()

		if battleData then
			self.txtProgressSearchTitle:setText(ClientUtils.getClientNotice(505))
			self.txtSearchCondition:setText(ClientUtils.getClientNotice(506))
			self.txtSearchTips:setText(ClientUtils.getClientNotice(507))

			local openedGridNum, totalGridNum = circle:getSearchProgress()

			self.progressSearch:setValue(openedGridNum / totalGridNum)
			self.txtProgressSearch:setText(math.floor(openedGridNum / totalGridNum * 100) .. "%")
			self.txtSearchConditionNum:setText("(" .. openedGridNum .. "/" .. totalGridNum .. ")")

			if openedGridNum == totalGridNum then
				self.imgSearchFinish:setVisible(true)
				self.txtSearchConditionNum:setFontColor(ResColor.GREEN)
			else
				self.imgSearchFinish:setVisible(false)
				self.txtSearchConditionNum:setFontColor(ResColor.BLACK)
			end
		end
	end
end

function CircleBattleProgressDlg:refreshRuneProgress()
	if CurAvatar.myCircle then
		local circle = CurAvatar.myCircle
		local battleData = circle:getBattleData()

		if battleData then
			self.txtProgressRuneTitle:setText(ClientUtils.getClientNotice(508))
			self.txtRuneCondition:setText(ClientUtils.getClientNotice(509))
			self.txtRuneTips:setText(ClientUtils.getClientNotice(510))

			local curBattleLayerConfig = CurAvatar.myCircle:getCurBattleLayerConfig()

			if curBattleLayerConfig then
				local runeNum = #CurAvatar.myCircle:getRuneDataList()
				local totalRuneNum = curBattleLayerConfig.rune_num

				self.progressRune:setValue(runeNum / totalRuneNum)
				self.txtProgressRune:setText(math.floor(runeNum / totalRuneNum * 100) .. "%")
				self.txtRuneConditionNum:setText("(" .. runeNum .. "/" .. totalRuneNum .. ")")

				if runeNum == totalRuneNum then
					self.imgRuneFinish:setVisible(true)
					self.txtRuneConditionNum:setFontColor(ResColor.GREEN)
				else
					self.imgRuneFinish:setVisible(false)
					self.txtRuneConditionNum:setFontColor(ResColor.BLACK)
				end
			end
		end
	end
end

function CircleBattleProgressDlg:onBtnConfirmClick()
	self:setVisible(false)
end

function CircleBattleProgressDlg:onBtnRuneClick()
	local circleBattleRuneDlg = UIManager.getUI("circleBattleRuneDlg", true)
end

return CircleBattleProgressDlg

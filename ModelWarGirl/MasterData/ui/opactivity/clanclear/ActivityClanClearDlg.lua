-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ClanClear\\ActivityClanClearDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResClientNotice = require("ClientData/ResClientNotice")
local ClanClearLayerCell = Class("ClanClearLayerCell", UIControls.Panel)

function ClanClearLayerCell:ctor()
	self.textName = UIControls.Label(self, self.mPath .. "/Text")
	self.btnLayerClick = UIControls.Button(self, self.mPath)

	self.btnLayerClick:addEventClick(self.onLayerClick)

	self.iconNew = UIControls.Panel(self, self.mPath .. "/IconNew")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.panelFinish = UIControls.Panel(self, self.mPath .. "/FinishPanel")
	self.panelInSending = UIControls.Panel(self, self.mPath .. "/DispatchedPanel")
	self.inComputing = UIControls.Panel(self, self.mPath .. "/AccountPanel")
	self.panelSend = UIControls.Panel(self, self.mPath .. "/TextDispatch")
	self.panelRest = UIControls.Panel(self, self.mPath .. "/RestPanel")
	self.iconNote = UIControls.Image(self, self.mPath .. "/IconNote1")
end

function ClanClearLayerCell:setData(layerData, curLayer, timeState, inSending, allLayerData)
	self.inSending = inSending
	self.layerData = layerData
	self.timeState = timeState

	self.textName:setText(layerData.name or "")

	local inComp = timeState == 1

	self.nowState = 0

	local btnPath = "BgNormal"

	if layerData.is_boss then
		btnPath = "BgHard"
	end

	if layerData.layer == curLayer then
		self.panelLock:setVisible(false)
		self.panelFinish:setVisible(false)
		self.iconNote:setImage(self.mParent.atlasPath, "BgStickers2")

		if timeState == 1 then
			self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "2")
			self.textName:setFontColor(self.mParent.dispatchingColor)
			self.inComputing:setVisible(true)
			self.panelInSending:setVisible(false)
			self.panelSend:setVisible(false)
			self.iconNew:setVisible(false)
			self.panelRest:setVisible(false)
		elseif timeState == 2 then
			self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "2")
			self.textName:setFontColor(self.mParent.dispatchingColor)
			self.inComputing:setVisible(false)
			self.panelInSending:setVisible(false)
			self.panelSend:setVisible(false)
			self.iconNew:setVisible(false)
			self.panelRest:setVisible(true)
		elseif self.inSending then
			self.panelInSending:setVisible(true)
			self.inComputing:setVisible(false)
			self.panelSend:setVisible(false)
			self.iconNew:setVisible(false)
			self.panelRest:setVisible(false)
			self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "2")
			self.textName:setFontColor(self.mParent.dispatchingColor)
		else
			self.inComputing:setVisible(false)
			self.panelInSending:setVisible(false)
			self.panelSend:setVisible(true)
			self.iconNew:setVisible(not self.mParent.actInFreeze)
			self.panelRest:setVisible(false)
			self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "1")
			self.textName:setFontColor(self.mParent.nmlColor)
		end
	elseif curLayer > layerData.layer then
		self.iconNote:setImage(self.mParent.atlasPath, "BgStickers2")

		self.nowState = 1

		self.panelInSending:setVisible(false)
		self.panelLock:setVisible(false)
		self.panelFinish:setVisible(true)
		self.inComputing:setVisible(false)
		self.panelRest:setVisible(false)
		self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "3")
		self.iconNew:setVisible(false)
		self.textName:setFontColor(self.mParent.finishColor)
		self.panelSend:setVisible(false)
	else
		self.iconNote:setImage(self.mParent.atlasPath, "BgStickers1")

		self.nowState = 2

		self.panelLock:setVisible(true)
		self.panelInSending:setVisible(false)
		self.panelFinish:setVisible(false)
		self.inComputing:setVisible(false)
		self.btnLayerClick:setImage(self.mParent.atlasPath, btnPath .. "3")
		self.iconNew:setVisible(false)
		self.textName:setFontColor(self.mParent.finishColor)
		self.panelSend:setVisible(false)
		self.panelRest:setVisible(false)

		self.preLayerData = allLayerData[layerData.layer - 1]
	end
end

function ClanClearLayerCell:onLayerClick()
	if self.mParent.actInFreeze then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.nowState == 0 then
		if self.timeState == 1 then
			MsgManager.clientNotice(423)

			return
		end

		self.mParent:onLayerClick(self)
	elseif self.nowState == 1 then
		MsgManager.clientNotice(416)
	elseif self.nowState == 2 then
		if self.preLayerData then
			MsgManager.notice(utils.replaceString(ResClientNotice[415].notice, "$1", self.preLayerData.name))
		else
			MsgManager.clientNotice(415)
		end
	end
end

local strClassName = "ActivityClanClearDlg"
local ActivityClanClearDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityClanClearDlg, ActivityPanelMixin)

local MAX_AREA_NUM = 3

function ActivityClanClearDlg:initUI()
	self.textTime = UIControls.Label(self, "MainInfoPanel/TimePanel/TxtTime")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnsNormal = {}
	self.btnsHard = {}
	self.btnsAward = {}

	for index = 1, MAX_AREA_NUM do
		local newNormalBtn = ClanClearLayerCell(self, "MainInfoPanel/BtnNormal" .. index)

		table.insert(self.btnsNormal, newNormalBtn)

		local newHardBtn = ClanClearLayerCell(self, "MainInfoPanel/BtnHard" .. index)

		table.insert(self.btnsHard, newHardBtn)

		local newAwardBtn = UIControls.Button(self, "MainInfoPanel/BgPanel/BtnAward" .. index)

		newAwardBtn:addEventClick(self.onAwardClick)

		newAwardBtn.index = index

		table.insert(self.btnsAward, newAwardBtn)
	end

	self.sliderAchieve = UIControls.Slider(self, "MainInfoPanel/DisPatchAwardPanel/DisPatchProgress")
	self.textAchieve = UIControls.Label(self, "MainInfoPanel/DisPatchAwardPanel/Text")
	self.btnAchieve = UIControls.Button(self, "MainInfoPanel/DisPatchAwardPanel/BtnAward")

	self.btnAchieve:addEventClick(self.onAchieveClick)

	self.aniAchieve = UIControls.UIAni(self, "MainInfoPanel/DisPatchAwardPanel/BtnAward/Icon")
	self.imgAchieve = UIControls.Image(self, "MainInfoPanel/DisPatchAwardPanel/BtnAward/Icon")
	self.imgAchieveNew = UIControls.Image(self, "MainInfoPanel/DisPatchAwardPanel/BtnAward/IconNew")
	self.textStateTime = UIControls.Label(self, "MainInfoPanel/AccountTimePanel/TxtTime")
	self.panelClan = UIControls.Panel(self, "DesPanel")
end

function ActivityClanClearDlg:_setData()
	self.atlasPath = "Atlas/ActivityAtlas/ActivityMayDayCleanAtlas/ActivityMayDayCleanAtlas01"

	if self.replaceableCellPath and self.replaceableCellPath[3] then
		self.atlasPath = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[3] .. "/ActivityMayDayCleanAtlas01"
	end

	self.miscData = self.actObj.actData.miscData or {}
	self.nmlColor = ResColor.WHITE
	self.finishColor = ResColor.GREYACT
	self.dispatchingColor = ResColor.BROWNACT

	if self.replaceableColorPath and self.replaceableColorPath[1] then
		self.nmlColor = ResColor[self.replaceableColorPath[1]]
		self.finishColor = ResColor[self.replaceableColorPath[2]]
		self.dispatchingColor = ResColor[self.replaceableColorPath[3]]
	end

	self:refreshData()
end

function ActivityClanClearDlg:refreshData()
	local actData = self.actObj.actData
	local nowState, countDown = actData:getNowTimeState()

	ClientTimerManager.RemoveSecondTickUI(self.textStateTime)

	self.actInFreeze = false

	if self.actObj:inFreeze() then
		self.textStateTime:setText(Lang.get(32793))

		self.actInFreeze = true
	elseif nowState == 1 then
		ClientTimerManager.AddSecondFormatTickUI(self.textStateTime, countDown, nil, self.miscData.dispatch_running_notice, nil, nil)
	elseif nowState == 2 then
		ClientTimerManager.AddSecondFormatTickUI(self.textStateTime, countDown, nil, self.miscData.dispatch_finish_notice, nil, nil)
	else
		ClientTimerManager.AddSecondFormatTickUI(self.textStateTime, countDown, nil, self.miscData.dispatch_wait_notice, nil, nil)
	end

	for bossId = 1, MAX_AREA_NUM do
		local award = actData:getValidBonus(bossId)

		if award then
			self.btnsAward[bossId]:setVisible(true)
			self.btnsNormal[bossId]:setVisible(false)
			self.btnsHard[bossId]:setVisible(false)
		else
			self.btnsAward[bossId]:setVisible(false)
			self.btnsNormal[bossId]:setVisible(true)
			self.btnsHard[bossId]:setVisible(true)

			local curLayer = actData:getCurClanLayer(bossId)
			local normalLayerData = actData:curClanNormalLayerData(bossId)
			local forms = actData:getCurClanLayerFormation(bossId)
			local inSending = forms and #forms > 0

			self.btnsNormal[bossId]:setData(normalLayerData, curLayer, nowState, inSending, actData.clientData[bossId])

			local hardLayerData = actData:curClanHardLayerData(bossId)

			self.btnsHard[bossId]:setData(hardLayerData, curLayer, nowState, inSending, actData.clientData[bossId])
		end
	end

	local nowNum, maxNum = actData:getSendCountInfo()

	if actData:isSendAchieveGot() then
		self.sliderAchieve:setValue(1)
		self.textAchieve:setText(maxNum .. "/" .. maxNum)
		self.aniAchieve:stopAni("LoopAwardGet")
		self.imgAchieve:setImage(self.atlasPath, "BgBox2")
		self.imgAchieveNew:setVisible(false)
		self.btnAchieve:setObjGray(false)
	else
		self.sliderAchieve:setValue(nowNum / maxNum)
		self.textAchieve:setText(nowNum .. "/" .. maxNum)
		self.imgAchieve:setImage(self.atlasPath, "BgBox1")
		self.imgAchieveNew:setVisible(maxNum <= nowNum)

		if maxNum <= nowNum then
			self.aniAchieve:startAniLoop("LoopAwardGet")
			self.btnAchieve:setObjGray(false)
		else
			self.aniAchieve:stopAni("LoopAwardGet")
			self.btnAchieve:setObjGray(true)
		end
	end

	if CurAvatar:isInCircle() then
		self.panelClan:setVisible(false)
	else
		self.panelClan:setVisible(true)
	end
end

function ActivityClanClearDlg:updateActivityData()
	self:refreshData()

	local clanClearLayerDlg = UIManager.tryGetUI("clanClearLayerDlg")

	if clanClearLayerDlg then
		clanClearLayerDlg:updateActivityData()
	end

	local clanClearBonusDlg = UIManager.tryGetUI("clanClearBonusDlg")

	if clanClearBonusDlg then
		clanClearBonusDlg:updateActivityData()
	end
end

function ActivityClanClearDlg:onAwardClick(sender)
	UIManager.getUI("clanClearBonusDlg", true):onShowBoss(sender.index, self.actObj)
end

function ActivityClanClearDlg:onAchieveClick(sender)
	local bonusId = self.actObj.actData.miscData.send_achieve_award

	if self.actObj.actData:isSendAchieveGot() then
		ClientUtils.ShowBonusPreviewDlg(bonusId, true)
	else
		local nowNum, maxNum = self.actObj.actData:getSendCountInfo()

		if maxNum <= nowNum then
			self.actObj.actData:rpcGetAchieve()
		else
			ClientUtils.ShowBonusPreviewDlg(bonusId)
		end
	end
end

function ActivityClanClearDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityClanClearDlg:onLayerClick(layerCell)
	local layerData = layerCell.layerData

	UIManager.getUI("clanClearLayerDlg", true):onShowBoss(layerData.boss_id, self.actObj)
end

function ActivityClanClearDlg:onOpen()
	ActivityClanClearDlg.super.onOpen(self)

	if self.inited then
		self:refreshData()
	end
end

return ActivityClanClearDlg

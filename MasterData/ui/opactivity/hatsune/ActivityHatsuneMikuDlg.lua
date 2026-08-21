-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Hatsune\\ActivityHatsuneMikuDlg.lua

local ResOpActivityHatsuneLib = require("ClientData/ResOpActivityHatsuneLib")
local ResOpActivityHatsuneLibDetail = require("ClientData/ResOpActivityHatsuneLibDetail")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local HatsuneMikuConfig = require("UI/OpActivity/Hatsune/HatsuneMikuConfig")
local ActivityHatsuneMikuAwardCell = require("UI/OpActivity/Hatsune/ActivityHatsuneMikuAwardCell")
local UserData = require("Helper/UserData")
local OpState = {
	Multi = 4,
	Single = 3,
	Exchange = 5,
	Award = 6,
	Free = 2,
	None = 1
}
local mainDlgName = "activityHatsuneMikuDlg"
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityHatsuneMikuDlg = Class(mainDlgName, UIControls.Window)

MixinClass(ActivityHatsuneMikuDlg, ActivityPanelMixin)

function ActivityHatsuneMikuDlg:initUI()
	self.actData = self.actObj.actData
	self.actID = self.actData.actID
	self.fireID = self.actData.fireID
	self.rewardType = self.actData.rewardType
	self.operateTip = self.actData.operateTip
	self.convertItemID = self.actData.convertItemID
	self.miscData = self.actData.miscData
	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)

	if self.miscData.extra_slider then
		self.extraSlider = UIControls.Slider(self, "MainInfoPanel/HoneySlider")

		self.extraSlider:setValue(0, 0)

		self.extraSliderEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/EffectNodeHoney")
	end

	self.scrollPanel = UIControls.Panel(self, "MainInfoPanel/AwardList")
	self.scrollOffset = self.scrollPanel:getPosition().x
	self.scrollContent = UIControls.Panel(self, "MainInfoPanel/AwardList/Content")
	self.fireNumLabel = UIControls.Label(self, "MainInfoPanel/FireNum/TxtNum")
	self.fireNumBtn = UIControls.Button(self, "MainInfoPanel/FireNum")

	self.fireNumBtn:addEventClick(self.onFireBtn)

	self.textTime = UIControls.Label(self, "MainInfoPanel/TimePanel/TxtTime")
	self.textRule = UIControls.Label(self, "MainInfoPanel/TimePanel/TxtTime02")
	self.freeTime = UIControls.Label(self, "MainInfoPanel/BtnGroup/BtnOne/FreeTime")
	self.showChooseAward = UIControls.Panel(self, "MainInfoPanel/ShowChooseAward")
	self.showChooseTitle = UIControls.Label(self, "MainInfoPanel/ShowChooseAward/ChooseAwardNode/TextTitle")

	if UIControls.checkControlFunc(self, "MainInfoPanel/BigAwardPanel/ShowChooseAward") then
		self.showChooseBigAward = UIControls.Panel(self, "MainInfoPanel/BigAwardPanel/ShowChooseAward")
		self.showChooseBigAwardTitle = UIControls.Label(self, "MainInfoPanel/BigAwardPanel/ShowChooseAward/ChooseAwardNode/TextTitle")
		self.btnCloseChooseBigAward = UIControls.Button(self, "MainInfoPanel/BigAwardPanel/ShowChooseAward/UIClickThrough")

		self.btnCloseChooseBigAward:addEventClick(self.closeShowChoose)
	end

	self.chooseAward = UIControls.Panel(self, "MainInfoPanel/ShowChooseAward/ChooseAwardNode")
	self.chooseAwardPosY = self.chooseAward:getPosition().y
	self.btnCloseChooseAward = UIControls.Button(self, "MainInfoPanel/ShowChooseAward/UIClickThrough")

	self.btnCloseChooseAward:addEventClick(self.closeShowChoose)

	self.chooseAwardNodePath = "MainInfoPanel/ShowChooseAward/ChooseAwardNode"
	self.chooseBigAwardNodePath = "MainInfoPanel/BigAwardPanel/ShowChooseAward/ChooseAwardNode"
	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnGroup/BtnStore")

	self.btnStore:addEventClick(self.onBtnStore)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/BtnGroup/BtnAward")

	self.btnAward:addEventClick(self.onBtnAward)

	self.btnOne = UIControls.Button(self, "MainInfoPanel/BtnGroup/BtnOne", "TxtName")
	self.btnMultiple = UIControls.Button(self, "MainInfoPanel/BtnGroup/BtnMultiple", "TxtName")

	self.btnMultiple:addEventClick(self.onBtnMultiple)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTips)

	self.oneRedDot = UIControls.Image(self, "MainInfoPanel/BtnGroup/BtnOne/IconNew")
	self.multiRedDot = UIControls.Image(self, "MainInfoPanel/BtnGroup/BtnMultiple/IconNew")
	self.awardRedDot = UIControls.Image(self, "MainInfoPanel/BtnGroup/BtnAward/IconNew")
	self.exchangeUI = UIManager.getUI(self.exchangeUIName, false, true)
	self.live2DTime = self.actData.miscData.cheer_time
	self.live2Ds = {}
	self.isCheering = {}

	for index, live2DData in ipairs(self.actData.miscData.live2d_paths) do
		local liveImage = UIControls.LazyLivePlayer(self, "MainInfoPanel/Live2D0" .. index .. "/Live2D")

		table.insert(self.live2Ds, liveImage)
	end

	self.live2DEfx2 = {}

	if UIConst.CONCERT_GIFT_EFFECT[self.actID] then
		for index, live2DData in ipairs(self.actData.miscData.live2d_paths) do
			local efx = UIControls.LazyEffectPlayer(self, "MainInfoPanel/Live2D0" .. index .. "/Efx")

			table.insert(self.live2DEfx2, efx)
		end
	end

	if self.rewardType == UIConst.CONCERT_REWARD_SHOWGIFT then
		self.showGiftNmb = UIControls.UIAni(self, "MainInfoPanel/ShowGiftNmb")
		self.showGiftNmbImg = UIControls.Image(self, "MainInfoPanel/ShowGiftNmb")
		self.giftCountTxt = UIControls.Label(self, "MainInfoPanel/ShowGiftNmb/TextNmb")
		self.giftEffect = UIControls.LazyEffectPlayer(self, "MainInfoPanel/ShowGiftEffect")

		self.showGiftNmb:setVisible(false)
	end

	self.freeTip = utils.format(Lang.get(43765), self.operateTip)
	self.cheerOneTip = utils.format(Lang.get(43766), self.operateTip)
	self.fullNoticeId = self.actData:getFullNoticeId()

	self:setOpState(OpState.None)

	self.curGiftCount = 0
	self.curSelReward = -1

	if self.miscData.reward_delay then
		if self.rewardNoticeTimer then
			self.rewardNoticeTimer:Stop()

			self.rewardNoticeTimer = nil
		end

		self.rewardNoticeTimer = Timer.New(Slot(self.rewardNotice, self), self.miscData.reward_delay, 1)

		self.rewardNoticeTimer:Start()
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/JumpButton") then
		self.btnJumpSlider = UIControls.Button(self, "MainInfoPanel/JumpButton")

		self.btnJumpSlider:addEventClick(self.onSliderJumpClick)
		self.btnJumpSlider:setVisible(self.miscData.slider_jump_idx and self.miscData.slider_jump_idx > 0)
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/BtnVanity") then
		self.btnVanity = UIControls.Button(self, "MainInfoPanel/BtnVanity")

		self.btnVanity:addEventClick(self.onBtnVanityClick)
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/BigAwardPanel") then
		self.textBigAwardNum = UIControls.Label(self, "MainInfoPanel/BigAwardPanel/TextNum")
		self.imgBigAward = UIControls.Image(self, "MainInfoPanel/BigAwardPanel/AwardPanel/AwardImage")
		self.btnBigAward = UIControls.Button(self, "MainInfoPanel/BigAwardPanel/AwardPanel/AwardImage")
	end

	self.bigAwardGrids = {}
end

function ActivityHatsuneMikuDlg:rewardNotice()
	local selReward = -1

	for index = #self.allAwardsNode, 1, -1 do
		local node = self.allAwardsNode[index]

		if node.progress_need <= self.cheerNum and not self.actData.nodeDict[index] then
			selReward = index

			break
		end
	end

	if selReward > self.curSelReward then
		self.curSelReward = selReward

		self:playRewardVocal()
	end

	if self.rewardNoticeTimer then
		self.rewardNoticeTimer = nil
	end
end

function ActivityHatsuneMikuDlg:playRewardVocal()
	if self.miscData.reward_vocal then
		CueManager.playGroupVocal(self.miscData.reward_vocal)
	end
end

function ActivityHatsuneMikuDlg:updateRelatedActivityData()
	self:refreshData()
end

function ActivityHatsuneMikuDlg:updateActivityData(actObj)
	self.actObj = actObj

	self:refreshData()
end

function ActivityHatsuneMikuDlg:onActivityDataRefresh(actObj)
	self.actObj = actObj

	self:refreshData()
end

function ActivityHatsuneMikuDlg:_setData()
	self:refreshData()

	if self.actData.miscData.info_dlg_flag and self.actData.miscData.info_dlg_flag == 1 then
		self:checkOpenInfoDlg()
	end
end

function ActivityHatsuneMikuDlg:onOpenOver()
	ActivityHatsuneMikuDlg.super.onOpenOver(self)
	self:refreshExtraSlider(true)
end

function ActivityHatsuneMikuDlg:_initCells()
	if self.cellsInited then
		return
	end

	self.awardPrefab = "System/Activity/ActivityMiKuConcert/MiKuConcertAwardNmlCell"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.awardPrefab = "System/Activity/" .. self.replaceableCellPath[1]
	end

	self.allAwardsNode = self.actData.allAwardsNode

	local totalCount = #self.allAwardsNode

	self.allAwardNodeData = {}
	self.cells = {}

	if UIConst.CONCERT_SCROLL_TYPE[self.miscData.display_direction] == UIConst.CONCERT_SCROLL_HORIZONTAL then
		self.awardScroll = UIControls.ScrollViewLoopH(self, "MainInfoPanel/AwardList")

		for _, data in ipairs(self.allAwardsNode) do
			table.insert(self.allAwardNodeData, data)
		end
	elseif UIConst.CONCERT_SCROLL_TYPE[self.miscData.display_direction] == UIConst.CONCERT_SCROLL_VERTICAL then
		self.awardScroll = UIControls.ScrollViewLoopV(self, "MainInfoPanel/AwardList")

		for i = #self.allAwardsNode, 1, -1 do
			table.insert(self.allAwardNodeData, self.allAwardsNode[i])
		end
	end

	self.awardScroll:addEventCellChanged(self.onCellChanged)

	local awardIndex = self.actData:getCurNodeIndex()

	if awardIndex and awardIndex > 1 then
		self.awardScroll:setTotalCount(totalCount, awardIndex - 1)
	else
		self.awardScroll:setTotalCount(totalCount, 1)
	end

	self:refreshNodes()

	self.cellsInited = true
end

function ActivityHatsuneMikuDlg:onCellChanged(sender, targetCell, newIdx)
	local data = self.allAwardNodeData[newIdx]

	if not data then
		return
	end

	if targetCell == nil then
		targetCell = ActivityHatsuneMikuAwardCell(sender, self.awardPrefab, newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local nodeData = self.allAwardNodeData[newIdx]
	local libID = nodeData.lib_id
	local itemList = ResOpActivityHatsuneLib[libID]

	targetCell:setData(nodeData, itemList, self.actID, self.cheerNum, self.allAwardsNode, self.actData)

	self.cells[newIdx] = targetCell
	self.viewLastIdx = 1

	for i = newIdx, newIdx + 5 do
		if self.cells[i] and self.cells[i].mIndex > self.viewLastIdx then
			self.viewLastIdx = self.cells[i].mIndex
		end
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/BigAwardPanel") then
		self:_refreshBigAwardPanel()
	end
end

function ActivityHatsuneMikuDlg:_refreshBigAwardPanel()
	local isGet = false

	for i = self.viewLastIdx, #self.allAwardsNode do
		if self.allAwardsNode[i].award_flag and (not self.actData.nodeDict or not self.actData.nodeDict[i]) then
			self:showBigAward(self.allAwardsNode[i])

			isGet = true

			break
		end
	end

	if not isGet then
		for i = #self.allAwardsNode, 1, -1 do
			if self.allAwardsNode[i].award_flag then
				self:showBigAward(self.allAwardsNode[i])

				break
			end
		end
	end
end

function ActivityHatsuneMikuDlg:showBigAward(nodeData)
	self.nextBigAwardLibId = nodeData.lib_id
	self.nextBigAwardData = ResOpActivityHatsuneLib[self.nextBigAwardLibId]

	if #self.nextBigAwardData == 1 then
		ClientUtils.CreateBonusGrid(self, self.bigAwardGrids, "MainInfoPanel/BigAwardPanel/AwardPanel", self.nextBigAwardData[1].award_id, true, nil, true)
		self.imgBigAward:setVisible(false)
	else
		self.imgBigAward:setVisible(true)

		local iconPath = ResOpActivityHatsuneLibDetail[self.nextBigAwardLibId].bag_path
		local iconName = ResOpActivityHatsuneLibDetail[self.nextBigAwardLibId].bag_icon

		if iconPath and iconName then
			self.imgBigAward:setImage(iconPath, iconName)
		end

		self.btnBigAward:clearEventClick()
		self.btnBigAward:addEventClick(Functor(self.onBtnBigAwardClick, self, nodeData))

		for i, grid in pairs(self.bigAwardGrids) do
			grid:setVisible(false)
		end
	end

	local item = BaseObject.GetObject(self.actData.miscData.fire_id)

	if self.textBigAwardNum then
		self.textBigAwardNum:setText(string.format(Lang.get(107495), item.name, nodeData.progress_need))
	end
end

function ActivityHatsuneMikuDlg:onBtnBigAwardClick(nodeData)
	self:openBigAwardShowChoose(nodeData)
end

function ActivityHatsuneMikuDlg:openBigAwardShowChoose(nodeData)
	self:closeShowChoose()

	if self.showChooseBigAward then
		self.showChooseBigAward:setVisible(true)
	end

	local libID = nodeData.lib_id
	local itemList = ResOpActivityHatsuneLib[libID]
	local libDetail = ResOpActivityHatsuneLibDetail[libID]

	if self.showChooseBigAwardTitle then
		self.showChooseBigAwardTitle:setText(libDetail.award_name)
	end

	if self.grids ~= nil then
		for index, grids in ipairs(self.grids) do
			for j, grid in ipairs(grids) do
				grid:destroy()
			end
		end
	end

	self.grids = {}

	local gridConfig = {}

	gridConfig.checkNeedConvertObject = true

	for index, award in ipairs(itemList) do
		local grids = {}

		ClientUtils.CreateBonusGrid(self, grids, self.chooseBigAwardNodePath, award.award_id, true, nil, true, nil, nil, gridConfig)
		table.insert(self.grids, grids)

		for j, grid in ipairs(grids) do
			grid:setVisible(true)

			local isGet = self.actData:getLibState(libID, index)

			grid:setState(isGet, isGet, isGet)
		end
	end
end

function ActivityHatsuneMikuDlg:_initAchieveUI()
	if self.achieveInited then
		return
	end

	self.achieveUIName = "activityHatsuneMikuAchieveDlg"

	local ui = UIManager.getUI(self.achieveUIName)

	ui:onShowActivity({
		self.clientTemplateData,
		self.actObj
	})

	local data = self.actData:getAchieves()
	local title = self.actData.miscData.achieve_title

	ui:setData(data, self.actID, title)

	self.achieveInited = true
end

function ActivityHatsuneMikuDlg:refreshData()
	local actData = self.actData

	self._buyOneCount = 1
	self.freeCheerNum = actData:getFreeNum()
	self.cheerUpNum = 1
	self._buyMultiCount = actData:getMultiNum()
	self.cheerNum = actData.cheerNum

	self.actObj:checkNew()

	if self.actObj:inFreeze() or not self.actObj:isValid() or self.freeCheerNum < 1 then
		self:hideFreeCheer()
	else
		self:showFreeCheer()
	end

	self:updateMultiple()

	if self.actObj:inFreeze() then
		self.textRule:setVisible(true)
	else
		self.textRule:setVisible(false)
	end

	self.fireNumLabel:setText(self.cheerNum)

	if self.btnVanity then
		self.btnVanity:setVisible(self.actData.miscData.info_dlg_flag and self.actData.miscData.info_dlg_flag == 1)
	end

	self:_initCells()
	self:_initAchieveUI()
	self:refreshNodes()
	self:refresAchieves()
	self:refreshOpRedDot()
end

function ActivityHatsuneMikuDlg:refreshExtraSlider(disableSimu)
	if not self.miscData.extra_slider then
		return
	end

	self.extraSlider:setVisible(true)

	local lastIndex = self.curIndex or 0

	for index, node in ipairs(self.allAwardsNode) do
		self.curIndex = index

		if node.progress_need > self.cheerNum then
			break
		end
	end

	local curIndex = self.curIndex
	local prevIndex = curIndex - 1
	local prevProgressNeed = 0

	if self.allAwardsNode[prevIndex] then
		prevProgressNeed = self.allAwardsNode[prevIndex].progress_need
	end

	local nodeData = self.allAwardsNode[curIndex]
	local len = nodeData.progress_need - prevProgressNeed
	local dis = self.cheerNum - prevProgressNeed
	local rate = dis / len

	rate = math.min(rate, 1)

	if not disableSimu and lastIndex ~= curIndex then
		if self.animCo then
			coroutine.stop(self.animCo)
		end

		self.animCo = coroutine.start(self._coExtraSliderAnim, self, lastIndex, curIndex, rate)
	else
		self.extraSlider:setValue(rate, HatsuneMikuConfig.ANIM_TIME, nil, true)
	end
end

function ActivityHatsuneMikuDlg:_coExtraSliderAnim(fromIndex, endIndex, endRate)
	if fromIndex ~= endIndex then
		local animTime = HatsuneMikuConfig.ANIM_TIME / 2 / (endIndex - fromIndex)

		while fromIndex ~= endIndex do
			self.extraSlider:setValue(1, animTime, nil, true)
			coroutine.wait(animTime)
			self.extraSliderEffect:setVisible(true)
			self.extraSliderEffect:playEffect()
			self.extraSlider:setValue(0, 0, nil, true)

			fromIndex = fromIndex + 1

			coroutine.wait(animTime)
		end
	end

	self.extraSlider:setValue(endRate, HatsuneMikuConfig.ANIM_TIME, nil, true)
end

function ActivityHatsuneMikuDlg:refreshNodes()
	for _, cell in pairs(self.cells) do
		cell:refreshData()
	end
end

function ActivityHatsuneMikuDlg:onSliderJumpClick()
	if self.miscData.slider_jump_idx and self.awardScroll then
		self.awardScroll:scrollToCell(self.miscData.slider_jump_idx, 7000)
	end
end

function ActivityHatsuneMikuDlg:refreshOpRedDot()
	if self.actData:getHasCheerNum() <= 0 or self.actObj:inFreeze() or not self.actObj:isValid() then
		self.oneRedDot:setVisible(false)
		self.multiRedDot:setVisible(false)
	else
		local oneRedDotVisible = self.actData:getFreeNum() > 0 or self.actData:checkCheerUp() and not self.actData:checkCheerUp(self._buyMultiCount)

		self.oneRedDot:setVisible(oneRedDotVisible)

		local multiVisiable = self.actData:checkCheerUp(self._buyMultiCount)

		self.multiRedDot:setVisible(multiVisiable)
	end
end

function ActivityHatsuneMikuDlg:showFreeCheer()
	self.btnOne:setText(self.freeTip)
	self.freeTime:setVisible(false)
	self.btnOne:clearEventClick()
	self.btnOne:addEventClick(self.freeCheer)
end

function ActivityHatsuneMikuDlg:hideFreeCheer()
	local remainTime = self.actData:getRemainFreeTime()

	if remainTime then
		self.freeTime:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.freeTime, remainTime, false, Lang.get(48684), Slot(self.freeTimerOver, self))
	else
		self.freeTime:setVisible(false)
	end

	self.btnOne:setText(self.cheerOneTip)
	self.btnOne:clearEventClick()
	self.btnOne:addEventClick(self.onBtnOne)
end

function ActivityHatsuneMikuDlg:freeTimerOver()
	if self.freeTime:isAlive() then
		self:refreshData()
	end
end

function ActivityHatsuneMikuDlg:updateMultiple()
	self.btnMultiple:setText(utils.format(Lang.get(32786), self.operateTip, self._buyMultiCount))
end

function ActivityHatsuneMikuDlg:onBtnAward()
	local awardUI = UIManager.getUI(self.achieveUIName, true)

	if awardUI then
		awardUI:onShowActivity({
			self.clientTemplateData,
			self.actObj
		})
	end
end

function ActivityHatsuneMikuDlg:refresAchieves()
	local ui = UIManager.getUI(self.achieveUIName)

	if ui then
		ui:onShowActivity({
			self.clientTemplateData,
			self.actObj
		})
		ui:refreshData()
		self.awardRedDot:setVisible(ui:checkRedDot())
	end
end

function ActivityHatsuneMikuDlg:onFireBtn()
	BaseObject.ShowObjectTips(self.fireID, self.cheerNum, self)
end

function ActivityHatsuneMikuDlg:onBtnStore()
	local actID = self.actData.miscData.activity_shop

	CurAvatar:jumpToShowActivity(actID)
end

function ActivityHatsuneMikuDlg:onBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_DRAWCARD)
end

function ActivityHatsuneMikuDlg:onBtnClose()
	if self.cheerTimer ~= nil then
		self.cheerTimer:Stop()

		self.cheerTimer = nil
	end

	self:setVisible(false)
end

function ActivityHatsuneMikuDlg:onBtnMultiple()
	if self:checkOp(OpState.Multi) then
		self.actData:tryCheerUp(self._buyMultiCount)
	end
end

function ActivityHatsuneMikuDlg:freeCheer()
	if self:checkOp(OpState.Free) then
		self.actData:freeCheer()
	end
end

function ActivityHatsuneMikuDlg:onBtnOne()
	if self:checkOp(OpState.Single) then
		self.actData:tryCheerUp(self._buyOneCount)
	end
end

function ActivityHatsuneMikuDlg:cheerUpCB(num)
	if num > 1 then
		for index, liveImage in ipairs(self.live2Ds) do
			self:playLive2DOnce(index)
		end

		if self.miscData.multi_vocal then
			CueManager.playGroupVocal(self.miscData.multi_vocal)
		end
	elseif num == 1 then
		local index = math.random(1, #self.live2Ds)

		self:playLive2DOnce(index)

		if self.miscData.single_vocal then
			CueManager.playGroupVocal(self.miscData.single_vocal)
		end
	end

	self:rewardNotice()
	self:refreshExtraSlider()
end

function ActivityHatsuneMikuDlg:playLive2DOnce(key)
	self.live2Ds[key]:playState("cheer")

	if not self.isCheering[key] then
		self.isCheering[key] = true

		if UIConst.CONCERT_GIFT_EFFECT[self.actID] then
			self.live2DEfx2[key]:setVisible(true)
		end
	end

	if UIConst.CONCERT_GIFT_EFFECT[self.actID] then
		self.live2DEfx2[key]:playEffect()
	end

	if self.cheerTimer ~= nil then
		self.cheerTimer:Restart()
	else
		self.cheerTimer = Timer(Slot(self.stopCheer, self), self.actData.miscData.cheer_time, -1)

		self.cheerTimer:Start()
	end
end

function ActivityHatsuneMikuDlg:stopCheer()
	if self.cheerTimer ~= nil then
		self.cheerTimer:Stop()

		self.cheerTimer = nil
	end

	for key, value in pairs(self.isCheering) do
		self.live2Ds[key]:playState("idle")

		if UIConst.CONCERT_GIFT_EFFECT[self.actID] then
			self.live2DEfx2[key]:stopEffect()
			self.live2DEfx2[key]:setVisible(false)
		end
	end

	self.isCheering = {}
end

function ActivityHatsuneMikuDlg:openShowChoose(nodeData, pos)
	self:closeShowChoose()
	self.showChooseAward:setVisible(true)

	local libID = nodeData.lib_id
	local itemList = ResOpActivityHatsuneLib[libID]
	local libDetail = ResOpActivityHatsuneLibDetail[libID]

	self.showChooseTitle:setText(libDetail.award_name)

	if self.grids ~= nil then
		for index, grids in ipairs(self.grids) do
			for j, grid in ipairs(grids) do
				grid:destroy()
			end
		end
	end

	self.grids = {}

	local gridConfig = {}

	gridConfig.checkNeedConvertObject = true

	for index, award in ipairs(itemList) do
		local grids = {}

		ClientUtils.CreateBonusGrid(self, grids, self.chooseAwardNodePath, award.award_id, true, nil, true, nil, nil, gridConfig)
		table.insert(self.grids, grids)

		for j, grid in ipairs(grids) do
			grid:setVisible(true)

			local isGet = self.actData:getLibState(libID, index)

			grid:setState(isGet, isGet, isGet)
		end
	end

	local width = self.chooseAward:getRectSize().width
	local offset = self.scrollContent:getPosition().x

	self.chooseAward:setPosition(pos.x + self.scrollOffset + offset + width - 342, self.chooseAwardPosY)
end

function ActivityHatsuneMikuDlg:closeShowChoose()
	if self.grids ~= nil then
		for index, grids in ipairs(self.grids) do
			for j, grid in ipairs(grids) do
				grid:destroy()
			end
		end
	end

	self.grids = nil

	self.showChooseAward:setVisible(false)

	if self.showChooseBigAward then
		self.showChooseBigAward:setVisible(false)
	end
end

function ActivityHatsuneMikuDlg:getNodeAward(nodeData)
	local items = ResOpActivityHatsuneLib[nodeData.lib_id]
	local itemStates = {}

	for key, value in ipairs(items) do
		itemStates[key] = self.actData:getLibState(nodeData.lib_id, key)
	end

	if #items > 1 then
		local data = {
			items = items,
			itemStates = itemStates,
			callback = Functor(self.getNodeAwardCB, self, nodeData),
			title = ResOpActivityHatsuneLibDetail[nodeData.lib_id].award_name
		}
		local ui = UIManager.getUI("openGiftBoxChooseDlg", true)

		if ui then
			ui:setData(data)
		end
	else
		self:getNodeAwardCB(nodeData, items[1])
	end
end

function ActivityHatsuneMikuDlg:getNodeAwardCB(nodeData, selected)
	self.actData:getNodeAward(nodeData, selected)
end

function ActivityHatsuneMikuDlg:checkOp(state)
	if state == OpState.Single or state == OpState.Free or state == OpState.Multi or state == OpState.Exchange then
		if self.actData:getHasCheerNum() <= 0 then
			if state == OpState.Free then
				UIManager.showConfirmWithId(1043)
			else
				UIManager.showConfirmWithId(self.fullNoticeId)
			end

			return false
		end

		if self.actObj:inFreeze() then
			MsgManager.notice(Lang.get(32793))

			return false
		end

		if not self.actObj:isValid() then
			MsgManager.notice(Lang.get(32785))

			return false
		end
	end

	return self.opFlag == OpState.None
end

function ActivityHatsuneMikuDlg:setOpState(state)
	self.opFlag = state
end

function ActivityHatsuneMikuDlg:opCallBack()
	local prevOpState = self.opFlag

	self:setOpState(OpState.None)

	if prevOpState ~= OpState.Multi and prevOpState ~= OpState.Single and prevOpState ~= OpState.Free then
		return
	end

	local newGift = 1

	if prevOpState == OpState.Multi then
		newGift = self._buyMultiCount

		self:cheerUpCB(self._buyMultiCount)
	end

	if prevOpState == OpState.Single or prevOpState == OpState.Free then
		self:cheerUpCB(self._buyOneCount)
	end

	self.actData:cheerTransformCB()

	if self.rewardType == UIConst.CONCERT_REWARD_SHOWGIFT then
		self:_playCheerUpCallback(newGift)
	end
end

function ActivityHatsuneMikuDlg:_playCheerUpCallback(newGift)
	self.curGiftCount = self.curGiftCount + newGift

	if not self.showGiftNmb:getVisible() then
		self.showGiftNmb:setVisible(true)
	end

	local basePath = "Atlas/ActivityAtlas/ActivityAIChannelLive/ActivityAIChannelLiveAtlas"
	local image = "BgRewardGreen"
	local effectPath = "Effects/UI/efx_ui_ActivityAIChannelLiveMainCanvas_01.prefab"

	if self.curGiftCount >= 10 then
		image = "BgRewardRed"
		effectPath = "Effects/UI/efx_ui_ActivityAIChannelLiveMainCanvas_02.prefab"
	end

	self.showGiftNmbImg:setImage(basePath, image)
	self.giftEffect:playEffectByPath(effectPath)
	self.showGiftNmb:startAni("ShowGiftNmbLoop", true)
	self.giftCountTxt:setText(self.curGiftCount)
end

function ActivityHatsuneMikuDlg:onGetRelatedActivityBonus(relateActId, relateInfo, callback)
	if self.opFlag == OpState.Multi or self.opFlag == OpState.Single or self.opFlag == OpState.Free then
		local isFull = self.actData:getHasCheerNum() <= 0
		local bonusUI = UIManager.getUI("commonBonusDlg")

		if isFull then
			bonusUI:disableFlyConfig(self.fireID, true)
		else
			bonusUI:setSpecialCustomizeFlyConfig(self.fireID, self.fireNumBtn)
			bonusUI:setSpecialCustomizeFlyConfig(self.convertItemID, self.btnStore)
		end

		callback(Slot(self.opCallBack, self), utils.format(Lang.get(43767), self.operateTip))
	elseif self.opFlag == OpState.Exchange then
		self.actData:tryCheerUpDirect()
	else
		callback(Slot(self.opCallBack, self))
	end
end

function ActivityHatsuneMikuDlg:onUpdateItemChanged()
	self:refreshData()
end

function ActivityHatsuneMikuDlg:checkOpenInfoDlg()
	if self.actData.miscData.not_show_index and self.actData.nodeDict and self.actData.nodeDict[self.actData.miscData.not_show_index] or self.actData.miscData.not_show_index and self.actData.miscData.not_show_index == 0 then
		-- block empty
	else
		local timeStr = UserData.loadCommonData(CurAvatar.uid .. "OpenHatsuneInfoDlg")
		local time = tonumber(timeStr)

		if time and ClientUtils.isTickToday(time) then
			-- block empty
		else
			self:onBtnVanityClick()
			UserData.saveCommonData(CurAvatar.uid .. "OpenHatsuneInfoDlg", ClientUtils.getServerTime())
		end
	end
end

function ActivityHatsuneMikuDlg:onBtnVanityClick()
	UIManager.getUI("activityHatsuneMikuInfoDlg", true):setData(self.actObj)
end

ActivityHatsuneMikuDlg.OpState = OpState

return ActivityHatsuneMikuDlg

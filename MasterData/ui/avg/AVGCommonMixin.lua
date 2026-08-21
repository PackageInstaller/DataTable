-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\AVGCommonMixin.lua

local UserData = require("Helper/UserData")
local AvgConfig = require("DesignerScript/AvgConfig")
local AVGInfo = require("UI/AVG/AVGInfo")
local ResAVGBulletMisc = require("ClientData/ResAVGBulletMisc")
local ResAVGBulletFake = require("ClientData/ResAVGBulletFake")
local ResPlotRewindDetail = require("ClientData/ResPlotRewindDetail")
local ResPlotRewindChapter = require("ClientData/ResPlotRewindChapter")
local ResPlotRewindMainChapter = require("ClientData/ResPlotRewindMainChapter")
local ResAVGSummary = require("ClientData/ResAVGSummary")
local ResAVGSummaryMisc = require("ClientData/ResAVGSummaryMisc")
local AVGCommonMixin = {}

function AVGCommonMixin.initAVGSummary()
	AVGCommonMixin.AVGTypeMap = {}

	local avgType, chapterId, sectionList

	for mainChapterIndex, mainChapter in ipairs(ResPlotRewindMainChapter) do
		avgType = mainChapter.main_chapter_type

		for chapterIndex, chapter in ipairs(ResPlotRewindChapter[mainChapterIndex] or {}) do
			chapterId = chapter.id

			for detailIndex, detail in ipairs(ResPlotRewindDetail[chapterId] or {}) do
				sectionList = detail.section

				if sectionList then
					for _, section in pairs(sectionList) do
						AVGCommonMixin.AVGTypeMap[section.id] = avgType
					end
				end
			end
		end
	end
end

AVGCommonMixin.initAVGSummary()

function AVGCommonMixin:_preInitAVGBullet()
	self.allBullets = {}
	self.showingBulletIndex = {}
	self.noServerBullets = {}
	self.avgBulletMisc = {}

	for _, data in pairs(ResAVGBulletMisc) do
		self.avgBulletMisc = data
	end

	self.avgBulletOn = self.avgBulletMisc.avgbullet_on == 1 and VersionUtils.hasAbilityCircleBattle()
	self.avgBulletTextLimit = self.avgBulletMisc.avgbullet_text_limit or 40
	self.localAVGLimit = self.avgBulletMisc.local_avg_limit or 10
	self.avgBulletMinNum = self.avgBulletMisc.bullet_num_min or 3
	self.avgFakeBulletNumMax = self.avgBulletMisc.fake_bullet_max or 5
	self.avgFakeBulletNumMin = self.avgBulletMisc.fake_bullet_min or 1
	self.fakeEmojiRatio = self.avgBulletMisc.emoji_ratio or 1
	self.fakeBulletNum = #ResAVGBulletFake
	self.avgbullet_post_limit_id = self.avgBulletMisc.avgbullet_post_limit_id
	self.bulletInputPanel = UIControls.Panel(self, "InputPanel")
	self.funcPanelL = UIControls.Panel(self, "FuncPanelL")

	if self.avgBulletOn then
		self:_initBulletUI()
		self:enableBullet()
	else
		self:disableBullet()
	end
end

function AVGCommonMixin:_initBulletUI()
	if self.isBulletUIInited then
		return
	end

	self.isBulletUIInited = true

	self.funcPanelL:setVisible(true)

	self.avgBulletDlg = UIManager.getUI("avgBulletDlg", true, true)

	self.avgBulletDlg:setOrder(self:getOrder() + 10)

	self.switchBulletBtn = UIControls.Button(self, "FuncPanelL/BtnBulletSwitch")

	self.switchBulletBtn:addEventClick(self._onSwitchBulletBtn)

	self.bulletOnPanel = UIControls.Panel(self, "FuncPanelL/BtnBulletSwitch/OnPanel")
	self.bulletOffPanel = UIControls.Panel(self, "FuncPanelL/BtnBulletSwitch/OffPanel")
	self.bulletEditSendBtn = UIControls.Button(self, "InputPanel/Inputanel/BtnSend")

	self.bulletEditSendBtn:addEventClick(self._onBulletMsgSend)

	self.bulletSendText = UIControls.Label(self, "InputPanel/Inputanel/BtnSend/Text")
	self.bulletEmojiEditBtn = UIControls.Button(self, "InputPanel/Inputanel/BtnEmoji")

	self.bulletEmojiEditBtn:addEventClick(self._onBulletEmojiEdit)

	self.bulletEditInputField = UIControls.Input(self, "InputPanel/Inputanel/InputTextPanel/InputText")
	self.bulletEditCloseBtn = UIControls.Button(self, "InputPanel/BtnClose")

	self.bulletEditCloseBtn:addEventClick(self._closeBulletEdit)

	self.bulletEditBtn = UIControls.Button(self, "FuncPanelL/BtnBullet")

	self.bulletEditBtn:addEventClick(self._onBulletEditBtn)

	self.bulletEditAnim = UIControls.UIAni(self, "InputPanel")
end

function AVGCommonMixin:enableBullet()
	self.avgBulletOn = true

	self:_initAVGBullet()
end

function AVGCommonMixin:disableBullet()
	self.funcPanelL:setVisible(false)
	self.bulletInputPanel:setVisible(false)

	if self.avgBulletDlg then
		self.avgBulletDlg:setState(false)
	end

	if self.updateBulletTimer then
		self.updateBulletTimer:Stop()

		self.updateBulletTimer = nil
	end

	if self.bulletPostTimer then
		self.bulletPostTimer:Stop()

		self.bulletPostTimer = nil
	end
end

function AVGCommonMixin:_initAVGBullet()
	if CurAvatar then
		self.showBulletFlag = CurAvatar:getAvgBulletState()
	else
		self.showBulletFlag = true
	end

	MsgManager.showMsgOnScreen(false)
	self:_initLocalAVGBullet()
	self:_initEmojiMap()
	self:_stopBulletTimer()

	self.updateBulletTimer = Timer.New(Slot(self._updateBulletTimer, self), AvgConfig.BULLET_UPDATE_CD, -1)

	self.updateBulletTimer:Start()
	self:setBulletState(self.showBulletFlag)
end

function AVGCommonMixin:_stopBulletTimer()
	if self.updateBulletTimer then
		self.updateBulletTimer:Stop()

		self.updateBulletTimer = nil
	end

	if self.bulletPostTimer then
		self.bulletPostTimer:Stop()

		self.bulletPostTimer = nil
	end
end

function AVGCommonMixin:_clearAVGBullet()
	self.showingBulletIndex = {}

	self:_stopBulletTimer()
	self:_closeBulletEdit()

	if self.avgBulletDlg then
		self.avgBulletDlg:clearCache()
	end

	MsgManager.showMsgOnScreen(true)
end

function AVGCommonMixin:_closeBulletEdit()
	if not self.inBulletEdit then
		return
	end

	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if ui then
		ui:setVisible(false)
	end

	if self.bulletInputPanel then
		self.bulletInputPanel:setVisible(false)
	end

	self.inBulletEdit = false

	if self.autoPlay then
		self:_startAutoTimer(AvgConfig.AUTO_TIMER_NEXTPAGE)
	end

	if self._resumeBulletVideoPlay then
		self:_resumeBulletVideoPlay()
	end
end

function AVGCommonMixin:displayBullet(pageID)
	if pageID and self.avgBulletOn and self.showBulletFlag then
		self.avgBulletDlg:clearCache()

		self.curBulletPage = pageID

		self:requestBullet(pageID, 1, true)
	end
end

function AVGCommonMixin:_updateBulletTimer()
	local suffixID = self:suffixPageID(self.curSection, self.curPage)
	local prevIndex = self.showingBulletIndex[suffixID]

	if not prevIndex then
		self.showingBulletIndex[suffixID] = 1

		self:requestBullet(self.curPage, self.showingBulletIndex[suffixID], true)
	elseif self.avgBulletDlg and self.avgBulletDlg:getCacheNum() < AvgConfig.BULLET_LIMIT then
		if self.noServerBullets[suffixID] then
			if self.noServerBullets[suffixID][prevIndex] then
				self.showingBulletIndex[suffixID] = 1
			else
				self.showingBulletIndex[suffixID] = prevIndex + 1
			end
		else
			self.showingBulletIndex[suffixID] = prevIndex + 1
		end

		self:requestBullet(self.curPage, self.showingBulletIndex[suffixID], true)
	end
end

function AVGCommonMixin:requestBullet(pageID, index, instant)
	index = index or 1

	local suffixID = self:suffixPageID(self.curSection, pageID)

	if not suffixID then
		return
	end

	if self.isSectionEnd ~= nil and self:isSectionEnd(pageID) then
		return
	end

	if self.allBullets[suffixID] and self.allBullets[suffixID][index] then
		self:cacheBulletCallback(suffixID, index, instant, self.allBullets[suffixID][index])
	else
		local callback = Functor(self.cacheBulletCallback, self, suffixID, index, instant)

		CurAvatar:requestBulletData(suffixID, index, callback)
	end
end

function AVGCommonMixin:cacheBulletCallback(suffixID, index, instant, bulletData)
	if not self.noServerBullets[suffixID] then
		self.noServerBullets[suffixID] = {}
	end

	if not bulletData then
		return
	end

	if #bulletData < AvgConfig.BULLET_PAGE_LIMIT then
		self.noServerBullets[suffixID][index] = true
	else
		self.noServerBullets[suffixID][index] = false
	end

	if not self.allBullets[suffixID] then
		self.allBullets[suffixID] = {}
	end

	self.allBullets[suffixID][index] = bulletData

	if instant then
		self:showBulletDataBySuffixID(suffixID, index)
	end
end

function AVGCommonMixin:suffixPageID(sectionID, pageID)
	sectionID = sectionID or self.curSection

	if not sectionID then
		return nil
	end

	pageID = pageID or self.curPage or 1

	local suffixID

	if pageID then
		suffixID = sectionID * 1000 + pageID
	end

	return suffixID
end

function AVGCommonMixin:getCurSuffixPageID(pageID)
	if not pageID then
		return self:getCurSuffixID()
	else
		return self:suffixPageID(self.curSection, pageID)
	end
end

function AVGCommonMixin:getCurSuffixID()
	return self:suffixPageID(self.curSection, self.curPage)
end

local function dataComp(a, b)
	if not a or not b or not a.content or not b.content then
		return false
	end

	if a.uid == CurAvatar.uid and b.uid ~= CurAvatar.uid then
		return true
	end

	if b.uid == CurAvatar.uid and a.uid ~= CurAvatar.uid then
		return false
	end

	local aLen = utils.utf8len(a.content, 2)
	local bLen = utils.utf8len(b.content, 2)

	if aLen == bLen then
		if not a.created or not b.created then
			return false
		end

		if a.created == b.created then
			return false
		end

		return a.created > b.created
	else
		return bLen < aLen
	end
end

function AVGCommonMixin:showBulletDataBySuffixID(suffixID, index)
	self.showingBulletIndex[suffixID] = index

	local localBulletData = self:fetchLocalBullet(suffixID)
	local bulletData = utils.deepcopy(localBulletData)

	bulletData = bulletData or {}

	if self.allBullets[suffixID] then
		for _, data in pairs(self.allBullets[suffixID][index]) do
			if not self:checkExistBullet(localBulletData, data) then
				table.insert(bulletData, data)
			end
		end
	end

	local curBulletNum = 0

	if bulletData then
		table.sort(bulletData, dataComp)

		for index, data in pairs(bulletData) do
			local content = {
				text = data.content,
				isMainPlayer = data.uid == CurAvatar.uid
			}

			self.avgBulletDlg:addBullet(content)

			curBulletNum = curBulletNum + 1
		end
	end

	if index == 1 and curBulletNum < self.avgBulletMinNum then
		local fakeNum = math.random(self.avgFakeBulletNumMin, self.avgFakeBulletNumMax)

		for i = 1, fakeNum do
			local isEmoji = math.random()
			local fakeContent

			if isEmoji < self.fakeEmojiRatio then
				fakeContent = self:getRandomLargeEmoji()
			else
				local fakeIndex = math.random(1, self.fakeBulletNum)

				fakeContent = ResAVGBulletFake[fakeIndex].content
			end

			if self.avgBulletDlg then
				local content = {
					text = fakeContent
				}

				self.avgBulletDlg:addBullet(content)
			end
		end
	end
end

function AVGCommonMixin:getRandomLargeEmoji()
	if self.largeEmojiMap then
		local max = #self.largeEmojiMap
		local index = math.random(1, max)

		return self.largeEmojiMap[index]
	else
		return nil
	end
end

function AVGCommonMixin:_initEmojiMap()
	self.emojiMap = {}

	for key, info in pairs(UIConst.EMOJI_DATA) do
		self.emojiMap[info.type] = self.emojiMap[info.type] or {}

		for _, name in ipairs(info.data) do
			table.insert(self.emojiMap[info.type], name)
		end
	end

	self.largeEmojiMap = self.emojiMap[UIConst.EMOJI_TYPE_LARGE]
end

function AVGCommonMixin:showBulletDataByPageID(pageID, index)
	local suffixID = self:getCurSuffixPageID(pageID)

	self:showBulletDataBySuffixID(suffixID, index)
end

function AVGCommonMixin:_onSwitchBulletBtn()
	self:setBulletState(not self.showBulletFlag)
end

function AVGCommonMixin:setBulletState(state)
	self.showBulletFlag = state

	local flag = "0"

	if self.showBulletFlag then
		flag = "1"
	end

	if CurAvatar then
		CurAvatar:setAvgBulletState(flag)
	end

	self.bulletOnPanel:setVisible(not self.showBulletFlag)
	self.bulletOffPanel:setVisible(self.showBulletFlag)
	self.avgBulletDlg:setState(self.showBulletFlag)

	if self.showBulletFlag then
		if self.updateBulletTimer then
			self.updateBulletTimer:Restart()
		end

		self:displayBullet(self.curPage)
	elseif self.updateBulletTimer then
		self.updateBulletTimer:Stop()
	end
end

function AVGCommonMixin:_onBulletEditBtn()
	if self:checkInPostLimit() then
		return
	end

	if self.inBulletEdit then
		self:_closeBulletEdit()
	else
		self.bulletInputPanel:setVisible(true)

		self.inBulletEdit = true

		if self.autoPlay then
			self:_stopAutoTimer()
		end

		if self._pauseBulletVideoPlay then
			self:_pauseBulletVideoPlay()
		end
	end
end

function AVGCommonMixin:checkInPostLimit()
	if self.avgbullet_post_limit_id then
		local locked = ConditionLimitManager.inLimitState(self.avgbullet_post_limit_id)

		if locked then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(self.avgbullet_post_limit_id))

			return true
		end
	end

	return false
end

function AVGCommonMixin:_onBulletEmojiEdit()
	local ui = UIManager.tryGetUI("avgBulletEmojiBox")

	if not ui then
		ui = UIManager.getUI("avgBulletEmojiBox", true)

		ui:setOrder(self:getOrder() + 100)
		ui:show(self.editInput, Slot(self._onBulletMsgSend, self), Slot(self._onBulletEmojiClose, self))
		self.bulletEditAnim:startAni("ShowEmoji", true)
	end
end

function AVGCommonMixin:_onBulletEmojiClose()
	self.bulletEditAnim:startAni("CloseEmoji", true)
end

function AVGCommonMixin:_onBulletMsgSend(sender, content, moveFunc, moveEmojiInfo)
	local clear = true
	local type = UIConst.AVG_BULLET_TEXT
	local item_id
	local text = ""

	if content then
		clear = false
		text = content
		type = UIConst.AVG_BULLET_EMOJI
	else
		text = self.bulletEditInputField:getText()
		text = ClientUtils.checkMarkIllegal(text)
		type = UIConst.AVG_BULLET_TEXT
	end

	if moveEmojiInfo then
		item_id = moveEmojiInfo.item_id
		type = UIConst.AVG_BULLET_MOVEEMOJI
	end

	if text == "" then
		MsgManager.notice(Lang.get(30165))

		return
	end

	if not self:checkBulletLength(text) then
		return
	end

	local pageID = self:getCurSuffixID()
	local postCallback = Functor(self._onBulletMsgPostCallback, self, text)

	if CurAvatar:postButtlet(pageID, text, postCallback, type, item_id) then
		if clear then
			self.bulletEditInputField:setText("")
		end

		if self.bulletPostTimer then
			self.bulletPostTimer:Stop()
		end

		self.bulletPostCDCount = self.avgBulletMisc.avgbullet_post_cd

		self.bulletSendText:setText(utils.format(Lang.get(49674), self.bulletPostCDCount))

		self.bulletPostTimer = Timer.New(Functor(self._updatePostBulletLabel, self), 1, self.avgBulletMisc.avgbullet_post_cd)

		self.bulletPostTimer:Start()
		self:_closeBulletEdit()
	end
end

function AVGCommonMixin:_updatePostBulletLabel()
	self.bulletPostCDCount = self.bulletPostCDCount - 1

	if self.bulletPostCDCount <= 0 then
		self.bulletSendText:setText(utils.format(Lang.get(690)))
	else
		self.bulletSendText:setText(utils.format(Lang.get(49674), self.bulletPostCDCount))
	end
end

function AVGCommonMixin:_onBulletMsgPostCallback(oriText, uid, pageID, text)
	local content = {
		isMainPlayer = true,
		text = text
	}

	if self.avgBulletDlg then
		if not self.showBulletFlag then
			self:setBulletState(true)
		end

		self.avgBulletDlg:addBullet(content, true)
	end

	local cacheBullet = {
		content = text,
		uid = uid,
		entry_id = pageID
	}

	if not self.allBullets[pageID] then
		self.allBullets[pageID] = {}
	end

	if not self.allBullets[pageID][1] then
		self.allBullets[pageID][1] = {}
	end

	table.insert(self.allBullets[pageID][1], cacheBullet)

	if oriText == text then
		self:saveLocalBullet(uid, pageID, content)
	end
end

function AVGCommonMixin:checkBulletLength(text)
	local len = utils.utf8len(text, 2)

	if len > self.avgBulletTextLimit then
		MsgManager.notice(utils.format(Lang.get(51014), self.avgBulletTextLimit))

		return false
	end

	return true
end

function AVGCommonMixin:_initLocalAVGBullet()
	self.AVGBulletKey = CurAvatar.uid .. "localAVGBullet"
	self.AVGBulletIndexKey = CurAvatar.uid .. "localAVGBulletIndex"

	local localBulletString = UserData.loadCommonData(self.AVGBulletKey)

	self.oriAVGBulletTable = ClientUtils.string2Table(localBulletString)
	self.localAVGBullet = {}

	for _, data in ipairs(self.oriAVGBulletTable) do
		if not self.localAVGBullet[data.entry_id] then
			self.localAVGBullet[data.entry_id] = {}
		end

		table.insert(self.localAVGBullet[data.entry_id], data)
	end

	self.localAVGIndex = UserData.loadCommonData(self.AVGBulletIndexKey) or 0
	self.localAVGIndex = tonumber(self.localAVGIndex) or 0
end

function AVGCommonMixin:fetchLocalBullet(pageID)
	if not self.localAVGBullet then
		self.localAVGBullet = {}

		return nil
	end

	return self.localAVGBullet[pageID]
end

function AVGCommonMixin:saveLocalBullet(uid, pageID, content)
	local data = {
		uid = uid,
		entry_id = pageID,
		content = content
	}

	if #self.oriAVGBulletTable > self.localAVGLimit then
		self.oriAVGBulletTable[self.AVGBulletIndex + 1] = data
	else
		table.insert(self.oriAVGBulletTable, data)

		self.localAVGIndex = (self.localAVGIndex + 1) % self.localAVGLimit
	end

	UserData.saveCommonData(self.AVGBulletIndexKey, self.localAVGIndex)
	UserData.saveCommonData(self.AVGBulletKey, ClientUtils.table2String(self.localAVGBullet))
end

function AVGCommonMixin:checkExistBullet(src, target)
	if not src then
		return false
	end

	for _, data in pairs(src) do
		if data.entry_id == target.entry_id and data.uid == target.uid and data.content == target.content then
			return true
		end
	end

	return false
end

function AVGCommonMixin:onBtnSkipClick(sender)
	if self.inVideoPlay then
		self:_realSkipClick()
	elseif ResAVGSummary[self.curSection] then
		local ui = UIManager.getUI("avgconfirmbox", true)
		local data = {
			yesCallback = Slot(self._realSkipClick, self),
			noCallback = Slot(self.onSkilCancelCallback, self),
			title = ResAVGSummary[self.curSection].title,
			content = ResAVGSummary[self.curSection].summary
		}

		ui:setData(data)

		if self.autoPlay then
			self:_stopAutoTimer()
		end
	else
		local plotRewindUI = UIManager.tryGetUI("plotRewindDlg")

		if not plotRewindUI then
			local avgType = AVGCommonMixin.AVGTypeMap[self.curSection]

			if avgType == UIConst.PLOT_REWIND_MAIN_LINE then
				local commonSkipTip = ResAVGSummaryMisc[avgType].skip_tip

				if not self.lastSkipTipTime or ClientUtils.getServerTime() >= self.lastSkipTipTime + AvgConfig.SKIP_TIP_CD then
					MsgManager.notice(commonSkipTip)

					self.lastSkipTipTime = ClientUtils.getServerTime()
				end
			end
		end

		self:_realSkipClick()
	end
end

function AVGCommonMixin:onSkilCancelCallback()
	if self.autoPlay and self._autoPlayTimer then
		self._autoPlayTimer:Restart()
	end
end

return AVGCommonMixin

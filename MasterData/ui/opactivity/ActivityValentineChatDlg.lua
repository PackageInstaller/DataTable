-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityValentineChatDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityChatGamePlot = require("ClientData/ResOpActivityChatGamePlot")
local ResOpActivityChatGameSection = require("ClientData/ResOpActivityChatGameSection")
local ResOpActivityChatGameSectionConfig = require("ClientData/ResOpActivityChatGameSectionConfig")
local ResOpActivityChatGameMisc = require("ClientData/ResOpActivityChatGameMisc")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ChatBox = require("UI/Chat/ChatBox")
local UserData = require("Helper/UserData")
local MathMin = math.min
local MathMax = math.max
local USER_KEY_SECTION = "chat_section"
local USER_KEY_SECTION_SELECT = "chat_section_id"
local DEFAULT_WIDTH = 1100
local TOTAL_WIDTH = 550
local BG_WIDTH = 44
local BG_HEIGHT = 40
local MIN_HEIGHT = 72
local ChatMessageCell = Class("ChatMessageCell", UIControls.ScrollViewLoopCell)

function ChatMessageCell:ctor()
	self:initUI()
end

function ChatMessageCell:initUI()
	self.chatPanelSelf = UIControls.Panel(self, "ChatSelfPanel")
	self.headGridSelf = UIControls.Panel(self, "ChatSelfPanel/GridPlayer")
	self.bgMessageSelf = UIControls.Image(self, "ChatSelfPanel/BgMessage")
	self.textMessageSelf = UIControls.Label(self, "ChatSelfPanel/BgMessage/TextMessage")
	self.chatPanelOther = UIControls.Panel(self, "ChatOthersPanel")
	self.headGridOther = UIControls.Panel(self, "ChatOthersPanel/GridPlayer")
	self.bgMessageOther = UIControls.Image(self, "ChatOthersPanel/BgMessage")
	self.textMessageOther = UIControls.Label(self, "ChatOthersPanel/BgMessage/TextMessage")
	self.waitMessage = UIControls.Panel(self, "ChatOthersPanel/WaitMessage")

	if UIControls.checkControlFunc(self, "ChatOthersPanel/BgMessage02") then
		self.bgMessageOther02 = UIControls.Image(self, "ChatOthersPanel/BgMessage02")
		self.textMessageOther02 = UIControls.Label(self, "ChatOthersPanel/BgMessage02/TextMessage")
	end
end

function ChatMessageCell:setChatCellData(chatData, isShowed)
	local isSelf = chatData.head_type == Lang.get(655)

	self.chatPanelSelf:setVisible(isSelf)
	self.chatPanelOther:setVisible(not isSelf)
	self.waitMessage:setVisible(false)

	if self.nextTalkTimer then
		self.nextTalkTimer:Stop()

		self.nextTalkTimer = nil
	end

	if isSelf then
		self:setMessageText(self.textMessageSelf, self.bgMessageSelf, self.chatPanelSelf, chatData.desc)

		if not isShowed and not chatData.isForge then
			self.mParent:setShowState(chatData.section_id, chatData.text_id)
			self.mParent:nextTalk(chatData.section_id, chatData.text_id + 1)
		end
	else
		local bgMessageOther, textMessageOther

		if chatData.head_type == Lang.get(92707) then
			self.bgMessageOther:setVisible(false)

			bgMessageOther = self.bgMessageOther02
			textMessageOther = self.textMessageOther02
		else
			bgMessageOther = self.bgMessageOther
			textMessageOther = self.textMessageOther

			if self.bgMessageOther02 then
				self.bgMessageOther02:setVisible(false)
			end
		end

		if not isShowed then
			local intervalTime = chatData.input_interval or 1

			if self.mParent.quickMode then
				intervalTime = ResOpActivityChatGameMisc[self.mParent.activityId].quick_mode_interval or 0.5
			end

			self.waitMessage:setVisible(true)
			bgMessageOther:setVisible(false)
			self:setMessageText(textMessageOther, bgMessageOther, self.chatPanelOther, chatData.desc)

			self.nextTalkTimer = Timer.New(function()
				self.mParent:setShowState(chatData.section_id, chatData.text_id)
				bgMessageOther:setVisible(true)
				self.waitMessage:setVisible(false)
				self.mParent:timerNextTalk(chatData.section_id, chatData.text_id + 1)
			end, intervalTime, 1)

			self.nextTalkTimer:Start()
		else
			bgMessageOther:setVisible(true)
			self.textMessageOther:setVisible(true)
			self:setMessageText(textMessageOther, bgMessageOther, self.chatPanelOther, chatData.desc)
		end
	end

	self.bgMessageSelf:setVisible(isSelf)
end

function ChatMessageCell:setMessageText(curLable, curMessageImage, chatPanel, desc)
	curLable:setText(ClientUtils.ConvertContent(desc))

	local width = curLable:getWidth()
	local w = MathMin(width, TOTAL_WIDTH)

	curLable:setSize(TOTAL_WIDTH, curLable:getHeight())

	local h = curLable:getHeight() + BG_HEIGHT

	w = w + BG_WIDTH

	curMessageImage:setSize(w, h)

	local minHeight = MathMax(MIN_HEIGHT, h)

	chatPanel:setRectSize(0, minHeight)
	self:setLayoutSize(DEFAULT_WIDTH, minHeight)
end

function ChatMessageCell:onDestroy()
	if self.nextTalkTimer then
		self.nextTalkTimer:Stop()

		self.nextTalkTimer = nil
	end

	ChatMessageCell.super.onDestroy(self)
end

local strClassName = "ValentineChatDlg"
local ValentineChatDlg = Class(strClassName, UIControls.Window)

MixinClass(ValentineChatDlg, ActivityPanelMixin)

function ValentineChatDlg:initUI()
	self.cellPath = "System/Activity/ActivityCookValentine/ChatMessageCell"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/ChatMessageCell"
	end

	self.atlasPath = "Atlas/ActivityAtlas/ActivityCookValentineAtlas/ValentineChatAtlas"

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.atlasPath = "Atlas/" .. self.replaceableCellPath[2]
	end

	self.textNpcName = UIControls.Label(self, "ChatMainPanel/NameText")
	self.textFavorNum = UIControls.Label(self, "ChatMainPanel/NameText/NumText")
	self.scrollView = UIControls.ScrollViewLoopV(self, "ChatMainPanel/MessagePanel", 0, self.onCellChanged)
	self.btnClose = UIControls.Button(self, "ChatMainPanel/CloseBtn")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnConfirm = UIControls.Button(self, "ChatMainPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onReplyClick)

	self.iconNewReply = UIControls.Panel(self, "ChatMainPanel/BtnConfirm/IconNew")
	self.btnRest = UIControls.Button(self, "ChatMainPanel/BtnReturn")
	self.iconNewRest = UIControls.Panel(self, "ChatMainPanel/BtnReturn/IconNew")

	self.btnRest:addEventClick(self.onRestClick)

	self.replyNode = UIControls.Panel(self, "ReplyNode")
	self.textTips = UIControls.Panel(self, "ReplyNode/TipsText")
	self.btnReplyOne = UIControls.Button(self, "ReplyNode/ReplyBtn01", "Text")

	self.btnReplyOne:addEventClick(Functor(self.onSelectClick, self, 1))

	self.panelReplayOneOver = UIControls.Panel(self, "ReplyNode/ReplyBtn01/CleanNode")
	self.btnReplyTwo = UIControls.Button(self, "ReplyNode/ReplyBtn02", "Text")

	self.btnReplyTwo:addEventClick(Functor(self.onSelectClick, self, 2))

	self.panelReplayTwoOver = UIControls.Panel(self, "ReplyNode/ReplyBtn02/CleanNode")
	self.lockText = UIControls.Label(self, "ChatMainPanel/LockText")
	self.btnGo = UIControls.Button(self, "ChatMainPanel/LockText/BtnGo")

	self.btnGo:addEventClick(self.onJumpSendClick)

	self.quickMode = false
	self.btnSpeed = UIControls.Button(self, "ChatMainPanel/BtnSpeed")

	self.btnSpeed:addEventClick(self.onBtnSpeedClick)

	self.imgNotQuick = UIControls.Image(self, "ChatMainPanel/BtnSpeed/Icon")
	self.panelQuick = UIControls.Panel(self, "ChatMainPanel/BtnSpeed/AutoPanel")
end

function ValentineChatDlg:resetData()
	self.scrollView:setTotalCount(0)
	self:clearAllTimer()

	self.chatMessages = {}
	self.chatCell = {}
	self.showedTalks = {}
	self.autoLoop = true
	self.isLock = false
	self.curBranch = nil
	self.opId = self.actObj.opId
	self.activityId = self.clientTemplateData.template_id

	local actData = self.actObj.actData

	self.curMaxPlotId = actData.curNode
	self.nowLikeAbility = actData.nowLikeAbility or 0

	self.textFavorNum:setText(string.format(Lang.get(65465), self.nowLikeAbility))

	self.branch = actData.branch

	local chatBranch = actData.curBranch

	if chatBranch then
		self.curBranchData = chatBranch.branch_data
		self.isCanRest = chatBranch.result > 0
	end

	self.curProgressId = 0
	self.curPlotId = 1

	self:refreshBtnSpeedState()

	local plotDate = ResOpActivityChatGamePlot[self.activityId][1]
	local sectionId = plotDate.section_id

	self.curSectionId = sectionId
end

function ValentineChatDlg:_setData()
	self:refreshData()
end

function ValentineChatDlg:refreshLockState()
	if self.nowLikeAbility == self.actObj.actData.nowLikeAbility then
		return
	end

	self.nowLikeAbility = self.actObj.actData.nowLikeAbility or 0

	self.textFavorNum:setText(string.format(Lang.get(65465), self.nowLikeAbility))

	local plotDate = ResOpActivityChatGamePlot[self.activityId][self.curPlotId]
	local nextPlotId = plotDate.next_id
	local nextPlotData = ResOpActivityChatGamePlot[self.activityId][nextPlotId]
	local nextConfigData = ResOpActivityChatGameSectionConfig[self.activityId][nextPlotData.section_id]

	if nextConfigData.need_favorability > self.nowLikeAbility then
		self.autoLoop = false
		self.isLock = true

		self.lockText:setText(string.format(Lang.get(66181), nextConfigData.need_favorability))
	else
		self:nextPlot(nextPlotId)
	end

	self:setBtnReplyState()
end

function ValentineChatDlg:refreshData()
	self:resetData()

	if self.curMaxPlotId and self.curMaxPlotId > 0 then
		self.curBranchIndex = 1

		self:nextTalk(self.curSectionId, 1, true)
		self.scrollView:setTotalCount(#self.chatMessages, 1)

		if not self.isCanRest then
			local curPlotDate = ResOpActivityChatGamePlot[self.activityId][self.curPlotId]

			if curPlotDate.section_id == self.curSectionId then
				self:nextTalk(self.curSectionId, self.curProgressId + 1)
			end
		else
			self.autoLoop = false
		end
	else
		local userSectionData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION)

		if userSectionData then
			local oldOpId = userSectionData.opId

			userSectionData = {}

			if oldOpId ~= self.opId then
				userSectionData.opId = self.opId

				UserData.setClientData(CurAvatar.uid .. USER_KEY_SECTION, userSectionData)
				RPC.opActChatGameChooseBranch(self.opId, 1)
			else
				if not userSectionData[self.opId] then
					userSectionData[self.opId] = {}
				end

				local lastId = userSectionData[self.opId][self.curSectionId]

				if lastId then
					self:nextTalk(self.curSectionId, lastId)
				else
					RPC.opActChatGameChooseBranch(self.opId, 1)
				end
			end
		else
			RPC.opActChatGameChooseBranch(self.opId, 1)
		end
	end

	self:setBtnReplyState()
end

function ValentineChatDlg:nextPlot(targetId, isInit)
	local nextPlotId

	if not targetId then
		local oldPlotData = ResOpActivityChatGamePlot[self.activityId][self.curPlotId]

		if oldPlotData then
			if oldPlotData.next_id then
				nextPlotId = oldPlotData.next_id
			else
				if not isInit or not self.isCanRest then
					self.ending = true

					RPC.opActChatGameChatEnd(self.opId)
				end

				return
			end
		else
			nextPlotId = self.curPlotId + 1
		end
	else
		nextPlotId = targetId
	end

	if isInit and nextPlotId > self.curMaxPlotId then
		return
	end

	local newPlotDate = ResOpActivityChatGamePlot[self.activityId][nextPlotId]

	if newPlotDate then
		local branchs = newPlotDate.branch

		if branchs then
			if not isInit then
				self:addBranchMessage(branchs, "plot", newPlotDate)

				self.isPlotNode = true
				self.autoLoop = false

				self:setBtnReplyState()
			else
				local userDataSectionData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION_SELECT) or {}
				local forgeId = self.activityId .. newPlotDate.id

				if self.curBranchData[self.curBranchIndex] then
					local curIndex = self.curBranchIndex

					self.curBranchIndex = self.curBranchIndex + 1

					local branchId = 1

					if next(userDataSectionData) then
						branchId = userDataSectionData[forgeId] and userDataSectionData[forgeId][1] or 1
					end

					local forgeData = newPlotDate

					forgeData.desc = branchs[branchId].text
					forgeData.head_type = Lang.get(655)
					forgeData.isForge = true

					self:addChatMessages(forgeData)

					self.curPlotId = nextPlotId

					self:nextPlot(self.curBranchData[curIndex].node, true)
				else
					local branchId

					if next(userDataSectionData) and userDataSectionData[forgeId] then
						branchId = userDataSectionData[forgeId][1]
					end

					if branchId then
						local forgeData = newPlotDate

						forgeData.desc = branchs[branchId].text
						forgeData.head_type = Lang.get(655)
						forgeData.isForge = true

						self:addChatMessages(forgeData)

						self.isLock = true

						local nextPlotId = branchs[branchId].id

						self.curPlotId = nextPlotId

						self:nextPlot(nextPlotId)
					else
						self:addBranchMessage(branchs, "plot", newPlotDate)

						self.isPlotNode = true
					end

					self.autoLoop = false

					self:setBtnReplyState()
				end
			end
		elseif newPlotDate.section_id then
			local configData = ResOpActivityChatGameSectionConfig[self.activityId][newPlotDate.section_id]

			if configData.need_favorability > self.nowLikeAbility then
				self.autoLoop = false
				self.isLock = true

				self.lockText:setText(string.format(Lang.get(66181), configData.need_favorability))
				self:setBtnReplyState()

				return
			else
				self.isLock = false
			end

			if not isInit then
				self.curPlotId = nextPlotId

				RPC.opActChatGameChooseBranch(self.opId, self.curPlotId)
			else
				self.curPlotId = nextPlotId

				self:nextTalk(newPlotDate.section_id, 1, true)
			end
		end
	end
end

function ValentineChatDlg:nextTalk(sectionId, nextProgressId, isInit)
	local sectionMap = ResOpActivityChatGameSection[self.activityId][sectionId]
	local sectionData = sectionMap[nextProgressId]

	if not sectionData then
		if not isInit then
			self.curProgressId = 0

			self:refreshUserSectionData(sectionId, nil, true)
			self:nextPlot()
		else
			self:nextPlot(nil, isInit)
		end

		return
	end

	self.curSectionId = sectionId

	if not isInit then
		if sectionData.branch then
			self:addBranchMessage(sectionData.branch, "section", sectionData)

			self.autoLoop = false
			self.isPlotNode = false

			self:setBtnReplyState()
		else
			self.curProgressId = nextProgressId

			self:refreshUserSectionData(sectionData.section_id, sectionData.text_id)
			self:addChatMessages(sectionData, true)
		end
	else
		local userSectionData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION) or {}
		local curProgressId = #sectionMap

		if next(userSectionData) and userSectionData[self.opId] and userSectionData[self.opId][sectionId] then
			curProgressId = userSectionData[self.opId][sectionId]
		end

		local userDataSectionData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION_SELECT) or {}

		for i, data in ipairs(sectionMap) do
			if i <= curProgressId then
				local branchData = data.branch

				if not branchData then
					self:addChatMessages(data, false, true)
				else
					local branchId = 1

					if next(userDataSectionData) then
						branchId = userDataSectionData[sectionId] and userDataSectionData[sectionId][i] or 1
					end

					data.desc = branchData[branchId].text

					self:addChatMessages(data, false, true)
				end
			end
		end

		self.curProgressId = curProgressId

		if curProgressId == #sectionMap then
			self:nextPlot(nil, isInit)
		end
	end
end

function ValentineChatDlg:timerNextTalk(sectionId, nextProgressId)
	if self.nextTalkTimer then
		self.nextTalkTimer:Stop()

		self.nextTalkTimer = nil
	end

	self.nextTalkTimer = Timer.New(Functor(self.nextTalk, self, sectionId, nextProgressId), 0.2, 1)

	self.nextTalkTimer:Start()
end

function ValentineChatDlg:addChatMessages(sectionData, isGoTop, isAddShowed)
	table.insert(self.chatMessages, sectionData)

	if isAddShowed then
		self:setShowState(sectionData.section_id, sectionData.text_id)
	end

	if self.scrollGoTopTimer then
		self.scrollGoTopTimer:Stop()

		self.scrollGoTopTimer = nil
	end

	local chatLength = #self.chatMessages

	if isGoTop then
		local time = 0.1

		if sectionData.head_type == Lang.get(655) then
			if not self.quickMode then
				time = sectionData.input_interval or 1
			else
				time = ResOpActivityChatGameMisc[self.activityId].quick_mode_interval or 0.5
			end
		end

		if not self.scrollGoTopTimer then
			self.scrollGoTopTimer = Timer.New(function()
				if not self:getVisible() then
					return
				end

				self.scrollView:setTotalCount(chatLength, 1)
			end, time, 1)
		end

		self.scrollGoTopTimer:Start()
	end
end

function ValentineChatDlg:addBranchMessage(branch, type, data)
	self.curBranch = branch
	self.curBranch.type = type
	self.curBranch.data = data
end

function ValentineChatDlg:setShowState(sectionId, progressId)
	if not self.showedTalks[sectionId] then
		self.showedTalks[sectionId] = {}
	end

	if not self.showedTalks[sectionId][progressId] then
		self.showedTalks[sectionId][progressId] = true
	end
end

function ValentineChatDlg:checkShowed(section_id, progressId)
	return self.showedTalks[section_id] and self.showedTalks[section_id][progressId]
end

function ValentineChatDlg:refreshUserSectionData(sectionId, targetId, isRest)
	local userSectionData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION) or {}

	if isRest then
		if sectionId then
			if userSectionData[self.opId] then
				userSectionData[self.opId][sectionId] = nil
			end
		else
			userSectionData = {}
		end
	else
		if not userSectionData[self.opId] then
			userSectionData[self.opId] = {}
		end

		userSectionData[self.opId][sectionId] = targetId
	end

	UserData.setClientData(CurAvatar.uid .. USER_KEY_SECTION, userSectionData)
end

function ValentineChatDlg:setBtnReplyState()
	if self.isLock then
		self.lockText:setVisible(true)
		self.btnRest:setVisible(false)
		self.btnConfirm:setVisible(false)
	else
		if not self.isCanRest then
			self.btnRest:setVisible(false)

			if self.curBranch then
				self.btnConfirm:setObjGray(false)
				self.btnConfirm:setEnable(true)
				self.iconNewReply:setVisible(true)
			else
				self.btnConfirm:setObjGray(true)
				self.iconNewReply:setVisible(false)
				self.btnConfirm:setEnable(false)
			end

			self.btnConfirm:setVisible(true)
		else
			local branch = self.actObj.actData.branch

			if branch and #branch < 4 then
				self.iconNewRest:setVisible(true)
			else
				self.iconNewRest:setVisible(false)
			end

			self.btnRest:setVisible(true)
			self.btnConfirm:setVisible(false)
		end

		self.lockText:setVisible(false)
	end

	self:refrreshScrollState()
end

function ValentineChatDlg:refrreshScrollState()
	if self.autoLoop then
		self.scrollView:cancelScroll()
	else
		self.scrollView:openScroll(true)
	end
end

function ValentineChatDlg:refreshBtnSpeedState()
	if self.curPlotId then
		self.btnSpeed:setVisible(self.actObj.actData:checkHadOneEnd())

		if not self.btnSpeed:getVisible() then
			self.quickMode = false
		end

		self.imgNotQuick:setVisible(not self.quickMode)
		self.panelQuick:setVisible(self.quickMode)
	end
end

function ValentineChatDlg:onRestClick()
	if self.ending then
		return
	end

	local confrimId = ResOpActivityChatGameMisc[self.activityId].confrim_id or 1073
	local resConfirmData = ResClientConfirm[confrimId]

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, resConfirmData.title, resConfirmData.content, function()
		RPC.opActChatGameResetChat(self.opId)
	end, nil, nil, resConfirmData.confirm_text, resConfirmData.cancel_text)
end

function ValentineChatDlg:onJumpSendClick()
	local jumpId = ResOpActivityChatGameMisc[self.activityId].send_jump_id or 862

	JumpGuideManager.jump(jumpId)
end

function ValentineChatDlg:onOpActChatGameResetChatResp(opId)
	UserData.setClientData(CurAvatar.uid .. USER_KEY_SECTION, {})
	UserData.setClientData(CurAvatar.uid .. USER_KEY_SECTION_SELECT, {})

	if not self.restTimer then
		self.restTimer = Timer.New(function()
			self:refreshData()
		end, 0.5, 1)

		self.restTimer:Start()
	else
		self.restTimer:ReStart()
	end
end

function ValentineChatDlg:onOpActChatGameChooseBranchResp(opId, nodeId)
	self.curBranch = nil
	self.curPlotId = nodeId
	self.autoLoop = true

	local newPlotDate = ResOpActivityChatGamePlot[self.activityId][nodeId]

	if self.selectNextPlot then
		local curSelectNextPlot = self.selectNextPlot

		self.selectNextPlot = false

		RPC.opActChatGameChooseBranch(self.opId, curSelectNextPlot)
	elseif not newPlotDate.branch then
		if self.selectNextPlot == nodeId then
			local newPlotDate = ResOpActivityChatGamePlot[self.activityId][nodeId]

			self:nextTalk(newPlotDate.section_id, 1)

			self.selectNextPlot = false
		else
			self:nextTalk(newPlotDate.section_id, self.curProgressId + 1)
		end
	end

	self:setBtnReplyState()
end

function ValentineChatDlg:onOpActChatGameChatEndResp(opId, nodeId)
	self.isCanRest = true
	self.autoLoop = false

	if self.endTimer then
		self.endTimer:Stop()

		self.endTimer = nil
	end

	self.endTimer = Timer.New(function()
		local curPlotData = ResOpActivityChatGamePlot[self.activityId][self.curPlotId]

		UIManager.getUI("activityValentineChatEndDlg", true):setChatEndData(curPlotData.end_path, curPlotData.end_icon, curPlotData.end_title)

		self.ending = false

		self:setBtnReplyState()
	end, 2, 1)

	self.endTimer:Start()
end

function ValentineChatDlg:onReplyClick()
	self.replyNode:setVisible(true)
	self.btnConfirm:setVisible(false)
	self.textTips:setVisible(self.isPlotNode)
	self.btnReplyOne:setText(self.curBranch[1].text)
	self.btnReplyTwo:setText(self.curBranch[2].text)

	if self.curBranch.type ~= "section" and self.actObj.actData:isThisBranchOver(self.curBranch[1].id) then
		self.panelReplayOneOver:setVisible(true)
		self.btnReplyOne:setImage(self.atlasPath, "BtnChoiceDis")
	else
		self.panelReplayOneOver:setVisible(false)
		self.btnReplyOne:setImage(self.atlasPath, "BtnChoice")
	end

	if self.curBranch.type ~= "section" and self.actObj.actData:isThisBranchOver(self.curBranch[2].id) then
		self.panelReplayTwoOver:setVisible(true)
		self.btnReplyTwo:setImage(self.atlasPath, "BtnChoiceDis")
	else
		self.panelReplayTwoOver:setVisible(false)
		self.btnReplyTwo:setImage(self.atlasPath, "BtnChoice")
	end
end

function ValentineChatDlg:onBtnSpeedClick()
	self.quickMode = not self.quickMode

	self:refreshBtnSpeedState()
end

function ValentineChatDlg:onCloseClick()
	if self.ending then
		return
	end

	self.actObj:checkNew()

	local mainDlg = UIManager.getUI("activityValentineDlg", nil, false)

	if mainDlg then
		local isChatNew = self.actObj.actData:checkChatNew()

		mainDlg.iconNewChat:setVisible(isChatNew)
	end

	self:setVisible(false)
end

function ValentineChatDlg:clearAllTimer()
	if self.nextTalkTimer then
		self.nextTalkTimer:Stop()

		self.nextTalkTimer = nil
	end

	if self.restTimer then
		self.restTimer:Stop()

		self.restTimer = nil
	end

	if self.scrollGoTopTimer then
		self.scrollGoTopTimer:Stop()

		self.scrollGoTopTimer = nil
	end

	if self.endTimer then
		self.endTimer:Stop()

		self.endTimer = nil
	end
end

function ValentineChatDlg:onDestroy()
	self:clearAllTimer()
	ValentineChatDlg.super.onDestroy(self)
end

function ValentineChatDlg:onSelectClick(index)
	if not self.curBranch then
		return
	end

	if self.curBranch.type == "plot" then
		local sectionData = self.curBranch.data
		local forgeId = self.activityId .. sectionData.id
		local nextId = self.curBranch[index].id
		local forgeData = self.curBranch.data

		forgeData.desc = self.curBranch[index].text
		forgeData.head_type = Lang.get(655)
		forgeData.isForge = true
		forgeData.input_interval = 0

		self:refreshUserSelectData(forgeId, 1, index)
		table.insert(self.chatMessages, forgeData)
		self.scrollView:setTotalCount(#self.chatMessages, 1)

		self.selectNextPlot = nextId

		RPC.opActChatGameChooseBranch(self.opId, sectionData.id)
	else
		self.autoLoop = true

		local sectionData = self.curBranch.data

		sectionData.desc = self.curBranch[index].text
		sectionData.input_interval = 0

		local nextId = self.curBranch[index].id

		self:refreshUserSelectData(self.curSectionId, sectionData.text_id, index)

		self.curBranch = nil

		self:setBtnReplyState()
		self:addChatMessages(sectionData, true)

		self.curProgressId = nextId
	end

	self.replyNode:setVisible(false)
end

function ValentineChatDlg:refreshUserSelectData(curSectionId, sectionId, index)
	local curSectionSellectData = UserData.getClientData(CurAvatar.uid .. USER_KEY_SECTION_SELECT) or {}

	if not curSectionSellectData[curSectionId] then
		curSectionSellectData[curSectionId] = {}
	end

	curSectionSellectData[curSectionId][sectionId] = index

	UserData.setClientData(CurAvatar.uid .. USER_KEY_SECTION_SELECT, curSectionSellectData)
end

function ValentineChatDlg:onCellChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = ChatMessageCell(sender, self.cellPath, newIdx, 0, 0)
	else
		self.chatCell[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local messageData = self.chatMessages[newIdx]
	local isShowed = self:checkShowed(messageData.section_id, messageData.text_id) and not messageData.isForge

	targetCell:setChatCellData(messageData, isShowed)

	self.chatCell[newIdx] = targetCell
end

return ValentineChatDlg

-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/view/MailMediator.lua

require("dm.gameplay.mail.view.mailComponent.MailCell")

MailMediator = class("MailMediator", DmPopupViewMediator, _M)

MailMediator:has("_mailSystem", {
	is = "r"
}):injectWith("MailSystem")

local kBtnHandlers = {
	["mailpanel.button_back"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	},
	["mailpanel.bg_right.button_receive.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReceive"
	},
	["mailpanel.button_one_key_receive.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReceiveOneKey"
	},
	btn_close = {
		clickAudio = "Se_Click_Close_1",
		func = "onClickClose"
	}
}
local kCellWidth, kCellHeight = 335, 100
local kSelectedMail = -1
local kTextWidth = 624
local kTextScrollHeight_Short = 155
local kTextScrollHeight_Large = 239

function MailMediator:initialize()
	super.initialize(self)
end

function MailMediator:dispose()
	if self._luaScheduler then
		LuaScheduler:getInstance():unschedule(self._luaScheduler)

		self._luaScheduler = nil
	end

	super.dispose(self)
end

function MailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mailpanel.button_one_key_receive", TwoLevelMainButton, {
		ignoreAddKerning = true
	})

	self._receiveBtnWidget = self:bindWidget("mailpanel.bg_right.button_receive", TwoLevelViceButton, {})

	self:mapEventListeners()
end

function MailMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_GET_MAIL_LIST_SUCC, self, self.getMailListSuc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECEIVE_MAIL_SUCC, self, self.receiveAwardSuc)
end

function MailMediator:enterWithData(data)
	self:initWigetInfo()
	self:setupView()
	self:setupClickEnvs()
end

function MailMediator:setupView()
	if self:getMailsNumber() <= 0 then
		self:setEmptyUiInfo()
	else
		self:setNotSelectMailUi()
		self:setupListView()
	end
end

function MailMediator:initWigetInfo()
	self._bg = self:getView():getChildByName("mailpanel")
	self._btnOneKeyReceive = self._bg:getChildByName("button_one_key_receive")
	self._emptyPanel = self._bg:getChildByName("empty_panel")

	self:initRightWigetInfo()

	local maxStoreMailCount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Mail_StoreMax", "content")
	local maxCountText = self._bg:getChildByFullName("bg_left.maxCount")

	maxCountText:setString("/" .. maxStoreMailCount)

	self._leftFadeImg = self._bg:getChildByFullName("bg_left.topEffect")

	self._leftFadeImg:setLocalZOrder(101)

	self._enterPanel = self._bg:getChildByName("enterPanel")

	self._enterPanel:setVisible(false)
end

function MailMediator:initRightWigetInfo()
	self._rightPanel = self._bg:getChildByName("bg_right")
	self._title = self._rightPanel:getChildByName("title_content")
	self._remainTime = self._rightPanel:getChildByName("time_content")
	self._sender = self._rightPanel:getChildByFullName("content_bg.sender_content")
	self._receivePanel = self._rightPanel:getChildByName("received_panel")
	self._btnReceive = self._rightPanel:getChildByName("button_receive")
	self._textContent = self._rightPanel:getChildByFullName("content_bg.content_scrollpanel.text_content")

	self._textContent:getVirtualRenderer():setDimensions(kTextWidth, 0)
	self._textContent:setLineSpacing(6)

	self._annex_bg = self._rightPanel:getChildByFullName("content_bg.annex_bg")

	self._annex_bg:setScrollBarEnabled(false)

	self._topEffect = self._rightPanel:getChildByFullName("content_bg.topEffect")
	self._topEffect2 = self._rightPanel:getChildByFullName("content_bg.topEffect2")
	self._textContentBg = self._rightPanel:getChildByFullName("content_bg.content_scrollpanel")

	self._textContentBg:setScrollBarAutoHideEnabled(false)

	local function onscroll(scrollView, eventType)
		if eventType == 9 then
			local innerSize = scrollView:getInnerContainerSize()
			local scrollSize = scrollView:getContentSize()

			if scrollSize.height >= innerSize.height then
				self._topEffect:setVisible(false)
				self._topEffect2:setVisible(false)
			else
				local pos = scrollView:getInnerContainerPosition()

				self._topEffect2:setVisible(pos.y > scrollSize.height - innerSize.height)
				self._topEffect:setVisible(pos.y < 0)
			end
		end
	end

	self._textContentBg:addEventListener(onscroll)
	GameStyle:setCommonOutlineEffect(self._title)
	GameStyle:setCommonOutlineEffect(self._remainTime)
	GameStyle:setCommonOutlineEffect(self._remainTime:getChildByFullName("Text_8"))
end

function MailMediator:setEmptyUiInfo()
	self:setNotSelectMailUi()

	local leftPanel = self._bg:getChildByName("bg_left")

	leftPanel:setVisible(false)

	local tipsText = self._emptyPanel:getChildByName("talk_content")

	tipsText:setString(Strings:find("MailBox_NoMail"))
	self._emptyPanel:setVisible(true)
end

function MailMediator:setNotSelectMailUi()
	self._btnOneKeyReceive:setVisible(false)
	self._btnReceive:setVisible(false)
	self._title:setString("")
	self._sender:setString("")
	self._textContent:setString("")
	self._remainTime:setVisible(false)
	self._receivePanel:setVisible(false)
	self._annex_bg:removeAllChildren()

	local bg1 = self._rightPanel:getChildByName("bg_1")
	local bg2 = self._rightPanel:getChildByName("bg_2")

	bg1:setVisible(false)
	bg2:setVisible(true)

	local tipsText = bg2:getChildByName("text")

	if self:getMailsNumber() <= 0 then
		tipsText:setString(Strings:get("Mail_None"))
	else
		tipsText:setString(Strings:get("MailBox_SelectAMail"))
	end

	self._enterPanel:setVisible(true)
end

function MailMediator:getMailsNumber(extra)
	local curMailCount = self._mailSystem:getMailsNumber()

	if extra then
		local curMailCountText = self._bg:getChildByFullName("bg_left.curCount")

		curMailCountText:setString(curMailCount)
	end

	return curMailCount
end

function MailMediator:setupListView()
	kSelectedMail = -1

	self:createTableView()
	self._btnOneKeyReceive:setVisible(self._mailSystem:hasQuickReceiveMails())
end

function MailMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(319, 369))

	local function numberOfCells(view)
		return self:getMailsNumber(true)
	end

	local function cellTouched(table, cell)
		self:onClickCell(cell)
	end

	local function cellSize(table, idx)
		if idx == 0 then
			return kCellWidth, kCellHeight + 20
		end

		return kCellWidth, kCellHeight + 10
	end

	local function onScroll(table)
		local offset = table:getContentOffset()

		self._leftFadeImg:setVisible(offset.y < table:maxContainerOffset().y)
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if not cell then
			cell = cc.TableViewCell:new()

			local mailCell = MailCell:new({
				mediator = self
			})

			mailCell:getView():addTo(cell):offset(13, -5)

			cell.mediator = mailCell
		end

		cell:setTag(index)
		cell.mediator:refreshData(index, kSelectedMail == index)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._bg:getChildByName("bg_left"))
	tableView:setLocalZOrder(100)
	tableView:reloadData()
	tableView:setBounceable(true)

	self._tableView = tableView
end

function MailMediator:onClickCell(sender, oppoRecord)
	local bg1 = self._rightPanel:getChildByName("bg_1")
	local bg2 = self._rightPanel:getChildByName("bg_2")

	bg1:setVisible(true)
	bg2:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local tag = sender:getTag()

	if kSelectedMail ~= tag then
		if kSelectedMail == -1 then
			kSelectedMail = tag
		end

		local mailCell = self._tableView:cellAtIndex(kSelectedMail - 1)

		if mailCell then
			mailCell.mediator:refreshData(kSelectedMail)
		end

		kSelectedMail = tag

		self:refreshContent(tag)
		sender.mediator:readMail()

		local mailInfo = self._mailSystem:getMailByIndex(tag)

		if mailInfo:getIsRead() == false then
			self._mailSystem:requestReadMail(mailInfo._id, false)
		end
	end

	self._enterPanel:setVisible(false)
end

function MailMediator:refreshContent(idx)
	if self._luaScheduler then
		LuaScheduler:getInstance():unschedule(self._luaScheduler)

		self._luaScheduler = nil
	end

	local mailInfo = self._mailSystem:getMailByIndex(idx)
	local param = mailInfo:getCustomData()

	self._textContent:setString(Strings:get(mailInfo:getContent(), param))

	local contentSize = self._textContent:getContentSize()

	self._title:setString(Strings:get(mailInfo:getTitle()))
	self._sender:setString(Strings:get(mailInfo:getSource()))
	self._annex_bg:removeAllChildren()

	if mailInfo:isItemMail() == false then
		self._btnReceive:setVisible(false)
		self._receivePanel:setVisible(false)
		self._textContentBg:setContentSize(cc.size(kTextWidth, kTextScrollHeight_Large))
		self._textContentBg:setInnerContainerSize(cc.size(kTextWidth, contentSize.height))

		local innerContainerSize = self._textContentBg:getInnerContainerSize()

		self._textContent:setPositionY((contentSize.height > kTextScrollHeight_Large or nil) and (contentSize.height or kTextScrollHeight_Large))
	else
		self._textContentBg:setContentSize(cc.size(kTextWidth, kTextScrollHeight_Short))
		self._textContentBg:setInnerContainerSize(cc.size(kTextWidth, contentSize.height))
		self._textContent:setPositionY((contentSize.height > kTextScrollHeight_Short or nil) and (contentSize.height or kTextScrollHeight_Short))

		local innerContainerSize = self._textContentBg:getInnerContainerSize()

		self:createRewardItem(mailInfo:getItems())

		if mailInfo:isReceive() then
			self._receivePanel:setVisible(true)
			self._btnReceive:setVisible(false)
		else
			self._receivePanel:setVisible(false)
			self._btnReceive:setVisible(true)
		end
	end

	if self._mailSystem:isNeedUpdateVersion(mailInfo) then
		self._receiveBtnWidget:setButtonName(Strings:get("Task_UI7"))
	else
		self._receiveBtnWidget:setButtonName(Strings:get("Task_UI11"))
	end

	self._remainTime:setVisible(true)

	local expireDate = mailInfo:getExpire()
	local curTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local remainDate = expireDate - curTime

	if remainDate > 0 then
		local hour = remainDate / 3600
		local minutes = math.modf((remainDate - math.modf(3600 * hour)) / 60)
		local day, daylit = math.modf(hour / 24)

		hour = math.modf(daylit * 24)

		local dayStr = day > 0 and tostring(day .. Strings:get("Questionnaire_UI_Desc5")) or ""
		local hourstr = hour > 0 and tostring(hour .. Strings:get("Questionnaire_UI_Desc6")) or ""
		local minutestr = minutes > 0 and tostring(minutes .. Strings:get("Questionnaire_UI_Desc7")) or ""
		local catStr = dayStr ~= "" and dayStr .. hourstr or hourstr .. minutestr

		if catStr == "" then
			self._remainTime:setString(Strings:get("Mail_DeadInOneSec"))
		else
			self._remainTime:setString(catStr)
		end
	else
		self._remainTime:setString(Strings:get("Mail_DeadInOneSec"))
	end

	self._luaScheduler = LuaScheduler:getInstance():schedule(handler(self, self.onTick), 3, false)

	self:setSenderPosY()
	self:setTextFadeEffect()
end

function MailMediator:setSenderPosY()
	local scrollHeight = self._textContentBg:getContentSize().height
	local textHeight = self._textContent:getContentSize().height + 12
	local posY = self._textContentBg:getPositionY() - (textHeight < scrollHeight and textHeight or scrollHeight) - 20

	self._sender:setPositionY(posY)
end

function MailMediator:setTextFadeEffect()
	local fadeEffectImg = self._rightPanel:getChildByFullName("content_bg.topEffect")
	local fadeEffectImg2 = self._rightPanel:getChildByFullName("content_bg.topEffect2")
	local scrollHeight = self._textContentBg:getContentSize().height
	local textHeight = self._textContent:getContentSize().height

	fadeEffectImg2:setVisible(false)

	if textHeight < scrollHeight then
		fadeEffectImg:setVisible(false)
	else
		fadeEffectImg:setVisible(true)
		fadeEffectImg:setPositionY(self._textContentBg:getPositionY() - scrollHeight - 1)
	end
end

function MailMediator:updateListView()
	if self._tableView then
		self._tableView:reloadData()
	end

	self._btnOneKeyReceive:setVisible(self._mailSystem:hasQuickReceiveMails())
end

function MailMediator:cleanMailContent()
	self:setNotSelectMailUi()
end

function MailMediator:onTick(dt)
	if kSelectedMail == -1 then
		return
	end

	local mailInfo = self._mailSystem:getMailByIndex(kSelectedMail)
	local expireDate = mailInfo:getExpire()
	local curTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local remainDate = expireDate - curTime

	if remainDate > 0 then
		local hour = remainDate / 3600
		local minutes = math.modf((remainDate - math.modf(3600 * hour)) / 60)
		local day, daylit = math.modf(hour / 24)

		hour = math.modf(daylit * 24)

		local dayStr = day > 0 and tostring(day .. Strings:get("Questionnaire_UI_Desc5")) or ""
		local hourstr = hour > 0 and tostring(hour .. Strings:get("Questionnaire_UI_Desc6")) or ""
		local minutestr = minutes > 0 and tostring(minutes .. Strings:get("Questionnaire_UI_Desc7")) or ""
		local catStr = dayStr ~= "" and dayStr .. hourstr or hourstr .. minutestr

		if catStr == "" then
			self._remainTime:setString(Strings:get("Mail_DeadInOneSec"))
		else
			self._remainTime:setString(catStr)
		end
	else
		self._remainTime:setString(Strings:get("Mail_DeadInOneSec"))
	end
end

function MailMediator:createRewardItem(rewards)
	local containerSize = self._annex_bg:getContentSize()
	local cellSize = cc.size(70, 70)

	self._annex_bg:setInnerContainerSize(cc.size(cellSize.width * #rewards, containerSize.height))

	for k, v in pairs(rewards) do
		local icon = IconFactory:createRewardIcon(v, {
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), v, {
			needDelay = true
		})
		icon:setScaleNotCascade(0.55)
		icon:setAnchorPoint(cc.p(0, 0))
		self._annex_bg:addChild(icon)
		icon:setPosition(cc.p((k - 1) * cellSize.width, 0))
	end
end

function MailMediator:getMailListSuc()
	self:updateListView()

	if self:getMailsNumber() <= 0 then
		self:setEmptyUiInfo()
	end
end

function MailMediator:receiveAwardSuc(event)
	self._btnOneKeyReceive:setVisible(self._mailSystem:hasQuickReceiveMails())

	local mailCell = self._tableView:cellAtIndex(kSelectedMail - 1)

	if mailCell then
		mailCell.mediator:refreshData(kSelectedMail, true)
	end

	self:refreshContent(kSelectedMail)

	local this = self
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		needClick = true,
		rewards = event:getData().rewards,
		callback = function()
			local sequence = cc.Sequence:create(cc.CallFunc:create(function()
				local storyDirector = this:getInjector():getInstance(story.StoryDirector)

				storyDirector:notifyWaiting("exit_GetRewardView_suc")
			end))

			this:getView():runAction(sequence)
		end
	}))
end

function MailMediator:oneKeyReceiveAwardSuc(resData)
	kSelectedMail = -1

	self:getMailListSuc()
	self:setNotSelectMailUi()

	local rewards = resData.data.rewards

	if #rewards > 0 then
		local view = self:getInjector():getInstance("getRewardView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			needClick = true,
			rewards = rewards
		}))
	end
end

function MailMediator:onClickReceiveOneKey(sender, eventType, oppoRecord)
	self._mailSystem:requestReceiveMailOneKey(true, function(resData)
		if checkDependInstance(self) then
			self:oneKeyReceiveAwardSuc(resData)
		end
	end)
end

function MailMediator:onClickReceive(sender, eventType, oppoRecord)
	local mailInfo = self._mailSystem:getMailByIndex(kSelectedMail)

	if self._mailSystem:isNeedUpdateVersion(mailInfo) then
		PlatformHelper:thirdUpdate()

		return
	end

	if mailInfo._expireAfterRead == 0 then
		self._mailSystem:setReceiveExpireMail(true)
	else
		self._mailSystem:setReceiveExpireMail(false)
	end

	self._mailSystem:requestReceiveMail(mailInfo._id)
end

function MailMediator:onClickClose(sender, eventType, oppoRecord)
	self:close()
end

function MailMediator:setupClickEnvs()
	if GameConfigs.closeGuide or self._tableView == nil then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local mailCell = self._tableView:cellAtIndex(0)

		if mailCell then
			storyDirector:setClickEnv("mailView.mailCell", mailCell.mediator._imgMail, function(sender, eventType)
				self:onClickCell(mailCell)
			end)
		end

		local receiveBtn = self:getView():getChildByFullName("mailpanel.bg_right.button_receive.button")

		if receiveBtn then
			storyDirector:setClickEnv("mailView.receiveBtn", receiveBtn, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				kSelectedMail = 1

				self:onClickReceive()
			end)
		end

		local button_back = self:getView():getChildByFullName("btn_close")

		if button_back then
			storyDirector:setClickEnv("mailView.btnback", button_back, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
				self:onClickClose()
			end)
		end

		storyDirector:notifyWaiting("enter_mail_view")
	end))

	self:getView():runAction(sequence)
end

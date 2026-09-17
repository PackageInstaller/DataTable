PopInviteResidentLayer = class("PopInviteResidentLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local invite_manager = require("controller.invite_manager")
local time_check_manager = require("controller.time_check_manager")
local account_manager = require("controller.account_manager")
local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local LocalEvent = require("common.LocalEvent")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = invite_manager.INVITE_TASK_TYPE
local var_0_10 = invite_manager.INVITE_TASK_STATUS
local var_0_11 = "InviteResident/"
local var_0_12 = {
	{
		off = "btn_invited_off.png",
		on = "btn_invited_on.png",
		type = invite_manager.INVITE_TASK_TYPE.BEINVITED
	},
	{
		off = "btn_invite_off.png",
		on = "btn_invite_on.png",
		type = invite_manager.INVITE_TASK_TYPE.INVITE
	},
	{
		off = "btn_call_off.png",
		on = "btn_call_on.png",
		type = invite_manager.INVITE_TASK_TYPE.CALL
	}
}
local var_0_13 = {
	[invite_manager.INVITE_TASK_STATUS.PROGRESS] = "InviteResident/" .. "btn_progress.png",
	[invite_manager.INVITE_TASK_STATUS.COMPLETE] = "InviteResident/" .. "btn_get.png",
	[invite_manager.INVITE_TASK_STATUS.FINISHED] = "InviteResident/" .. "btn_rewarded.png"
}
local var_0_14 = 1
local var_0_15 = 605
local var_0_16 = 123
local var_0_17

function PopInviteResidentLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopInviteResidentLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopInviteResidentLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:show()
end

function PopInviteResidentLayer.initData(arg_4_0, arg_4_1)
	arg_4_0.btnSwitchs = {}
	arg_4_0.curType = var_0_9.UNKNOWN
	arg_4_0.bindUID = invite_manager:getBindUID()
	arg_4_0.preBindUID = 0
	arg_4_0.tasks = {}
	arg_4_0.isShowUpdatePanel = false
end

function PopInviteResidentLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopInviteResidentLayer.json" or "PopInviteResidentLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)
	self.panelMain:setPositionY(self.panelMain:getPositionY() + 50)

	self.panelMask = self.panelMain:getChildByName("panelMask")

	self.panelMask:setLocalZOrder(1)

	self.panelTop = self.panelMain:getChildByName("panelTop")

	self.panelTop:setLocalZOrder(1)

	self.imgTime = self.panelTop:getChildByName("imgTime")
	self.labelRemainTIme = self.imgTime:getChildByName("labelRemainTime")
	self.imgInfo = self.panelTop:getChildByName("imgInfo")
	self.labelInfo = self.imgInfo:getChildByName("labelInfo")

	self.labelInfo:setString(INVITE_INFO)

	self.listViewBtns = self.panelTop:getChildByName("listViewBtns")
	self.imgInvite = self.panelTop:getChildByName("imgInvite")
	self.labelCodeInfo = Utility:seekChildByName(self.imgInvite, "labelCodeInfo")
	self.labelCode = Utility:seekChildByName(self.imgInvite, "labelCode")
	self.editBoxCode = Utility:replaceTextFieldByEditBox(Utility:seekChildByName(self.imgInvite, "textFieldCode"), 10)
	self.btnBind = self.imgInvite:getChildByName("btnBind")
	self.btnGenerate = self.imgInvite:getChildByName("btnGenerate")
	self.btnBindDetail = self.imgInvite:getChildByName("btnBindDetail")
	self.btnShare = self.panelMain:getChildByName("btnShare")

	self.btnShare:setLocalZOrder(2)

	self.btnCall = ccui.Button:create("InviteResident/btn_christmas_call.png", "InviteResident/btn_christmas_call.png", "InviteResident/btn_christmas_call.png", var_0_8)

	self.btnCall:setPosition(cc.p(302, -45))
	self.btnCall:setLocalZOrder(2)
	self.btnCall:setName("btnCall")
	self.btnCall:setVisible(false)
	self.panelMain:addChild(self.btnCall)

	self.listViewTasks = self.panelMain:getChildByName("listViewTasks")
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
	self:updateLabelTime()
	self:initListViewBtns()
end

function PopInviteResidentLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	Utility:addClickEventListener(self.panelMask, handler(self, self.hide))
	Utility:addClickEventListener(self.btnBind, handler(self, self.onBtnBind))
	Utility:addClickEventListener(self.btnGenerate, handler(self, self.onBtnGenerate))
	Utility:addClickEventListener(self.btnBindDetail, handler(self, self.onBtnBindDetail))
	Utility:addClickEventListener(self.btnShare, handler(self, self.onBtnShare))
	Utility:addClickEventListener(self.btnCall, handler(self, self.onBtnCall))
	self.editBoxCode:registerScriptEditBoxHandler(handler(self, self.onEditBoxReturn))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_INFO, handler(self, self.handleGetInviteInfo))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_TASK_INFO, handler(self, self.handleGetInviteTaskInfo))
	EventManager:subscribe(self, EventManager.EVENT_IDS.BIND_INVITE_UID, handler(self, self.handleBindInviteUID))
	EventManager:subscribe(self, EventManager.EVENT_IDS.TERMINATE_BIND_UID, handler(self, self.handleTerminateBindUID))
	EventManager:subscribe(self, EventManager.EVENT_IDS.GET_INVITE_TASK_REWARD, handler(self, self.handleGetInviteTaskReward))
end

function PopInviteResidentLayer:onBtnGenerate(arg_7_1)
	if playermodel.class < var_0_14 then
		global_ShowBlockWords((self.curType == var_0_9.CALL or nil) and (L_INVITE_ONBTNSTATUS[7] or L_INVITE_ONBTNSTATUS[8]))
	else
		global_ShowBlockWords((self.curType == var_0_9.CALL or nil) and (L_INVITE_ONBTNSTATUS[9] or L_INVITE_ONBTNSTATUS[10]))
	end
end

function PopInviteResidentLayer:onBtnBind(arg_8_1)
	if not self.preBindUID or self.preBindUID == 0 then
		global_ShowBlockWords(L_INVITE_ONBTNSTATUS[11])

		return
	end

	if self.preBindUID == playermodel.playerid then
		global_ShowBlockWords(L_INVITE_ONBTNSTATUS[12])

		return
	end

	EventManager:requestBindInviteUID(self.preBindUID)
end

function PopInviteResidentLayer.onBtnBindDetail(arg_9_0, arg_9_1)
	LayerManager:pushInLayer("PopInviteDetailLayer", {
		invites = invite_manager:getInvitePlayers()
	})
end

function PopInviteResidentLayer:onBtnShare(arg_10_1)
	if playermodel.class < var_0_14 then
		global_ShowBlockWords((self.curType == var_0_9.CALL or nil) and (L_INVITE_ONBTNSTATUS[7] or L_INVITE_ONBTNSTATUS[8]))

		return
	end

	invite_manager:share()
end

function PopInviteResidentLayer.onBtnCall(arg_11_0, arg_11_1)
	invite_manager:showWebActivity()
end

function PopInviteResidentLayer:onEditBoxReturn(arg_12_1, arg_12_2)
	if arg_12_1 == "return" then
		self.editBoxCode:setText("")

		self.preBindUID = tonumber((self.editBoxCode:getText())) or 0

		self.labelCode:setVisible(true)
		self.labelCode:setString("" .. self.preBindUID)
		self.labelCodeInfo:setVisible(true)
		self.labelCodeInfo:setString(L_INVITE_ONBTNSTATUS[6])
	elseif arg_12_1 == "began" then
		self.labelCode:setVisible(false)
		self.labelCodeInfo:setVisible(false)
	end
end

function PopInviteResidentLayer:updateLabelTime()
	self.imgTime:setVisible(false)

	local var_13_0 = global_get_time_by_date(require("data.activity_yaoqing_share_data")[1].end_time) - time_check_manager:getCurTime()

	self.labelRemainTIme:setString(L_LEFT_TIME_SPACE .. Utility:formatTimeStr(var_13_0))
	self.labelRemainTIme:stopAllActions()
	self.labelRemainTIme:runAction((Utility:createClockTimerAction(self.labelRemainTIme, 1, var_13_0, function(arg_14_0)
		self.labelRemainTIme:setString(L_LEFT_TIME_SPACE .. Utility:formatTimeStr(arg_14_0))
		self:updateLimitTimeTaskPanel()
	end)))
end

function PopInviteResidentLayer:updateLimitTimeTaskPanel()
	if self.tableViewTasks == nil or self.curType ~= var_0_9.INVITE or invite_manager:getLimitTimeInviteTaskLeftTime() <= 0 then
		return
	end

	for iter_15_0 = 1, 3 do
		local var_15_0 = self.tableViewTasks:cellAtIndex(iter_15_0 - 1)

		if var_15_0 then
			local var_15_1 = var_15_0:getChildByName("panelTask"):getChildByName("limitTime")

			if self.tasks[iter_15_0].islimittime == true then
				var_15_1:setString(L_LEFT_TIME_SPACE .. (self:getLeftLimitTimeStr() or 0))
				var_15_1:setVisible(true)
			else
				var_15_1:setVisible(false)
			end
		end
	end
end

function PopInviteResidentLayer:initListViewBtns()
	self.listViewBtns:removeAllChildren()

	self.btnSwitchs = {}

	for iter_16_0, iter_16_1 in ipairs(var_0_12) do
		local var_16_0 = ccui.Button:create(var_0_11 .. iter_16_1.off, var_0_11 .. iter_16_1.off, var_0_11 .. iter_16_1.on, var_0_8)

		self.listViewBtns:pushBackCustomItem(var_16_0)

		var_16_0.type = iter_16_1.type

		Utility:addClickEventListener(var_16_0, handler(self, self.onBtnSwitch))

		self.btnSwitchs[#self.btnSwitchs + 1] = var_16_0

		if iter_16_0 > 1 and not invite_manager:isCanShowShare() then
			var_16_0:setVisible(false)
		end
	end
end

function PopInviteResidentLayer:onBtnSwitch(arg_17_1)
	if not arg_17_1 or arg_17_1.type == self.curType then
		return
	end

	local var_17_0 = Utility:indexOf(self.btnSwitchs, arg_17_1)

	if var_17_0 < 0 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(self.btnSwitchs) do
		iter_17_1:setTouchEnabled(iter_17_1 ~= arg_17_1)
		iter_17_1:setBright(iter_17_1 ~= arg_17_1)
	end

	var_0_17 = var_17_0
	self.curType = arg_17_1.type

	self:updateLayout()
	EventManager:requestGetInviteTaskInfo(arg_17_1.type)
end

function PopInviteResidentLayer:updateSwitchBtns()
	if invite_manager:isTaskFinished(var_0_9.BEINVITED) or playermodel.class >= 2 and not invite_manager:isOldPlayer() and invite_manager:getBindUID() == 0 then
		local var_18_0 = Utility:removeElement(self.btnSwitchs, function(arg_19_0)
			return arg_19_0.type == var_0_9.BEINVITED
		end)

		if var_18_0 then
			var_18_0:removeFromParent()
		end
	end
end

function PopInviteResidentLayer:autoSwitchBtns()
	local var_20_0 = 1

	if invite_manager:isCanShowShare() then
		for iter_20_0, iter_20_1 in pairs(self.btnSwitchs) do
			if iter_20_1.type == var_0_9.INVITE then
				var_20_0 = iter_20_0

				break
			end
		end
	end

	self:onBtnSwitch(self.btnSwitchs[var_0_17 or var_20_0] or self.btnSwitchs[var_20_0])
end

function PopInviteResidentLayer:updateAlert()
	for iter_21_0, iter_21_1 in ipairs(self.btnSwitchs) do
		if iter_21_1.type ~= var_0_9.UNKNOWN then
			if invite_manager:canRewardTask(iter_21_1.type) then
				global_add_alert_tag(iter_21_1, {
					x = 190,
					y = 35
				})
			else
				global_remove_alert_tag(iter_21_1)
			end
		end
	end
end

function PopInviteResidentLayer:updatePanelTop()
	self.btnBind:setVisible(self.curType == var_0_9.BEINVITED and self.bindUID == 0)
	self.btnBindDetail:setVisible(self.curType == var_0_9.INVITE)
	self.btnGenerate:setVisible(self.curType ~= var_0_9.BEINVITED and false)
	self.btnBindDetail:setPosition(self.btnBind:getPosition())

	if playermodel.class < var_0_14 then
		self.btnGenerate:loadTextures(var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call.png" or "img_generate.png"), var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call.png" or "img_generate.png"), var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call.png" or "img_generate.png"), var_0_8)
	else
		self.btnGenerate:loadTextures(var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call_on.png" or "img_generate_on.png"), var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call_on.png" or "img_generate_on.png"), var_0_11 .. (self.curType == var_0_9.CALL and "img_generate_call_on.png" or "img_generate_on.png"), var_0_8)
	end

	self.editBoxCode:setEnabled(self.curType == var_0_9.BEINVITED and self.bindUID == 0)

	if self.curType == var_0_9.BEINVITED then
		if self.bindUID == 0 then
			self.labelCodeInfo:setString(L_INVITE_1)
		else
			self.labelCodeInfo:setString(L_INVITE_ONBTNSTATUS[5])
		end

		self.labelCodeInfo:setVisible(true)
		self.labelCode:setVisible(self.bindUID ~= 0)
		self.labelCode:setString("" .. self.bindUID)
	elseif self.curType == var_0_9.INVITE then
		self.labelCodeInfo:setVisible(true)
		self.labelCodeInfo:setString(L_INVITE_MYMA)
		self.labelCode:setString("" .. playermodel.playerid)
		self.labelCode:setVisible(playermodel.class >= var_0_14)
	elseif self.curType == var_0_9.CALL then
		self.labelCodeInfo:setVisible(true)
		self.labelCodeInfo:setString(L_INVITE_ONBTNSTATUS[4])
		self.labelCode:setString("" .. playermodel.playerid)
		self.labelCode:setVisible(playermodel.class >= var_0_14)
	end
end

function PopInviteResidentLayer:updateLayout()
	self.btnShare:setVisible(self.curType ~= var_0_9.BEINVITED and account_manager:getChannel() ~= "270048")

	if self.curType == var_0_9.CALL then
		self.btnShare:loadTextures(var_0_11 .. "btn_share_call.png", nil, var_0_11 .. "btn_share_call.png", var_0_8)
	else
		self.btnShare:loadTextures(var_0_11 .. "btn_share_invite.png", nil, var_0_11 .. "btn_share_invite.png", var_0_8)
	end

	local var_23_0 = self.btnShare:getChildByName("labelInfo")

	var_23_0:setVisible(self.curType ~= var_0_9.CALL)
	var_23_0:setString(string.format(L_INVITE_HAS_IN, invite_manager:getInviteNum() or 0))
	self.btnCall:setVisible(false)
	self:updateBtnListPos()
	self:updatePanelTop()
end

function PopInviteResidentLayer:updateBtnListPos()
	local var_24_0 = {
		{
			302,
			302
		},
		{
			180,
			440
		}
	}
	local var_24_1 = {
		"btnCall",
		"btnShare"
	}
	local var_24_2 = 0

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		if self[iter_24_1] and self[iter_24_1]:isVisible() then
			var_24_2 = var_24_2 + 1
		end
	end

	if var_24_2 > 0 then
		for iter_24_2, iter_24_3 in pairs(var_24_1) do
			if self[iter_24_3] then
				self[iter_24_3]:setPositionX(var_24_0[var_24_2][iter_24_2])
			end
		end
	end
end

function PopInviteResidentLayer:updateListViewTasks(arg_25_1)
	self.listViewTasks:removeAllChildren()

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_0 = self.panelItem:clone()

		self:updateOnePanelTask(var_25_0, iter_25_1)
		self.listViewTasks:pushBackCustomItem(var_25_0)
	end

	self.listViewTasks:doLayout()
	self.listViewTasks:jumpToPercentVertical(0)
end

function PopInviteResidentLayer:initTableViewTasks()
	self.tableViewTasks = cc.TableView:create(self.listViewTasks:getContentSize())

	self.tableViewTasks:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableViewTasks:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableViewTasks:setDelegate()
	self.tableViewTasks:setPositionY(self.listViewTasks:getPositionY())
	self.panelMain:addChild(self.tableViewTasks)
	self.tableViewTasks:registerScriptHandler(handler(self, self.numberOfCells), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableViewTasks:registerScriptHandler(handler(self, self.cellSizeForIndex), cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableViewTasks:registerScriptHandler(handler(self, self.updateCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
	self.tableViewTasks:setLocalZOrder(0)
end

function PopInviteResidentLayer:numberOfCells(arg_27_1)
	return #self.tasks
end

function PopInviteResidentLayer.cellSizeForIndex(arg_28_0, arg_28_1, arg_28_2)
	return var_0_15, var_0_16
end

function PopInviteResidentLayer:updateCellAtIndex(arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1:dequeueCell()
	local var_29_1 = true

	if not var_29_0 then
		var_29_0 = cc.TableViewCell:create()
		var_29_1 = false
	end

	if var_29_1 then
		self:updateOnePanelTask(var_29_0, arg_29_2)
	else
		self:createOnePanelTask(var_29_0, arg_29_2)
	end

	return var_29_0
end

function PopInviteResidentLayer:updateTableViewTasks(arg_30_1)
	if not self.tableViewTasks then
		self:initTableViewTasks()
	end

	self.tasks = arg_30_1

	self.tableViewTasks:reloadData()
end

function PopInviteResidentLayer:createOnePanelTask(arg_31_1, arg_31_2)
	local var_31_0 = self.panelItem:clone()

	var_31_0:setName("panelTask")
	var_31_0:setPositionY(5)
	var_31_0:setSwallowsTouches(false)
	arg_31_1:addChild(var_31_0)
	self:updateOnePanelTask(arg_31_1, arg_31_2)
end

function PopInviteResidentLayer:getLeftLimitTimeStr()
	local var_32_0
	local var_32_1 = invite_manager:getLimitTimeInviteTaskLeftTime()

	if var_32_1 > 5 then
		var_32_0 = Utility:formatTimeStr(var_32_1)
	elseif var_32_1 <= 5 and var_32_1 > 0 then
		var_32_0 = Utility:formatTimeStr(var_32_1)

		time_check_manager:reset(function()
			self:updateLabelTime()
		end)
	else
		if self.isShowUpdatePanel == true then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			surecallback = function()
				self:hide()
			end,
			cancelcallback = function()
				self:hide()
			end,
			labels = {
				titleImage = "title_warorder.png"
			},
			desRichTexts = {
				{
					{
						fontSize = 28,
						str = L_INVITE_ONBTNSTATUS[3],
						font = FONT_W5
					}
				}
			}
		})

		self.isShowUpdatePanel = true
	end

	return var_32_0
end

function PopInviteResidentLayer:updateOnePanelTask(arg_36_1, arg_36_2)
	local var_36_0 = arg_36_1:getChildByName("panelTask")
	local var_36_1 = var_36_0:getChildByName("imgStatus")
	local var_36_2 = var_36_0:getChildByName("imgMask")
	local var_36_3 = var_36_0:getChildByName("btnStatus")
	local var_36_4 = var_36_0:getChildByName("richText")
	local var_36_5 = var_36_0:getChildByName("limitTime")

	if not var_36_4 then
		var_36_4 = Utility:replaceLabelByRichTextPro(var_36_0:getChildByName("labelInfo"), 260, 0, 18)

		var_36_4:setName("richText")
	end

	local var_36_6 = var_36_0:getChildByName("listViewRewards")
	local var_36_7 = self.tasks[arg_36_2 + 1]

	if not self.tasks[arg_36_2 + 1] then
		print("error data")

		return
	end

	var_36_5:setPositionX(75)

	if var_36_7.islimittime == true then
		var_36_5:setString("剩余时间:" .. (self:getLeftLimitTimeStr() or 0))
		var_36_5:setVisible(true)
	else
		var_36_5:setVisible(false)
	end

	var_36_4:clearText()
	var_36_2:setVisible(var_36_7.status == var_0_10.FINISHED)

	if var_36_7.islimittime == true and var_36_7.status == var_0_10.FINISHED then
		var_36_1:loadTexture(var_0_11 .. "bg_limit_time.png", var_0_8)
		var_36_4:setText(task_data[var_36_7.taskid].task_des)
	elseif var_36_7.islimittime == true and var_36_7.status ~= var_0_10.FINISHED then
		var_36_1:loadTexture(var_0_11 .. "bg_limit_time.png", var_0_8)
		var_36_4:setText(string.format("<p><span style=color: rgb(255, 255, 255);>%s(</span><span style=color: rgb(255, 222, 0);>%d/</span><span style=color: rgb(255, 255, 255);>%d)</span></p>", task_data[var_36_7.taskid].task_des, Utility:clamp(var_36_7.finished, 0, var_36_7.need), var_36_7.need))
	elseif var_36_7.islimittime ~= true and var_36_7.status == var_0_10.FINISHED then
		var_36_1:loadTexture(var_0_11 .. "img_complete.png", var_0_8)
		var_36_4:setText(task_data[var_36_7.taskid].task_des)
	else
		var_36_1:loadTexture(var_0_11 .. "img_progress.png", var_0_8)
		var_36_4:setText(string.format("<p><span style=color: rgb(255, 255, 255);>%s(</span><span style=color: rgb(255, 222, 0);>%d/</span><span style=color: rgb(255, 255, 255);>%d)</span></p>", task_data[var_36_7.taskid].task_des, Utility:clamp(var_36_7.finished, 0, var_36_7.need), var_36_7.need))
	end

	var_36_4:setPosition(35, 68)
	var_36_3:loadTextures(var_0_13[var_36_7.status], var_0_13[var_36_7.status], var_0_13[var_36_7.status], var_0_8)
	Utility:addClickEventListener(var_36_3, handler(self, self.onBtnStatus), var_36_7)
	var_36_6:removeAllChildren()
	var_36_6:setTouchEnabled(false)
	var_36_6:setItemsMargin(10)

	local var_36_8 = Utility:getDropData(task_data[var_36_7.taskid].drop)
	local var_36_9 = 0

	for iter_36_0, iter_36_1 in ipairs(var_36_8) do
		local var_36_10 = ItemSpriteActivityRecharge:createSignItem(iter_36_1.itemid, iter_36_1.num)

		var_36_10:addClickEventListener(handler(self, self.onBtnItem), iter_36_1.itemid)
		var_36_10:setSwallowsTouches(false)
		var_36_6:pushBackCustomItem(var_36_10)

		var_36_9 = var_36_9 + var_36_10:getContentSize().width
	end

	local var_36_11 = var_36_9 + 10 * math.max(#var_36_8 - 1, 0)

	var_36_6:setContentSize(cc.size(var_36_11, 118))
	var_36_6:setInnerContainerSize(cc.size(var_36_11, 118))
	var_36_6:setAnchorPoint(1, 0)
	var_36_6:setPosition(490, 0)
end

function PopInviteResidentLayer.onBtnItem(arg_37_0, arg_37_1, arg_37_2)
	LayerManager:pushInLayer("PopItemLayer", {
		itemid = arg_37_2
	})
end

function PopInviteResidentLayer:onBtnStatus(arg_38_1, arg_38_2)
	if self.curType == var_0_9.BEINVITED and self.bindUID == 0 and (arg_38_2.status == var_0_10.PROGRESS or arg_38_2.finished < arg_38_2.need) then
		global_ShowBlockWords(L_INVITE_ONBTNSTATUS[1])

		return
	end

	if arg_38_2.status == var_0_10.COMPLETE then
		if arg_38_2.islimittime == true then
			invite_manager:getLimitTimeReward(arg_38_2, function(arg_39_0)
				self:handleGetInviteTaskReward(arg_39_0)
			end)
		else
			EventManager:requestGetInviteTaskReward(arg_38_2.taskid)
		end
	elseif arg_38_2.status == var_0_10.PROGRESS then
		global_ShowBlockWords(L_INVITE_ONBTNSTATUS[2])
	end
end

function PopInviteResidentLayer.onEnter(arg_40_0)
	EventManager:requestGetInviteInfo()
end

function PopInviteResidentLayer:onExit()
	self.panelItem:release()
	EventManager:unsubscribe(self)
end

function PopInviteResidentLayer:show()
	self.showActions.extendVertical(self)
end

function PopInviteResidentLayer:hide()
	var_0_17 = nil

	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopInviteResidentLayer:handleGetInviteInfo(arg_45_1)
	if not arg_45_1 then
		return
	end

	if arg_45_1 and arg_45_1.result == 1 then
		self:updateSwitchBtns()
		self:autoSwitchBtns()
		self:updateLayout()
		self:updateAlert()
	end
end

function PopInviteResidentLayer:handleGetInviteTaskInfo(arg_46_1)
	if not arg_46_1 then
		return
	end

	if arg_46_1 and arg_46_1.result == 1 then
		if self.curType == var_0_9.INVITE and invite_manager:getLimitTimeInviteTaskLeftTime() > 0 then
			invite_manager:requestLimitTimeInviteTaskInfo(function(arg_47_0)
				self:updateTableViewTasks(arg_46_1.list)
				self:updateAlert()
			end)
		else
			self:updateTableViewTasks(arg_46_1.list)
			self:updateAlert()
		end
	end
end

function PopInviteResidentLayer.handleTerminateBindUID(arg_48_0, arg_48_1)
	if not arg_48_1 then
		return
	end

	if arg_48_1 and arg_48_1.result == 1 then
		-- block empty
	end
end

function PopInviteResidentLayer:handleBindInviteUID(arg_49_1)
	if not arg_49_1 then
		return
	end

	if arg_49_1 and arg_49_1.result == 1 then
		global_ShowBlockWords(L_INVITE_BIND_UID_RES[arg_49_1.result])

		self.bindUID = self.preBindUID

		self.editBoxCode:setEnabled(false)
		EventManager:requestGetInviteInfo()
	else
		global_ShowBlockWords(global_ShowBlockWords(L_INVITE_BIND_UID_RES[arg_49_1.result]))
		print("bind error", arg_49_1.result)
		self.labelCodeInfo:setString(L_INVITE_1)
		self.labelCodeInfo:setVisible(true)
		self.labelCode:setVisible(false)
	end
end

function PopInviteResidentLayer:handleGetInviteTaskReward(arg_50_1)
	if not arg_50_1 then
		return
	end

	if arg_50_1.result == 1 then
		global_gain(arg_50_1)
		EventManager:requestGetInviteTaskInfo(self.curType)
	end
end

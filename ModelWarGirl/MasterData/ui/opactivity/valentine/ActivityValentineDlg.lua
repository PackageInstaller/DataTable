-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Valentine\\ActivityValentineDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResClientNotice = require("ClientData/ResClientNotice")
local NODE_NOW = 1
local NODE_FINISH = 2
local NODE_FUTURE = 3
local ActivityValentineNodeCell = Class("ActivityValentineNodeCell", UIControls.Panel)

function ActivityValentineNodeCell:ctor()
	self.panelFinish = UIControls.Panel(self, self.mPath .. "/Efx")
	self.panelTime = UIControls.Panel(self, self.mPath .. "/Countdown")
	self.textTime = UIControls.Label(self, self.mPath .. "/Countdown/TimeText")
end

function ActivityValentineNodeCell:setData(nodeState)
	self.nodeState = nodeState[1]
	self.extraTime = nodeState[2]

	if self.nodeState == NODE_FINISH then
		self.panelFinish:setVisible(true)
		self.panelTime:setVisible(false)
		ClientTimerManager.RemoveSecondTickUI(self.textTime)
	elseif self.nodeState == NODE_FUTURE then
		ClientTimerManager.RemoveSecondTickUI(self.textTime)
		self:setVisible(false)
	else
		self.panelTime:setVisible(true)
		self.panelFinish:setVisible(false)
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.extraTime, false, self.mParent.actObj.actData.miscData.chat_replace_str or Lang.get(65468), Slot(self.onTimeOut, self))
	end
end

function ActivityValentineNodeCell:onTimeOut()
	self.mParent:refreshData()
end

local MAX_NODE_NUM = 8
local strClassName = "ActivityValentineDlg"
local ActivityValentineDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityValentineDlg, ActivityPanelMixin)

function ActivityValentineDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.textHookTime = UIControls.Label(self, "BgTime/TextTime")
	self.textHookFreezeRule = UIControls.Label(self, "BgTime/TextTime02")
	self.btnChat = UIControls.Button(self, "BtnGroup/Btn01")

	self.btnChat:addEventClick(self.onChatClick)

	self.iconNewChat = UIControls.Panel(self, "BtnGroup/Btn01/IconNew")
	self.btnMake = UIControls.Button(self, "BtnGroup/Btn02")

	self.btnMake:addEventClick(self.onMakeClick)

	self.iconNewMake = UIControls.Panel(self, "BtnGroup/Btn02/IconNew")
	self.btnGift = UIControls.Button(self, "BtnGroup/Btn03")

	self.btnGift:addEventClick(self.onGiftClick)

	self.iconNewGift = UIControls.Panel(self, "BtnGroup/Btn03/IconNew")
	self.btnAchieve = UIControls.Button(self, "BtnGroup/Btn04")

	self.btnAchieve:addEventClick(self.onAchieveClick)

	self.iconNewAchieve = UIControls.RedDot(self, "BtnGroup/Btn04/IconNew")
	self.nodeCells = {}

	for index = 1, MAX_NODE_NUM do
		local newNode = ActivityValentineNodeCell(self, "ReapGroup/0" .. index)

		table.insert(self.nodeCells, newNode)
	end

	self.iconNodeNew = UIControls.Panel(self, "ReapGroup/IconNew")
	self.btnGetAward = UIControls.Button(self, "ReapGroup/BtnConfirm")

	self.btnGetAward:addEventClick(self.onGetAwardClick)

	local relatAct = self.actObj.templateData.relate_act

	self.hookActId = relatAct[1]
	self.hookActObj = CurAvatar:getActivityObj(self.hookActId)
	self.achieveActId = relatAct[2]
	self.achieveActObj = CurAvatar:getActivityObj(self.achieveActId)

	CurAvatar:addActivityRelated(self.hookActId, self.mUIName, self.actObj.actId)
	CurAvatar:addActivityRelated(self.achieveActId, self.mUIName, self.actObj.actId)

	if self.achieveActObj then
		self.iconNewAchieve:addHint({
			self.achieveActObj.redDotId
		})
	end
end

function ActivityValentineDlg:onGetAwardClick()
	if self.hookActObj and self.hasNode then
		RPC.opActDepositGetAward(self.hookActObj.opId)
	else
		MsgManager.clientNotice(self.actObj.actData.miscData.no_node_notice)
	end
end

function ActivityValentineDlg:onChatClick(sender)
	UIManager.getUI("activityValentineChatDlg", true):onShowActivity({
		self.clientTemplateData,
		self.actObj
	})
end

function ActivityValentineDlg:onMakeClick(sender)
	UIManager.getUI("activityValentineMakeDlg", true):onShowActivity({
		self.clientTemplateData,
		self.actObj
	})
end

function ActivityValentineDlg:onGiftClick(sender)
	UIManager.getUI("activityValentineSendGiftDlg", true):onShowActivity({
		self.clientTemplateData,
		self.actObj
	})
end

function ActivityValentineDlg:onAchieveClick(sender)
	CurAvatar:jumpToShowActivity(self.achieveActId)
end

function ActivityValentineDlg:_setData()
	self:refreshData()
end

function ActivityValentineDlg:refreshData()
	local actData = self.actObj.actData

	if actData:checkMakeNew() then
		self.iconNewMake:setVisible(true)
	else
		self.iconNewMake:setVisible(false)
	end

	if actData:checkGiftNew() then
		self.iconNewGift:setVisible(true)
	else
		self.iconNewGift:setVisible(false)
	end

	if actData:checkChatNew() then
		self.iconNewChat:setVisible(true)
	else
		self.iconNewChat:setVisible(false)
	end

	if self.hookActObj then
		local mainColor = self.clientTemplateData.main_color

		if mainColor then
			self.textHookTime:setColorByRGBA(mainColor[1] / 255, mainColor[2] / 255, mainColor[3] / 255, 1)
		end

		if self.hookActObj:inOpenState() then
			ClientTimerManager.AddSecondFormatTickUI(self.textHookTime, self.hookActObj:getRemainOpenTime(), false, Lang.get(48657), Slot(self._timerOver, self))
		else
			ClientTimerManager.AddSecondFormatTickUI(self.textHookTime, self.hookActObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))
		end

		if self.hookActObj.templateData.freeze_rule_desc and self.hookActObj:inFreeze() then
			self.textHookFreezeRule:setVisible(true)
			self.textHookFreezeRule:setText(self.hookActObj.templateData.freeze_rule_desc or "")
		else
			self.textHookFreezeRule:setVisible(false)
		end

		local hookIndex = 1
		local hookInfo = self.hookActObj.actData:getHookDetailState(hookIndex)

		if hookInfo then
			local maxCount = math.min(hookInfo.maxCount, MAX_NODE_NUM)
			local hasGetCount = self.hookActObj.actData.hasGotCount
			local passedTime = hookInfo.passedTime
			local oneTime = hookInfo.oneTime
			local passCount = math.floor(passedTime / oneTime)

			self.hasNode = passCount > 0

			local extraTime = oneTime - passedTime % oneTime

			self.hookState = {}

			self.iconNodeNew:setVisible(self.hasNode)

			for index = 0, maxCount - 1 do
				local dataIndex = (index + hasGetCount) % maxCount + 1

				if passCount >= index + 1 then
					self.hookState[dataIndex] = {
						NODE_FINISH
					}
				elseif index == passCount and self.hookActObj:inOpenState() then
					self.hookState[dataIndex] = {
						NODE_NOW,
						extraTime
					}
				else
					self.hookState[dataIndex] = {
						NODE_FUTURE
					}
				end
			end

			for index, cell in ipairs(self.nodeCells) do
				if self.hookState[index] then
					cell:setVisible(true)
					cell:setData(self.hookState[index])
				else
					cell:setVisible(false)
				end
			end
		end
	end
end

function ActivityValentineDlg:updateActivityData()
	self:refreshData()

	local activityValentineSendGiftDlg = UIManager.tryGetUI("activityValentineSendGiftDlg")

	if activityValentineSendGiftDlg and activityValentineSendGiftDlg.updateActivityData then
		activityValentineSendGiftDlg:updateActivityData()
	end

	local activityValentineMakeDlg = UIManager.tryGetUI("activityValentineMakeDlg")

	if activityValentineMakeDlg and activityValentineMakeDlg.updateActivityData then
		activityValentineMakeDlg:updateActivityData()
	end
end

function ActivityValentineDlg:updateRelatedActivityData()
	self:refreshData()
end

function ActivityValentineDlg:onSaveHandBook()
	if self.actObj.actData:checkMakeNew() then
		self.iconNewMake:setVisible(true)
	else
		self.iconNewMake:setVisible(false)
	end
end

function ActivityValentineDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityValentineDlg:activityStateShow(actObj, extraArgs)
	if not CurAvatar:isBeginnerFinished(self.actObj.actData.miscData.beginner_guide_id or 457) then
		return
	end

	if extraArgs and extraArgs[1] == 0 then
		local activityValentineMakeDlg = UIManager.getUI("activityValentineMakeDlg", true)

		activityValentineMakeDlg:onShowActivity({
			self.clientTemplateData,
			self.actObj
		})
		activityValentineMakeDlg:setByGift(extraArgs[2])
	end
end

return ActivityValentineDlg

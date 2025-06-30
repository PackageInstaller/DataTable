-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_OpenInteractionUI.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)
local acType = {
	invite = 2,
	solo = 1,
	cancel = 3
}

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	local actionData = WorldMapModule.GetComponentActionDataWithId(self.args.actionId)

	if not actionData:GetCfg().CanInvite then
		if not actionData:GetCfg().TriggerCost[1] or not actionData:GetCfg().TriggerCost[2] then
			logError(string.format("【日常交互】actionCid = %s ,没有配置消耗 ", actionData.cid))

			return
		end

		local haveCount = WarehouseModule.GetItemNumByCfgID(actionData:GetCfg().TriggerCost[1])
		local costCount = actionData:GetCfg().TriggerCost[2]

		if costCount <= haveCount then
			WorldMapModule.TriggerDailyAction(self.args.actionId)
		else
			NoticeModule.ShowNotice(53009)
		end

		self.isComplete = true

		return
	end

	local comp = HomeModule.GetRoomComponentWithId(actionData.compCid)
	local actionDataList = {}
	local acData_solo = {}

	acData_solo.textDesc = CfgUtil.GetCfgStoryTextDataWithID(107045)
	acData_solo.actionType = acType.solo
	acData_solo.actionParam = ""

	table.insert(actionDataList, acData_solo)

	local acData_invite = {}

	acData_invite.textDesc = CfgUtil.GetCfgStoryTextDataWithID(107046)
	acData_invite.actionType = acType.invite
	acData_invite.actionParam = ""

	table.insert(actionDataList, acData_invite)

	local acData_cancel = {}

	acData_cancel.textDesc = "取消"
	acData_cancel.actionType = acType.cancel
	acData_cancel.actionParam = ""

	table.insert(actionDataList, acData_cancel)

	local userData = {}

	userData.DialogType = Constant.CommonDialogPanelType.DialogSelect
	userData.mountPoint = comp:GetSelectMountPoint()
	userData.headText = CfgUtil.GetCfgStoryTextDataWithID(107044)
	userData.actionList = actionDataList

	function userData.clickCallBack(actionType, actionParam)
		if actionType == acType.solo then
			if WorldMapModule.GetSoloInviteCount() >= CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.MaxSoloInviteCount) then
				NoticeModule.ShowNotice(53008)

				function self.onSelectCompleteDelegate()
					self:OnStart()
					EventDispatcher.RemoveEventListener(EventID.CommonDialogControl_OnActionComplete, self.onSelectCompleteDelegate)
				end

				EventDispatcher.AddEventListener(EventID.CommonDialogControl_OnActionComplete, self.onSelectCompleteDelegate)

				return
			end

			WorldMapModule.TriggerDailyAction(self.args.actionId)

			self.isComplete = true
		elseif actionType == acType.invite then
			UIModule.Open(Constant.UIControllerName.FavorInviteUI, Constant.UILayer.UI, {
				actionId = self.args.actionId
			})

			self.isComplete = true
		else
			self.isComplete = true
		end
	end

	UIModule.OpenCommonDialogPanel(userData)
end

return m

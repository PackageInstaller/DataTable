-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_ShowActionSelect.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	if not self.args.actionParam[1] then
		logError("【RPG】显示选项行为，没有配置 数组索引为 [1]： 组件id")

		return
	end

	if not self.args.actionParam[2] then
		logError("【RPG】显示选项行为，没有配置 数组索引为 [2]： 问题textId")

		return
	end

	if not self.args.actionParam[3] then
		logError("【RPG】显示选项行为，没有配置 数组索引为 [3]： 行为配置")

		return
	end

	local componentId = tonumber(self.args.actionParam[1])
	local component = HomeModule.GetRoomComponentWithId(componentId)
	local actionDataList = {}
	local len = #self.args.actionParam

	for i = 3, len do
		local strArray = string.split(self.args.actionParam[i], ",")
		local actionData = {}

		actionData.textDesc = CfgUtil.GetCfgStoryTextDataWithID(tonumber(strArray[1]))
		actionData.actionType = tonumber(strArray[2])
		actionData.actionParam = {}

		local strArrayLen = #strArray

		for j = 3, strArrayLen do
			table.insert(actionData.actionParam, strArray[j])
		end

		table.insert(actionDataList, actionData)
	end

	local headText = CfgUtil.GetCfgStoryTextDataWithID(tonumber(self.args.actionParam[2]))
	local userData = {}

	userData.DialogType = Constant.CommonDialogPanelType.DialogSelect
	userData.mountPoint = component:GetSelectMountPoint()
	userData.headText = headText
	userData.actionList = actionDataList
	userData.clickCallBack = self.args.clickCallBack

	UIModule.OpenCommonDialogPanel(userData)
end

return m

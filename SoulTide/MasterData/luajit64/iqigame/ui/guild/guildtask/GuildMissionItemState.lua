﻿-- chunkname: @IQIGame\\UI\\Guild\\GuildTask\\GuildMissionItemState.lua

local ActivityTaskItemState = require("IQIGame.UI.Activity.Common.ActivityTaskItemState")
local m = {
	InitState = 0
}

m = extend(ActivityTaskItemState, m)

function m.New(view, state, rewardPool, api, onClick, onClickLookReward)
	local obj = Clone(m)

	obj:Init(view, state, rewardPool, api, onClick, onClickLookReward)

	return obj
end

function m:Init(view, state, rewardPool, api, onClick, onClickLookReward)
	self.View = view
	self.InitState = state
	self.RewardPool = rewardPool
	self.Api = api
	self.OnClickCallback = onClick
	self.OnClickLookRewardBack = onClickLookReward

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFunctionBtn()
		self:OnClickFunctionBtn()
	end

	function self.DelegateLookRewardBtn()
		self:OnLookRewardBtn()
	end

	if api == nil then
		logError("必须传入Api")
	elseif api.langApiFuncList.TaskItemFunctionBtnText == nil or api.langApiFuncList.TaskItemProgressText == nil then
		logError("Api必须包含方法：Name:TaskItemFunctionBtnText, Param:state[1,2,3], Name:TaskItemProgressText, Param:finishNum, targetNum")
	end

	UGUIUtil.SetTextInChildren(self.FunctionBtn, api:GetString("TaskItemFunctionBtnText", state))
	self:AddListeners()
end

function m:AddListeners()
	local functionBtnCom = self.FunctionBtn:GetComponent("Button")

	if functionBtnCom ~= nil then
		functionBtnCom.onClick:AddListener(self.DelegateOnClickFunctionBtn)
	end

	local lookRewardBtnCom = self.RewardBtn:GetComponent("Button")

	if lookRewardBtnCom ~= nil then
		lookRewardBtnCom.onClick:AddListener(self.DelegateLookRewardBtn)
	end
end

function m:RemoveListeners()
	local functionBtnCom = self.FunctionBtn:GetComponent("Button")

	if functionBtnCom ~= nil then
		functionBtnCom.onClick:RemoveListener(self.DelegateOnClickFunctionBtn)
	end

	local lookRewardBtnCom = self.RewardBtn:GetComponent("Button")

	if lookRewardBtnCom ~= nil then
		lookRewardBtnCom.onClick:RemoveListener(self.DelegateLookRewardBtn)
	end
end

function m:SetData(guildMissData, taskState)
	self.View:SetActive(self.InitState == taskState)

	self.guildMissData = guildMissData

	if self.InitState == taskState then
		UGUIUtil.SetText(self.NameText, self.guildMissData.CfgInfo.Description)
		UGUIUtil.SetText(self.ProgressText, self.Api:GetString("TaskItemProgressText", self.guildMissData.CurrentNum, self.guildMissData.TargetNum))
	end

	UGUIUtil.SetText(self.StageText, self.Api:GetString("StateText", self.guildMissData.CfgInfo.DisplayOrder, self.guildMissData.TotalStage))

	self.ImgPer:GetComponent("Image").fillAmount = self.guildMissData.CfgInfo.DisplayOrder / self.guildMissData.TotalStage
end

function m:OnClickFunctionBtn()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self.InitState)
	end
end

function m:OnLookRewardBtn()
	if self.OnClickLookRewardBack ~= nil then
		self.OnClickLookRewardBack(self.guildMissData.Cid, self.InitState)
	end
end

function m:Dispose()
	self:RemoveListeners()

	self.OnClickCallback = nil
	self.OnClickLookRewardBack = nil

	self:BaseDispose()

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)

		self.View = nil
	end
end

return m

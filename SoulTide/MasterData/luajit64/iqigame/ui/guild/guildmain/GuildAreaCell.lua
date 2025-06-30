-- chunkname: @IQIGame\\UI\\Guild\\GuildMain\\GuildAreaCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnArea()
		self:OnBtnArea()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnArea:GetComponent("Button").onClick:AddListener(self.delegateBtnArea)
end

function m:RemoveListener()
	self.BtnArea:GetComponent("Button").onClick:RemoveListener(self.delegateBtnArea)
end

function m:SetData(data)
	self.guildAreaData = data
	self.View.name = self.guildAreaData.cfgInfo.Id

	self:UpdateView()
end

function m:UpdateView()
	local isShow = self.guildAreaData.isLock

	if self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Sign then
		isShow = self.guildAreaData.isLock and not PlayerModule.PlayerInfo.isGuildSign
	elseif self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Board then
		local myMemberData = GuildModule.GetMySelfGuildMemberData()
		local isLeader = false

		if myMemberData then
			isLeader = myMemberData.position == Constant.GuildPosition.Guild_President or myMemberData.position == Constant.GuildPosition.Guild_Vice_President
		end

		isShow = isLeader and self.guildAreaData.isLock
	end

	self.View:SetActive(isShow)
	UGUIUtil.SetText(self.TextName, self.guildAreaData.cfgInfo.Name)
	self.ImgAreaBG:SetActive(self.guildAreaData.cfgInfo.FunctionType ~= Constant.GuildFunctionType.Guild_Sign and self.guildAreaData.cfgInfo.FunctionType ~= Constant.GuildFunctionType.Guild_Board)
	self.ImgSignBG:SetActive(self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Sign)
	self.ImgBoardBG:SetActive(self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Board)
	self:RefreshPos()
	self:RefreshRedPoint()
end

function m:RefreshRedPoint()
	local showRed = false

	if self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Members then
		local myMemberData = GuildModule.GetMySelfGuildMemberData()
		local isLeader = false

		if myMemberData then
			isLeader = myMemberData.position == Constant.GuildPosition.Guild_President or myMemberData.position == Constant.GuildPosition.Guild_Vice_President
		end

		if isLeader then
			showRed = GuildModule.guildPOD.newAuditCount > 0
		end
	elseif self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Task then
		showRed = GuildModule.GetGuildTaskRedPoint()
	elseif self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Offer_A_Reward then
		local challengeRewards, canGetReward = GuildChallengeModule.GetGuildChallengeRewardList()

		showRed = #canGetReward > 0
	elseif self.guildAreaData.cfgInfo.FunctionType == Constant.GuildFunctionType.Guild_Trial and GuildTrainingModule.GuildTrainingPOD then
		showRed = GuildTrainingModule.GuildTrainingPOD.maxIntegral == 0
	end

	self.RedPoint:SetActive(showRed)
end

function m:RefreshPos()
	if self.guildAreaData then
		local position = GuildModule.GetSceneAreaPoint(self.guildAreaData.cfgID)
		local uiPos, v_v3 = self:ConvertPosToUI(position)

		self.View.transform.position = uiPos
	end
end

function m:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local canvas = self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas")
	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new, v_v3
end

function m:OnBtnArea()
	GuildModule.OnTouchArea(self.guildAreaData.cfgID)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m

-- chunkname: @IQIGame\\UI\\NPCAction\\NPCActionView.lua

local NPCActionView = {
	idleDuration = 10,
	IDLE_DURATION = 20,
	lastSoundId = 0,
	CV_SHOW_DURATION = 1
}
local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function NPCActionView.New(go)
	local o = Clone(NPCActionView)

	o:Initialize(go)

	return o
end

function NPCActionView:Initialize(go)
	self.goView = go

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.txtHelperComp = TextHelper.New()
end

function NPCActionView:Refresh(actionData, goNpc, path, parent, pos, scale, talkOffset, cvEndCallback)
	self.cvEndCallback = cvEndCallback

	self:StopSomething()
	self:SetDefaultPosition(talkOffset)
	self:ShowNpc(goNpc, path, parent, pos, scale)
	self:InitComp()
	self:PlayAction(actionData)
end

function NPCActionView:Update(elapseSeconds, realElapseSeconds)
	self.txtHelperComp:Update(elapseSeconds, realElapseSeconds)

	if self.enableCVTimer then
		if self.txtHelperComp:IsTypeFinished() then
			self.cvTimer = self.cvTimer + elapseSeconds
		end

		if self.curAnimName ~= self.IDLE_ANIM_NAME and self.animComp ~= nil and self.animComp.AnimationState ~= nil and self.animComp.AnimationState:GetCurrent(0) ~= nil and self.animComp.AnimationState:GetCurrent(0).IsComplete then
			self:PlayAnim(self.IDLE_ANIM_NAME)
		end

		if self.cvTimer >= self.CV_SHOW_DURATION then
			self:HideCv()

			if self.cvEndCallback ~= nil then
				self.cvEndCallback()
			end
		end
	end

	if self.startIdleTimer then
		self.idleTimer = self.idleTimer + elapseSeconds

		if self.idleTimer >= self.IDLE_DURATION + self.CV_SHOW_DURATION then
			self:RandomPlayStandbyAnim()
			self:StopIdleTimer()
		end
	end
end

function NPCActionView:OnHide()
	self:StopSomething()
end

function NPCActionView:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
	self.animComp = nil
end

function NPCActionView:SetDefaultPosition(talkOffset)
	if talkOffset == nil then
		return
	end

	self.goView.transform.anchoredPosition = Vector3.New(talkOffset[1], talkOffset[2], talkOffset[3])
end

function NPCActionView:ShowNpc(goNpc, path, parent, pos, scale)
	if self.goNpc ~= nil then
		if path ~= self.lastPath then
			UnityEngine.GameObject.DestroyImmediate(self.goNpc)

			self.goNpc = goNpc
		else
			UnityEngine.GameObject.DestroyImmediate(goNpc)
		end
	else
		self.goNpc = goNpc
	end

	self.lastPath = path

	self.goNpc.transform:SetParent(parent, false)

	self.goNpc.transform.localScale = Vector3(scale[1], scale[2], scale[3])
	self.goNpc.transform.localPosition = Vector3(pos[1], pos[2] + 350, pos[3])
end

function NPCActionView:InitComp()
	self.animComp = self.goNpc.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if self.animComp == nil then
		self.animComp = self.goNpc.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	end

	local animData = self.animComp.AnimationState.Data.SkeletonData:FindAnimation("Idle")

	if animData == nil then
		self.IDLE_ANIM_NAME = "idle"
	else
		self.IDLE_ANIM_NAME = "Idle"
	end
end

function NPCActionView:PlayAction(actionData)
	self.actionData = actionData

	local animName = self.IDLE_ANIM_NAME

	if self.actionData.Motion ~= "" then
		animName = self.actionData.Motion
	end

	self:PlayAnim(animName)
	self:ShowCV(self.actionData.CVid)
end

function NPCActionView:PlayAnim(animName)
	if animName ~= self.IDLE_ANIM_NAME then
		self.animComp.AnimationState:SetAnimation(0, animName, false)
	else
		self.animComp.AnimationState:SetAnimation(0, animName, true)
	end

	self.curAnimName = animName

	if self.curAnimName == self.IDLE_ANIM_NAME then
		self:StartIdleTimer()
	end
end

function NPCActionView:RandomPlayStandbyAnim()
	local actionData = NPCActionModule.GetAction(self.actionData.GroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.Standby, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	self:PlayAction(actionData)
end

function NPCActionView:ShowCV(id)
	self.cvTimer = 0
	self.enableCVTimer = true
	self.enableCheckAnimEnd = false

	self.goTalkBlock:SetActive(true)
	self.txtHelperComp:ResetGameObject(self.goTalkContent)

	local cfgCVData = CfgCVTable[id]

	self.CV_SHOW_DURATION = cfgCVData.TextTime

	if cfgCVData.SoundID > 0 then
		if self.lastSoundId ~= 0 then
			GameEntry.Sound:StopSound(self.lastSoundId)
		end

		self:PlaySound(cfgCVData.SoundID)
	end

	if cfgCVData.Text ~= "" then
		local str = string.gsub(cfgCVData.Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

		self.txtHelperComp:Perform(self.goTalkContent, str)
	end
end

function NPCActionView:HideCv()
	self.goTalkBlock:SetActive(false)

	self.enableCVTimer = false
end

function NPCActionView:StartIdleTimer()
	self.startIdleTimer = true
	self.idleTimer = 0
end

function NPCActionView:StopIdleTimer()
	self.startIdleTimer = false
end

function NPCActionView:PlaySound(id)
	self.lastSoundId = GameEntry.Sound:PlaySound(id, Constant.SoundGroup.CHARACTER)
end

function NPCActionView:StopSound()
	if self.lastSoundId > 0 then
		GameEntry.Sound:StopSound(self.lastSoundId)

		self.lastSoundId = 0
	end
end

function NPCActionView:StopSomething()
	self:HideCv()
	self:StopIdleTimer()
	self:StopSound()

	self.enableCheckAnimEnd = false
end

function NPCActionView:Pause()
	self:StopSomething()
end

function NPCActionView:Resume()
	self:PlayAnim(self.IDLE_ANIM_NAME)
end

return NPCActionView

-- chunkname: @IQIGame\\UI\\Guide\\GuideNpcTalkRender.lua

local GuideNpcTalkRender = {
	cvSoundId = 0,
	isStart = false
}
local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function GuideNpcTalkRender.__New(ui, index)
	local o = Clone(GuideNpcTalkRender)

	o:InitView(ui, index)

	return o
end

function GuideNpcTalkRender:InitView(ui, index)
	self.rootUI = ui
	self.index = index

	self.rootUI:SetActive(false)

	self.txtHelper = TextHelper.New()

	self.txtHelper:SetTypeInterval(0.05)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.btnSelf = self.rootUI:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end
end

function GuideNpcTalkRender:AddEventListener()
	self.btnSelf.onClick:AddListener(self.delegateBtnSelf)
end

function GuideNpcTalkRender:RemoveEventListener()
	self.btnSelf.onClick:RemoveListener(self.delegateBtnSelf)
end

function GuideNpcTalkRender:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuideNpcTalkRender:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.txtHelper ~= nil then
		self.txtHelper:Update(elapseSeconds, realElapseSeconds)
	end
end

function GuideNpcTalkRender:UpDateView()
	local cfgNpc = CfgNPCTable[self.guideModuleData[3]]
	local path = UIGlobalApi.GetImagePath(cfgNpc.NpcHeadImage)

	AssetUtil.LoadImage(self, path, self.NpcIcon:GetComponent("Image"))
end

function GuideNpcTalkRender:HexToColor(hex)
	local str = string.sub(hex, 2, 17)
	local s = string.sub(str, 1, 2)
	local r = tonumber(s, 16) / 255

	s = string.sub(str, 3, 4)

	local g = tonumber(s, 16) / 255

	s = string.sub(str, 5, 6)

	local b = tonumber(s, 16) / 255

	s = string.sub(str, 7, 8)

	local a = tonumber(s, 16) / 255

	return Color.New(r, g, b, a)
end

function GuideNpcTalkRender:Start()
	local isShowLevel2d = self.guideModuleData[13] == 1 and true or false

	EventDispatcher.Dispatch(EventID.GuideIsShowLevel2D, isShowLevel2d)
	self.rootUI:SetActive(true)
	self:Speak(self.guideModuleData[8])
end

function GuideNpcTalkRender:Speak(cvId)
	self.txtHelper:ResetGameObject(self.TextMsg)

	local cvData = CfgCVTable[cvId]

	if cvData ~= nil then
		if cvData.SoundID > 0 then
			GameEntry.Sound:StopSound(self._cvSoundId)

			self.cvSoundId = GameEntry.Sound:PlaySound(cvData.SoundID, Constant.SoundGroup.CHARACTER)
		end

		if cvData.Text ~= "" then
			local text = string.gsub(cvData.Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

			self.txtHelper:Perform(self.TextMsg, text)
		end
	end
end

function GuideNpcTalkRender:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function GuideNpcTalkRender:OnBtnSelf()
	if not self.txtHelper:IsTypeFinished() then
		self.txtHelper.Typer:Stop()
	else
		self:Close()
	end
end

function GuideNpcTalkRender:OpenImmediately()
	if self.guideModuleData then
		if self.startCallBack then
			self.startCallBack(self)
		end

		self:Start()
	end
end

function GuideNpcTalkRender:Open(data, isStart)
	self.guideModuleData = data
	self.isStart = isStart

	self:AddEventListener()
	self:UpDateView()

	if self.isStart then
		if self.startCallBack then
			self.startCallBack(self)
		end

		self:Start()
	end
end

function GuideNpcTalkRender:Close()
	self.startCallBack = nil

	self:RemoveEventListener()
	self.rootUI:SetActive(false)

	if self.cvSoundId > 0 then
		GameEntry.Sound:StopSound(self.cvSoundId)
	end

	EventDispatcher.Dispatch(EventID.GuideIsShowLevel2D, true)

	if self.endCallBack then
		self.endCallBack(self)
	end
end

return GuideNpcTalkRender

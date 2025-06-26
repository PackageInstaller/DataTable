-- chunkname: @IQIGame\\UI\\SummerActivity\\SummerActivityStageUI_tabItem.lua

local SummerActivityStageUI_tabItem = {}

function SummerActivityStageUI_tabItem.New(go, mainView)
	local o = Clone(SummerActivityStageUI_tabItem)

	o:Initialize(go, mainView)

	return o
end

function SummerActivityStageUI_tabItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SummerActivityStageUI_tabItem:InitComponent()
	return
end

function SummerActivityStageUI_tabItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function SummerActivityStageUI_tabItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function SummerActivityStageUI_tabItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function SummerActivityStageUI_tabItem:OnClickButtonClick()
	if not self.isOpen then
		NoticeModule.ShowNotice(21044002)

		return
	end

	self.mainView:OnTabSelected(self)
end

function SummerActivityStageUI_tabItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SummerActivityStageUI_tabItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function SummerActivityStageUI_tabItem:Selected()
	LuaUtility.SetScaleWithTransform(self.gameObject.transform, 1, 1, 1)
end

function SummerActivityStageUI_tabItem:UnSelected()
	LuaUtility.SetScaleWithTransform(self.gameObject.transform, 0.8, 0.8, 1)
end

function SummerActivityStageUI_tabItem:Refresh(Data, index)
	self.data = Data

	local activityPod = self.mainView.activityPOD

	if activityPod then
		self.openTime = tonumber(ActivityModule.GetActivityStageOpenTime(activityPod.cid, index))

		if self.openTime then
			self.isOpen = tonumber(PlayerModule.GetServerTimeByMs()) >= self.openTime

			if not self.isOpen then
				self:StopTimer()

				self.timer = Timer.New(function()
					self:RefreshTime()
				end, 1, -1)

				self.timer:Start()
				self:RefreshTime()
			end
		end
	else
		self.isOpen = false
	end

	LuaUtility.SetGameObjectShow(self.lockRoot, not self.isOpen)
	LuaUtility.SetText(self.textName, self.data.Name)
	LuaUtility.LoadImage(self, self.data.BackPicture, self.bg:GetComponent("Image"))

	if self.data.Id == self.mainView.currentSelectedTabId then
		self:Selected()
	else
		self:UnSelected()
	end
end

function SummerActivityStageUI_tabItem:RefreshTime()
	local s = tonumber(self.openTime) / 1000 - PlayerModule.GetServerTime()

	s = math.max(0, s)

	LuaUtility.SetText(self.textLock, DateStandardFormation(s))

	if s == 0 then
		self.isOpen = true

		LuaUtility.SetGameObjectShow(self.lockRoot, not self.isOpen)
		self.timer:Stop()

		self.timer = nil
	end
end

function SummerActivityStageUI_tabItem:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function SummerActivityStageUI_tabItem:OnDestroy()
	self:StopTimer()
	self:RemoveListener()
end

return SummerActivityStageUI_tabItem

-- chunkname: @IQIGame\\UI\\BattleActivityDungeon\\BattleActivityDungeon_StageItem.lua

local BattleActivityDungeon_StageItem = {}

function BattleActivityDungeon_StageItem.New(go, mainView)
	local o = Clone(BattleActivityDungeon_StageItem)

	o:Initialize(go, mainView)

	return o
end

function BattleActivityDungeon_StageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function BattleActivityDungeon_StageItem:InitComponent()
	return
end

function BattleActivityDungeon_StageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		if not self.isOpen then
			NoticeModule.ShowNotice(49005)

			return
		end

		UIModule.Open(Constant.UIControllerName.ActivityStageUI, Constant.UILayer.UI, {
			ActivityChapterPOD = self.data
		})
	end
end

function BattleActivityDungeon_StageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function BattleActivityDungeon_StageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function BattleActivityDungeon_StageItem:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleActivityDungeon_StageItem:Refresh(Data)
	self.data = Data

	local cfgActivityChapter = CfgUtil.GetCfgActivityChapterDataWithID(self.data.chapterId)

	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgActivityChapter.BossChapterImg), self.stageImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgActivityChapter.ChapterNameImg), self.nameImg:GetComponent("Image"))
	LuaUtility.SetText(self.stageNameText, cfgActivityChapter.Name)

	self.isOpen = PlayerModule.GetIsInTime(self.data.startTime, self.data.endTime)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	LuaUtility.SetGameObjectShow(self.lockState, not self.isOpen)

	if not self.isOpen then
		self.timer = Timer.New(function()
			self:RefreshTime()
		end, 1, -1)

		self.timer:Start()
		self:RefreshTime()
	end

	LuaUtility.SetText(self.textHero, cfgActivityChapter.Suggest)
	LuaUtility.LoadImage(self, UIGlobalApi.GetImagePath(cfgActivityChapter.ElementImg), self.imageElement:GetComponent("Image"))

	local currentProgress, maxProgress = ActivityDungeonModule.GetChapterProgress(self.data)

	LuaUtility.SetGameObjectShow(self.perfectRoot, currentProgress == maxProgress)
	LuaUtility.SetText(self.textCurrentProgress, currentProgress)
	LuaUtility.SetText(self.textMaxProgress, maxProgress)
	self:RefreshDot()
end

function BattleActivityDungeon_StageItem:RefreshDot()
	LuaUtility.SetGameObjectShow(self.RedDot, RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.BattleActivity_Chapter) >= 1 and RedDotModule.BattleActivityChapterRedDot[self.data.chapterId])
end

function BattleActivityDungeon_StageItem:RefreshTime()
	local s = tonumber(self.data.startTime) / 1000 - PlayerModule.GetServerTime()

	LuaUtility.SetText(self.LockText, DateStandardFormation(s))

	self.isOpen = PlayerModule.GetIsInTime(self.data.startTime, self.data.endTime)

	if self.isOpen then
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		LuaUtility.SetGameObjectShow(self.lockState, not self.isOpen)
	end
end

return BattleActivityDungeon_StageItem

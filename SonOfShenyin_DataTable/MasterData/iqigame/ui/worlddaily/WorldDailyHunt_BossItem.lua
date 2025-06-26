-- chunkname: @IQIGame\\UI\\WorldDaily\\WorldDailyHunt_BossItem.lua

local WorldDailyHunt_BossItem = {}
local dataName_bossItem = "bossItem"
local stateName_normal = "normal"
local stateName_elite = "elite"
local stateName_boss = "boss"

function WorldDailyHunt_BossItem.New(go, mainView)
	local o = Clone(WorldDailyHunt_BossItem)

	o:Initialize(go, mainView)

	return o
end

function WorldDailyHunt_BossItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function WorldDailyHunt_BossItem:InitComponent()
	self.startComp = self.starts:GetComponent("SimpleStarComponent")
end

function WorldDailyHunt_BossItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function WorldDailyHunt_BossItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function WorldDailyHunt_BossItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function WorldDailyHunt_BossItem:OnClickButtonClick()
	self.mainView:OnBossItemSelected(self)
end

function WorldDailyHunt_BossItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function WorldDailyHunt_BossItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function WorldDailyHunt_BossItem:Selected()
	LuaUtility.SetGameObjectShow(self.selected, true)
end

function WorldDailyHunt_BossItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selected, false)
end

function WorldDailyHunt_BossItem:Refresh(Data)
	self.data = Data

	local cfgCrusade = CfgUtil.GetCfgCrusadeDupStageDataWithID(self.data.crusadeCid)

	LuaUtility.SetText(self.textName, cfgCrusade.Name)
	self.startComp:UpdateView(cfgCrusade.Star, cfgCrusade.Star)
	LuaUtility.SetGameObjectShow(self.hasGet, self.data.state == Constant.WorldDailyHuntState.HasGet)
	LuaUtility.SetGameObjectShow(self.hadHunted, self.data.state == Constant.WorldDailyHuntState.HadHunted)
	LuaUtility.LoadImage(self, cfgCrusade.MonsterImage, self.imageMonster:GetComponent("Image"))
	LuaUtility.SetGameObjectShow(self.title, false)

	if cfgCrusade.Type == 1 then
		LuaUtility.SetStateController(self.gameObject, dataName_bossItem, stateName_normal)
	elseif cfgCrusade.Type == 2 then
		LuaUtility.SetStateController(self.gameObject, dataName_bossItem, stateName_elite)
		LuaUtility.SetText(self.textTitle, getTipText(1300071))
		LuaUtility.SetGameObjectShow(self.title, true)
	elseif cfgCrusade.Type == 3 then
		LuaUtility.SetStateController(self.gameObject, dataName_bossItem, stateName_boss)
		LuaUtility.SetText(self.textTitle, getTipText(1300072))
		LuaUtility.SetGameObjectShow(self.title, true)
	end

	if self.mainView.crrSelectedId and self.mainView.crrSelectedId == self.data.crusadeCid then
		self:Selected()
	else
		self:UnSelected()
	end
end

function WorldDailyHunt_BossItem:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.startComp = nil
end

return WorldDailyHunt_BossItem

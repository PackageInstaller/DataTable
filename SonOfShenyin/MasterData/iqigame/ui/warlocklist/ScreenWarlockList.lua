-- chunkname: @IQIGame\\UI\\WarlockList\\ScreenWarlockList.lua

ScreenWarlockList = {
	CurScreentable = {}
}

function ScreenWarlockList.New(go, mainView)
	local o = Clone(ScreenWarlockList)

	o:Initialize(go, mainView)

	return o
end

function ScreenWarlockList:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitDelegates()

	self.tapContent_Element = TapContent:New()

	self.tapContent_Element:Init(self.ElementTapRoot.gameObject, self.OnToggleElementChangedDelegate)

	self.tapContent_Profession = TapContent:New()

	self.tapContent_Profession:Init(self.ProfessionTapRoot.gameObject, self.OnToggleProfessionChangedDelegate)

	self.tapContent_Influence = TapContent:New()

	local des = {}

	for i = 1, #WarlockModule.EaseInfluenceTable do
		des[i] = CfgTipsTable[WarlockModule.EaseInfluenceTable[i].DesId].Text
	end

	self.tapContent_Influence:Init(self.InfluenceTapRoot.gameObject, self.OnToggleInfluenceChangedDelegate, nil, nil, nil, des)
end

function ScreenWarlockList:ResetAllScreen()
	self.tapContent_Element:ToggleSetItemIsOn()
	self.tapContent_Profession:ToggleSetItemIsOn()
	self.tapContent_Influence:ToggleSetItemIsOn()
end

function ScreenWarlockList:CloseBtn()
	self.gameObject:SetActive(false)
end

function ScreenWarlockList:InitDelegates()
	function self.OnToggleElementChangedDelegate(go, isOn)
		self:OnToggleElementChanged(go, isOn)
	end

	function self.OnToggleProfessionChangedDelegate(go, isOn)
		self:OnToggleProfessionChanged(go, isOn)
	end

	function self.OnToggleInfluenceChangedDelegate(go, isOn)
		self:OnToggleInfluenceChanged(go, isOn)
	end
end

function ScreenWarlockList:OnToggleElementChanged(go_name)
	local CurChooseEase

	if go_name == "fire" then
		CurChooseEase = WarlockModule.EaseElement.EaseFire
	elseif go_name == "water" then
		CurChooseEase = WarlockModule.EaseElement.EaseWater
	elseif go_name == "wind" then
		CurChooseEase = WarlockModule.EaseElement.EaseWind
	elseif go_name == "mine" then
		CurChooseEase = WarlockModule.EaseElement.EaseMine
	end

	WarlockModule.CurScreentable.Element = CurChooseEase

	self:RefreshOther()
end

function ScreenWarlockList:OnToggleProfessionChanged(go_name)
	local CurChooseEase

	if go_name == "conjuring" then
		CurChooseEase = WarlockModule.EaseProfession.EaseConjuring
	elseif go_name == "implement" then
		CurChooseEase = WarlockModule.EaseProfession.EaseImplement
	elseif go_name == "speech" then
		CurChooseEase = WarlockModule.EaseProfession.EaseSpeech
	elseif go_name == "Rune" then
		CurChooseEase = WarlockModule.EaseProfession.EaseRune
	elseif go_name == "curtain" then
		CurChooseEase = WarlockModule.EaseProfession.EaseCurtain
	elseif go_name == "provide" then
		CurChooseEase = WarlockModule.EaseProfession.EaseProvide
	end

	WarlockModule.CurScreentable.Profession = CurChooseEase

	self:RefreshOther()
end

function ScreenWarlockList:OnToggleInfluenceChanged(go_name)
	local CurChooseEase
	local index = tonumber(go_name)

	CurChooseEase = WarlockModule.EaseInfluenceTable[index].TypeId
	WarlockModule.CurScreentable.Influence = CurChooseEase

	self:RefreshOther()
end

function ScreenWarlockList:RefreshOther()
	self.mainView:RefreshOther()
end

function ScreenWarlockList:ToggleRefresh(WarlockDataDic)
	self.CurWarlockDataDic = {}

	for i, v in pairs(WarlockDataDic) do
		if v.BaseData.Elements == self.CurScreentable.Element then
			table.insert(self.CurWarlockDataDic, v)
		end

		if v.BaseData.Profession == self.CurScreentable.Profession and self:IsContain(self.CurWarlockDataDic, v.BaseData.Id) == false then
			table.insert(self.CurWarlockDataDic, v)
		end

		if v.BaseData.Forces == self.CurScreentable.Influence and self:IsContain(self.CurWarlockDataDic, v.BaseData.Id) == false then
			table.insert(self.CurWarlockDataDic, v)
		end
	end

	if #self.CurWarlockDataDic == 0 then
		self.CurWarlockDataDic = WarlockDataDic
	end
end

function ScreenWarlockList:IsContain(_table, id)
	for i, v in pairs(_table) do
		if v.id == id then
			return true
		end
	end

	return false
end

function ScreenWarlockList:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

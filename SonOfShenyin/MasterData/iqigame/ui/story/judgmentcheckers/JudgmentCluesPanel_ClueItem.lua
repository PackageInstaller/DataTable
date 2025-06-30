-- chunkname: @IQIGame\\UI\\Story\\JudgmentCheckers\\JudgmentCluesPanel_ClueItem.lua

local JudgmentCluesPanel_ClueItem = {}

function JudgmentCluesPanel_ClueItem.New(go, mainView)
	local o = Clone(JudgmentCluesPanel_ClueItem)

	o:Initialize(go, mainView)

	return o
end

function JudgmentCluesPanel_ClueItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function JudgmentCluesPanel_ClueItem:InitComponent()
	self.clueImg = self.clueImg:GetComponent("Image")
end

function JudgmentCluesPanel_ClueItem:InitDelegate()
	function self.delegateOnClickButtonDetail()
		self:OnClickButtonDetail()
	end
end

function JudgmentCluesPanel_ClueItem:AddListener()
	self.buttonDetail:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonDetail)
end

function JudgmentCluesPanel_ClueItem:RemoveListener()
	self.buttonDetail:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonDetail)
end

function JudgmentCluesPanel_ClueItem:OnClickButtonDetail()
	self.mainView:OnClueSelected(self.data)
end

function JudgmentCluesPanel_ClueItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function JudgmentCluesPanel_ClueItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function JudgmentCluesPanel_ClueItem:Refresh(Data)
	self.data = Data
	self.cfgClue = CfgUtil.GetCfgCluesDataWithID(self.data)

	LuaUtility.LoadImage(self, self.cfgClue.Icon, self.clueImg)
	LuaUtility.SetText(self.nameText, self.cfgClue.CluesName)
	LuaUtility.SetText(self.descText, self.cfgClue.Des)
	LuaUtility.SetGameObjectShow(self.detailBtn, self.cfgClue.IsSurvey)
end

function JudgmentCluesPanel_ClueItem:OnDestroy()
	return
end

return JudgmentCluesPanel_ClueItem

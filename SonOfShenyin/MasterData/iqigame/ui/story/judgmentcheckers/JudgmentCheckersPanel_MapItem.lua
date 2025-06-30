-- chunkname: @IQIGame\\UI\\Story\\JudgmentCheckers\\JudgmentCheckersPanel_MapItem.lua

local JudgmentCheckersPanel_MapItem = {}
local dataName = "state"
local stateStateName_null = "null"
local stateStateName_player = "player"
local stateStateName_normal = "normal"
local stateStateName_clue = "clue"

function JudgmentCheckersPanel_MapItem.New(go, mainView)
	local o = Clone(JudgmentCheckersPanel_MapItem)

	o:Initialize(go, mainView)

	return o
end

function JudgmentCheckersPanel_MapItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function JudgmentCheckersPanel_MapItem:InitComponent()
	return
end

function JudgmentCheckersPanel_MapItem:InitDelegate()
	function self.delegateOnClickProblemBg()
		self:OnClickProblemBg()
	end
end

function JudgmentCheckersPanel_MapItem:AddListener()
	self.problemBg:GetComponent("Button").onClick:AddListener(self.delegateOnClickProblemBg)
end

function JudgmentCheckersPanel_MapItem:RemoveListener()
	self.problemBg:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickProblemBg)
end

function JudgmentCheckersPanel_MapItem:OnClickProblemBg()
	self.mainView:OnProblemSelected(self.id)
end

function JudgmentCheckersPanel_MapItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function JudgmentCheckersPanel_MapItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function JudgmentCheckersPanel_MapItem:SwitchNull()
	LuaUtility.SetStateController(self.gameObject, dataName, stateStateName_null)
end

function JudgmentCheckersPanel_MapItem:SwitchPlayer()
	LuaUtility.SetStateController(self.gameObject, dataName, stateStateName_player)

	if PlayerModule.GetSex() == 0 then
		LuaUtility.LoadImage(self, CfgUtil.GetStoryResourceWithID(50060), self.imagePlayer:GetComponent("Image"))
	elseif PlayerModule.GetSex() == 1 then
		LuaUtility.LoadImage(self, CfgUtil.GetStoryResourceWithID(50061), self.imagePlayer:GetComponent("Image"))
	end
end

function JudgmentCheckersPanel_MapItem:SwitchClue(clueId)
	LuaUtility.SetStateController(self.gameObject, dataName, stateStateName_clue)

	local cfgClue = CfgUtil.GetCfgCluesDataWithID(clueId)

	LuaUtility.LoadImage(self, cfgClue.Icon, self.imageClue:GetComponent("Image"))
end

function JudgmentCheckersPanel_MapItem:ShowProblem(textId)
	local text = CfgUtil.GetCfgStoryTextDataWithID(textId)

	LuaUtility.SetText(self.textProblem, text)
	LuaUtility.SetGameObjectShow(self.problemBg, true)
end

function JudgmentCheckersPanel_MapItem:HideProblem()
	LuaUtility.SetGameObjectShow(self.problemBg, false)
end

function JudgmentCheckersPanel_MapItem:OnDestroy()
	return
end

return JudgmentCheckersPanel_MapItem

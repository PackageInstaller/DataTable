-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DIYRefineTipPanel.lua

local DIYRefineTipPanel = {}

function DIYRefineTipPanel.New(go, mainView)
	local o = Clone(DIYRefineTipPanel)

	o:Initialize(go, mainView)

	return o
end

function DIYRefineTipPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DIYRefineTipPanel:InitComponent()
	return
end

function DIYRefineTipPanel:InitDelegate()
	return
end

function DIYRefineTipPanel:AddListener()
	return
end

function DIYRefineTipPanel:RemoveListener()
	return
end

function DIYRefineTipPanel:OnDestroy()
	return
end

function DIYRefineTipPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DIYRefineTipPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DIYRefineTipPanel:Refresh(data)
	self.data = data

	local curLevelCfg = DiySkillModule.GetSkillRefineCfg(self.data.skillCid, self.data.purifyLv)

	LuaUtility.SetText(self.textName, DiySkillStrengthenUIApi:GetTextRefineLevel(self.data.purifyLv))
	LuaUtility.SetText(self.textDesc, curLevelCfg.SkillTips)
end

return DIYRefineTipPanel

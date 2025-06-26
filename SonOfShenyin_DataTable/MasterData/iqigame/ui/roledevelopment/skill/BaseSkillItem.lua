-- chunkname: @IQIGame\\UI\\RoleDevelopment\\Skill\\BaseSkillItem.lua

local BaseSkillItem = {}

function BaseSkillItem.New(go, mainView, index)
	local o = Clone(BaseSkillItem)

	o:Initialize(go, mainView, index)

	return o
end

function BaseSkillItem:Initialize(go, mainView, index)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.index = index

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function BaseSkillItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function BaseSkillItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClickClick()
	end
end

function BaseSkillItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function BaseSkillItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function BaseSkillItem:OnButtonClickClick()
	self.mainView:ShowSkillDetailPanel(self.index, false)
end

function BaseSkillItem:SelectState(state)
	LuaUtility.SetGameObjectShow(self.selectImg, state)
end

function BaseSkillItem:Refresh(Data)
	self.Data = Data

	local skillCfg = CfgUtil.GetCfgSkillDataWithID(self.Data.skillCid)

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(skillCfg.Icon), self.SkillIcon:GetComponent("Image"))
	LuaUtility.SetText(self.skillType, RoleDevelopmentApi:GetSkillType(skillCfg.SkillType))
	LuaUtility.SetText(self.SkillLvText, "Lv." .. self.Data.lv + self.Data.extLv)

	local skillElement = CfgSkillDetailTable[self.Data.skillCid].Element

	LuaUtility.SetGameObjectShow(self.SkillElementIcon, skillElement ~= 0)

	if skillElement ~= 0 then
		LuaUtility.LoadImage(self, RoleDevelopmentApi:GetSkillElementImgPath(skillElement), self.SkillElementIcon:GetComponent("Image"))
	end
end

function BaseSkillItem:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

return BaseSkillItem

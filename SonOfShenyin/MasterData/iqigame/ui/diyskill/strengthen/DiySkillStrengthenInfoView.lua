-- chunkname: @IQIGame\\UI\\DiySkill\\Strengthen\\DiySkillStrengthenInfoView.lua

local DiySkillStrengthenInfoView = {}
local attrClass = require("IQIGame/UI/DiySkill/Strengthen/DiySkillStrengthenAttrCell")

function DiySkillStrengthenInfoView.New(view)
	local obj = Clone(DiySkillStrengthenInfoView)

	obj:__Init(view)

	return obj
end

function DiySkillStrengthenInfoView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.attrCellArray = {}

	self:InitComponent()
	self:InitDelegate()
	self:__AddListeners()
end

function DiySkillStrengthenInfoView:InitDelegate()
	function self.delegateOnClickLockBtn()
		RoleDevelopmentModule.RoleSkillLock({
			self.skillData.id
		})
	end

	function self.onShowMaxValueChanged(isOn)
		if isOn then
			self:RefreshMaxSkillInfo(self.skillData)
		else
			self:RefreshSkillInfo(self.skillData)
		end
	end
end

function DiySkillStrengthenInfoView:InitComponent()
	self.startsComponent = self.presentBreachStars:GetComponent("StartsHelperComponent")
end

function DiySkillStrengthenInfoView:__AddListeners()
	self.lockBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickLockBtn)
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:AddListener(self.onShowMaxValueChanged)
end

function DiySkillStrengthenInfoView:__RemoveListeners()
	self.lockBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickLockBtn)
	self.toggleShowMax:GetComponent("Toggle").onValueChanged:RemoveListener(self.onShowMaxValueChanged)
end

function DiySkillStrengthenInfoView:Dispose()
	self:__RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiySkillStrengthenInfoView:SetData(skillData)
	self.skillData = skillData

	LuaUtility.SetGameObjectShow(self.gameObject, true)

	if self.toggleShowMax:GetComponent("Toggle").isOn then
		self:RefreshMaxSkillInfo(self.skillData)
	else
		self:RefreshSkillInfo(self.skillData)
	end

	EventDispatcher.Dispatch(EventID.PlayDiySkillStrengthInAnimationEvent, nil, nil, true)
end

function DiySkillStrengthenInfoView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DiySkillStrengthenInfoView:RefreshSkillInfo(skillData)
	local cfgSkill = skillData:GetCfg()

	LuaUtility.SetText(self.textCurrentLevel, skillData.lv)
	LuaUtility.SetText(self.textMaxLevel, skillData:GetSkillMaxLevel())
	LuaUtility.SetText(self.textName, cfgSkill.Name)
	LuaUtility.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(cfgSkill.ReleaseType))

	if cfgSkill.ElementLimit and cfgSkill.ElementLimit[1] and cfgSkill.ElementLimit[1] ~= 0 then
		LuaUtility.SetGameObjectShow(self.elementLimit, true)

		local path = CommonSkillTipsUIApi:GetSkillElementIconPath(cfgSkill.ElementLimit[1])

		LuaUtility.LoadImage(self, path, self.imageType:GetComponent("Image"))
		LuaUtility.SetText(self.textType, CommonSkillTipsUIApi:GetTextElementLimit(cfgSkill.ElementLimit[1]))
	else
		LuaUtility.SetGameObjectShow(self.elementLimit, false)
	end

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(cfgSkill.Id)

	self.startsComponent:Refresh(skillData.strengLv, maxStrengthenLv)

	local index = 1
	local attrTable = DiySkillModule.GetSkillTotalAttributes(skillData, Constant.DIYSkillDisplayAttrTable)

	ForPairs(attrTable, function(_attrType, _attrValue)
		local cell = self:_GetAttrCell(index)

		cell:Refresh(_attrType, _attrValue)
		cell:Show()

		index = index + 1
	end)

	local len = #self.attrCellArray

	for i = index, len do
		self.attrCellArray[i]:Hide()
	end

	local refineCfg = DiySkillModule.GetSkillRefineCfg(skillData.skillCid, skillData.purifyLv)

	LuaUtility.SetText(self.textStrengthenLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(skillData.purifyLv))
	LuaUtility.SetText(self.textDesc, refineCfg.SkillTips)
	self:RefreshSkillLockState(skillData.lock)
end

function DiySkillStrengthenInfoView:RefreshMaxSkillInfo(skillData)
	local cfgSkill = skillData:GetCfg()
	local maxLevel = skillData:GetSkillMaxLevel()

	LuaUtility.SetText(self.textCurrentLevel, maxLevel)
	LuaUtility.SetText(self.textMaxLevel, maxLevel)
	LuaUtility.SetText(self.textName, cfgSkill.Name)
	LuaUtility.SetText(self.skillTypeText, CommonSkillTipsUIApi:GetSkillTypeText(cfgSkill.ReleaseType))

	if cfgSkill.ElementLimit and cfgSkill.ElementLimit[1] and cfgSkill.ElementLimit[1] ~= 0 then
		LuaUtility.SetGameObjectShow(self.elementLimit, true)

		local path = CommonSkillTipsUIApi:GetSkillElementIconPath(cfgSkill.ElementLimit[1])

		LuaUtility.LoadImage(self, path, self.imageType:GetComponent("Image"))
		LuaUtility.SetText(self.textType, CommonSkillTipsUIApi:GetTextElementLimit(cfgSkill.ElementLimit[1]))
	else
		LuaUtility.SetGameObjectShow(self.elementLimit, false)
	end

	local maxStrengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(cfgSkill.Id)

	self.startsComponent:Refresh(maxStrengthenLv, maxStrengthenLv)

	local maxRefineLevel = DiySkillModule.GetSkillMaxRefineLevel(skillData.skillCid)
	local refineCfg = DiySkillModule.GetSkillRefineCfg(skillData.skillCid, maxRefineLevel)

	LuaUtility.SetText(self.textStrengthenLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(maxRefineLevel))
	LuaUtility.SetText(self.textDesc, refineCfg.SkillTips)

	local attrTable = DiySkillModule.GetSkillTotalAttributesWithCustomData(skillData.Quality, skillData.skillCid, maxLevel, maxStrengthenLv, maxRefineLevel, Constant.DIYSkillDisplayAttrTable)
	local index = 1

	ForPairs(attrTable, function(_attrType, _attrValue)
		local cell = self:_GetAttrCell(index)

		cell:Refresh(_attrType, _attrValue)
		cell:Show()

		index = index + 1
	end)

	local len = #self.attrCellArray

	for i = index, len do
		self.attrCellArray[i]:Hide()
	end

	self:RefreshSkillLockState(skillData.lock)
end

function DiySkillStrengthenInfoView:_GetAttrCell(index)
	if not self.attrCellArray[index] then
		local o = GameObject.Instantiate(self.attPrefab, self.attRoot.transform)

		self.attrCellArray[index] = attrClass.New(o, self)
	end

	return self.attrCellArray[index]
end

function DiySkillStrengthenInfoView:RefreshSkillLockState(isLock)
	LuaCodeInterface.SetGameObjectShow(self.lockOn, isLock)
	LuaCodeInterface.SetGameObjectShow(self.lockOff, not isLock)
end

return DiySkillStrengthenInfoView

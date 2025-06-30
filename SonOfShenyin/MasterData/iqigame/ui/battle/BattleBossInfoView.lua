-- chunkname: @IQIGame\\UI\\Battle\\BattleBossInfoView.lua

local BossSkillInfoItem = {}

function BossSkillInfoItem.New(view)
	local obj = Clone(BossSkillInfoItem)

	obj:__Init(view)

	return obj
end

function BossSkillInfoItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function BossSkillInfoItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BossSkillInfoItem:Show(skillCid)
	self.gameObject:SetActive(true)

	local skillConfig = CfgSkillTable[skillCid]
	local path = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, path, self.icon:GetComponent(typeof(UnityEngine.UI.Image)), nil, nil, nil, true)
	UGUIUtil.SetText(self.nameText, skillConfig.Name)
	UGUIUtil.SetText(self.typeText, BattleUIApi:GetSkillTypeTips(skillConfig.SkillType))

	local skillDetailConfig = CfgSkillDetailTable[skillConfig.SkillDetail]

	UGUIUtil.SetText(self.cdText, skillDetailConfig.CoolDown)

	if skillConfig.SkillType == Constant.SkillType.TYPE_PASSIVE then
		self.rangeImg.gameObject.transform.parent.gameObject:SetActive(false)
	else
		self.rangeImg.gameObject.transform.parent.gameObject:SetActive(true)

		local searchTargetData = CfgSearchTargetTable[skillDetailConfig.TargetTypeID]
		local rangeImgPath = UIGlobalApi.GetImagePath(searchTargetData.SkillRangeImg)

		AssetUtil.LoadImage(self, rangeImgPath, self.rangeImg.gameObject:GetComponent("Image"), nil, function()
			logError("技能: {0} SearchTarget配置图片SkillRangeImg: {1} 加载失败", skillData.configID, searchTargetData.SkillRangeImg)
		end)
	end

	UGUIUtil.SetText(self.descText, skillConfig.EffectText)
end

function BossSkillInfoItem:Hide()
	self.gameObject:SetActive(false)
end

local BattleBossInfoView = {
	skillDataList = {},
	skillItemList = {}
}

function BattleBossInfoView.New(view)
	local obj = Clone(BattleBossInfoView)

	obj:__Init(view)

	return obj
end

function BattleBossInfoView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnCloseButtonClick()
		self:__OnCloseButtonClick()
	end

	self.closeBG.gameObject:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.__delegateOnCloseButtonClick)

	function self.__delegateOnRenderCell(cell)
		self:__OnRenderCell(cell)
	end

	local scrollAreaList = self.scrollArea:GetComponent("ScrollAreaList")

	scrollAreaList.onRenderCell = self.__delegateOnRenderCell
end

function BattleBossInfoView:Dispose()
	self.closeBG.gameObject:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.__delegateOnCloseButtonClick)
	ForPairs(self.skillItemList, function(_, _item)
		_item:Dispose()
	end)

	self.skillItemList = nil
	self.skillDataList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleBossInfoView:Show(battleUnitID)
	self.gameObject:SetActive(true)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local monsterData = CfgMonsterTable[battleUnitData.monsterConfigID]

	self.titleText:GetComponent("Text").text = monsterData.Name
	self.skillDataList = {}

	ForArray(monsterData.SkillShow, function(_index, _skillCid)
		local skillConfig = CfgSkillTable[_skillCid]

		if not skillConfig.IsTipsVisible then
			return
		end

		table.insert(self.skillDataList, _skillCid)
	end)

	local scrollAreaList = self.scrollArea:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.skillDataList)
end

function BattleBossInfoView:Hide()
	self.gameObject:SetActive(false)
end

function BattleBossInfoView:__OnCloseButtonClick()
	self:Hide()
end

function BattleBossInfoView:__OnRenderCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local skillInfoItem = self.skillItemList[instanceID]

	if skillInfoItem == nil then
		skillInfoItem = BossSkillInfoItem.New(cell.gameObject)
		self.skillItemList[instanceID] = skillInfoItem
	end

	local skillData = self.skillDataList[cell.index + 1]

	if skillData == nil then
		skillInfoItem:Hide()
	else
		skillInfoItem:Show(skillData)
	end
end

return BattleBossInfoView

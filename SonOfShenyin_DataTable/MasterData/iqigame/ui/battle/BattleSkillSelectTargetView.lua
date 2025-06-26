-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillSelectTargetView.lua

local SkillTargetItemView = {
	canSelect = false,
	battleUnitID = 0
}

function SkillTargetItemView.New(view)
	local obj = Clone(SkillTargetItemView)

	obj:__Init(view)

	return obj
end

function SkillTargetItemView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnItemClick()
		if not self.canSelect then
			NoticeModule.ShowNotice(BattleUIApi:GetSkillCanNotSelectTargetNoticeCid())

			return
		end

		BattleSkillModule.OnBattleUnitSkillTargetSelect(self.battleUnitID)
	end

	self.button.gameObject:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnItemClick)
end

function SkillTargetItemView:Show(battleUnitData, canSelect)
	self.canSelect = canSelect
	self.battleUnitID = battleUnitData.battleUnitID

	local headIconPath = BattleModule.GetBattleUnitHeadIcon(self.battleUnitID)

	AssetUtil.LoadImage(self, headIconPath, self.iconGo:GetComponent(typeof(UnityEngine.UI.Image)))
	self:ShowNormalState()

	self.indexText.gameObject:GetComponent("Text").text = tostring(battleUnitData.battlePos)

	self.gameObject:SetActive(true)

	local isStealth = battleUnitData:IsInFightStatus(Constant.BattleFightStatus.STEALTH)

	self.stealthTag.gameObject:SetActive(isStealth)

	local isTaunt = battleUnitData:IsInFightStatus(Constant.BattleFightStatus.TAUNT)

	self.tauntTag.gameObject:SetActive(isTaunt)
end

function SkillTargetItemView:Hide()
	self.gameObject:SetActive(false)
end

function SkillTargetItemView:Dispose()
	self.button.gameObject:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnItemClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil

	AssetUtil.UnloadAsset(self)
end

function SkillTargetItemView:ShowNormalState()
	self.mainTag.gameObject:SetActive(false)
	self.subTag.gameObject:SetActive(false)
end

function SkillTargetItemView:ShowMainTargetState()
	self.mainTag.gameObject:SetActive(true)
	self.subTag.gameObject:SetActive(true)
end

function SkillTargetItemView:ShowSecondaryTargetState()
	self.mainTag.gameObject:SetActive(false)
	self.subTag.gameObject:SetActive(true)
end

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.delegateOnReturnSelectSkill()
		BattleSkillModule.OnReturnShowBattleManualSelectSkill()
	end

	function self.delegateOnRefreshUISkillTarget(headStateDic)
		self:__OnRefreshHeadsState(headStateDic)
	end

	self.targetHeads = {}

	local childCount = self.targetsRoot.transform.childCount

	for i = 1, childCount do
		local child = self.targetsRoot.transform:GetChild(i - 1)
		local item = SkillTargetItemView.New(child.gameObject)

		table.insert(self.targetHeads, item)
	end
end

function m:Show(battleUnitID, skillCid)
	self.gameObject:SetActive(true)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(skillCid)

	self:__OnRefreshSKillInfo(battleSkillData)

	local skillTargets = BattleSkillModule.GetSkillTargets(battleUnitData, battleSkillData)

	self:__ShowSkillTargets(skillTargets)
	EventDispatcher.AddEventListener(EventID.OnRefreshUISkillTarget, self.delegateOnRefreshUISkillTarget)
	self.returnBtn:GetComponent("Button").onClick:AddListener(self.delegateOnReturnSelectSkill)
end

function m:__ShowSkillTargets(skillTargets)
	ForArray(self.targetHeads, function(_, _itemCell)
		_itemCell:Hide()
	end)
	ForPairs(skillTargets, function(battleUnitID, canSelect)
		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
		local item = self.targetHeads[battleUnitData.battlePos]

		item:Show(battleUnitData, canSelect)
	end)
end

function m:RefreshTargetSelectedShow(anchorTile, hitTiles)
	ForArray(self.targetHeads, function(_, _itemCell)
		_itemCell:ShowNormalState()
	end)

	local battleUnitData = BattleModule.GetBattleUnitDataByTileIndex(anchorTile)
	local selectedItemCell = self.targetHeads[battleUnitData.battlePos]

	selectedItemCell:ShowMainTargetState()
	ForPairs(hitTiles, function(_index, _tileIndex)
		if _index == 1 then
			return
		end

		local _battleUnitData = BattleModule.GetBattleUnitDataByTileIndex(_tileIndex)

		if _battleUnitData == nil then
			return
		end

		local _itemCell = self.targetHeads[_battleUnitData.battlePos]

		_itemCell:ShowSecondaryTargetState()
	end)
end

function m:Hide()
	self.returnBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnReturnSelectSkill)
	EventDispatcher.RemoveEventListener(EventID.OnRefreshUISkillTarget, self.delegateOnRefreshUISkillTarget)
	self.gameObject:SetActive(false)
end

function m:__OnRefreshHeadsState(headDic)
	ForArray(self.targetHeads, function(_, _itemCell)
		if not _itemCell.gameObject.activeSelf then
			return
		end

		local state = headDic[_itemCell.battleUnitID]

		if state == true then
			_itemCell:ShowMainTargetState()
		elseif state == false then
			_itemCell:ShowSecondaryTargetState()
		else
			_itemCell:ShowNormalState()
		end
	end)
end

function m:__OnRefreshSKillInfo(battleSkillData)
	if not BattleTeamActionModule.showSkillDetail then
		self.skillDetailParent.gameObject:SetActive(false)

		return
	end

	self.skillDetailParent.gameObject:SetActive(true)

	local skillConfig = CfgSkillTable[battleSkillData.configID]
	local iconPath = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, iconPath, self.skillIcon:GetComponent(typeof(UnityEngine.UI.Image)))

	self.skillNameText.gameObject:GetComponent("Text").text = skillConfig.Name
	self.energyNumText.gameObject:GetComponent("Text").text = battleSkillData.energyCost
	self.cdText.gameObject:GetComponent("Text").text = battleSkillData.coolDown
	self.skillDetailText.gameObject:GetComponent("Text").text = self:__GetSkillTips(battleSkillData)

	local path = UIGlobalApi.GetImagePath(battleSkillData.searchTargetData.SkillRangeImg)

	AssetUtil.LoadImage(self, path, self.rangeImage.gameObject:GetComponent("Image"))
end

function m:__GetSkillTips(skillData)
	if skillData.skillType == Constant.SkillType.TYPE_LORE then
		local skillRefineData = DiySkillModule.GetSkillRefineCfg(skillData.configID, skillData.purifyLv)

		return skillRefineData.SkillTips
	end

	local exist, skillLevelConfig = RoleDevelopmentModule.GetSkillCfgByIDAndLv(skillData.configID, skillData.level - 1)

	if not exist then
		return ""
	end

	return UIGlobalApi.GetDescribeMatchTable(skillLevelConfig.SkillTips, function(_index, _formatType)
		local str = UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, skillLevelConfig.UpGradeOldValue[_index])

		return RoleDevelopmentApi:GetPromoteStrNotIncludNext(str)
	end)
end

function m:Dispose()
	self:Hide()

	for i = 1, #self.targetHeads do
		self.targetHeads[i]:Dispose()
	end

	self.targetHeads = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil

	AssetUtil.UnloadAsset(self)
end

return m

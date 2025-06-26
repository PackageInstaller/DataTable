-- chunkname: @IQIGame\\UI\\Formation\\FormationEnemyView.lua

local SkillItem = {}

function SkillItem.New(view)
	local obj = Clone(SkillItem)

	obj:__Init(view)

	return obj
end

function SkillItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SkillItem:Show(skillCid)
	self.gameObject:SetActive(true)

	local skillConfig = CfgSkillTable[skillCid]
	local path = UIGlobalApi.GetIconPath(skillConfig.Icon)

	AssetUtil.LoadImage(self, path, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))

	self.nameText:GetComponent("Text").text = skillConfig.Name

	local skillLevelCid = skillCid * 10 + 1
	local skillLevelCfg = CfgSkillLevelTable[skillLevelCid]
	local skillDescText = UIGlobalApi.GetDescribeMatchTable(skillLevelCfg.SkillTips, function(_index, _formatType)
		local curValue = skillLevelCfg.UpGradeOldValue[_index] ~= nil and skillLevelCfg.UpGradeOldValue[_index] or 0

		return UIGlobalApi.AnalysisDescribeArgsWithWildcard(_formatType, curValue)
	end)

	self.skillDetailText:GetComponent("Text").text = skillDescText
end

function SkillItem:Hide()
	self.gameObject:SetActive(false)
end

function SkillItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local EnemyItem = {
	monsterCid = 0
}

function EnemyItem.New(view, clickHandler)
	local obj = Clone(EnemyItem)

	obj:__Init(view, clickHandler)

	return obj
end

function EnemyItem:__Init(view, clickHandler)
	self.gameObject = view
	self.__itemClickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__ShowEmpty()
	UIEventUtil.AddClickEventListener_Button(self, "ButtonRoot", self.__OnItemClickHandler)
end

function EnemyItem:__OnItemClickHandler()
	if self.monsterCid == 0 then
		return
	end

	if self.__itemClickHandler == nil then
		return
	end

	self.__itemClickHandler(self.monsterCid)
end

function EnemyItem:Show(monsterCid)
	self.gameObject:SetActive(true)

	self.monsterCid = monsterCid

	if self.monsterCid == 0 then
		self:__ShowEmpty()
	else
		self:__ShowMonster()
	end
end

function EnemyItem:__ShowEmpty()
	self.headIcon.gameObject:SetActive(false)
	self.elementIcon.gameObject:SetActive(false)
	self.selectTarget.gameObject:SetActive(false)
	self.selectBottomRoot.gameObject:SetActive(false)
end

function EnemyItem:__ShowMonster()
	local monsterCfg = CfgMonsterTable[self.monsterCid]

	self.headIcon.gameObject:SetActive(true)

	local headIconPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(monsterCfg.EntityID, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.headIcon:GetComponent(typeof(UnityEngine.UI.Image)))

	local elementPath = WarlockApi:GetElementIconPath(monsterCfg.Elements)

	if not LuaUtility.StrIsNullOrEmpty(elementPath) then
		self.elementIcon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, elementPath, self.elementIcon:GetComponent("Image"))
	else
		self.elementIcon.gameObject:SetActive(false)
	end
end

function EnemyItem:ChangeSelectState(isSelect)
	if self.monsterCid == 0 then
		return
	end

	self.selectTarget.gameObject:SetActive(isSelect)
	self.selectBottomRoot.gameObject:SetActive(isSelect)
end

function EnemyItem:Hide()
	self.gameObject:SetActive(false)
end

function EnemyItem:Dispose()
	EventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local View = {
	enemyItemTable = {},
	skillCidList = {},
	skillItemList = {}
}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.HeadRoot.transform, function(_trans, _index)
		local item = EnemyItem.New(_trans.gameObject, function(_monsterCid)
			self:__OnRefreshMonsterInfoShow(_monsterCid)
		end)

		table.insert(self.enemyItemTable, item)
	end)

	self.skillScrollAreaList = self.SkillScrollRect:GetComponent("ScrollAreaList")

	function self.skillScrollAreaList.onRenderCell(_cell)
		self:__OnRenderSkillItemCell(_cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:Hide()
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.CommonReturnBtnRoot, self)

	self.commonReturnBtn:SetHomeBtnState(false)
	self.commonReturnBtn:RegisterReturnEvent(self.DelegateOnClickCloseBtn)
end

function View:Show(monsterTeamData)
	self.teamWave = 1
	self.monsterTeamData = monsterTeamData

	self.gameObject:SetActive(true)
	self:__RefreshMonsterShow()
end

function View:__RefreshMonsterShow()
	local monsterTeamCid = self.monsterTeamData[self.teamWave]
	local monsters = CfgMonsterTeamTable[monsterTeamCid].MonsterTeam

	self.__showMonsterCid = 0

	ForArray(self.enemyItemTable, function(_index, _itemCell)
		local monsterCid = monsters[_index]

		_itemCell:Show(monsterCid)

		if self.__showMonsterCid == 0 and monsterCid ~= 0 then
			self.__showMonsterCid = monsterCid
		end
	end)
	self:__OnRefreshMonsterInfoShow(self.__showMonsterCid)
end

function View:__OnRefreshMonsterInfoShow(monsterCid)
	self.__showMonsterCid = monsterCid

	ForArray(self.enemyItemTable, function(_, _itemCell)
		local isSelect = _itemCell.monsterCid == self.__showMonsterCid

		_itemCell:ChangeSelectState(isSelect)
	end)

	local monsterCfg = CfgMonsterTable[self.__showMonsterCid]

	self.NameText:GetComponent("Text").text = monsterCfg.Name

	local isBoss = monsterCfg.MonsterType == 4

	self.BossTagRoot.gameObject:SetActive(isBoss)

	self.LevelText:GetComponent("Text").text = UIGlobalApi.GetLevelText(monsterCfg.Level)
	self.skillCidList = monsterCfg.SkillShow

	self.skillScrollAreaList:Refresh(#self.skillCidList)

	local headIconPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(monsterCfg.EntityID, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.RightHeadIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function View:__OnRenderSkillItemCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local skillItem = self.skillItemList[instanceID]

	if skillItem == nil then
		skillItem = SkillItem.New(cell.gameObject)
		self.skillItemList[instanceID] = skillItem
	end

	local skillCid = self.skillCidList[cell.index + 1]

	skillItem:Show(skillCid)
end

function View:__DisposeSkillView()
	self.commonReturnBtn:Dispose()

	self.skillScrollAreaList.onRenderCell = nil
	self.skillScrollAreaList = nil

	ForPairs(self.skillItemList, function(_, _item)
		_item:Dispose()
	end)
end

function View:Hide()
	self.gameObject:SetActive(false)
end

function View:Dispose()
	self:__DisposeSkillView()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return View

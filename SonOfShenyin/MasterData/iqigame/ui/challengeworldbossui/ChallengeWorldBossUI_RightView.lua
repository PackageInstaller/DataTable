-- chunkname: @IQIGame\\UI\\ChallengeWorldBossUI\\ChallengeWorldBossUI_RightView.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local MonsterHeadItem = {
	__monsterCid = 0
}

function MonsterHeadItem.New(view, clickHandler)
	local obj = Clone(MonsterHeadItem)

	obj:__Init(view, clickHandler)

	return obj
end

function MonsterHeadItem:__Init(view, clickHandler)
	self.__gameObject = view
	self.__clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.__gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "ItemBtn", self.__OnItemClicked)
end

function MonsterHeadItem:__OnItemClicked()
	if self.__clickHandler == nil then
		return
	end

	self.__clickHandler(self.__monsterCid)
end

function MonsterHeadItem:IsFree()
	return self.__monsterCid == 0
end

function MonsterHeadItem:Show(monsterCid)
	self.__monsterCid = monsterCid

	if self.__monsterCid == 0 then
		self:Hide()

		return
	end

	self.__gameObject:SetActive(true)

	local monsterCfg = CfgMonsterTable[monsterCid]
	local headIconPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(monsterCfg.EntityID, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))
	self.BossTag.gameObject:SetActive(monsterCfg.MonsterType == 4)
end

function MonsterHeadItem:Hide()
	self.__gameObject:SetActive(false)
end

function MonsterHeadItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.__gameObject, self)

	self.__gameObject = nil
end

local EntriesItem = {
	__entryCid = 0
}

function EntriesItem.New(view, clickHandler)
	local obj = Clone(EntriesItem)

	obj:__Init(view, clickHandler)

	return obj
end

function EntriesItem:__Init(view, clickHandler)
	self.__gameObject = view
	self.__clickHandler = clickHandler

	LuaCodeInterface.BindOutlet(self.__gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "ItemBtn", self.__OnItemClicked)
end

function EntriesItem:__OnItemClicked()
	if self.__clickHandler == nil then
		return
	end

	self.__clickHandler(self.__entryCid)
end

function EntriesItem:IsFree()
	return self.__entryCid == 0
end

function EntriesItem:Show(entryCid)
	self.__entryCid = entryCid

	if self.__entryCid == 0 then
		self:Hide()

		return
	end

	local skillDescription = CfgSkillDescriptionTable[entryCid]

	self.Text:GetComponent("Text").text = skillDescription.EffectName

	self.__gameObject:SetActive(true)
end

function EntriesItem:Hide()
	self.__gameObject:SetActive(false)
end

function EntriesItem:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.__gameObject, self)

	self.__gameObject = nil
end

local View = {
	rewardItems = {}
}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.MonsterHeadTemplate.gameObject:SetActive(false)

	self.monsterHeadPool = UIViewObjectPool.New(self.MonsterHeadTemplate, nil, function(_view)
		return MonsterHeadItem.New(_view, function(_monsterCid)
			self:__OnMonsterHeadClicked(_monsterCid)
		end)
	end)

	self.EntriesItemTemplate.gameObject:SetActive(false)

	self.entriesItemPool = UIViewObjectPool.New(self.EntriesItemTemplate, nil, function(_view)
		return EntriesItem.New(_view, function(_entryCid)
			self:__OnEntryItemClicked(_entryCid)
		end)
	end)

	ForTransformChild(self.RewardItemRoot.transform, function(_trans, _index)
		local itemCell = ItemCell.New(_trans.gameObject, true, true, true)

		itemCell.showMoneyNum = true

		table.insert(self.rewardItems, itemCell)
	end)
	UIEventUtil.AddClickEventListener_Button(self, "StartBtn", self.__OnStartBtnClickHandler)
end

function View:Show(chapterCid, stageCfg, rankData, goalieData)
	self.__chapterCid = chapterCid
	self.__stageCid = stageCfg.Id

	self.gameObject:SetActive(true)

	self.EnglishNameText:GetComponent("Text").text = stageCfg.Describe
	self.ChapterNameText:GetComponent("Text").text = stageCfg.Describe
	self.LevelText:GetComponent("Text").text = stageCfg.BossLevel

	self:__RefreshMonsterShow(stageCfg)
	self:__RefreshEntriesShow(stageCfg)
	self:__RefreshAwardItemShow(stageCfg)

	if rankData.myRanking == -1 then
		self.descParentRoot.gameObject:SetActive(false)

		return
	end

	self.descParentRoot.gameObject:SetActive(true)

	if rankData.rankType == Constant.CenterRankRankType.Specific then
		self.DescContentText.gameObject:SetActive(true)
		self.OrderText.gameObject:SetActive(false)

		self.DescContentText:GetComponent("Text").text = rankData.myRanking
	else
		self.OrderText.gameObject:SetActive(true)
		self.DescContentText.gameObject:SetActive(false)

		local cfg = ChallengeWorldBossModule.GetRankRangeCfgData(rankData.rankType, rankData.myRanking)

		self.OrderText:GetComponent("Text").text = cfg.RankRating
	end
end

function View:Hide()
	self.gameObject:SetActive(false)
end

function View:Dispose()
	UIEventUtil.ClearEventListener(self)
	self.monsterHeadPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.monsterHeadPool = nil

	self.entriesItemPool:Dispose(function(_item)
		_item:Dispose()
	end)

	self.entriesItemPool = nil

	ForArray(self.rewardItems, function(_index, _itemCell)
		_itemCell:Dispose()
	end)

	self.rewardItems = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function View:__RefreshMonsterShow(stageCfg)
	self.monsterHeadPool:ForItems(function(_item)
		_item:Hide()
	end)

	local monsters = CfgMonsterTeamTable[stageCfg.MonsterTeam[1]].MonsterTeam

	ForArray(monsters, function(_, _monsterCid)
		if _monsterCid == 0 then
			return
		end

		local headItem = self.monsterHeadPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		headItem:Show(_monsterCid)
	end)
end

function View:__OnMonsterHeadClicked(monsterCid)
	EventDispatcher.Dispatch(EventID.ChallengeWorldBossUI_MonsterItemClick, self.__chapterCid, self.__stageCid, monsterCid)
end

function View:__RefreshEntriesShow(stageCfg)
	self.entriesItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	ForArray(stageCfg.AffixBuff, function(_, _cid)
		local entryItem = self.entriesItemPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		entryItem:Show(_cid)
	end)
end

function View:__OnEntryItemClicked(entryCid)
	EventDispatcher.Dispatch(EventID.ChallengeWorldBossUI_EntryItemClick, entryCid)
end

function View:__RefreshAwardItemShow(stageCfg)
	ForArray(self.rewardItems, function(_index, _itemCell)
		local cfgIndex = (_index - 1) * 2 + 1
		local itemCid = GetArrayValue(stageCfg.KillReward, cfgIndex, 0)

		if itemCid == 0 then
			_itemCell:Hide()

			return
		end

		local itemCount = GetArrayValue(stageCfg.KillReward, cfgIndex + 1, 1)

		_itemCell:SetItemByCid(itemCid, itemCount)
	end)
end

function View:__OnStartBtnClickHandler()
	local userData = {}

	userData.OpenType = 1
	userData.ChapterType = Constant.ChapterPassType.Type_ChallengeWorldBoss
	userData.StageId = self.__stageCid

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

return View

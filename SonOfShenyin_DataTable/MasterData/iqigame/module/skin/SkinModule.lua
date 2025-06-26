-- chunkname: @IQIGame\\Module\\Skin\\SkinModule.lua

SkinModule = {
	__heroSkinData = {},
	__heroSkinUnlockItemData = {}
}
SkinModule.SpinePreviewAnimationList = {
	{
		[1] = "idle",
		[2] = 2
	},
	{
		[1] = "born"
	},
	{
		[1] = "idle",
		[2] = 2
	},
	{
		[1] = "ready_1"
	},
	{
		[1] = "idle",
		[2] = 2
	},
	{
		[1] = "win"
	}
}

function SkinModule.Initialize()
	SkinModule.__InitHeroSkinData()
	SkinModule.OnAddListeners()

	SkinModule.ShowAppearanceSkinList = {}
end

function SkinModule.Shutdown()
	SkinModule.OnRemoveListeners()

	SkinModule.ShowAppearanceSkinList = {}
end

function SkinModule.OnAddListeners()
	EventDispatcher.AddEventListener(EventID.AddItem, SkinModule.CheckSkinItemAdd)
	EventDispatcher.AddEventListener(EventID.DeleteItem, SkinModule.CheckSkinItemRemove)
	EventDispatcher.AddEventListener(EventID.UpdateItem, SkinModule.CheckSkinItemUpdate)
end

function SkinModule.OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.AddItem, SkinModule.CheckSkinItemAdd)
	EventDispatcher.RemoveEventListener(EventID.DeleteItem, SkinModule.CheckSkinItemRemove)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, SkinModule.CheckSkinItemUpdate)
end

function SkinModule.CheckSkinItemAdd(addItems)
	for _, itemData in pairs(addItems) do
		local isSkinItem, skinCid = SkinModule.CheckIsSkinItem(itemData)

		if isSkinItem then
			EventDispatcher.Dispatch(EventID.AddSkinItem, skinCid)
			log("皮肤系统 - 获得皮肤道具 : skinCid={0}  item.Id={1}", skinCid, itemData.id)
		end
	end
end

function SkinModule.CheckSkinItemRemove(removeItems)
	for _, itemData in pairs(removeItems) do
		local isSkinItem, skinCid = SkinModule.CheckIsSkinItem(itemData)

		if isSkinItem then
			EventDispatcher.Dispatch(EventID.RemoveSkinItem, skinCid)
			log("皮肤系统 - 移除皮肤道具 : skinCid={0}  item.Id={1}", skinCid, itemData.id)
		end
	end
end

function SkinModule.CheckSkinItemUpdate(updateItems)
	for _, itemData in pairs(updateItems) do
		local isSkinItem, skinCid = SkinModule.CheckIsSkinItem(itemData)

		if isSkinItem then
			EventDispatcher.Dispatch(EventID.UpdateSkinItem, skinCid)
			log("皮肤系统 - 更新皮肤道具 : skinCid={0}  item.Id={1}", skinCid, itemData.id)
		end
	end
end

function SkinModule.GetAllSkinGroupFromPlayerByHeroCid(heroCid)
	local skinGroups = {}
	local allSkinItems = WarehouseModule.GetAllItemsByTypeAndSubType(Constant.ItemType.Skin, nil)
	local skinCid, skinConfig, itemConfig

	for _, itemData in pairs(allSkinItems) do
		itemConfig = itemData:GetCfg()
		skinCid = itemConfig.LikeId
		skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

		if skinConfig ~= nil and heroCid == skinConfig.HeroId then
			if skinGroups[skinConfig.SkinsId] == nil then
				skinGroups[skinConfig.SkinsId] = {}
			end

			if itemConfig.ItemSubTypes == 1 then
				skinGroups[skinConfig.SkinsId][Constant.SkinType.StaticImage] = SkinModule.GenerateSkinPOD(heroCid, itemData.id, itemData.cid, skinCid)
			end

			if itemConfig.ItemSubTypes == 2 then
				skinGroups[skinConfig.SkinsId][Constant.SkinType.SpineElementEntity] = SkinModule.GenerateSkinPOD(heroCid, itemData.id, itemData.cid, skinCid)
			end
		end
	end

	return skinGroups
end

function SkinModule.GetAllSkinGroupFromConfigTableByHeroCid(heroCid)
	local skinGroups = {}

	for skinCid, skinConfig in pairs(CfgHeroSkinTable) do
		if heroCid == skinConfig.HeroId and skinConfig.IsShow == 1 then
			if skinGroups[skinConfig.SkinsId] == nil then
				skinGroups[skinConfig.SkinsId] = {}
			end

			if skinConfig.SkinType == Constant.SkinType.StaticImage then
				skinGroups[skinConfig.SkinsId][Constant.SkinType.StaticImage] = SkinModule.GenerateSkinPOD(heroCid, 0, nil, skinCid)
			end

			if skinConfig.SkinType == Constant.SkinType.SpineElementEntity then
				skinGroups[skinConfig.SkinsId][Constant.SkinType.SpineElementEntity] = SkinModule.GenerateSkinPOD(heroCid, 0, nil, skinCid)
			end
		end
	end

	return skinGroups
end

function SkinModule.GetHeroCurrentSkinGroupFromPlayerByHeroCid(heroCid)
	local warlockData = WarlockModule.WarlockDataDic[heroCid]

	if warlockData ~= nil then
		return warlockData:GetCurSkinPODs()
	else
		logError("皮肤系统 - 玩家未持有heroCid={0}的角色，因此无法获取其装备中的皮肤信息.", heroCid)
	end

	return nil
end

function SkinModule.GetHeroDefaultSkinGroupFromConfigTableByHeroCid(heroCid)
	local defaultSkins = SkinModule.GetDefaultSkinsByHeroCid(heroCid)

	if defaultSkins ~= nil then
		local staticImageSkinPOD = SkinModule.GenerateSkinPOD(heroCid, 0, 0, 0)
		local spineSkinPOD = SkinModule.GenerateSkinPOD(heroCid, 0, 0, 0)

		for _, skinCid in pairs(defaultSkins) do
			if SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid) then
				staticImageSkinPOD.skinCid = tonumber(skinCid)
				staticImageSkinPOD.itemCid = SkinModule.GetSkinItemCidBySkinCid(skinCid)
			end

			if SkinModule.IsSpineSkinBySkinCid(skinCid) then
				spineSkinPOD.skinCid = tonumber(skinCid)
				spineSkinPOD.itemCid = SkinModule.GetSkinItemCidBySkinCid(skinCid)
			end
		end

		if staticImageSkinPOD.skinCid == 0 or spineSkinPOD.skinCid == 0 then
			logError("皮肤系统 - Hero表中 ID={0} 单位的 默认皮肤表（Hero.skin参数） 配置错误，至少需要配置 一个立绘皮肤及Spine皮肤.", heroCid)
		end

		local skinGroup = {
			[Constant.SkinType.StaticImage] = staticImageSkinPOD,
			[Constant.SkinType.SpineElementEntity] = spineSkinPOD
		}

		return skinGroup
	end

	return nil
end

function SkinModule.GetSkinItemDataBySkinCid(skinCid)
	local allSkinItems = WarehouseModule.GetAllItemsByTypeAndSubType(Constant.ItemType.Skin)

	for _, itemData in pairs(allSkinItems) do
		if itemData:GetCfg().LikeId == skinCid then
			return itemData
		end
	end

	return nil
end

function SkinModule.GetSkinConfigBySkinCid(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local skinConfig = CfgHeroSkinTable[skinCid]

	if skinConfig == nil then
		logError("皮肤系统 - 无法从Skin表获取到 ID={0} 的数据. 请检查 传参或配表 是否正确.", skinCid)
	end

	return skinConfig
end

function SkinModule.GetSkinTypeBySkinCid(skinCid)
	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil then
		return skinConfig.SkinType
	end

	return -1
end

function SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil and skinConfig.SkinType == Constant.SkinType.StaticImage then
		return true
	end

	return false
end

function SkinModule.IsSpineSkinBySkinCid(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil and skinConfig.SkinType == Constant.SkinType.SpineElementEntity then
		return true
	end

	return false
end

function SkinModule.GetDefaultSkinsByHeroCid(heroCid)
	local heroConfig = CfgHeroTable[heroCid]

	if heroConfig ~= nil then
		return heroConfig.Skin
	else
		logError("皮肤系统 - 无法在 Hero表 找到ID={0} 的数据. 请检查 传参或配表是否正确.", heroCid)
	end

	return nil
end

function SkinModule.GetSkinItemCidBySkinCid(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	for _, itemConfig in pairs(CfgItemTable) do
		if itemConfig.ItemTypes == Constant.ItemType.Skin and itemConfig.LikeId == skinCid then
			return itemConfig.Id
		end
	end

	logError("皮肤系统 - 无法找到 skin.ID={0} 对应的 道具. 所有在Skin表中配置的皮肤，理应对应在Item表内存在对应道具.", skinCid)

	return 0
end

function SkinModule.GetSkinCidBySkinItemCid(skinItemCid)
	if type(skinItemCid) == "string" then
		skinItemCid = tonumber(skinItemCid)
	end

	local itemConfig = CfgItemTable[skinItemCid]

	if itemConfig ~= nil then
		if itemConfig.ItemTypes == Constant.ItemType.Skin then
			return tonumber(itemConfig.LikeId)
		else
			logError("皮肤系统 - itemCid={0} 不属于 ItemTypes={1} 皮肤物品.", skinItemCid, Constant.ItemType.Skin)
		end
	else
		logError("皮肤系统 - 无法从Item表找到 ID={0} 的物品.", skinItemCid)
	end

	return 0
end

function SkinModule.GetHeroCidBySkinCid(skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	return tonumber(skinConfig.HeroId)
end

function SkinModule.GetSkinGroupCidBySkinCid(skinCid)
	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil then
		return skinConfig.SkinsId
	end

	return 0
end

function SkinModule.GetSkinStateByHeroCidAndSkinCid(heroCid, skinCid)
	local skinItemData = SkinModule.GetSkinItemDataBySkinCid(skinCid)

	if skinItemData ~= nil then
		if WarlockModule.WarlockDataDic[heroCid] ~= nil then
			local skinPODs = SkinModule.GetHeroCurrentSkinGroupFromPlayerByHeroCid(heroCid)

			for _, skinPOD in pairs(skinPODs) do
				if skinPOD.skinCid == skinCid then
					return Constant.SkinState.OwnedAndEquipping
				end
			end

			return Constant.SkinState.OwnedAndNotEquipping
		else
			return Constant.SkinState.OwnedAndNotEquipping
		end
	else
		local skinItemCid = SkinModule.GetSkinItemCidBySkinCid(skinCid)
		local skinItemConfig = CfgItemTable[skinItemCid]

		if skinItemConfig ~= nil then
			local skinItemSource = skinItemConfig.Source

			if skinItemSource ~= nil and getTableLength(skinItemSource) > 0 then
				return Constant.SkinState.NotOwnAndCanGet
			end
		end

		return Constant.SkinState.NotOwnAndCanNotGet
	end
end

function SkinModule.IsHeroEquippingTargetSkinCid(heroCid, skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	local heroEquippingSkinPODs = SkinModule.GetHeroCurrentSkinGroupFromPlayerByHeroCid(heroCid)

	if heroEquippingSkinPODs ~= nil then
		for _, skinPOD in pairs(heroEquippingSkinPODs) do
			if skinPOD.skinCid == skinCid then
				return true
			end
		end
	end

	return false
end

function SkinModule.GenerateSkinPOD(heroCid, id, itemCid, skinCid)
	if type(itemCid) == "string" then
		itemCid = tonumber(itemCid)
	end

	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	if (itemCid == nil or itemCid == 0) and skinCid ~= nil and skinCid ~= 0 then
		itemCid = SkinModule.GetSkinItemCidBySkinCid(skinCid)
	end

	if (skinCid == nil or skinCid == 0) and itemCid ~= nil and itemCid ~= 0 then
		skinCid = SkinModule.GetSkinCidBySkinItemCid(itemCid)
	end

	if (heroCid == nil or heroCid == 0) and skinCid ~= nil and skinCid ~= 0 then
		local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

		heroCid = skinConfig.HeroId
	end

	local skinPOD = {
		id = id,
		heroCid = heroCid,
		itemCid = itemCid,
		skinCid = skinCid
	}

	return skinPOD
end

function SkinModule.CheckIsSkinItem(itemData)
	if itemData ~= nil then
		local itemConfig = itemData:GetCfg()

		if itemConfig ~= nil and itemConfig.ItemTypes == Constant.ItemType.Skin then
			return true, tonumber(itemConfig.LikeId)
		end
	end

	return false, 0
end

function SkinModule.OpenSkinPreviewUI(...)
	local skinData = ...
	local skinPreviewUIUserData = {}

	if type(skinData) == "number" then
		if SkinModule.GetSkinConfigBySkinCid(skinData) ~= nil then
			table.insert(skinPreviewUIUserData, skinData)
		end
	elseif type(skinData) == "table" then
		for _, skinCid in pairs(skinData) do
			if SkinModule.GetSkinConfigBySkinCid(skinCid) ~= nil then
				table.insert(skinPreviewUIUserData, skinCid)
			end
		end
	end

	if getTableLength(skinPreviewUIUserData) > 0 then
		UIModule.Open(Constant.UIControllerName.SkinPreviewUI, Constant.UILayer.UI, skinPreviewUIUserData)
	end
end

function SkinModule.GeneratePlaySpineAnimationCoroutine(skeletonAnimation)
	if skeletonAnimation == nil then
		logError("SkinModule.GeneratePlaySpineAnimationCoroutine : skeletonAnimation is nil.")

		return nil
	end

	return CoroutineUtility.CreateCoroutine(function()
		local animationQueue = Queue.New()

		while true do
			if skeletonAnimation == nil then
				break
			end

			if animationQueue.Size == 0 then
				for _, data in pairs(SkinModule.SpinePreviewAnimationList) do
					animationQueue:Enqueue(data)
				end
			end

			local animationData = animationQueue:Dequeue()
			local animName, animDuration = animationData[1], animationData[2]
			local animData = skeletonAnimation.state.Data.SkeletonData:FindAnimation(animName)

			if animData ~= nil then
				if animDuration == nil then
					animDuration = animData.Duration
				end

				SkinModule.SetPlaySpineAnimation(skeletonAnimation, animName, false)
				CoroutineUtility.Yield(CustomWaitForSeconds(animDuration))
			else
				logError("皮肤系统 - 单位 skeletonAnimation={0} skeletonAnimation.parent={1} 的Spine上 缺失 {2} 动画.", skeletonAnimation.gameObject.name, skeletonAnimation.transform.parent.gameObject.name, animName)
			end
		end
	end)
end

function SkinModule.SetPlaySpineAnimation(skeletonAnimation, animationName, isLoop)
	if skeletonAnimation ~= nil then
		if skeletonAnimation.state ~= nil then
			local animData = skeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

			if animData ~= nil then
				if isLoop == nil then
					isLoop = false
				end

				if skeletonAnimation.AnimationName ~= animationName then
					skeletonAnimation.state:SetAnimation(0, animationName, isLoop)
				else
					skeletonAnimation.state:AddAnimation(0, animationName, isLoop, 0)
				end
			end
		else
			logError("play spine animation error, state is null. Animation name: " .. animationName .. " gameObject: ")
		end
	end
end

function SkinModule.ChangeSkinBySkinCid(heroCid, skinCid)
	if type(skinCid) == "string" then
		skinCid = tonumber(skinCid)
	end

	if WarlockModule.WarlockDataDic[heroCid] ~= nil and SkinModule.IsHeroEquippingTargetSkinCid(heroCid, skinCid) then
		logError("皮肤系统 - 企图更换皮肤失败 : heroCid={0} 已经装备 skinCid={1} 中.", heroCid, skinCid)

		return
	end

	local skinItemData = SkinModule.GetSkinItemDataBySkinCid(skinCid)

	if skinItemData ~= nil then
		log("皮肤系统 - 请求更换 heroCid={0} skinCid={1} itemID={2} 的皮肤.", heroCid, skinCid, skinItemData.id)

		return SkinModule.ChangeSkin(heroCid, skinItemData.id)
	else
		logError("皮肤系统 - 玩家未拥有 skinCid={0} 的皮肤道具，无法更换.", skinCid)
	end

	return false
end

function SkinModule.ChangeSkin(heroCid, id)
	FormatRoleModule.CurChangeType = FormatRoleModule.Type.Skin

	return net_hero.changeSkin(heroCid, id)
end

function SkinModule.ChangeSkinResult()
	log("皮肤系统 - 更换皮肤成功.")
	EventDispatcher.Dispatch(EventID.ChangeSkinResult)
	NoticeModule.ShowNotice(20023)
end

function SkinModule.TEST_CheckToOpenGetSkinShowUI()
	local items = {
		{
			cid = 300102
		},
		{
			cid = 330102
		},
		{
			cid = 300202
		}
	}
end

function SkinModule.TEST_CheckSkinResourceLegally()
	local success = true

	local function checkStaticSkinImageResFunc()
		local START, END = Constant.SkinImageType.HeroResourcesVerticalDraw, Constant.SkinImageType.FormationShowImg

		for skinCid, _ in pairs(CfgHeroSkinTable) do
			if SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid) then
				for staticImageType = START, END do
					local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, staticImageType)

					if not GameEntry.Resource:HasAsset(path) then
						logError("【皮肤资源检查工具】\n缺失  {0}\n涉及表格：SkinID={1}  HeroSkinID={2}\n", path, skinCid, SkinModule.GetSkinConfigBySkinCid(skinCid).LinkId)

						success = false
					end
				end
			end
		end
	end

	checkStaticSkinImageResFunc()

	local function checkSpineResFunc()
		for skinCid, _ in pairs(CfgHeroSkinTable) do
			if SkinModule.IsSpineSkinBySkinCid(skinCid) then
				local elementEntityID = tonumber(SkinModule.GetSkinConfigBySkinCid(skinCid).LinkId)
				local elementEntityConfig = CfgElementEntityTable[elementEntityID]

				if elementEntityConfig ~= nil then
					local path = BattleApi:GetSpinePrefabUrl(elementEntityConfig.PrefabName)

					if not GameEntry.Resource:HasAsset(path) then
						logError("【皮肤资源检查工具】\n缺失  {0}\n涉及表格：SkinID={1}  ElementEntityID={2}\n", path, skinCid, elementEntityID)

						success = false
					end
				else
					logError("【皮肤资源检查工具】\n无法找到 ElementEntity.ID={0} 的数据段，请检查配表.\nSkinID={1}", elementEntityID, skinCid)

					success = false
				end
			end
		end
	end

	checkSpineResFunc()

	local function checkSkinCidMatchWithItemCid()
		for skinCid, _ in pairs(CfgHeroSkinTable) do
			if SkinModule.IsHeroStaticImageSkinBySkinCid(skinCid) or SkinModule.IsSpineSkinBySkinCid(skinCid) then
				local skinItemCid = SkinModule.GetSkinItemCidBySkinCid(skinCid)

				if skinItemCid == 0 then
					logError("【皮肤资源检查工具】\n无法在Item表中找到 SkinID={0} 对应的道具.", skinCid)

					success = false
				end
			end
		end
	end

	checkSkinCidMatchWithItemCid()

	return success
end

function SkinModule.IsSkinItemByItemCid(itemCid)
	local itemCfg = CfgItemTable[itemCid]

	if itemCfg == nil then
		return false
	end

	return SkinModule.IsSkinItemByItemCfg(itemCfg)
end

function SkinModule.IsSkinItemByItemCfg(itemCfg)
	if itemCfg.ItemTypes ~= Constant.ItemType.Skin then
		return false
	end

	if itemCfg.ItemSubTypes ~= Constant.ItemSubType[Constant.ItemType.Skin].Normal then
		return false
	end

	return true, itemCfg.LikeId
end

function SkinModule.__InitHeroSkinData()
	SkinModule.__heroSkinData = {}
	SkinModule.__heroSkinUnlockItemData = {}

	ForPairs(CfgHeroSkinTable, function(_skinCid, _skinConfig)
		local heroCid = _skinConfig.HeroId

		if SkinModule.__heroSkinData[heroCid] == nil then
			SkinModule.__heroSkinData[heroCid] = {}
		end

		if _skinConfig.IsShow == 1 then
			table.insert(SkinModule.__heroSkinData[heroCid], _skinCid)
		end
	end)
	ForPairs(CfgItemTable, function(_itemCid, _itemCfg)
		local isSkinItem, _ = SkinModule.IsSkinItemByItemCfg(_itemCfg)

		if not isSkinItem then
			return
		end

		if _itemCfg.LikeId == nil then
			logError("皮肤配置 _itemCfg {0} LikeId 字段为 nil", _itemCid)

			return
		end

		SkinModule.__heroSkinUnlockItemData[_itemCfg.LikeId] = _itemCid
	end)
end

function SkinModule.GetHeroSkinList(heroCid)
	return SkinModule.__heroSkinData[heroCid]
end

function SkinModule.GetHeroSkinUnlockItemCid(skinCid)
	return SkinModule.__heroSkinUnlockItemData[skinCid]
end

function SkinModule.SkinIsUnlock(skinCid)
	local itemCid = SkinModule.__heroSkinUnlockItemData[skinCid]
	local itemData = WarehouseModule.GetItemDataByCfgID(itemCid)

	if itemData == nil then
		return false
	end

	return true
end

function SkinModule.GetSpeakTextBySex(actionData, showPosition)
	local speakData = {}
	local speakContentCfg = {}
	local cfgArray = {}

	if showPosition == Constant.DynamicSkinShowPosition.RoleDevelopmentPanel then
		cfgArray = actionData.RoleDevelopment
	elseif showPosition == Constant.DynamicSkinShowPosition.SkinPanel then
		cfgArray = actionData.SkinPanel
	elseif showPosition == Constant.DynamicSkinShowPosition.MobilePhone then
		cfgArray = actionData.MobilPhone
	elseif showPosition == Constant.DynamicSkinShowPosition.GetHero then
		cfgArray = actionData.GetHero
	elseif showPosition == Constant.DynamicSkinShowPosition.UserInfo then
		cfgArray = actionData.UserInfo
	elseif showPosition == Constant.DynamicSkinShowPosition.RoleInfoDetails then
		cfgArray = actionData.RoleInfoDetails
	elseif showPosition == Constant.DynamicSkinShowPosition.DetailsPreviewUI then
		cfgArray = actionData.DetailsPreviewUI
	elseif showPosition == Constant.DynamicSkinShowPosition.BattleResultUI then
		cfgArray = actionData.BattleResult
	elseif showPosition == Constant.DynamicSkinShowPosition.MobilePhone_Skin then
		cfgArray = actionData.MobilePhoneSkin
	end

	if PlayerModule.PlayerInfo.baseInfo.sex == Constant.PlayerSex.Man then
		table.insert(speakData, actionData.SpeakText[1])

		speakContentCfg = SkinModule.__GetSpeakContentCfg(cfgArray, 0)
	elseif PlayerModule.PlayerInfo.baseInfo.sex == Constant.PlayerSex.WoMen then
		table.insert(speakData, actionData.SpeakText[2])

		speakContentCfg = SkinModule.__GetSpeakContentCfg(cfgArray, 4)
	else
		table.insert(speakData, actionData.SpeakText[1])

		speakContentCfg.localPosition = Vector3.zero
		speakContentCfg.sizeDelta = Vector2.zero
	end

	return speakData, speakContentCfg
end

function SkinModule.__GetSpeakContentCfg(cfgArray, offset)
	local result = {}
	local beginIndex = offset + 1
	local x = GetArrayValue(cfgArray, beginIndex, 0)
	local y = GetArrayValue(cfgArray, beginIndex + 1, 0)
	local width = GetArrayValue(cfgArray, beginIndex + 2, 0)
	local height = GetArrayValue(cfgArray, beginIndex + 3, 0)

	result.localPosition = Vector3.New(x / 100, y / 100, 0)
	result.sizeDelta = Vector2.New(width / 100, height / 100)

	return result
end

function SkinModule.GetHeroDefaultSkinCfg(heroCid)
	local heroCfgData = CfgHeroTable[heroCid]
	local monsterCfgData = CfgMonsterTable[heroCfgData.MonsterId]

	return CfgHeroSkinTable[monsterCfgData.EntityID]
end

function SkinModule.GetHeroDefaultSkinImgPath(heroCid, skinImageType)
	local skinCfgData = SkinModule.GetHeroDefaultSkinCfg(heroCid)

	return SkinModule.GetHeroSkinImgPathByType(skinCfgData, skinImageType)
end

function SkinModule.GetHeroCurrentSkinConfig(heroCid)
	if heroCid > 0 then
		local heroData = WarlockModule.GetHeroData(heroCid)

		if heroData ~= nil then
			return CfgHeroSkinTable[heroData.heroSkin.skinCid]
		end

		logError("玩家英雄数据中找不到英雄数据:{0}", heroCid)
	end

	return CfgHeroSkinTable[CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]]
end

function SkinModule.GetMonsterSkinConfig(monsterCid)
	local monsterConfig = CfgMonsterTable[monsterCid]

	return CfgHeroSkinTable[monsterConfig.EntityID]
end

function SkinModule.GetHeroCurrentSkinImgPath(heroCid, skinImageType)
	local skinCfgData = SkinModule.GetHeroCurrentSkinConfig(heroCid)

	return SkinModule.GetHeroSkinImgPathByType(skinCfgData, skinImageType)
end

function SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, skinImageType)
	local heroSkinConfig = CfgHeroSkinTable[skinCid]

	return SkinModule.GetHeroSkinImgPathByType(heroSkinConfig, skinImageType)
end

function SkinModule.GetHeroSkinImgPathByType(heroSkinConfig, skinImageType)
	if skinImageType == Constant.SkinImageType.HeroResourcesVerticalDraw then
		return string.format(SkinApi:GetResUrl(1600006), heroSkinConfig.HeroResourcesVerticalDraw)
	elseif skinImageType == Constant.SkinImageType.HeadIcon then
		return string.format(SkinApi:GetResUrl(1600009), heroSkinConfig.HeadIcon)
	elseif skinImageType == Constant.SkinImageType.HeroResourcesHead then
		return string.format(SkinApi:GetResUrl(1600004), heroSkinConfig.HeroResourcesHead)
	elseif skinImageType == Constant.SkinImageType.FriendHeadImg then
		return string.format(SkinApi:GetResUrl(1600003), heroSkinConfig.FriendHeadImg)
	elseif skinImageType == Constant.SkinImageType.HeroSmartHead then
		return string.format(SkinApi:GetResUrl(1600008), heroSkinConfig.HeroSmartHead)
	elseif skinImageType == Constant.SkinImageType.HeroSkillChangeHeadImg then
		return string.format(SkinApi:GetResUrl(1600007), heroSkinConfig.HeroSkillChangeHeadImg)
	elseif skinImageType == Constant.SkinImageType.AssistInFightingImg then
		return string.format(SkinApi:GetResUrl(1600001), heroSkinConfig.AssistInFightingImg)
	elseif skinImageType == Constant.SkinImageType.HeroResourcesShowImg then
		return string.format(SkinApi:GetResUrl(1600005), heroSkinConfig.HeroResourcesShowImg)
	elseif skinImageType == Constant.SkinImageType.FormationShowImg then
		return string.format(SkinApi:GetResUrl(1600002), heroSkinConfig.FormationShowImg)
	elseif skinImageType == Constant.SkinImageType.DynamicPrefab then
		return UIGlobalApi.ElementSpinePath .. heroSkinConfig.DynamicPrefab
	elseif skinImageType == Constant.SkinImageType.HeroLotteryResources then
		return string.format(SkinApi:GetResUrl(2005), heroSkinConfig.HeroLotteryTenResources)
	elseif skinImageType == Constant.SkinImageType.DetailsHeadIcon then
		return string.format(SkinApi:GetResUrl(1600003), heroSkinConfig.DetailsHeadIcon)
	elseif skinImageType == Constant.SkinImageType.ShopShowImg then
		return string.format(SkinApi:GetResUrl(1600005), heroSkinConfig.ShopShowImg)
	elseif skinImageType == Constant.SkinImageType.DialogSpine then
		return heroSkinConfig.HeroTachie
	else
		logError("找不到皮肤表对应类型的皮肤 {0}", skinImageType)

		return ""
	end
end

function SkinModule.GetHeroDynamicSkinOffsetWithUIName(skinCid, showPosition)
	local discreteData = CfgHeroSkinDiscreteTable[skinCid]

	if discreteData == nil then
		return Vector3.zero, 1
	end

	return SkinModule.GetHeroDynamicSkinSpineOffset(discreteData, showPosition)
end

function SkinModule.GetHeroDynamicSkinSpineOffset(discreteData, showPosition)
	local posArray = {}

	if showPosition == Constant.DynamicSkinShowPosition.RoleDevelopmentPanel then
		posArray = discreteData.RoleDevelopmentPosition
	elseif showPosition == Constant.DynamicSkinShowPosition.SkinPanel then
		posArray = discreteData.SkinPanelPosition
	elseif showPosition == Constant.DynamicSkinShowPosition.MobilePhone then
		posArray = discreteData.MobilPhonePosition
	elseif showPosition == Constant.DynamicSkinShowPosition.GetHero then
		posArray = discreteData.GetHeroPosition
	elseif showPosition == Constant.DynamicSkinShowPosition.UserInfo then
		posArray = discreteData.UserInfoPosition
	elseif showPosition == Constant.DynamicSkinShowPosition.RoleInfoDetails then
		posArray = discreteData.RoleInfoDetails
	elseif showPosition == Constant.DynamicSkinShowPosition.DetailsPreviewUI then
		posArray = discreteData.DetailsPreviewUI
	elseif showPosition == Constant.DynamicSkinShowPosition.BattleResultUI then
		posArray = discreteData.BattleResult
	elseif showPosition == Constant.DynamicSkinShowPosition.MobilePhone_Skin then
		posArray = discreteData.MobilePhoneSkin
	end

	local x = GetArrayValue(posArray, 1, 0)
	local y = GetArrayValue(posArray, 2, 0)
	local scale = GetArrayValue(posArray, 3, 100)

	return Vector3.New(x / 100, y / 100, 0), scale / 100
end

function SkinModule.GetRandomSkinDisplayActionCid(actionCfgData)
	local actionCidList = SkinModule.__GetSkinDisplayActionCidWidthCfgData(actionCfgData)
	local cnt = #actionCidList

	if cnt == 0 then
		warning("皮肤表演动作组没有符合条件的配置")

		return 0
	end

	if cnt == 1 then
		return actionCidList[1]
	end

	local index = math.random(10, cnt * 10 + 9)
	local realIndex = math.modf(index / 10)

	return actionCidList[realIndex]
end

function SkinModule.__GetSkinDisplayActionCidWidthCfgData(cfgData)
	local actionCidList = {}

	ForArrayCustomStep(cfgData, function(_index, _groupCid)
		local conditionCid = cfgData[_index + 1]

		if not ConditionModule.Check(conditionCid) then
			return
		end

		table.insert(actionCidList, _groupCid)
	end, 2)

	return actionCidList
end

function SkinModule.CanShowAppearance(skinCid)
	local recordData = SkinModule.ShowAppearanceSkinList[skinCid]

	if recordData == true then
		return false
	end

	SkinModule.ShowAppearanceSkinList[skinCid] = true

	return true
end

function SkinModule.GetSkinCidByHeroSkinPOD(heroSkinPOD)
	if heroSkinPOD == nil then
		return CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
	end

	local skinCid = TryToNumber(heroSkinPOD.skinCid, 0)

	if skinCid == 0 then
		return CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
	end

	return skinCid
end

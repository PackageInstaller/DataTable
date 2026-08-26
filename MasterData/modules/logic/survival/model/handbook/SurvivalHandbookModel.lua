-- chunkname: @modules/logic/survival/model/handbook/SurvivalHandbookModel.lua

module("modules.logic.survival.model.handbook.SurvivalHandbookModel", package.seeall)

local SurvivalHandbookModel = class("SurvivalHandbookModel", BaseModel)

function SurvivalHandbookModel:onInit()
	self.handbookMoDic = nil
	self.subTypeMoDic = {}
	self.resultMos = {}
	self.progressDic = {}
	self.eventTypes = {}

	for i, v in pairs(SurvivalEnum.HandBookEventSubType) do
		table.insert(self.eventTypes, v)
	end

	self.amplifierTypes = {}

	for i, v in pairs(SurvivalEnum.HandBookAmplifierSubType) do
		table.insert(self.amplifierTypes, v)
	end

	self.npcTypes = {}

	for i, v in pairs(SurvivalEnum.HandBookNpcSubType) do
		table.insert(self.npcTypes, v)
	end

	self.roleStoryTypes = {}

	for i, v in pairs(SurvivalEnum.HandBookRoleSubType) do
		table.insert(self.roleStoryTypes, v)
	end

	local HandBookAmplifierSubType = SurvivalEnum.HandBookAmplifierSubType
	local HandBookNpcSubType = SurvivalEnum.HandBookNpcSubType

	self.handbookTypeCfg = {
		[SurvivalEnum.HandBookType.Amplifier] = {
			[HandBookAmplifierSubType.Common] = {
				tabImage = "99_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Common"
			},
			[HandBookAmplifierSubType.ElectricEnergy] = {
				tabImage = "101_1",
				tabTitle = "p_survivalhandbookview_txt_tab_ElectricEnergy"
			},
			[HandBookAmplifierSubType.Revelation] = {
				tabImage = "102_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Revelation"
			},
			[HandBookAmplifierSubType.Bloom] = {
				tabImage = "103_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Bloom"
			},
			[HandBookAmplifierSubType.ExtraActions] = {
				tabImage = "104_1",
				tabTitle = "p_survivalhandbookview_txt_tab_ExtraActions"
			},
			[HandBookAmplifierSubType.Ceremony] = {
				tabImage = "105_1",
				tabTitle = "p_survivalhandbookview_txt_tab_Ceremony"
			},
			[HandBookAmplifierSubType.StateAbnormal] = {
				tabImage = "106_1",
				tabTitle = "Survival_HandBookTitle_StateAbnormal"
			},
			RedDot = RedDotEnum.DotNode.SurvivalHandbookAmplifier
		},
		[SurvivalEnum.HandBookType.Npc] = {
			[HandBookNpcSubType.People] = {
				tabImage = "survival_handbook_npctabicon4",
				tabTitle = "p_survivalhandbookview_txt_tab_People"
			},
			[HandBookNpcSubType.Laplace] = {
				tabImage = "survival_handbook_npctabicon2",
				tabTitle = "p_survivalhandbookview_txt_tab_Laplace"
			},
			[HandBookNpcSubType.Foundation] = {
				tabImage = "survival_handbook_npctabicon1",
				tabTitle = "p_survivalhandbookview_txt_tab_Foundation"
			},
			[HandBookNpcSubType.Zeno] = {
				tabImage = "survival_handbook_npctabicon3",
				tabTitle = "p_survivalhandbookview_txt_tab_Zeno"
			},
			RedDot = RedDotEnum.DotNode.SurvivalHandbookNpc
		},
		[SurvivalEnum.HandBookType.Event] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookEvent
		},
		[SurvivalEnum.HandBookType.Result] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookResult
		},
		[SurvivalEnum.HandBookType.Story] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookStory
		},
		[SurvivalEnum.HandBookType.Collection] = {
			RedDot = RedDotEnum.DotNode.SurvivalHandbookCollect
		}
	}
	self.StoryTabRedDot = {
		RedDotEnum.DotNode.SurvivalHandbookStory_1,
		RedDotEnum.DotNode.SurvivalHandbookStory_2
	}
	self.StoryFragmentRedDot = {
		RedDotEnum.DotNode.SurvivalHandbookStory_1_Fragment,
		RedDotEnum.DotNode.SurvivalHandbookStory_2_Fragment
	}
	self.StoryFragmentSubType = {
		{
			SurvivalEnum.HandBookRoleSubType.Role_1_1,
			SurvivalEnum.HandBookRoleSubType.Role_1_2
		},
		{
			SurvivalEnum.HandBookRoleSubType.Role_2_1,
			SurvivalEnum.HandBookRoleSubType.Role_2_2
		}
	}
end

function SurvivalHandbookModel:reInit()
	self.handbookMoDic = nil
	self.subTypeMoDic = {}
	self.resultMos = {}
end

function SurvivalHandbookModel:setSurvivalHandbookBox(survivalHandbookBox)
	self:_parseBasicData()

	self.cellMoDic = {}

	local unlock = {}

	if survivalHandbookBox then
		local list = survivalHandbookBox.handbook

		for i, handbook in ipairs(list) do
			local id = handbook.id
			local isNew = handbook.isNew
			local mo = self.handbookMoDic[id]

			if mo then
				local isValid = true

				if mo:getType() == SurvivalEnum.HandBookType.Amplifier and handbook.param then
					local equipCo = lua_survival_equip.configDict[handbook.param]

					if not mo:isLinkGroup(equipCo.group) then
						isValid = false
					end
				end

				if isValid then
					mo:setCellCfgId(handbook.param)
					mo:setIsNew(isNew)
					mo:setStoryStatus(handbook.status)

					unlock[id] = true

					if handbook.param then
						self.cellMoDic[handbook.param] = mo
					end
				end
			else
				logError("配置表没有id：" .. tostring(id) .. " i:" .. i)
			end
		end
	end

	for i, v in pairs(self.handbookMoDic) do
		v:setIsUnlock((v:getType() == SurvivalEnum.HandBookType.Story and not v:isCanFinishStory() or nil) and true)
	end

	tabletool.clear(self.progressDic)

	for i, v in pairs(self.handbookMoDic) do
		local type = v:getType()

		if self.progressDic[type] == nil then
			self.progressDic[type] = {
				progress = 0,
				amount = 0
			}
		end

		self.progressDic[type].amount = self.progressDic[type].amount + 1

		if v.isUnlock then
			self.progressDic[type].progress = self.progressDic[type].progress + 1
		end
	end

	self:refreshRedDot()

	self.inheritSelectDic = {}
	self.inheritSelectList = {}
	self.inheritSubTypeMoDic = {}

	for id, _ in pairs(unlock) do
		local cfg = lua_survival_handbook.configDict[id]
		local type = cfg.type

		if type == SurvivalEnum.HandBookType.Amplifier then
			local mainMo = self.handbookMoDic[id]
			local mainItemId = mainMo:getCellCfgId()
			local mainSubtype = cfg.subtype
			local mainItemCfg = lua_survival_item.configDict[mainItemId]
			local mainItemRare = mainItemCfg.rare

			if mainMo:getSurvivalBagItemMo():getExtendCost() > 0 then
				self:insetInheritMo(mainItemId, mainSubtype, mainMo)
			end

			local link = cfg.link
			local cfgs = SurvivalConfig.instance:getEquipByGroup(link)

			for i, v in ipairs(cfgs) do
				local itemId = v.id

				if itemId ~= mainItemId then
					local itemCfg = lua_survival_item.configDict[itemId]
					local rare = itemCfg.rare

					if rare <= mainItemRare then
						local mo = SurvivalHandbookMo.New()

						mo:setData(mainMo.cfg)
						mo:setCellCfgId(itemId)
						mo:setIsNew(mainMo.isNew)
						mo:setIsUnlock(mainMo.isUnlock)

						if mo:getSurvivalBagItemMo():getExtendCost() > 0 then
							self:insetInheritMo(itemId, mainSubtype, mo)
						end
					end
				end
			end
		end
	end

	self.inheritSubTypeNpcList = {}

	for subType, dic in pairs(self.subTypeMoDic[SurvivalEnum.HandBookType.Npc]) do
		self.inheritSubTypeNpcList[subType] = {}

		for id, mo in pairs(dic) do
			if mo.isUnlock then
				local itemMo = mo:getSurvivalBagItemMo()

				if itemMo:getExtendCost() > 0 then
					table.insert(self.inheritSubTypeNpcList[subType], mo)
				end
			end
		end
	end
end

function SurvivalHandbookModel:insetInheritMo(cellId, subtype, mo)
	self.inheritSelectDic[cellId] = mo

	table.insert(self.inheritSelectList, mo)

	if self.inheritSubTypeMoDic[subtype] == nil then
		self.inheritSubTypeMoDic[subtype] = {}
	end

	table.insert(self.inheritSubTypeMoDic[subtype], mo)
end

function SurvivalHandbookModel:getInheritMoById(cellId)
	if self.inheritSelectDic[cellId] then
		return self.inheritSelectDic[cellId]
	else
		return self.cellMoDic[cellId]
	end
end

function SurvivalHandbookModel:getInheritHandBookDatas(handbookType, subType)
	local data = {}

	if handbookType == SurvivalEnum.HandBookType.Amplifier then
		data = self.inheritSubTypeMoDic[subType]
	elseif handbookType == SurvivalEnum.HandBookType.Npc then
		data = self.inheritSubTypeNpcList[subType]
	end

	return data or {}
end

function SurvivalHandbookModel:getMoById(id)
	return self.handbookMoDic[id]
end

function SurvivalHandbookModel:getProgress(type)
	return self.progressDic[type]
end

function SurvivalHandbookModel:onReceiveSurvivalMarkNewHandbookReply(resultCode, msg)
	if resultCode == 0 then
		for i, id in ipairs(msg.ids) do
			if self.handbookMoDic[id] then
				self.handbookMoDic[id]:setIsNew(false)
			else
				logError("??")
			end
		end
	end

	self:refreshRedDot()
end

function SurvivalHandbookModel:refreshRedDot()
	local redDotInfoList = {}

	self.eventRedDots = {}

	local total = 0

	for i, subType in ipairs(self.eventTypes) do
		local redDot = self:getRedDot(SurvivalEnum.HandBookType.Event, subType)

		self.eventRedDots[subType] = redDot

		table.insert(redDotInfoList, {
			id = RedDotEnum.DotNode.SurvivalHandbookEvent,
			uid = subType,
			value = redDot
		})

		total = total + redDot
	end

	table.insert(redDotInfoList, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookEvent,
		value = total
	})

	self.amplifierRedDots = {}
	total = 0

	for i, subType in ipairs(self.amplifierTypes) do
		local redDot = self:getRedDot(SurvivalEnum.HandBookType.Amplifier, subType)

		self.amplifierRedDots[subType] = redDot

		table.insert(redDotInfoList, {
			id = RedDotEnum.DotNode.SurvivalHandbookAmplifier,
			uid = subType,
			value = redDot
		})

		total = total + redDot
	end

	table.insert(redDotInfoList, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookAmplifier,
		value = total
	})

	self.npcRedDots = {}
	total = 0

	for i, subType in ipairs(self.npcTypes) do
		local redDot = self:getRedDot(SurvivalEnum.HandBookType.Npc, subType)

		self.npcRedDots[subType] = redDot

		table.insert(redDotInfoList, {
			id = RedDotEnum.DotNode.SurvivalHandbookNpc,
			uid = subType,
			value = redDot
		})

		total = total + redDot
	end

	table.insert(redDotInfoList, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookNpc,
		value = total
	})

	local redDot = self:getRedDot(SurvivalEnum.HandBookType.Result)

	table.insert(redDotInfoList, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookResult,
		value = redDot
	})

	for i, redDot in ipairs(self.StoryFragmentRedDot) do
		local subTypes = self.StoryFragmentSubType[i]

		for j, subType in ipairs(subTypes) do
			local redDotValue = self:getRedDot(SurvivalEnum.HandBookType.Story, subType)

			table.insert(redDotInfoList, {
				id = redDot,
				uid = subType,
				value = redDotValue
			})
		end
	end

	total = self:getRedDot(SurvivalEnum.HandBookType.Collection, 0)

	table.insert(redDotInfoList, {
		uid = -1,
		id = RedDotEnum.DotNode.SurvivalHandbookCollect,
		value = total
	})
	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function SurvivalHandbookModel:getRedDot(type, subType)
	local ids = self:getNewHandbook(type, subType)

	if #ids > 0 then
		return 1
	end

	return 0
end

function SurvivalHandbookModel:getHandBookDatas(type, subType)
	if self.subTypeMoDic[type] == nil or self.subTypeMoDic[type][subType] == nil then
		self:_parseBasicData()
	end

	if not self.subTypeMoDic[type][subType] then
		return {}
	end
end

function SurvivalHandbookModel:getHandBookUnlockDatas(type, subType)
	if self.subTypeMoDic[type] == nil or self.subTypeMoDic[type][subType] == nil then
		self:_parseBasicData()
	end

	if not self.subTypeMoDic[type][subType] then
		local datas = {}
		local result = {}

		for i, mo in ipairs(datas) do
			if mo.isUnlock then
				table.insert(result, mo)
			end
		end

		return result
	end
end

function SurvivalHandbookModel:getHandbookByCollectionBuild(id)
	local datas = self:getHandBookDatas(SurvivalEnum.HandBookType.Collection, 0)

	for j, mo in ipairs(datas) do
		if mo.links == id then
			return mo
		end
	end
end

function SurvivalHandbookModel:_parseBasicData()
	if self.handbookMoDic then
		return
	end

	self.handbookMoDic = {}

	local list = SurvivalHandbookConfig.instance:getConfigList()

	for i, cfg in ipairs(list) do
		local type = cfg.type
		local subType = cfg.subtype

		if self.subTypeMoDic[type] == nil then
			self.subTypeMoDic[type] = {}
		end

		local mo = SurvivalHandbookMo.New()

		mo:setData(cfg)

		self.handbookMoDic[cfg.id] = mo

		if type == SurvivalEnum.HandBookType.Result then
			table.insert(self.resultMos, mo)
		else
			if self.subTypeMoDic[type][subType] == nil then
				self.subTypeMoDic[type][subType] = {}
			end

			table.insert(self.subTypeMoDic[type][subType], mo)
		end
	end
end

function SurvivalHandbookModel:getNewHandbook(type, subType)
	local ids = {}

	for id, survivalHandbookMo in pairs(self.handbookMoDic) do
		if survivalHandbookMo:getType() == type and (subType == nil or subType == survivalHandbookMo:getSubType()) and survivalHandbookMo.isNew then
			table.insert(ids, id)
		end
	end

	return ids
end

function SurvivalHandbookModel:getTabTitleBySubType(handBookType, subType)
	return luaLang(self.handbookTypeCfg[handBookType][subType].tabTitle)
end

function SurvivalHandbookModel:getTabImageBySubType(handBookType, subType)
	return self.handbookTypeCfg[handBookType][subType].tabImage
end

function SurvivalHandbookModel.handBookSortFuncById(a, b)
	local isUnlockA = a.isUnlock
	local isUnlockB = b.isUnlock

	if isUnlockA ~= isUnlockB then
		return isUnlockA
	end

	return a.id < b.id
end

function SurvivalHandbookModel.handBookSortFunc(a, b)
	local isUnlockA = a.isUnlock
	local isUnlockB = b.isUnlock

	if isUnlockA ~= isUnlockB then
		return isUnlockA
	end

	local rareA = a:getRare()
	local rareB = b:getRare()

	if rareA ~= 0 and rareB ~= 0 and rareA ~= rareB then
		return rareB < rareA
	end

	return a.id < b.id
end

function SurvivalHandbookModel.handBookStorySortFunc(a, b)
	local isStoryNotFinishA = not a:isStoryFinish()
	local isStoryNotFinishB = not b:isStoryFinish()

	if isStoryNotFinishA ~= isStoryNotFinishB then
		return isStoryNotFinishA
	end

	return a.id < b.id
end

SurvivalHandbookModel.instance = SurvivalHandbookModel.New()

return SurvivalHandbookModel

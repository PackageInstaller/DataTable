-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/model/ClimbingTowerModel.lua

module("logic.extensions.climbingtower.model.ClimbingTowerModel", package.seeall)

local M = class("ClimbingTowerModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._storeyId2DungeonId = {}
	self._dungeonId2StoreyId = {}
	self._dungeonPreDungeonIdList = {}
	self._viewPageType = false
end

function M:onInit()
	self:onReset()

	local cfgBrightSideLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.LightMoonTower)

	for _, cfg in ipairs(cfgBrightSideLst or {}) do
		local storeyId = cfg.id
		local dungeonId = cfg.dungeon
		local preDungeonId = self._storeyId2DungeonId[storeyId - 1]

		self._storeyId2DungeonId[storeyId] = dungeonId
		self._dungeonId2StoreyId[dungeonId] = storeyId
		self._dungeonPreDungeonIdList[dungeonId] = preDungeonId
	end
end

function M:onReset()
	self._dungeonMoLstBright = {}
end

function M:getDungeonMoById(dungeonId)
	if not self._dungeonMoLstBright[dungeonId] then
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		if not dungeonCo then
			printError(string.format("无法从[t_%s]中找到[%s]的配置", ConfigName.Dungeon, dungeonId))

			return
		end

		local dungeonMo = ClimbingTowerDungeonMo.New()
		local storeyId = self._dungeonId2StoreyId[dungeonId]

		if dungeonCo.type == CommEnum.DungeonType.LightTower then
			dungeonMo:setTowerCfg(ClimbingTowerEnum.PageTyp.BrightSide, storeyId)
		elseif dungeonCo.type == CommEnum.DungeonType.LightTower then
			dungeonMo:setTowerCfg(ClimbingTowerEnum.PageTyp.DarkSide, storeyId)
		end

		dungeonMo:initByConfig(dungeonCo)
		dungeonMo:initByAgent(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))
		dungeonMo:setPreDungeonId(self._dungeonPreDungeonIdList[dungeonId])

		self._dungeonMoLstBright[dungeonId] = dungeonMo
	end

	return self._dungeonMoLstBright[dungeonId]
end

function M:getClearDungeonCount()
	local count = 0

	for dungeonId, storeyId in pairs(self._dungeonId2StoreyId) do
		local passData = DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId)

		if passData then
			count = count + 1
		end
	end

	return count
end

function M:getTowerEffListModel()
	if not self._effListModelForListBinderView then
		local function createFunc(isSkill, name, desc, icon, skillTyp)
			local data = {
				isSkill = isSkill,
				name = name,
				desc = desc,
				icon = icon,
				skillTyp = skillTyp
			}

			return data
		end

		local descItemDataLst = {}

		table.insert(descItemDataLst, createFunc(false, ClimbingTowerConfig.instance:getConst("RuleDescBuffTitle").strValue, ClimbingTowerConfig.instance:getConst("RuleDescBuffContent").strValue))

		local cfgEffLst = ClimbingTowerConfig.instance:getConfigList(ConfigName.TowerEffect)

		for _, cfg in ipairs(cfgEffLst or {}) do
			local co = ClimbingTowerConfig.instance:getTowerEffectCO(cfg.code)

			if co then
				local name = co:getSkillName()
				local desc = co:getSkillDesc()
				local icon = co:getSkillIcon()
				local skillTyp = co:getTyp()

				table.insert(descItemDataLst, createFunc(true, name, desc, icon, skillTyp))
			end
		end

		self._effListModelForListBinderView = BaseListModel.New()

		self._effListModelForListBinderView:setMoList(descItemDataLst)
	end

	return self._effListModelForListBinderView
end

function M:setEntryViewEnterTyp(typ)
	self._entryViewEnterTyp = typ or ClimbingTowerEnum.PageTyp.Moon
end

function M:getEntryViewEnterTyp()
	return self._entryViewEnterTyp or ClimbingTowerEnum.PageTyp.Moon
end

function M:setEntryViewFloatMsg(msg)
	self._entryViewFloatMsg = msg
end

function M:getEntryViewFloatMsg()
	return self._entryViewFloatMsg
end

function M:cacheEntryViewPageType(pageType)
	self._viewPageType = pageType
end

function M:getEntryViewPageType()
	return self._viewPageType or 0
end

M.instance = M.New()

return M

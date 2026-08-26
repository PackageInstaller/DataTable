-- chunkname: @modules/logic/survival/model/map/SurvivalInitGroupModel.lua

module("modules.logic.survival.model.map.SurvivalInitGroupModel", package.seeall)

local SurvivalInitGroupModel = class("SurvivalInitGroupModel", ListScrollModel)

function SurvivalInitGroupModel:init()
	self.allSelectHeroMos = {}
	self.assistHeroMo = nil
	self.allSelectNpcs = {}
	self.selectMapIndex = 0
	self.curClickHeroIndex = 1

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		local str = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.SurvivalTeamSave, "")

		if not string.nilorempty(str) then
			local dict = GameUtil.splitString2(str)

			if not dict[1] then
				if not dict[2] then
					local npcIds = {}
					local carryHeroCount = self:getCarryHeroCount()
					local carryNpcCount = self:getCarryNPCCount()

					for _, uid in ipairs(dict[1]) do
						if carryHeroCount <= 0 then
							break
						end

						local heroMo = HeroModel.instance:getById(uid)

						if heroMo and weekInfo:getHeroMo(heroMo.heroId).health > 0 then
							table.insert(self.allSelectHeroMos, heroMo)

							carryHeroCount = carryHeroCount - 1
						end
					end

					for _, npcId in ipairs(npcIds) do
						if carryNpcCount <= 0 then
							break
						end

						local npcMo = weekInfo.npcDict[tonumber(npcId)]

						if npcMo then
							table.insert(self.allSelectNpcs, npcMo)

							carryNpcCount = carryNpcCount - 1
						end
					end
				end
			end
		end
	end
end

function SurvivalInitGroupModel:initHeroList()
	local moList = {}
	local deathList = {}
	local repeatHero = {}
	local selectIndex

	for i = 1, self:getCarryHeroCount() do
		if self.allSelectHeroMos[i] and (not self.assistHeroMo or self.assistHeroMo.heroMO ~= self.allSelectHeroMos[i]) then
			table.insert(moList, self.allSelectHeroMos[i])

			repeatHero[self.allSelectHeroMos[i].uid] = true
			selectIndex = #moList
		end
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	for i, mo in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
		if not repeatHero[mo.uid] then
			repeatHero[mo.uid] = true

			if weekInfo:getHeroMo(mo.heroId).health == 0 then
				table.insert(deathList, mo)
			else
				table.insert(moList, mo)
			end
		end
	end

	tabletool.addValues(moList, deathList)
	self:setList(moList)

	if selectIndex then
		self:selectCell(selectIndex, true)
	end

	self.defaultIndex = selectIndex
end

function SurvivalInitGroupModel:getMoIndex(heroMo)
	for index, mo in pairs(self.allSelectHeroMos) do
		if mo == heroMo then
			return index
		end
	end

	return -1
end

function SurvivalInitGroupModel:trySetHeroMo(heroMo)
	if heroMo then
		for index, mo in pairs(self.allSelectHeroMos) do
			if mo and mo.heroId == heroMo.heroId then
				self.allSelectHeroMos[index] = nil

				if self.assistHeroMo and mo == self.assistHeroMo.heroMO then
					self.assistHeroMo = nil
				end
			end
		end
	end

	self.allSelectHeroMos[self.curClickHeroIndex] = heroMo
end

function SurvivalInitGroupModel:tryAddHeroMo(heroMo)
	for index, mo in pairs(self.allSelectHeroMos) do
		if heroMo == mo then
			return false
		end

		if mo and mo.heroId == heroMo.heroId then
			self.allSelectHeroMos[index] = nil

			if self.assistHeroMo and mo == self.assistHeroMo.heroMO then
				self.assistHeroMo = nil
			end
		end
	end

	for i = 1, self:getCarryHeroCount() do
		if not self.allSelectHeroMos[i] then
			self.allSelectHeroMos[i] = heroMo

			return i
		end
	end
end

function SurvivalInitGroupModel:getCarryHeroCount()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo:getAttr(SurvivalEnum.AttrType.ExploreRoleNum)
end

function SurvivalInitGroupModel:getCarryNPCCount()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo:getAttr(SurvivalEnum.AttrType.ExploreNpcNum)
end

function SurvivalInitGroupModel:getCarryHeroMax()
	return tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.CarryHeroMax))) or 0
end

function SurvivalInitGroupModel:getCarryNPCMax()
	return tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.CarryNpcMax))) or 0
end

function SurvivalInitGroupModel:hasAssistHeroMo()
	return self.assistHeroMo ~= nil
end

function SurvivalInitGroupModel:addAssistHeroMo(assistHeroMo)
	self.assistHeroMo = assistHeroMo

	for index, heroMo in pairs(self.allSelectHeroMos) do
		if heroMo and heroMo.heroId == assistHeroMo.heroMO.heroId then
			self.allSelectHeroMos[index] = assistHeroMo.heroMO

			return
		end
	end

	for i = 1, self:getCarryHeroCount() do
		if not self.allSelectHeroMos[i] then
			self.allSelectHeroMos[i] = assistHeroMo.heroMO

			return
		end
	end
end

function SurvivalInitGroupModel:removeAssistMo()
	if not self.assistHeroMo then
		return
	end

	for index, heroMo in pairs(self.allSelectHeroMos) do
		if heroMo and heroMo.heroId == self.assistHeroMo.heroId then
			self.allSelectHeroMos[index] = nil

			break
		end
	end

	self.assistHeroMo = nil
end

function SurvivalInitGroupModel:isHeroFull()
	return tabletool.len(self.allSelectHeroMos) == self:getCarryHeroCount()
end

return SurvivalInitGroupModel

-- chunkname: @modules/logic/character/model/HeroTalentCubeInfosMO.lua

module("modules.logic.character.model.HeroTalentCubeInfosMO", package.seeall)

local HeroTalentCubeInfosMO = pureTable("HeroTalentCubeInfosMO")

function HeroTalentCubeInfosMO:init(info)
	self.data_list = {}

	for i = 1, #info do
		self.data_list[i] = {}
		self.data_list[i].cubeId = info[i].cubeId
		self.data_list[i].direction = info[i].direction
		self.data_list[i].posX = info[i].posX
		self.data_list[i].posY = info[i].posY
	end
end

function HeroTalentCubeInfosMO:clearData()
	self.data_list = {}
end

function HeroTalentCubeInfosMO:setOwnData(hero_id, talent_level)
	self.own_cube_dic = {}
	self.own_cube_list = {}

	local talent_config = HeroResonanceConfig.instance:getTalentConfig(hero_id, talent_level)

	if talent_config then
		self.own_cube_list = {}

		if talent_config then
			self.own_cube_dic = {}

			local tab = string.splitToNumber(talent_config.exclusive, "#")

			if tab and #tab > 0 then
				self.own_cube_dic[tab[1]] = {
					own = 1,
					use = 0,
					id = tab[1],
					level = tab[2]
				}
				self.own_main_cube_id = tab[1]
			end
		end

		local talent_model_config = HeroResonanceConfig.instance:getTalentModelConfig(hero_id, talent_level)

		for i = 10, 20 do
			local tab = string.splitToNumber(talent_model_config["type" .. i], "#")

			if tab and #tab > 0 then
				self.own_cube_dic[i] = self.own_cube_dic[i] or {}
				self.own_cube_dic[i].id = i
				self.own_cube_dic[i].own = tab[1]
				self.own_cube_dic[i].level = tab[2]
				self.own_cube_dic[i].use = 0
			end
		end

		for i = #self.data_list, 1, -1 do
			local v = self.data_list[i]

			if self.own_cube_dic[v.cubeId] then
				self.own_cube_dic[v.cubeId].own = self.own_cube_dic[v.cubeId].own - 1
				self.own_cube_dic[v.cubeId].use = self.own_cube_dic[v.cubeId].use + 1
			else
				table.remove(self.data_list, i)
			end
		end

		for k, v in pairs(self.own_cube_dic) do
			if v.own > 0 then
				table.insert(self.own_cube_list, v)
			end
		end
	end

	return self.own_cube_dic, self.own_cube_list
end

function HeroTalentCubeInfosMO:getMainCubeMo()
	return self.own_cube_dic[self.own_main_cube_id]
end

return HeroTalentCubeInfosMO

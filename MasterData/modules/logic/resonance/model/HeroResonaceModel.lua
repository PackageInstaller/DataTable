-- chunkname: @modules/logic/resonance/model/HeroResonaceModel.lua

module("modules.logic.resonance.model.HeroResonaceModel", package.seeall)

local HeroResonaceModel = class("HeroResonaceModel", BaseModel)

function HeroResonaceModel:onInit()
	self._copyShareCode = nil
end

function HeroResonaceModel:reInit()
	self._copyShareCode = nil
end

function HeroResonaceModel:getCurLayoutShareCode(heroMo)
	local dataList = heroMo.talentCubeInfos.data_list

	if dataList and tabletool.len(dataList) > 0 then
		local list = {}
		local style = heroMo:getHeroUseCubeStyleId() or 0

		table.insert(list, style)

		for _, data in ipairs(dataList) do
			local cubeId = data.cubeId

			if cubeId > 100 then
				style = cubeId % 10
				cubeId = math.floor(cubeId / 10)
			end

			local temp1 = bit.lshift(cubeId - 1, 2) + data.direction

			table.insert(list, temp1)

			local temp2 = bit.lshift(data.posX, 4) + data.posY

			table.insert(list, temp2)
		end

		local bin_str = string.char(unpack(list))

		return Base64Util.encode(bin_str)
	end
end

function HeroResonaceModel:decodeLayoutShareCode(code)
	local bin_str = Base64Util.decode(code)
	local list = {}
	local style = string.byte(bin_str, 1)

	for i = 1, string.len(bin_str) / 2 do
		local temp1 = string.byte(bin_str, i * 2)
		local temp2 = string.byte(bin_str, i * 2 + 1)

		if not temp1 or not temp2 then
			return
		end

		if temp1 < 0 then
			temp1 = temp1 + 256
		end

		local id = bit.rshift(temp1, 2) + 1
		local dir = bit.band(temp1, 3)
		local x = bit.rshift(temp2, 4)
		local y = bit.band(temp2, 15)
		local data = {
			cubeId = id,
			direction = dir,
			posX = x,
			posY = y
		}

		table.insert(list, data)
	end

	return list, style
end

function HeroResonaceModel:canUseLayoutShareCode(heroMo, code)
	if not heroMo then
		return
	end

	local shareDataList = self:decodeLayoutShareCode(code)

	if not shareDataList or tabletool.len(shareDataList) == 0 then
		if not string.nilorempty(code) then
			return false, ToastEnum.CharacterTalentCopyCodeError
		end

		return
	end

	local x_y = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(heroMo.heroId, heroMo.talent), ",")
	local sameCubeIdList = {}

	for _, data in ipairs(shareDataList) do
		local shapeCo = HeroResonanceConfig.instance:getCubeConfigNotError(data.cubeId)

		if shapeCo then
			local shape = GameUtil.splitString2(shapeCo.shape, true, "#", ",")
			local _shape = {}

			for i = 1, #shape do
				for j = 1, #shape[i] do
					_shape[i - 1] = _shape[i - 1] or {}
					_shape[i - 1][j - 1] = shape[i][j]
				end
			end

			local _rotationMatrix = self:rotationMatrix(_shape, data.direction)

			if self:_isOverCell(_rotationMatrix, x_y, data) then
				return
			end

			sameCubeIdList[data.cubeId] = sameCubeIdList[data.cubeId] or 0
			sameCubeIdList[data.cubeId] = sameCubeIdList[data.cubeId] + 1
		else
			return false, ToastEnum.CharacterTalentCopyCodeError
		end
	end

	local curDataList = heroMo.talentCubeInfos.own_cube_dic

	for cubeId, count in pairs(sameCubeIdList) do
		local data = curDataList[cubeId]

		if not data or count > data.own + data.use then
			return
		end
	end

	return true
end

function HeroResonaceModel:_isOverCell(matrix, size, data)
	local x, y = self:getMatrixRange(matrix, data)

	return x > size[1] or y > size[2]
end

function HeroResonaceModel:getMatrixRange(matrix, data)
	local x, y = 0, 0

	if matrix then
		for i = 0, GameUtil.getTabLen(matrix) - 1 do
			local _m = matrix[i]

			for j = 0, GameUtil.getTabLen(_m) - 1 do
				if _m[j] == 1 then
					if x < j then
						x = j
					end

					if y < i then
						y = i
					end
				end
			end
		end
	end

	return data.posX + x + 1, data.posY + y + 1
end

function HeroResonaceModel:rotationMatrix(matrix, rotation_count)
	local temp_matrix = matrix

	while rotation_count > 0 do
		temp_matrix = {}

		local m = GameUtil.getTabLen(matrix)
		local n = GameUtil.getTabLen(matrix[0])

		for i = 0, n - 1 do
			temp_matrix[i] = {}

			for j = 0, m - 1 do
				temp_matrix[i][j] = matrix[m - j - 1][i]
			end
		end

		rotation_count = rotation_count - 1

		if rotation_count > 0 then
			matrix = temp_matrix
		end
	end

	return temp_matrix
end

function HeroResonaceModel:_isUseTalentStyle(heroId, style)
	if style and style > 0 then
		local styleCubeMo = TalentStyleModel.instance:getCubeMoByStyle(heroId, style)

		return styleCubeMo._isUse
	end
end

function HeroResonaceModel:_isUnlockTalentStyle(heroId, style)
	if style and style > 0 then
		local styleCubeMo = TalentStyleModel.instance:getCubeMoByStyle(heroId, style)

		return styleCubeMo._isUnlock, styleCubeMo
	end
end

function HeroResonaceModel:getShareTalentAttrInfos(heroMo, dataList, style)
	local infos = {}

	if not dataList then
		return infos
	end

	local cubeInfos = {}
	local attrInfos = heroMo:getTalentGain()
	local mainCubeId = heroMo.talentCubeInfos.own_main_cube_id
	local damping_tab = SkillConfig.instance:getTalentDamping()
	local type_dic = {}

	for _, data in ipairs(dataList) do
		local cubeId = data.cubeId

		type_dic[cubeId] = type_dic[cubeId] or {}

		table.insert(type_dic[cubeId], data)
	end

	for cubeId, v in pairs(type_dic) do
		local _cubeInfos = {}
		local _cubeId = cubeId

		if mainCubeId == cubeId and style ~= 0 then
			local mo = TalentStyleModel.instance:getCubeMoByStyle(heroMo.heroId, style)

			if mo and mo._isUnlock then
				_cubeId = mo._replaceId
			end
		end

		local count = #v

		if count >= damping_tab[1][1] then
			if count >= damping_tab[2][1] then
				if not damping_tab[2][2] then
					local damping = damping_tab[1][2]

					if not damping_tab[1][2] then
						for i = 1, count do
							heroMo:getTalentAttrGainSingle(_cubeId, _cubeInfos)
						end

						for key, value in pairs(_cubeInfos) do
							if damping then
								_cubeInfos[key] = value * (damping / 1000)
							end

							if _cubeInfos[key] > 0 then
								cubeInfos[key] = (cubeInfos[key] or 0) + _cubeInfos[key]
							end
						end
					end
				end
			end
		end
	end

	for key, value in pairs(cubeInfos) do
		local cur = attrInfos[key]
		local info = {}

		info.key = key

		if cur then
			info.value = cur.value or 0
		end

		info.shareValue = value or 0

		table.insert(infos, info)
	end

	for key, _info in pairs(attrInfos) do
		if not self:_isHasAttr(infos, key) then
			local info = {}

			info.key = key

			if _info then
				info.value = _info.value or 0
			end

			info.shareValue = 0

			table.insert(infos, info)
		end
	end

	table.sort(infos, self._sortAttr)

	return infos
end

function HeroResonaceModel:_isHasAttr(infoList, key)
	if infoList then
		for _, info in pairs(infoList) do
			if info.key == key then
				return true
			end
		end
	end
end

function HeroResonaceModel._sortAttr(a, b)
	return HeroConfig.instance:getIDByAttrType(a.key) < HeroConfig.instance:getIDByAttrType(b.key)
end

function HeroResonaceModel:saveShareCode(code)
	self._copyShareCode = code
end

function HeroResonaceModel:getShareCode()
	return self._copyShareCode
end

function HeroResonaceModel:getSpecialCn(heroMo)
	local type = heroMo and heroMo:getTalentTxtByHeroType() or 1

	return luaLang("talent_character_talentcn" .. type)
end

HeroResonaceModel.instance = HeroResonaceModel.New()

return HeroResonaceModel

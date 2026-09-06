-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/model/PetRelationModel.lua

module("logic.extensions.petrelation.model.PetRelationModel", package.seeall)

local PetRelationModel = class("PetRelationModel", BaseListModel)

function PetRelationModel:ctor()
	PetRelationModel.super.ctor(self)
end

function PetRelationModel:onInit()
	PetRelationModel.super.onInit(self)
	self:initPetSeat()
end

function PetRelationModel:onReset()
	PetRelationModel.super.onReset(self)
end

function PetRelationModel:initPetSeat()
	self._petSeat = {}
	self._petLine = {}

	local R = tonumber(PetRelationConfig.instance:getCommonValue("RADIUS"))
	local seatCfg = PetRelationConfig.instance:getSeat()

	for i = 1, #seatCfg do
		self._petSeat[i] = self:initSeat(R, seatCfg[i])
	end

	local lineCfg = PetRelationConfig.instance:getLine()
	local relationName = {}

	for i, line in ipairs(lineCfg) do
		if not line.linkRaceId then
			if not line.linkName2 then
				local linkName, linkName2 = line.linkName or {}, {}

				for i, raceId in ipairs(line.linkRaceId) do
					if tonumber(line.raceId) and tonumber(raceId) then
						if raceId > line.raceId then
							self._petLine[line.raceId .. "#" .. raceId] = {
								thickness = line.lineThickness,
								color = Framework.ColorUtil.ParseColor(line.lineColor)
							}
						else
							self._petLine[raceId .. "#" .. line.raceId] = {
								thickness = line.lineThickness,
								color = Framework.ColorUtil.ParseColor(line.lineColor)
							}
						end
					elseif line.raceId == "User" then
						self._petLine[line.raceId .. "#" .. raceId] = {
							thickness = line.lineThickness,
							color = Framework.ColorUtil.ParseColor(line.lineColor)
						}
					else
						self._petLine[raceId .. "#" .. line.raceId] = {
							thickness = line.lineThickness,
							color = Framework.ColorUtil.ParseColor(line.lineColor)
						}
					end

					relationName[line.raceId .. raceId] = linkName[i]
					relationName[raceId .. line.raceId] = linkName2[i]

					for i = 1, #self._petSeat do
						if self._petSeat[i][line.raceId] then
							table.insert(self._petSeat[i][line.raceId].linkPetId, raceId)
						end

						if self._petSeat[i][raceId] then
							table.insert(self._petSeat[i][raceId].linkPetId, line.raceId)
						end
					end
				end

				if self._petSeat[line.raceId] then
					self._petSeat[line.raceId].scale = line.scale
				end
			end
		end
	end

	self._relationName = relationName
end

function PetRelationModel:initSeat(R, seatCfg)
	local _petSeat = {}
	local xGap = R * 1.5
	local yGap = R * math.sqrt(3)
	local HR = yGap * 0.5
	local xMin, xMax, yMin, yMax = 999, 0, 999, 0

	for y, cfg in ipairs(seatCfg) do
		local colNum = #cfg

		for i = 3, colNum do
			local raceId = cfg[i]

			if raceId and raceId ~= "" then
				if i < xMin then
					xMin = i
				end

				if xMax < i then
					xMax = i
				end

				if y < yMin then
					yMin = y
				end

				if yMax < y then
					yMax = y
				end
			end
		end
	end

	_petSeat._maxWidth = (xMax - xMin + 6) * xGap
	_petSeat._maxHeight = (yMax - yMin + 4) * yGap
	_petSeat.pointerArray = {}

	local centerX, centerY, index = (xMax + xMin) / 2, (yMax + yMin) / 2, 1

	for y, cfg in ipairs(seatCfg) do
		local colNum = #cfg

		for i = 3, colNum do
			local raceId = cfg[i]

			if raceId and raceId ~= "" then
				if raceId ~= "User" then
					raceId = tonumber(raceId)
				end

				local x = i - 1

				_petSeat[raceId] = {
					raceId = raceId,
					x = x,
					y = y
				}
				_petSeat[raceId].position = x % 2 == 0 and Vector2.New(xGap * (i - centerX), yGap * (y - centerY) * -1) or Vector2.New(xGap * (i - centerX), yGap * (y - centerY) * -1 - HR)
				_petSeat[raceId].linkPetId = {
					raceId
				}
				_petSeat[raceId].scale = 1
				_petSeat.pointerArray[index] = _petSeat[raceId]
				index = index + 1
			end
		end
	end

	local vector = Vector2.New()

	for i, v in ipairs(_petSeat.pointerArray) do
		v.distance = GameUtil.getVector2Distance((_petSeat.User or nil) and _petSeat.User.position, v.position)
	end

	return _petSeat
end

function PetRelationModel:getMaxWidthAndHeight(type)
	return self._petSeat[type or 1]._maxWidth, self._petSeat[type or 1]._maxHeight
end

function PetRelationModel:getPetSeat(type)
	return self._petSeat[type or 1]
end

function PetRelationModel:getRelationName(aRaceId, bRaceId)
	return self._relationName[aRaceId .. bRaceId]
end

function PetRelationModel:getLineInfo(aRaceId, bRaceId)
	if tonumber(aRaceId) and tonumber(bRaceId) then
		if aRaceId < bRaceId then
			return self._petLine[aRaceId .. "#" .. bRaceId]
		else
			return self._petLine[bRaceId .. "#" .. aRaceId]
		end
	elseif aRaceId == "User" then
		return self._petLine[aRaceId .. "#" .. tonumber(bRaceId)]
	else
		return self._petLine[bRaceId .. "#" .. tonumber(aRaceId)]
	end
end

function PetRelationModel:getUrl(type, distance)
	local tempPath, temp = {}, {}

	for i, v in ipairs(self._petSeat[type].pointerArray) do
		local petCo = CharacterConfig.instance:getPetCo(PetSkinConfig.instance:getPetSkinRaceId(v.raceId))

		if petCo and distance > v.distance then
			local url = GameUrl.getCharacterIconUrl(CharacterConfig.instance:getModelCo(tonumber(v.raceId)).headName)

			if not temp[url] then
				temp[url] = 1

				table.insert(tempPath, url)
			end
		end
	end

	local headId = RoleModel.instance:getHeadIconId()

	if headId == 1 then
		table.insert(tempPath, GameUrl.getIconFolderUrl("headicon", "com_player_b2_"))
	else
		table.insert(tempPath, GameUrl.getIconFolderUrl("headicon", "com_player_g2_"))
	end

	return tempPath
end

function PetRelationModel:setViewType(viewType)
	self._viewType = viewType
end

function PetRelationModel:getViewType()
	return self._viewType
end

PetRelationModel.instance = PetRelationModel.New()

return PetRelationModel

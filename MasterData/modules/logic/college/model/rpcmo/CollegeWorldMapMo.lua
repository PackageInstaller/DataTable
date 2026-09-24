-- chunkname: @modules/logic/college/model/rpcmo/CollegeWorldMapMo.lua

module("modules.logic.college.model.rpcmo.CollegeWorldMapMo", package.seeall)

local CollegeWorldMapMo = pureTable("CollegeWorldMapMo")

function CollegeWorldMapMo:init(data)
	self.areas, self.areasMap = GameUtil.rpcInfosToListAndMap(data.areas, CollegeWorldMapAreaMo, "id", self.areasMap)
	self.isUnlock = #self.areas > 0

	for i, v in ipairs(lua_college_location.configList) do
		if not self.areasMap[v.id] then
			table.insert(self.areas, CollegeWorldMapAreaMo.Create(v.id))

			self.areasMap[v.id] = self.areas[#self.areas]
		end
	end
end

function CollegeWorldMapMo:getAreaMo(id)
	return self.areasMap[id]
end

function CollegeWorldMapMo:updateAreaInfo(areaInfo)
	local areaMo = self.areasMap[areaInfo.id]

	if not areaMo then
		logError("区域不存在！" .. areaInfo.id)

		return
	end

	if not self.isUnlock then
		self.isUnlock = true

		CollegeController.instance:dispatchEvent(CollegeEvent.UnlockMap)
	end

	if not areaMo.unlock then
		GameFacade.showToast(ToastEnum.CollegeUnlockArea, areaMo.co.name)
	end

	local isFinish = areaMo.isFinish
	local haveCharacter = areaMo.unlock and #areaMo.slotCharacterUid > 0 or false

	if areaMo.unlock then
		if not areaMo.explorationProp.progress then
			local progress = 0

			areaMo:init(areaInfo)

			if not isFinish and areaMo.isFinish then
				CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_area_finish"), areaMo.co.name))
			elseif not isFinish then
				if progress < areaMo.explorationProp.progress then
					CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_toast_area_addstep"), areaMo.co.name, areaMo.explorationProp.progress - progress))
				elseif not haveCharacter and #areaMo.slotCharacterUid > 0 then
					CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_area_begin"), areaMo.co.name))
				elseif haveCharacter and #areaMo.slotCharacterUid == 0 then
					CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_area_pause"), areaMo.co.name))
				end
			end
		end
	end
end

function CollegeWorldMapMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeWorldMapMo" then
		return false
	end

	local isSame = true

	if #self.areas ~= #otherMo.areas then
		isSame = false

		logError(string.format("CollegeWorldMapMo compareWith areas count not same: %s >> %s", #self.areas, #otherMo.areas))
	else
		for i = 1, #self.areas do
			local otherAreaMo = otherMo.areasMap[self.areas[i].id]

			if not otherAreaMo or not self.areas[i]:compareWith(otherAreaMo) then
				isSame = false

				logError(string.format("CollegeWorldMapMo compareWith areas not same: id=%s", self.areas[i].id))

				break
			end
		end
	end

	return isSame
end

return CollegeWorldMapMo

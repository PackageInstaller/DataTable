-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/EffectCenter.lua

EffectCenter = class("EffectCenter", objectlua.Object, _M)

EffectCenter:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function EffectCenter:initialize(data)
	super.initialize(self)

	self._player = data
	self._emblemEffects = {}
	self._galleryEffects = {}
	self._galleryAllEffects = {}
	self._buildComfortEffects = {}
	self._oldEmblemEffects = {}
	self._oldGalleryEffects = {}
	self._oldGalleryAllEffects = {}
	self._oldBuildComfortEffects = {}
	self._extraUpEffects = {}
	self._spEffects = {}
	self._auraEffects = {}
	self._oldAuraEffects = {}
	self._buildingRoomPutHeroEffect = {}
	self._galleryLegendEffects = {}
	self._oldGalleryLegendEffects = {}
	self._timeEffects = {}
	self._oldTimeEffects = {}
	self._leadStageEffects = {}
	self._tsoulEffects = {}
	self._messageEffects = {}
	self._oldMessageEffects = {}
	self._oldMessagePartyEffects = {}
	self._messagePartyEffects = {}
	self._oldMessageMasterEffects = {}
	self._messageMasterEffects = {}
end

function EffectCenter:dispatch(event)
	local eventDispatcher = self:getEventDispatcher()

	if eventDispatcher ~= nil then
		return eventDispatcher:dispatchEvent(event)
	end
end

function EffectCenter:syncData(data)
	if data then
		self._effCenterData = data

		self:setEmblemAttrByType(self._effCenterData)
		self:setGalleryAttrByType(self._effCenterData)
		self:setGalleryAllAttrByType(self._effCenterData)
		self:setAuraAttrByType()
		self:setBuildAttrByType()
		self:setMonthExtraUpByType()
		self:setSpEffectByType()
		self:setBuildingRoomPutHeroEffect()
		self:setGalleryLegendAttrByType()
		self:setTimeEffect()
		self:setLeadStageEffect()
		self:setTSOULAttrByType()
		self:setMessageAttrByType()
		self:setMessagePartyAttrByType()
		self:setMessageMasterAttrByType()
		self._player:syncAttrEffect()
	end
end

function EffectCenter:delete(data)
	if data.managers.SpFuncEffectManager then
		if not data.managers.SpFuncEffectManager.effects then
			do
				local effect = {}

				for k, v in pairs(effect) do
					self._spEffects[k] = nil

					if k == "Worldmap_Speed_Change" then
						cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kExploreSpeedKey, "")
					end
				end
			end

			if data.managers.AttrEffectManager then
				if not data.managers.AttrEffectManager.effects.ALL then
					do
						local effect = {}

						for heroId, eff in pairs(effect) do
							for k, v in pairs(eff) do
								if string.split(k, "-")[1] == "TSOUL" then
									self._tsoulEffects[heroId] = {}
								end
							end
						end
					end

					if self._effCenterData.managers.AttrEffectManager then
						if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
							return
						end

						local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.HERO

						if effect then
							for k, v in pairs(effect) do
								local strs = string.split(k, "-")

								if strs[1] == "VILLAGEHERO_Room5" then
									self._buildingRoomPutHeroEffect = {}
								end
							end
						end
					end
				end
			end
		end
	end
end

function EffectCenter:setAuraAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._auraEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.HERO

		if effect then
			for k, v in pairs(effect) do
				if string.split(k, "_")[1] == "AURA" then
					for kk, vv in pairs(v.attrs) do
						local vvn = vv

						self._auraEffects[kk] = self._auraEffects[kk] and self._auraEffects[kk] + vvn or vvn or 0
					end
				end
			end
		end

		self._oldAuraEffects = self._auraEffects
	end
end

function EffectCenter:setBuildAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._buildComfortEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.HERO

		if effect then
			for k, v in pairs(effect) do
				if string.split(k, "-")[1] == "VILLAGECOMFORT" then
					for kk, vv in pairs(v.attrs) do
						local vvn = vv

						self._buildComfortEffects[kk] = self._buildComfortEffects[kk] and self._buildComfortEffects[kk] + vvn or vvn or 0
					end
				end
			end
		end

		self._oldBuildComfortEffects = self._buildComfortEffects
	end
end

function EffectCenter:setEmblemAttrByType(type)
	if self._effCenterData.managers.AttrEffectManager then
		self._emblemEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.MASTER

		if effect then
			for k, v in pairs(effect) do
				if string.split(k, "-")[1] == "EMBLEM" then
					for kk, vv in pairs(v.attrs) do
						self._emblemEffects[kk] = self._emblemEffects[kk] and self._emblemEffects[kk] + vv or vv or 0
					end
				end
			end
		end

		self._oldEmblemEffects = self._emblemEffects
	end
end

function EffectCenter:setGalleryAttrByType(type)
	if self._effCenterData.managers.AttrEffectManager then
		self._galleryEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.MASTER

		if effect then
			for k, v in pairs(effect) do
				if string.split(k, "-")[1] == "Gallery" then
					for kk, vv in pairs(v.attrs) do
						self._galleryEffects[kk] = self._galleryEffects[kk] and self._galleryEffects[kk] + vv or vv or 0
					end
				end
			end
		end

		self._oldGalleryEffects = self._galleryEffects
	end
end

function EffectCenter:setGalleryAllAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._galleryAllEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.ALL

		if effect then
			for k, v in pairs(effect) do
				if string.split(k, "-")[1] == "Gallery" then
					for kk, vv in pairs(v.attrs) do
						self._galleryAllEffects[kk] = self._galleryAllEffects[kk] and self._galleryAllEffects[kk] + vv or vv or 0
					end
				end
			end
		end

		self._oldGalleryAllEffects = self._galleryAllEffects
	end
end

function EffectCenter:setGalleryLegendAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL

		if effect then
			for k, v in pairs(effect) do
				for kk, vv in pairs(v) do
					if string.split(kk, "_")[1] == "LEGEND" then
						self._galleryLegendEffects[k] = self._galleryLegendEffects[k] or {}

						local arr = string.split(kk, "-")
						local effectId = arr[#arr]

						self._galleryLegendEffects[k][effectId] = 1
					end
				end
			end
		end
	end
end

function EffectCenter:setMonthExtraUpByType()
	if self._effCenterData.managers.ExtraUpEffectManager then
		if not self._effCenterData.managers.ExtraUpEffectManager.effects then
			return
		end

		local effect = self._effCenterData.managers.ExtraUpEffectManager.effects

		if effect then
			for k, v in pairs(effect) do
				for kk, vv in pairs(v.value) do
					self._extraUpEffects[kk] = vv or 0
				end
			end
		end
	end
end

function EffectCenter:setSpEffectByType()
	if self._effCenterData.managers.SpFuncEffectManager then
		if not self._effCenterData.managers.SpFuncEffectManager.effects then
			return
		end

		local effect = self._effCenterData.managers.SpFuncEffectManager.effects

		if effect then
			for k, v in pairs(effect) do
				if table.nums(v) > 0 then
					self._spEffects[k] = v
				end
			end
		end
	end
end

function EffectCenter:setBuildingRoomPutHeroEffect()
	if self._effCenterData.managers.AttrEffectManager then
		self._buildingRoomPutHeroEffect = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.HERO

		if effect then
			for k, v in pairs(effect) do
				local strs = string.split(k, "-")

				if strs[1] == "VILLAGEHERO_Room5" then
					for kk, num in pairs(v.attrs) do
						self._buildingRoomPutHeroEffect[kk] = {
							num = num,
							effectId = v.id
						}
					end
				end
			end
		end
	end
end

function EffectCenter:getEmblenEffectAttrsById(type)
	if table.nums(self._emblemEffects) > 0 and self._emblemEffects[type] then
		for k, v in pairs(self._emblemEffects) do
			if v ~= self._oldEmblemEffects[k] then
				self._emblemEffects[type] = math.abs(self._oldEmblemEffects[type] - v)
			end
		end

		return self._emblemEffects[type]
	end

	return 0
end

function EffectCenter:getEmblemEffectAttrsInfo()
	return self._emblemEffects or {}
end

function EffectCenter:getGalleryEffectAttrsInfo()
	return self._galleryEffects or {}
end

function EffectCenter:getGalleryAllEffectAttrsInfo()
	return self._galleryAllEffects or {}
end

function EffectCenter:getGalleryEffectAttrsById(type)
	if table.nums(self._galleryEffects) > 0 and self._galleryEffects[type] then
		for k, v in pairs(self._galleryEffects) do
			if v ~= self._oldGalleryEffects[k] then
				self._galleryEffects[type] = math.abs(self._oldGalleryEffects[type] - v)
			end
		end

		return self._galleryEffects[type]
	end

	return 0
end

function EffectCenter:getGalleryAllEffectAttrsById(type)
	if table.nums(self._galleryAllEffects) > 0 and self._galleryAllEffects[type] then
		for k, v in pairs(self._galleryAllEffects) do
			if v ~= self._oldGalleryAllEffects[k] then
				self._galleryAllEffects[type] = math.abs(self._oldGalleryAllEffects[type] - v)
			end
		end

		return self._galleryAllEffects[type]
	end

	return 0
end

function EffectCenter:getGalleryLegendEffectIdsById(heroId)
	if table.nums(self._galleryLegendEffects) > 0 and self._galleryLegendEffects[heroId] then
		return self._galleryLegendEffects[heroId]
	end

	return {}
end

function EffectCenter:getAuraEffectById(type)
	if table.nums(self._auraEffects) > 0 and self._auraEffects[type] then
		for k, v in pairs(self._auraEffects) do
			if v ~= self._oldAuraEffects[k] then
				self._auraEffects[type] = math.abs(self._oldAuraEffects[type] - v)
			end
		end

		return self._auraEffects[type]
	end

	return 0
end

function EffectCenter:getBuildComfortEffectById(type)
	if table.nums(self._buildComfortEffects) > 0 and self._buildComfortEffects[type] then
		for k, v in pairs(self._buildComfortEffects) do
			if v ~= self._oldBuildComfortEffects[k] then
				self._buildComfortEffects[type] = math.abs(self._oldBuildComfortEffects[type] - v)
			end
		end

		return self._buildComfortEffects[type]
	end

	return 0
end

function EffectCenter:getMessageEffectById(type)
	if table.nums(self._messageEffects) > 0 and self._messageEffects[type] then
		for k, v in pairs(self._messageEffects) do
			if v ~= self._oldMessageEffects[k] then
				self._messageEffects[type] = math.abs(self._oldMessageEffects[type] - v)
			end
		end

		return self._messageEffects[type]
	end

	return 0
end

function EffectCenter:getMessagePartyEffectById(party, type)
	if table.nums(self._messagePartyEffects) > 0 and self._messagePartyEffects[party] and self._messagePartyEffects[party][type] then
		for k, v in pairs(self._messagePartyEffects[party]) do
			if v ~= self._oldMessagePartyEffects[party][k] then
				self._messagePartyEffects[party][type] = math.abs(self._messagePartyEffects[party][type] - v)
			end
		end

		return self._messagePartyEffects[party][type]
	end

	return 0
end

function EffectCenter:getMessageMasterById(type)
	if table.nums(self._messageMasterEffects) > 0 and self._messageMasterEffects[type] then
		for k, v in pairs(self._messageMasterEffects) do
			if v ~= self._oldMessageMasterEffects[k] then
				self._messageMasterEffects[type] = math.abs(self._oldMessageMasterEffects[type] - v)
			end
		end

		return self._messageMasterEffects[type]
	end

	return 0
end

function EffectCenter:getExtraUpById(type)
	return self._extraUpEffects[type] or 0
end

function EffectCenter:getSpEffectById(type)
	return self._spEffects[type]
end

function EffectCenter:getBuildingRoomPutHeroEffect()
	return self._buildingRoomPutHeroEffect
end

function EffectCenter:setTimeEffect()
	self._timeEffects = {}

	if self._effCenterData.managers.AttrEffectManager and self._effCenterData.managers.AttrEffectManager.timeEffects then
		self._timeEffects = self._effCenterData.managers.AttrEffectManager.timeEffects.ALL
		self._oldTimeEffects = self._timeEffects
	end
end

function EffectCenter:getHeroTimeEffectByIdForType(id, type)
	local attrValue = 0

	if self._timeEffects then
		local attr = self._timeEffects[id]
		local attrAll = self._timeEffects.HERO

		if attr then
			for k, v in pairs(attr) do
				if v.attrs and v.attrs[type] then
					attrValue = attrValue + v.attrs[type]
				end
			end
		end

		if attrAll then
			for k, v in pairs(attrAll) do
				if v.attrs and v.attrs[type] then
					attrValue = attrValue + v.attrs[type]
				end
			end
		end
	end

	return attrValue
end

function EffectCenter:getMasterTimeEffectByIdForType(id, type)
	local attrValue = 0

	if self._timeEffects then
		local attr = self._timeEffects[id]
		local attrAll = self._timeEffects.MASTER

		if attr then
			for k, v in pairs(attr) do
				if v.attrs and v.attrs[type] then
					attrValue = attrValue + v.attrs[type]
				end
			end
		end

		if attrAll then
			for k, v in pairs(attrAll) do
				if v.attrs and v.attrs[type] then
					attrValue = attrValue + v.attrs[type]
				end
			end
		end
	end

	return attrValue
end

function EffectCenter:getMasterTimeEffectInfoById(id)
	local info = {}

	if self._timeEffects then
		local attr = self._timeEffects[id]
		local attrAll = self._timeEffects.MASTER

		if attr then
			for _, vv in pairs(attr) do
				for k, v in pairs(vv.attrs) do
					info[k] = info[k] or 0
					info[k] = info[k] + v
				end
			end
		end

		if attrAll then
			for _, vv in pairs(attrAll) do
				for k, v in pairs(vv.attrs) do
					info[k] = info[k] or 0
					info[k] = info[k] + v
				end
			end
		end
	end

	return info
end

function EffectCenter:setLeadStageEffect()
	if self._effCenterData.managers.AttrEffectManager then
		local sceneAll = self._effCenterData.managers.AttrEffectManager.effects.SCENE_ALL

		if not sceneAll then
			return
		end

		self._leadStageEffects = {}

		for id, effect in pairs(sceneAll) do
			for k, v in pairs(effect) do
				local strs = string.split(k, "-")

				if strs[1] == "LEADSTAGE_BUFF" then
					self._leadStageEffects[id] = self._leadStageEffects[id] or {}
					self._leadStageEffects[id][v.id] = 1
				end
			end
		end
	end
end

function EffectCenter:getLeadStageEffectsById(masterId)
	if table.nums(self._leadStageEffects) > 0 and self._leadStageEffects[masterId] then
		return self._leadStageEffects[masterId]
	end

	return {}
end

function EffectCenter:setTSOULAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL

		if not effect then
			return
		end

		self._tsoulEffects = {}

		for heroId, v in pairs(effect) do
			for kk, vv in pairs(v) do
				if string.split(kk, "-")[1] == "TSOUL" then
					self._tsoulEffects[heroId] = self._tsoulEffects[heroId] or {}
					self._tsoulEffects[heroId] = vv.attrs
				end
			end
		end
	end
end

function EffectCenter:setMessageAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._messageEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.ALL

		if effect then
			for kk, vv in pairs(effect) do
				if string.split(kk, "_")[1] == "MSGCARD" then
					for kkk, vvv in pairs(vv.attrs) do
						local vvn = vvv

						self._messageEffects[kkk] = self._messageEffects[kkk] and self._messageEffects[kkk] + vvn or vvn or 0
					end
				end
			end
		end

		self._oldMessageEffects = self._messageEffects
	end
end

function EffectCenter:setMessagePartyAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._messagePartyEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local party = {
			"XD",
			"MNJH",
			"BSNCT",
			"DWH",
			"WNSXJ",
			"SSZS"
		}

		for _, partyId in pairs(party) do
			local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL[partyId]

			if effect then
				self._messagePartyEffects[partyId] = self._messagePartyEffects[partyId] or {}

				for kk, vv in pairs(effect) do
					if string.split(kk, "_")[1] == "MSGCARD" then
						for kkk, vvv in pairs(vv.attrs) do
							local vvn = vvv

							self._messagePartyEffects[partyId][kkk] = self._messagePartyEffects[partyId][kkk] and self._messagePartyEffects[partyId][kkk] + vvn or vvn or 0
						end
					end
				end
			end
		end

		self._oldMessagePartyEffects = self._messagePartyEffects
	end
end

function EffectCenter:setMessageMasterAttrByType()
	if self._effCenterData.managers.AttrEffectManager then
		self._messageMasterEffects = {}

		if not self._effCenterData.managers.AttrEffectManager.effects.ALL then
			return
		end

		local effect = self._effCenterData.managers.AttrEffectManager.effects.ALL.MASTER

		if effect then
			for kk, vv in pairs(effect) do
				if string.split(kk, "_")[1] == "MSGCARD" then
					for kkk, vvv in pairs(vv.attrs) do
						local vvn = vvv

						self._messageMasterEffects[kkk] = self._messageMasterEffects[kkk] and self._messageMasterEffects[kkk] + vvn or vvn or 0
					end
				end
			end
		end

		self._oldMessageMasterEffects = self._messageMasterEffects
	end
end

function EffectCenter:getTSOULEffectsById(heroId, type)
	if self._tsoulEffects[heroId] then
		return self._tsoulEffects[heroId][type] or 0
	end

	return 0
end

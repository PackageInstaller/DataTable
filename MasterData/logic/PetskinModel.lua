-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/model/PetskinModel.lua

module("logic.extensions.petskin.model.PetskinModel", package.seeall)

local PetskinModel = class("PetskinModel", BaseModel)

PetskinModel.ReadFlag = "PetskinModel.ReadFlag"

function PetskinModel:ctor()
	PetskinModel.super.ctor(self)
end

function PetskinModel:onInit()
	self:onReset()
end

function PetskinModel:onReset()
	self.isInited = false
	self.skinMap = {}
	self.delSkinArr = {}
	self.otherUserSkinIdList = {}
	self._foreverSkinIds = {}
	self._hasDyPosterMap = {}
end

function PetskinModel:init(skinInfos)
	for i, v in ipairs(skinInfos) do
		local mo = PetskinMo.New()

		mo:initData(MatType.PET_SKIN, v.skinId, 1)
		mo:setData(v)

		self.skinMap[v.skinId] = mo
	end

	self.isInited = true

	self:_doDeleteSkin()
end

function PetskinModel:getIsUnlockDyPoster(posterId)
	if self._hasDyPosterMap[posterId] then
		return true
	end

	local cfg = PetSkinConfig.instance:getPosterModelCo(posterId)

	if cfg then
		if not string.nilorempty(cfg.unlockDynItem) then
			if MaterialMgr.getMatCount(cfg.unlockDynItem) > 0 then
				self._hasDyPosterMap[posterId] = true

				return true
			end

			return false
		else
			self._hasDyPosterMap[posterId] = true

			return true
		end
	end

	return false
end

function PetskinModel:addSkins(skinInfos)
	for i, v in ipairs(skinInfos) do
		local mo = PetskinMo.New()

		mo:initData(MatType.PET_SKIN, v.skinId, 1)
		mo:setData(v)

		self.skinMap[v.skinId] = mo
	end
end

function PetskinModel:deletedSkins(skinIds)
	for i, v in ipairs(skinIds) do
		table.insert(self.delSkinArr, v)
	end

	self:_doDeleteSkin()
end

function PetskinModel:_doDeleteSkin(skinIds)
	if self.isInited then
		for i, v in ipairs(self.delSkinArr) do
			self.skinMap[v] = nil
		end

		self.delSkinArr = {}
	end
end

function PetskinModel:getSkinInfoById(id)
	local mo = self.skinMap[id]

	if mo then
		return mo.data
	end
end

function PetskinModel:getSkinMoById(id)
	return self.skinMap[id]
end

function PetskinModel:getSkinInfoList()
	local list = {}

	for k, v in pairs(self.skinMap or {}) do
		table.insert(list, v)
	end

	return list
end

function PetskinModel:initOtherUserSkin(msg)
	self.otherUserSkinIdList = {}

	for i, data in ipairs(msg.skinInfos) do
		if data:HasField("expireTimeMillis") and checknumber(data.expireTimeMillis) > 0 then
			-- block empty
		else
			table.insert(self.otherUserSkinIdList, data.skinId)
		end
	end
end

function PetskinModel:getUserOwnSkinList()
	local skinHashList = {}

	for k, v in pairs(self.skinMap or {}) do
		local skinId = v:getId()

		if self:isForeverSkin(skinId) then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				if not cfg.quality then
					local quality = 0

					if quality > 0 then
						skinHashList[quality] = skinHashList[quality] or {}
						skinHashList[quality][skinId] = cfg
					end
				end
			end
		end
	end

	return skinHashList
end

function PetskinModel:getOtherUserOwnSkinList()
	local skinHashList = {}

	for k, v in pairs(self.otherUserSkinIdList or {}) do
		local skinId = v
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			if not cfg.quality then
				local quality = 0

				if quality > 0 then
					skinHashList[quality] = skinHashList[quality] or {}
					skinHashList[quality][skinId] = cfg
				end
			end
		end
	end

	return skinHashList
end

function PetskinModel:getUserOwnSkinListBySkinGroup()
	local skinHashList = {}

	for k, v in pairs(self.skinMap or {}) do
		local skinId = v:getId()

		if self:isForeverSkin(skinId) then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				if not cfg.quality then
					local quality = 0

					if quality > 0 then
						if PetSkinConfig.instance:isExistSkinGroup(skinId) then
							if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(cfg) then
								skinHashList[quality] = skinHashList[quality] or {}
								skinHashList[quality][skinId] = cfg
							end
						else
							skinHashList[quality] = skinHashList[quality] or {}
							skinHashList[quality][skinId] = cfg
						end
					end
				end
			end
		end
	end

	return skinHashList
end

function PetskinModel:getUserOwnSkinNum()
	local skinNum = 0

	for k, v in pairs(self.skinMap or {}) do
		local skinId = v:getId()

		if self:isForeverSkin(skinId) then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				if not cfg.quality then
					local quality = 0

					if quality > 0 then
						if PetSkinConfig.instance:isExistSkinGroup(skinId) then
							if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(cfg) then
								skinNum = skinNum + 1
							end
						else
							skinNum = skinNum + 1
						end
					end
				end
			end
		end
	end

	return skinNum
end

function PetskinModel:getUserOwnSkinNumByQuality(qualityIdx)
	local skinNum = 0

	for k, v in pairs(self.skinMap or {}) do
		local skinId = v:getId()

		if self:isForeverSkin(skinId) then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				if not cfg.quality then
					local quality = 0

					if quality == qualityIdx then
						if PetSkinConfig.instance:isExistSkinGroup(skinId) then
							if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(cfg) then
								skinNum = skinNum + 1
							end
						else
							skinNum = skinNum + 1
						end
					end
				end
			end
		end
	end

	return skinNum
end

function PetskinModel:getOtherUserOwnSkinListBySkinGroup()
	local skinHashList = {}

	for k, v in pairs(self.otherUserSkinIdList or {}) do
		local skinId = v
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			if not cfg.quality then
				local quality = 0

				if quality > 0 then
					if PetSkinConfig.instance:isExistSkinGroup(skinId) then
						if PetSkinConfig.instance:isMainSkinCfgBySkinGroup(cfg) then
							skinHashList[quality] = skinHashList[quality] or {}
							skinHashList[quality][skinId] = cfg
						end
					else
						skinHashList[quality] = skinHashList[quality] or {}
						skinHashList[quality][skinId] = cfg
					end
				end
			end
		end
	end

	return skinHashList
end

function PetskinModel:setForeverSkin(skinId)
	self._foreverSkinIds[skinId] = true
end

function PetskinModel:isForeverSkin(skinId)
	return self._foreverSkinIds[skinId]
end

function PetskinModel:setPetSkinOtherName(skinId, name)
	local mo = self:getSkinMoById(skinId)

	if mo then
		mo:setOtherName(name)
	end
end

function PetskinModel:getUnEnableEnterEffect(skinId)
	local key = string.format("%s#EnterEffect#%d", PetskinModel.ReadFlag, skinId)

	return GameUtil.getUserData(key) or false
end

function PetskinModel:setUnEnableEnterEffect(skinId, bool)
	local key = string.format("%s#EnterEffect#%d", PetskinModel.ReadFlag, skinId)

	return GameUtil.saveUserData(key, bool)
end

PetskinModel.instance = PetskinModel.New()

return PetskinModel

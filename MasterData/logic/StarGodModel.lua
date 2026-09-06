-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargod/model/StarGodModel.lua

module("logic.extensions.stargod.model.StarGodModel", package.seeall)

local StarGodModel = class("StarGodModel", BaseModel)

function StarGodModel:ctor()
	StarGodModel.super.ctor(self)
	self:onReset()
end

function StarGodModel:onInit()
	StarGodModel.colorTab = {
		Color.gray,
		Framework.ColorUtil.ParseColor("#009631"),
		Framework.ColorUtil.ParseColor("#284bac"),
		Framework.ColorUtil.ParseColor("#5a02ad"),
		Framework.ColorUtil.ParseColor("#ee490d"),
		Color.red
	}
end

function StarGodModel:onReset()
	self._messengerState = 0
	self._stargodList = {}
	self._capacityLevel = 0
	self._starGodFusionState = 0
	self._redFusionState = 0
	self._isAutoCombine = true
	self._isDataInited = false
end

function StarGodModel:setStarGodMsgerInfo(msg)
	self:onReset()

	self._messengerState = msg.starGodMessengerState

	for i, v in ipairs(msg.starGodList) do
		self:getStarGod(v.id, v)
	end

	self._capacityLevel = msg.capacityLevel
	self._starGodFusionState = msg.starGodFusionState
	self._redFusionState = msg.redFusionState
	self._isAutoCombine = msg.isAutoCombine
	self._isDataInited = true
end

function StarGodModel:isBagFull(isRed, delta)
	local cnt, cap = self:getBagInfo(isRed)

	return cap <= cnt + delta
end

function StarGodModel:getBagInfo(isRed)
	local capacity = StarGodConfig.instance:getBagCapacity(isRed, self._capacityLevel)
	local datas = self:getBagStarGods(isRed)
	local count = #datas

	return count, capacity
end

function StarGodModel:isDataInited()
	return self._isDataInited
end

function StarGodModel:setAutoCombine(isAuto)
	self._isAutoCombine = isAuto
end

function StarGodModel:isAutoCombine()
	return self._isAutoCombine
end

function StarGodModel:setMessengerState(state)
	self._messengerState = state
end

function StarGodModel:getMessengerState()
	return self._messengerState
end

function StarGodModel:isMessengerActive(id)
	return self:isMessengerActiveByState(self._messengerState, id)
end

function StarGodModel:isMessengerActiveByState(state, id)
	return GameUtil.isBitOpenByDigit(state, id - 1)
end

function StarGodModel:isAutoCombineMarked(isRed, id)
	return GameUtil.isBitOpenByDigit(self:getAutoCombineState(isRed), id - 1)
end

function StarGodModel:getAutoCombineState(isRed)
	if isRed then
		return self._redFusionState
	end

	return self._starGodFusionState
end

function StarGodModel:setAutoCombineState(isRed, state)
	if isRed then
		self._redFusionState = state
	else
		self._starGodFusionState = state
	end
end

function StarGodModel:getStoreStarGods()
	return self:_getStarGods(function(data, cfg)
		return data.place == 4
	end)
end

function StarGodModel:getBagStarGods(isRed)
	return self:_getStarGods(function(data, cfg)
		if data.place == 1 or data.place == 2 then
			if isRed then
				return cfg.quality == 1
			else
				return cfg.quality > 1
			end
		end

		return false
	end)
end

function StarGodModel:getAllInBagStarGods()
	return self:_getStarGods(function(data, cfg)
		if data.place == 1 or data.place == 2 then
			return true
		end

		return false
	end)
end

function StarGodModel:getUnlockBagStarGodsExcept(isRed, id)
	return (self:_getStarGods(function(data, cfg)
		if data.id == id then
			return false
		end

		if data.place == 1 then
			if isRed then
				return cfg.quality == 1
			else
				return cfg.quality > 1
			end
		end

		return false
	end))
end

function StarGodModel:getUnlockBagStarGods(isRed)
	return self:getUnlockBagStarGodsExcept(isRed, -1)
end

function StarGodModel:_getStarGods(func)
	local retList = {}

	for i = 1, #self._stargodList do
		local data = self._stargodList[i]
		local cfg = StarGodConfig.instance:getCfgByDefineId(data.defineId)

		if func(data, cfg) then
			table.insert(retList, data)
		end
	end

	return retList
end

function StarGodModel:getUsualInfos(id)
	local ret = {}

	ret.name = ""
	ret.icon = ""
	ret.quality = 1
	ret.baseExp = 0
	ret.level = 1
	ret.exp = 0
	ret.defineId = 1

	local data = StarGodModel.instance:getStarGodInfo(id)
	local cfg = StarGodConfig.instance:getCfgByDefineId(data.defineId)

	ret.level = data.levelId
	ret.exp = data.curExp
	ret.defineId = data.defineId

	if cfg ~= nil then
		ret.name = cfg.name
		ret.icon = cfg.icon
		ret.quality = cfg.quality
		ret.baseExp = cfg.baseExp
	end

	return ret
end

function StarGodModel:getStarGodInfo(id)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			return v
		end
	end
end

function StarGodModel:collectStarGods(ids)
	for i, v in ipairs(ids) do
		self:collectStarGod(v)
	end
end

function StarGodModel:fusionStarGods(ids)
	for i, v in ipairs(ids) do
		self:fusionStarGod(v)
	end
end

function StarGodModel:collectStarGod(id)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			v.place = 1
		end
	end
end

function StarGodModel:equipStarGod(id)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			v.place = 3
		end
	end
end

function StarGodModel:fusionStarGod(id)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			v.place = 66
		end
	end
end

function StarGodModel:changeLockState(id, isLock)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			v.place = isLock and 2 or 1
		end
	end
end

function StarGodModel:getLockState(id)
	for i, v in ipairs(self._stargodList) do
		if v.id == id and v.place == 2 then
			return true
		end
	end

	return false
end

function StarGodModel:setStarGodInfo(id, info)
	for i, v in ipairs(self._stargodList) do
		if v.id == id then
			v.defineId = info.defineId
			v.levelId = info.levelId
			v.curExp = info.curExp
			v.place = info.place

			if v.place == 3 or v.place == 66 then
				MaterialFacade.instance:AddMaterial(MatType.StarGod, id, -1)
			end
		end
	end
end

function StarGodModel:getStarGod(id, info)
	local tmp = StarGodMo.New()

	tmp.id = id
	tmp.defineId = info.defineId
	tmp.levelId = info.levelId or info.level
	tmp.curExp = info.curExp
	tmp.place = info.place

	table.insert(self._stargodList, tmp)

	if tmp.place == 1 or tmp.place == 2 then
		MaterialFacade.instance:AddMaterial(MatType.StarGod, id, 1)
	end
end

function StarGodModel:setEquipingStarGod(id)
	self._equipingStarGod = id
end

function StarGodModel:getEquipingStarGod()
	return self._equipingStarGod
end

function StarGodModel:setPetData(data)
	self._petData = data
end

function StarGodModel:getPetData()
	return self._petData
end

function StarGodModel:getPetId()
	return self._petData.petId
end

function StarGodModel:getPetStarGod(idx)
	return self._petData:getStarGods(idx)
end

function StarGodModel:getPetStarGodMo(idx)
	return nil
end

StarGodModel.instance = StarGodModel.New()

return StarGodModel

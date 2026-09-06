-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/model/PickAPetModel.lua

module("logic.extensions.pickapet.model.PickAPetModel", package.seeall)

local PickAPetModel = class("PickAPetModel")

PickAPetModel.GameType = {
	Default = 1,
	ChuangkongUnion = 3,
	QianNiaoZhenShen = 2
}

function PickAPetModel:ctor()
	self._levelCfg = nil
	self._levelIconArr = {}
	self._pickPetNum = 0
	self._gamePlayType = PickAPetModel.GameType.Default
	self._gateId = 1
	self._dealCountTime = 0
	self._levelId = 0
	self._levelNum = 0
	self._collect = 0
	self._levelStart = 0
	self._funcDataCls = nil
end

function PickAPetModel:onExit()
	self._levelCfg = nil
	self._levelIconArr = {}
	self._pickPetNum = 0
	self._gamePlayType = PickAPetModel.GameType.Default
	self._gateId = 1
	self._dealCountTime = 0
	self._levelId = 0
	self._levelNum = 0
	self._collect = 0
	self._levelStart = 0
	self._funcDataCls = nil
end

function PickAPetModel:_reset()
	self._levelCfg = nil
	self._levelIconArr = {}
	self._pickPetNum = 0
end

function PickAPetModel:setDataCls(cls)
	self._funcDataCls = cls or PickAPetInfoBase.New()
end

function PickAPetModel:getDataCls()
	return self._funcDataCls
end

function PickAPetModel:getGameType()
	return self._funcDataCls:getGameType()
end

function PickAPetModel:onGameOverCallback(callback)
	if self._funcDataCls then
		return self._funcDataCls:onGameOverCallback(callback)
	end
end

function PickAPetModel:getInitCollectNums()
	return self._funcDataCls:getParams()
end

function PickAPetModel:initGateInfo()
	self._gateCfg = PickAPetConfig.instance:getLevelCfg(self._funcDataCls:getGateId())
	self._levelId = self._gateCfg.startId - 1
	self._levelStart = self._gateCfg.startId - 1
	self._levelNum = self._gateCfg.levelNum
end

function PickAPetModel:initLevelInfo(key)
	key = key or self._levelId

	self:_reset()

	self._levelCfg = PickAPetConfig.instance:getCfgById(key)
	self._dealCountTime = self._levelCfg.time

	self:randomGate()
end

function PickAPetModel:setLevelId(gateID)
	self._levelId = gateID or self._levelId
end

function PickAPetModel:getLevelId()
	return self._levelId
end

function PickAPetModel:getLevelCfg()
	return self._levelCfg
end

function PickAPetModel:getLevelPetID()
	return self._levelCfg.icon
end

function PickAPetModel:getlevelNum()
	return self._levelNum
end

function PickAPetModel:getLevel()
	return self._levelId - self._levelStart
end

function PickAPetModel:setDealCountTime(time)
	self._dealCountTime = time
end

function PickAPetModel:getDealCountTime()
	return self._dealCountTime
end

function PickAPetModel:getCurPickPetNum()
	return self._pickPetNum
end

function PickAPetModel:getTotalPickPetNum()
	return self._levelCfg.targetNum
end

function PickAPetModel:getCollect()
	return self._collect
end

function PickAPetModel:randomGate()
	self._levelIconArr = {}

	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local tb = {}

	while #tb < self._levelCfg.targetNum do
		local istrue = false
		local num = math.random(1, self._levelCfg.rowAndCol[1] * self._levelCfg.rowAndCol[2])

		if #tb ~= nil then
			for i = 1, #tb do
				if tb[i] == num then
					istrue = true
				end
			end
		end

		if istrue == false then
			table.insert(tb, num)

			self._levelIconArr[num] = 1
		end
	end

	tb = nil

	if self._levelCfg.rowAndCol then
		for i = 1, self._levelCfg.rowAndCol[1] * self._levelCfg.rowAndCol[2] do
			self._levelIconArr[i] = self._levelIconArr[i] or math.random(2, #self._levelCfg.icons)
		end
	end
end

function PickAPetModel:getIconArr()
	return self._levelIconArr
end

function PickAPetModel:dealPickPet(raceId, target, callBack)
	if self._levelCfg.icon == raceId then
		self._pickPetNum = self._pickPetNum + 1
		self._collect = self._collect + 1

		GlobalDispatcher:dispatch(GlobalNotify.PickInfo)
		GlobalDispatcher:dispatch(GlobalNotify.PickRight, target)
	else
		self._dealCountTime = self._dealCountTime - 1

		GlobalDispatcher:dispatch(GlobalNotify.PickWrong, target)
	end

	if self._pickPetNum == self._levelCfg.targetNum then
		if self:getLevel() < self._levelNum then
			PickAPetController.instance:nextGame()
		else
			PickAPetController.instance:endGame(true, callBack)
		end
	end
end

PickAPetModel.instance = PickAPetModel.New()

return PickAPetModel

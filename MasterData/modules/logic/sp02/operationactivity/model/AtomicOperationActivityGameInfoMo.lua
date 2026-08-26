-- chunkname: @modules/logic/sp02/operationactivity/model/AtomicOperationActivityGameInfoMo.lua

module("modules.logic.sp02.operationactivity.model.AtomicOperationActivityGameInfoMo", package.seeall)

local AtomicOperationActivityGameInfoMo = pureTable("AtomicOperationActivityGameInfoMo")

function AtomicOperationActivityGameInfoMo:ctor()
	return
end

function AtomicOperationActivityGameInfoMo:init()
	self.curTargetCount = 0
	self.maxTargetCount = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.MaxTargetCount)
	self.targetCountLimitDic = {}
	self.targetCountDic = {}
	self.singleTargetDic = {}
	self.useTargetDic = {}
	self.unuseTargetDic = {}
	self.deltaTime = 0
	self.remainTime = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.GameTime)
	self.targetAppearTimeDic = {}
	self.targetConfigList = {}
	self.nearPointListDic = {}
	self.targetPosList = {}
	self.curScore = 0
	self.curHitCount = 0

	local config = AtomicOperationActivityConfig.instance:getPreparationConfig(AtomicOperationActivityEnum.PreparationId.MoreScoreEnemy)
	local paramList = string.split(config.buffpara, "|")

	self.replaceTargetDic = {}

	for _, param in ipairs(paramList) do
		local data = string.splitToNumber(param, "#")

		self.replaceTargetDic[data[1]] = data[2]
	end

	self.targetPosRemainTimeDic = {}

	local remainTimeRangeStr = AtomicOperationActivityConfig.instance:getConstStr(AtomicOperationActivityEnum.ConstId.PosCD)

	self.posRemainTimeRange = string.splitToNumber(remainTimeRangeStr, "#")
	self.targetPosIndexList = {}

	for i = 1, AtomicOperationActivityEnum.GameMaxTargetCount do
		self.targetPosIndexList[i] = true
	end

	self.countDownErrorStateTime = AtomicOperationActivityConfig.instance:getConstNum(AtomicOperationActivityEnum.ConstId.CountDownErrorStateTime)
	self.comboCount = 0
	self.maxComboCount = 0
	self.isPause = false
end

function AtomicOperationActivityGameInfoMo:getTargetNode(index)
	local infoMo = self.singleTargetDic[index]

	if not infoMo then
		infoMo = AtomicOperationActivityGameTargetMo.New()
		self.singleTargetDic[index] = infoMo
	end

	return infoMo
end

function AtomicOperationActivityGameInfoMo:addTargetNode(infoMo)
	self.useTargetDic[infoMo.index] = infoMo
	self.curTargetCount = self.curTargetCount + 1
	self.targetCountDic[infoMo.targetId] = self.targetCountDic[infoMo.targetId] or 0
	self.targetCountDic[infoMo.targetId] = self.targetCountDic[infoMo.targetId] + 1
end

function AtomicOperationActivityGameInfoMo:removeTargetNode(index)
	local infoMo = self.useTargetDic[index]

	self.useTargetDic[index] = nil
	self.curTargetCount = self.curTargetCount - 1
	self.targetCountDic[infoMo.targetId] = self.targetCountDic[infoMo.targetId] - 1
end

function AtomicOperationActivityGameInfoMo:isUseTargetIndex(index)
	return self.useTargetDic[index] ~= nil
end

function AtomicOperationActivityGameInfoMo:getTargetNum(targetId)
	return self.targetCountDic[targetId] or 0
end

function AtomicOperationActivityGameInfoMo:getNearPoint(index)
	return self.nearPointListDic[index]
end

function AtomicOperationActivityGameInfoMo:initPointData(points)
	tabletool.clear(self.targetPosList)

	for _, pointData in ipairs(points) do
		table.insert(self.targetPosList, pointData)
	end

	self.nearPointListDic = AtomicOperationActivityHelper.findNearPoint(self.targetPosList)
end

return AtomicOperationActivityGameInfoMo

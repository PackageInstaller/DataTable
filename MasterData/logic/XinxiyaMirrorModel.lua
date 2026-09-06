-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/model/XinxiyaMirrorModel.lua

module("logic.extensions.xinxiyamirror.model.XinxiyaMirrorModel", package.seeall)

local XinxiyaMirrorModel = class("XinxiyaMirrorModel", BaseModel)

function XinxiyaMirrorModel:ctor()
	self.activityType = 67
	self.activityMatId = 67001
	self.lastActivityId = nil
	self._mirrorBaseInfo = nil
	self._StagePowerList = nil
	self._battleRankList = nil
	self._cacheMirrorPet = nil
	self._lastMaxStageId = nil
end

function XinxiyaMirrorModel:onInit()
	XinxiyaMirrorModel.super.onInit(self)
	self:onReset()
end

function XinxiyaMirrorModel:onReset()
	self.lastActivityId = nil
	self._mirrorBaseInfo = nil
	self._StagePowerList = nil
	self._battleRankList = nil
	self._cacheMirrorPet = nil
	self._lastMaxStageId = nil
end

function XinxiyaMirrorModel:isXinxiyaMirrorOpen()
	local actId = XinxiyaMirrorConfig.instance:getOpenActivityId()

	return checknumber(actiId) > 0
end

function XinxiyaMirrorModel:getMirrorBaseInfo()
	return self._mirrorBaseInfo or {}
end

function XinxiyaMirrorModel:setMirrorPlayEff()
	if self._mirrorBaseInfo and self._mirrorBaseInfo.isPlayEff then
		self._mirrorBaseInfo.isPlayEff = false
	end
end

function XinxiyaMirrorModel:getBattleMirrorFormation()
	if self._mirrorBaseInfo == nil or self._mirrorBaseInfo.mirrorInfo == nil or self._mirrorBaseInfo.mirrorInfo.view == nil then
		return nil
	end

	return self._mirrorBaseInfo.mirrorInfo.view
end

function XinxiyaMirrorModel:isPassAllMirrorStage(planId)
	local allStageCfgs = XinxiyaMirrorConfig.instance:getBattleStageCfg(planId)

	if allStageCfgs == nil then
		return false
	end

	for _, cfg in pairs(allStageCfgs) do
		if cfg and checknumber(cfg.challengePlanId) == planId and ((self._mirrorBaseInfo and checknumber(self._mirrorBaseInfo.maxStageId) > 0 or nil) and self._mirrorBaseInfo.maxStageId) < checknumber(cfg.stageId) then
			return false
		end
	end

	return true
end

function XinxiyaMirrorModel:getMirrorItemsList(planId, isPass)
	local allStageCfgs = XinxiyaMirrorConfig.instance:getBattleStageCfg(planId)

	if allStageCfgs == nil then
		return
	end

	local maxStageId = 0

	if self._mirrorBaseInfo and checknumber(self._mirrorBaseInfo.maxStageId) > 0 then
		maxStageId = self._mirrorBaseInfo.maxStageId
	end

	local all = 6
	local maxNum = maxStageId

	if not isPass then
		maxNum = math.ceil((maxStageId + 1) / all) * all
	end

	if maxNum < all then
		maxNum = all
	end

	local targetList = {}

	for _, cfg in pairs(allStageCfgs) do
		if cfg and checknumber(cfg.challengePlanId) == planId and checknumber(cfg.stageId) > maxNum - all and maxNum >= checknumber(cfg.stageId) then
			local info = {}

			info.stageId = cfg.stageId
			info.masterId = cfg.creepsMasterId
			info.stageDesc = cfg.stageDesc
			info.sysPower = cfg.power
			info.mirPower = 0
			info.sysPrize = string.nilorempty(cfg.prize) and {} or string.split(cfg.prize, "#")
			info.mirPrize = string.nilorempty(cfg.MirrorPrize) and {} or string.split(cfg.MirrorPrize, "#")
			info.isSys = false
			info.isMir = false

			if isPass then
				info.isSys = true
				info.isMir = true
			elseif maxStageId >= cfg.stageId then
				info.isSys = true
				info.isMir = true
			elseif cfg.stageId == maxStageId + 1 and self._mirrorBaseInfo and self._mirrorBaseInfo.mirrorInfo then
				info.isSys = true
				info.mirPower = checknumber(self._mirrorBaseInfo.mirrorInfo.mirrorZdl)
			end

			table.insert(targetList, info)
		end
	end

	if #targetList ~= all then
		printError("sr---镜像   XinxiyaMirrorModel:getMirrorItemsList()    配置的挑战个数不是6的倍数？？ ", planId)
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.stageId < b.stageId
		end)
	end

	return targetList
end

function XinxiyaMirrorModel:getSingleMirrorItem(planId, stageId)
	local cfg = XinxiyaMirrorConfig.instance:getBattleStageCfg(planId, stageId)

	if cfg == nil or checknumber(cfg.stageId) ~= stageId then
		return nil
	end

	local info = {}

	info.stageId = cfg.stageId
	info.masterId = cfg.creepsMasterId
	info.sysPower = cfg.power
	info.mirPower = 0
	info.sysPrize = string.nilorempty(cfg.prize) and {} or string.split(cfg.prize, "#")
	info.mirPrize = string.nilorempty(cfg.MirrorPrize) and {} or string.split(cfg.MirrorPrize, "#")
	info.isSys = false

	if self:isPassAllMirrorStage(planId) then
		if self._mirrorBaseInfo.mirrorInfo and self._mirrorBaseInfo.mirrorInfo.stageId == stageId then
			info.isSys = true
			info.mirPower = checknumber(self._mirrorBaseInfo.mirrorInfo.mirrorZdl)
		end
	elseif cfg.stageId <= checknumber(self._mirrorBaseInfo.maxStageId) then
		info.isSys = true
	elseif cfg.stageId == checknumber(self._mirrorBaseInfo.maxStageId) + 1 and self._mirrorBaseInfo.mirrorInfo then
		info.isSys = true
		info.mirPower = checknumber(self._mirrorBaseInfo.mirrorInfo.mirrorZdl)
	end

	return info
end

function XinxiyaMirrorModel:getMirrorHeadList(stageId, masterId)
	local petSimpleView

	if self._mirrorBaseInfo and self._mirrorBaseInfo.mirrorInfo and self._mirrorBaseInfo.mirrorInfo.stageId == stageId and self._mirrorBaseInfo.mirrorInfo.view and self._mirrorBaseInfo.mirrorInfo.view.petSimpleView then
		petSimpleView = self._mirrorBaseInfo.mirrorInfo.view.petSimpleView
	end

	local petInfoList = {}

	if petSimpleView then
		for _, info in pairs(petSimpleView) do
			if info and checknumber(info.raceId) > 0 then
				local posId = self:_getMirrorPetPosition(self._mirrorBaseInfo.mirrorInfo.view, info.petId)

				print("sr---镜像 XinxiyaMirrorModel:getMirrorHeadList()  获取精灵站位 posId = ", postId, info.petId)

				if checknumber(posId) > 0 then
					petInfoList[posId] = {
						num = posId,
						raceId = info.raceId,
						curLv = info.curLv
					}
				end
			end
		end

		return petInfoList, true
	end

	local cfgs = XinxiyaMirrorConfig.instance:getMasterCreepsCfg(masterId)

	for _, info in pairs(cfgs or {}) do
		if info and checknumber(info.raceId) > 0 then
			petInfoList[info.posId] = {
				num = info.posId,
				raceId = info.raceId,
				curLv = info.lv
			}
		end
	end

	return petInfoList, false
end

function XinxiyaMirrorModel:_getMirrorPetPosition(viewInfo, petId)
	if viewInfo == nil or viewInfo.curForm == nil or viewInfo.curForm.pos == nil then
		printError("sr---镜像     XinxiyaMirrorModel:_getMirrorPetPosition()   下发站位数据空！")

		return 0
	end

	for pos, id in pairs(viewInfo.curForm.pos) do
		if pos and checknumber(id) == checknumber(petId) then
			return pos
		end
	end

	return 0
end

function XinxiyaMirrorModel:resetOrSetMirrorPet(isSet)
	return
end

function XinxiyaMirrorModel:checkIsMirrorPet(raceId)
	return self._cacheMirrorPet ~= nil and checknumber(self._cacheMirrorPet[raceId]) > 0
end

function XinxiyaMirrorModel:getXinxiyaRedpoint()
	local actId = XinxiyaMirrorConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return false
	end

	if self._mirrorBaseInfo == nil then
		return false
	end

	if not self._mirrorBaseInfo.isDailyPrize then
		return true
	end

	if self._mirrorBaseInfo.hadBuff then
		return false
	end

	local cfg = XinxiyaMirrorConfig.instance:getOpenTimeCfg(actId)

	if cfg == nil or checknumber(cfg.buffTimes) <= checknumber(self._mirrorBaseInfo.usedTimes) then
		return false
	end

	return true
end

function XinxiyaMirrorModel:scSendMirrorInfo(msg)
	self._mirrorBaseInfo = {}

	if msg == nil then
		return
	end

	self._lastMaxStageId = checknumber(self._lastMaxStageId)
	self._mirrorBaseInfo.maxStageId = checknumber(msg.maxStageId)
	self._mirrorBaseInfo.isPlayEff = false

	if self._lastMaxStageId > 0 and self._lastMaxStageId + 1 == self._mirrorBaseInfo.maxStageId then
		local rem = self._lastMaxStageId - math.floor(self._lastMaxStageId / 6) * 6

		if rem == 0 then
			self._mirrorBaseInfo.isPlayEff = true
		end
	end

	self._lastMaxStageId = self._mirrorBaseInfo.maxStageId
	self._mirrorBaseInfo.usedTimes = 0
	self._mirrorBaseInfo.hadBuff = false

	if msg.buffInfo then
		if checknumber(msg.buffInfo.usedTimes) > 0 then
			self._mirrorBaseInfo.usedTimes = msg.buffInfo.usedTimes
		end

		if msg.buffInfo.hadBuff then
			self._mirrorBaseInfo.hadBuff = true
		end
	end

	self._cacheMirrorPet = nil
	self._mirrorBaseInfo.mirrorInfo = nil

	if msg.mirror and checknumber(msg.mirror.stageId) > 0 and msg.mirror.view then
		self._mirrorBaseInfo.mirrorInfo = msg.mirror
	end

	self._mirrorBaseInfo.dailyItemNum = checknumber(msg.dailyItemNum)
	self._mirrorBaseInfo.isDailyPrize = msg.hadGainDailyPrize
	self._mirrorBaseInfo.dailyTimes = checknumber(msg.dailyTimes)

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMirrorBaseInfo)

	local viewData = self:getBattleMirrorFormation()

	if viewData and viewData.petSimpleView then
		self._cacheMirrorPet = {}

		for _, info in pairs(viewData.petSimpleView) do
			if info and checknumber(info.raceId) > 0 then
				self._cacheMirrorPet[info.raceId] = info.raceId
			end
		end
	end
end

function XinxiyaMirrorModel:scSendMirrorUseBuff(info)
	self._mirrorBaseInfo = self._mirrorBaseInfo or {}

	if info == nil then
		return
	end

	if checknumber(info.usedTimes) > 0 then
		self._mirrorBaseInfo.usedTimes = info.usedTimes
	end

	if info.hadBuff then
		self._mirrorBaseInfo.hadBuff = true
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMirrorBuffInfo, checknumber(self._mirrorBaseInfo.usedTimes), self._mirrorBaseInfo.hadBuff)
end

function XinxiyaMirrorModel:scSendsResetMirrorStage()
	self._mirrorBaseInfo = self._mirrorBaseInfo or {}
	self._mirrorBaseInfo.mirrorInfo = nil
	self._cacheMirrorPet = nil

	self:resetOrSetMirrorPet()
	GlobalDispatcher:dispatch(GlobalNotify.UpdateMirrorBaseInfo)
	GlobalDispatcher:dispatch(GlobalNotify.ResetMirrorStage, false)
end

function XinxiyaMirrorModel:scSendMirrorStagePower(info)
	self._StagePowerList = {}

	if info == nil then
		return
	end

	for _, item in pairs(info) do
		if item and checknumber(item.stageId) > 0 then
			self._StagePowerList[item.stageId] = checknumber(item.zdl)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMirrorStagePower)
end

function XinxiyaMirrorModel:scSendMirrorDailyPrize()
	self._mirrorBaseInfo = self._mirrorBaseInfo or {}

	if self._mirrorBaseInfo.isDailyPrize then
		return
	end

	local actId = XinxiyaMirrorConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		return
	end

	self._mirrorBaseInfo.isDailyPrize = true

	local cfg = XinxiyaMirrorConfig.instance:getOpenTimeCfg(actId)
	local count = checknumber(self._mirrorBaseInfo.dailyItemNum)

	if cfg and not string.nilorempty(cfg.dailyPrize) then
		local list = string.split(cfg.dailyPrize, ":")

		if checknumber(list[1]) == MatType.ACTIVITY_ITEM and checknumber(list[2]) == XinxiyaMirrorModel.instance.activityMatId then
			count = checknumber(self._mirrorBaseInfo.dailyItemNum) + checknumber(list[3])
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMirrorDailyPrize, true, count)
end

function XinxiyaMirrorModel:scSendNotifyMirrorEnd(msg)
	if msg == nil or not msg.isWin then
		return
	end

	self._mirrorBaseInfo = self._mirrorBaseInfo or {}

	if msg.buffInfo then
		if checknumber(msg.buffInfo.usedTimes) > 0 then
			self._mirrorBaseInfo.usedTimes = msg.buffInfo.usedTimes
		end

		if msg.buffInfo.hadBuff then
			self._mirrorBaseInfo.hadBuff = true
		end
	end

	if msg.mirror and checknumber(msg.mirror.stageId) > 0 and msg.mirror.view then
		self._mirrorBaseInfo.mirrorInfo = msg.mirror
	end
end

XinxiyaMirrorModel.instance = XinxiyaMirrorModel.New()

return XinxiyaMirrorModel

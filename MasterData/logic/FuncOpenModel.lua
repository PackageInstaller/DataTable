-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/model/FuncOpenModel.lua

module("logic.extensions.funcopen.model.FuncOpenModel", package.seeall)

local FuncOpenModel = class("FuncOpenModel", BaseModel)
local json = require("cjson")

function FuncOpenModel:ctor()
	return
end

function FuncOpenModel:onInit()
	self:onReset()
end

function FuncOpenModel:onReset()
	self._isTaskDataReady = false
	self._isMofangDataReady = false
	self._cacheMofangLv = 0
	self._status = -1

	MainUIFacade.instance:setNeedShowPetGuide(false)

	self._funcOpens = {}
	self._needShowFuncs = {}
	self._dataReadys = {}

	for k = 1, 3 do
		self._dataReadys[k] = false
	end
end

function FuncOpenModel:_onTaskDataReady()
	print("_onTaskDataReady")
	self:_tryInit(1)
end

function FuncOpenModel:_onMofangDataReady()
	print("_onMofangDataReady")
	self:_tryInit(2)
end

function FuncOpenModel:_onCopyDataReady()
	print("_onCopyDataReady")
end

function FuncOpenModel:_onWTowerDataReady()
	print("_onWTowerDataReady")
	self:_tryInit(3)
end

function FuncOpenModel:_tryInit(dataType)
	self._dataReadys[dataType] = true
end

function FuncOpenModel:isAllDataReady()
	for _, v in pairs(self._dataReadys) do
		if not v then
			return false
		end
	end

	return true
end

function FuncOpenModel:_onMofangLvUp(newLv)
	if self:isAllDataReady() then
		self:_checkFuncOpen(true)
	end
end

function FuncOpenModel:_onChallengeInit(funcs)
	self._needShowFuncs = {}
	self._funcOpens = {}

	for _, func in ipairs(funcs) do
		self._funcOpens[func.funcId] = self:getFuncIsOpen(func.funcId)
	end

	MainUIController.instance.taskOk = true

	GlobalDispatcher:dispatch(GlobalNotify.UpdateMainUIFuncs)
end

function FuncOpenModel:isDataInited()
	return self._dataReadys[1] and self._dataReadys[2]
end

function FuncOpenModel:getCacheMofangLv()
	return checknumber(self._cacheMofangLv)
end

function FuncOpenModel:setCacheMofangLv(value)
	self._cacheMofangLv = value
end

function FuncOpenModel:getNeedShowFuncs()
	return self._needShowFuncs
end

function FuncOpenModel:dequeueNeedShowFunc()
	if #self._needShowFuncs > 0 then
		local funcId = self._needShowFuncs[1]

		self._funcOpens[funcId] = true

		table.remove(self._needShowFuncs, 1)

		return funcId
	end

	return nil
end

function FuncOpenModel:getNeedShowFuncId()
	if #self._needShowFuncs > 0 then
		return self._needShowFuncs[1]
	end

	return nil
end

function FuncOpenModel:getFuncIsOpenFinished(funcId)
	return self._funcOpens[funcId] == true
end

local t = {}

function FuncOpenModel:_checkFuncOpen(isForce)
	table.clear(t)

	for k, v in pairs(self._funcOpens) do
		if self:getFuncIsOpen(k) == true then
			if v == false then
				table.insert(t, k)

				if k == 9 then
					MainUIFacade.instance:setNeedShowPetGuide(true)
				end

				if k == 62 then
					PowerCrystalModel.instance:checkRedDot()
				end
			end
		elseif v == true then
			isForce = true
		end
	end

	for _, funcId in ipairs(t) do
		self._funcOpens[funcId] = true

		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		if cfg.tipsType == 1 or cfg.tipsType == 3 then
			table.insert(self._needShowFuncs, funcId)
		end
	end

	if self:getFuncIsOpen(35) and self._status < 0 then
		self._status = 0
	end

	if #t > 0 or isForce then
		GlobalDispatcher:dispatch(GlobalNotify.OnNewFunctionOpen, t)
	end
end

function FuncOpenModel:getFuncIsOpen(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	return self:getFuncIsOpenWithCfg(cfg)
end

function FuncOpenModel:getFuncIsOpenWithCfg(cfg)
	if cfg == nil then
		return false
	end

	if cfg.hideWithReview == true and BootstrapPjaqGameConfigMgr.isReview then
		return false
	end

	return FuncOpenController.instance:getFuncIsOpenByCfg(cfg)
end

function FuncOpenModel:getFuncLockDescription(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	if cfg then
		return cfg.description
	else
		return "玩法还未解锁哦"
	end
end

function FuncOpenModel:getMofangTipsFunc()
	local funcId, level = -1, 999
	local funcs = FuncOpenConfig.instance:getFunctionOpens()

	for _, func in ipairs(funcs) do
		local openCondition = func.openCondition

		if openCondition and openCondition[1] == 2 and not self:getFuncIsOpen(func.funcId) and func.tipsType == 1 and level > openCondition[2] then
			funcId = func.funcId
			level = openCondition[2]
		end
	end

	return funcId, level
end

function FuncOpenModel:_onReceiveQilin()
	print("receive qilin change")

	self._status = 1

	self:_checkFuncOpen()
end

function FuncOpenModel:_onHeroChallengeStatusChange(challengeId, isAllReceived)
	if challengeId == 37 and isAllReceived and self._status <= 2 then
		self._status = 2
	elseif challengeId == 35 and isAllReceived then
		self._status = 3
	end

	self:_checkFuncOpen()
end

function FuncOpenModel:getHeroChallengeStatus()
	return self._status
end

function FuncOpenModel:getChallengePrizeReceived(challengeId, msg)
	for _, info in ipairs(msg) do
		if info.challengeId == challengeId then
			local params = json.decode(info.extJsonParams)

			return params.allPrized or false
		end
	end

	return false
end

FuncOpenModel.instance = FuncOpenModel.New()

return FuncOpenModel

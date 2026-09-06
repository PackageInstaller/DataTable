-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signinbuff/controller/SignInBuffController.lua

module("logic.extensions.signinbuff.controller.SignInBuffController", package.seeall)

local SignInBuffController = class("SignInBuffController", BaseController)

function SignInBuffController:onInit()
	self:onReset()
end

function SignInBuffController:onReset()
	self._signInBuffParamMap = {}
	self._signInUpdateCallbackMap = {}
end

function SignInBuffController:getInfo(activityId)
	SignInBuffAgent.instance:sendPM_SignInBuffInfoReq(activityId)
end

function SignInBuffController:handleGetInfo(msg)
	SignInBuffModel.instance:onGetInfo(msg)

	local activityId = checknumber(msg.activityId)

	self:_updateSignInBuffParamById(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.SignInBuffGetInfo)
end

function SignInBuffController:upgradeSignInBuff(activityId)
	SignInBuffAgent.instance:sendPM_UpgradeSignInBuffReq(activityId)
end

function SignInBuffController:handleUpgradeSignInBuff(msg)
	SignInBuffModel.instance:onUpgradeSignInBuff(msg)

	local activityId = checknumber(msg.activityId)

	self:_updateSignInBuffParamById(activityId)
	GlobalDispatcher:dispatch(GlobalNotify.SignInBuffUpgradeSignIn)
end

function SignInBuffController:handleBatchSignInBuffInfo(msg)
	SignInBuffModel.instance:handleBatchSignInBuffInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SignInBuffGetInfo)
end

function SignInBuffController:signInUpgradeBuff(activityId)
	local info = SignInBuffModel.instance:getBaseInfo(activityId)

	if info then
		if info.hasSignInToday then
			FloatWordMgr.instance:show("今日已签到")

			return
		end

		local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(activityId)

		if cfgs then
			local maxLevelCfg = cfgs[#cfgs]

			if maxLevelCfg.signInDays <= info.signInDays then
				FloatWordMgr.instance:show("已满级")

				return
			end
		end

		self:upgradeSignInBuff(activityId)
	end
end

function SignInBuffController:_updateSignInBuffParamById(activityId)
	self._signInBuffParamMap = self._signInBuffParamMap or {}

	if not self._signInBuffParamMap[activityId] then
		local param = {}
		local buffLevel = 0
		local buffCfg
		local isCanGain = false
		local isCurLvMax = false
		local hasSignInToday = false
		local info = SignInBuffModel.instance:getBaseInfo(activityId)

		if info then
			local lvCfgs = SignInBuffConfig.instance:getBuffCfgsByActId(activityId) or {}

			if #lvCfgs > 0 then
				hasSignInToday = info.hasSignInToday

				local signInDays = checknumber(info.signInDays)

				for _, cfg in ipairs(lvCfgs) do
					if signInDays >= cfg.signInDays then
						buffCfg = cfg
					else
						break
					end
				end

				local maxLevelCfg = lvCfgs[#lvCfgs]

				isCurLvMax = signInDays >= maxLevelCfg.signInDays

				if buffCfg then
					buffLevel = buffCfg.buffLevel
				end

				isCanGain = not hasSignInToday and not isCurLvMax
			end
		end

		param.info = info
		param.hasSignInToday = hasSignInToday
		param.buffCfg = buffCfg
		param.buffLevel = buffLevel
		param.isCurLvMax = isCurLvMax
		param.isCanGain = isCanGain
		self._signInBuffParamMap[activityId] = param

		local callbackMap = self._signInUpdateCallbackMap[activityId]

		if callbackMap then
			for _, cb in pairs(callbackMap) do
				GameUtil.callBack(cb, param)
			end
		end
	end
end

function SignInBuffController:getCurSignInBuffParam(activityId)
	if self._signInBuffParamMap then
		return self._signInBuffParamMap or self:getDefaultBuffShowParam()
	end
end

local DEFAULT_BUFF_PARAM = {
	buffLevel = 0,
	hasSign = false,
	isCurLvMax = false,
	isCanGain = false,
	hasSignInToday = false
}

function SignInBuffController:getDefaultBuffShowParam()
	return DEFAULT_BUFF_PARAM
end

function SignInBuffController:regSignInBuffUpdateCallback(activityId, subKey, updateCB)
	local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(activityId)

	if not cfgs then
		printError(string.format("签到buff验证配置: %s为空", activityId))
	end

	if not self._signInUpdateCallbackMap[activityId] then
		local callbackMap = {}
		local cbKey = string.format("%s_%s", activityId, subKey)

		if callbackMap[cbKey] then
			print(string.format("[SignInBuffController] 重复注册回调: %s", cbKey))
		end

		callbackMap[cbKey] = updateCB
		self._signInUpdateCallbackMap[activityId] = callbackMap

		GameUtil.callBack(updateCB, self:getDefaultBuffShowParam())
		self:getInfo(activityId)
	end
end

function SignInBuffController:unregSignInBuffUpdateCallback(activityId, subKey)
	local callbackMap = self._signInUpdateCallbackMap[activityId]

	if callbackMap then
		local cbKey = string.format("%s_%s", activityId, subKey)

		callbackMap[cbKey] = nil

		local isEmpty = true

		for _, _ in pairs(callbackMap) do
			isEmpty = false

			break
		end

		if isEmpty then
			self._signInUpdateCallbackMap[activityId] = nil
		end
	end
end

function SignInBuffController:regSignInBuffBtnClick(activityId, btnGo, errorCb)
	if btnGo then
		local _errorCallback = errorCb

		_errorCallback = _errorCallback or function(param)
			if not param.info then
				FloatWordMgr.instance:show("数据未初化" .. activityId)

				return
			end

			if not param.buffCfg then
				FloatWordMgr.instance:show("配置不存在" .. activityId)

				return
			end

			if param.hasSignInToday then
				FloatWordMgr.instance:show("今日已签到")

				return
			end

			if param.isCurLvMax then
				FloatWordMgr.instance:show("已满级")

				return
			end
		end

		local function clickFunc()
			local param = self:getCurSignInBuffParam(activityId)

			if param.isCanGain then
				self:upgradeSignInBuff(activityId)
			else
				GameUtil.callBack(_errorCallback, param)
			end
		end

		GameUtil.addClickHandler(btnGo, clickFunc, self)
	end
end

function SignInBuffController:unregSignInBuffBtnClick(btnGo)
	GameUtil.rmClickHandler(btnGo)
end

function SignInBuffController:regSignInBuffPart(activityId, subKey, btnGo, updateCB, errorCb)
	self:regSignInBuffUpdateCallback(activityId, subKey, updateCB)
	self:regSignInBuffBtnClick(activityId, btnGo, errorCb)
end

function SignInBuffController:unregSignInBuffPart(activityId, subKey, btnGo)
	self:unregSignInBuffUpdateCallback(activityId, subKey)
	self:unregSignInBuffBtnClick(btnGo)
end

function SignInBuffController:regSignInBuffPartSimple(activityId, btnGo, updateCB, errorCb)
	self:regSignInBuffPart(activityId, "subKey", btnGo, updateCB, errorCb)
end

function SignInBuffController:unregSignInBuffPartSimple(activityId, btnGo)
	self:unregSignInBuffPart(activityId, "subKey", btnGo)
end

function SignInBuffController:addCommonSignInBuffView(parentGo, parentPresentor, activityId)
	activityId = checknumber(activityId)

	if activityId <= 0 then
		printError(string.format("[SignInBuffController] addCommonSignInBuffView 打开通用签到buff失败，activityId非法: %s", activityId))

		return nil
	end

	local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(activityId)

	if not cfgs then
		return nil
	end

	return ViewMgr.instance:openAt(parentGo, ViewName.CommonSignInBuffView, parentPresentor, activityId)
end

SignInBuffController.instance = SignInBuffController.New()

return SignInBuffController

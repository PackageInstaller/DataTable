-- chunkname: @modules/logic/gm/model/GMMinusModel.lua

module("modules.logic.gm.model.GMMinusModel", package.seeall)

local GMMinusModel = class("GMMinusModel", BaseModel)

function GMMinusModel:onInit()
	self:reInit()
end

function GMMinusModel:reInit()
	self._firstLoginDataDict = {}
end

function GMMinusModel:setFirstLogin(k, v)
	self._firstLoginDataDict[k] = v
end

function GMMinusModel:getFirstLogin(k, defaultValue)
	local v = self._firstLoginDataDict[k]

	return v == nil and defaultValue or v
end

local s_constDataKeySet = {}
local s_constData = {}

function GMMinusModel:setConst(k, v)
	if s_constDataKeySet[k] then
		return
	end

	s_constDataKeySet[k] = true
	s_constData[k] = v
end

function GMMinusModel:getConst(k, defaultValue)
	if not s_constDataKeySet[k] then
		return defaultValue
	end

	return s_constData[k]
end

function GMMinusModel:setToPlayer(k, v)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return
	end

	local key = k .. "#" .. tostring(userId)

	self:setToUnity(key, v)
end

function GMMinusModel:getFromPlayer(k, defaultValue)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return defaultValue
	end

	local key = k .. "#" .. tostring(userId)

	return self:getFromUnity(key, defaultValue)
end

function GMMinusModel:setToUnity(k, v)
	PlayerPrefsHelper._set(k, v)
end

function GMMinusModel:getFromUnity(k, defaultValue)
	assert(defaultValue ~= nil)

	local isNum = type(defaultValue) == "number"

	return PlayerPrefsHelper._get(k, defaultValue, isNum)
end

function GMMinusModel:_addBtnText(parentGO)
	local go = GMController.instance:getGMNode("mainview", parentGO)
	local btnCmp = gohelper.findChildButtonWithAudio(go, "#btn_gm")
	local btnTextCmp = gohelper.findChildText(go, "#btn_gm/Text")

	return btnCmp, btnTextCmp, go
end

function GMMinusModel:addBtnGM(viewObj)
	if viewObj._btngm11235 then
		return viewObj._btngm11235
	end

	viewObj._btngm11235, viewObj._btntxtgm11235, viewObj._btngogm11235 = self:_addBtnText(viewObj.viewGO)

	gohelper.setActive(viewObj._btngogm11235, GMController.instance:isOpenGM())

	return viewObj._btngm11235
end

local function _defaultBtnGmFunc(viewObj)
	local T = viewObj.class
	local name = T.__cname
	local viewName = "GM_" .. name

	assert(ViewName[viewName], "please add customFunc when call btnGM_AddClickListener!!viewName not found: " .. viewName)
	ViewMgr.instance:openView(viewName)
end

function GMMinusModel:btnGM_AddClickListener(viewObj, customFunc)
	viewObj._btngm11235:AddClickListener(customFunc or _defaultBtnGmFunc, viewObj)
	viewObj.addEventCb(viewObj, MainController.instance, MainEvent.OnChangeGMBtnStatus, function(_viewObj)
		if not _viewObj then
			return
		end

		gohelper.setActive(_viewObj._btngogm11235, GMController.instance:isOpenGM())
	end, viewObj)
end

function GMMinusModel:btnGM_RemoveClickListener(viewObj)
	viewObj._btngm11235:RemoveClickListener()
end

local kMaxCountLimitStackOverflow = 20

local function _get_ori_func_key(T, funcName)
	return string.format("GM_%s_%s", T.__cname, funcName)
end

function GMMinusModel:saveOriginalFunc(T, funcName)
	assert(type(funcName) == "string")

	local func = T[funcName]

	if func == nil then
		local cls = T
		local safeLoopCount = kMaxCountLimitStackOverflow

		while cls.super and func == nil do
			if safeLoopCount <= 0 then
				logError("stack overflow >= " .. tostring(kMaxCountLimitStackOverflow))

				break
			end

			func = cls[funcName]
			cls = cls.super
			safeLoopCount = safeLoopCount - 1
		end
	end

	assert(type(func) == "function", "type(func)=" .. type(func) .. " funcName=" .. funcName)

	local key = _get_ori_func_key(T, funcName)

	self:setConst(key, func)
end

function GMMinusModel:loadOriginalFunc(T, funcName)
	local key = _get_ori_func_key(T, funcName)
	local func = self:getConst(key, nil)

	if not func then
		local cls = T.super
		local safeLoopCount = kMaxCountLimitStackOverflow

		while cls and func == nil do
			if safeLoopCount <= 0 then
				logError("stack overflow >= " .. tostring(kMaxCountLimitStackOverflow))

				break
			end

			key = _get_ori_func_key(cls, funcName)
			func = self:getConst(key, nil) or cls[funcName]
			cls = cls.super
			safeLoopCount = safeLoopCount - 1
		end
	end

	return func or function()
		assert(false, string.format("undefine behaviour: '%s:%s'", T.__cname, funcName))
	end
end

function GMMinusModel:callOriginalSelfFunc(viewObj, funcName, ...)
	local T = viewObj.class
	local f = self:loadOriginalFunc(T, funcName)

	return f(viewObj, ...)
end

function GMMinusModel:callOriginalStaticFunc(T, funcName, ...)
	local f = self:loadOriginalFunc(T, funcName)

	return f(...)
end

GMMinusModel.instance = GMMinusModel.New()

return GMMinusModel

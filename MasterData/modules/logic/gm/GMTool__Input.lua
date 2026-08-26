-- chunkname: @modules/logic/gm/GMTool__Input.lua

local sf = string.format
local ti = table.insert
local tc = table.concat
local getGlobal = _G.getGlobal
local GMTool = _G.getGlobal("Partial_GMTool")
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local GameObjectHelper = SLFramework.GameObjectHelper
local EventSystem = UnityEngine.EventSystems.EventSystem
local CS_List_RaycastResult = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult
local PointerEventData = UnityEngine.EventSystems.PointerEventData
local M = {}
local kGreen = "#00FF00"
local kYellow = "#FFFF00"
local kLangSettingsLuaLangFuncName1 = "_luaLang"
local kLangSettingsLuaLangFuncName2 = "_lang"
local csInstResLogMgr = SLFramework.ResLogMgr.Instance

local function _gm(cmd)
	local rpc = getGlobal("GMRpc")

	if rpc then
		rpc.instance:sendGMRequest(cmd)
	end
end

local function _logout()
	local ctl = getGlobal("LoginController")

	if ctl then
		ctl.instance:logout()
	end
end

function M:_super()
	local cmds = {
		"add hero all 1",
		"add material 10#10#100",
		"add material 2#5#1000000",
		"add allfaith 22222",
		"set level 60",
		"add equip 0#30#1",
		"set dungeon all"
	}

	for i = 1, #cmds do
		_gm(cmds[i])
	end
end

function M:_showMouseClickGoName()
	local current = EventSystem.current

	if not current or not current:IsPointerOverGameObject() then
		return
	end

	local go = current.currentSelectedGameObject

	if gohelper.isNil(go) then
		local mainCam = getGlobal("CameraMgr") and CameraMgr.instance:getMainCamera()

		if mainCam then
			local v3 = Input.mousePosition

			self._pointerEventData = self._pointerEventData or PointerEventData.New(EventSystem.current)
			self._pointerEventData.position = v3
			self._csList = self._csList or CS_List_RaycastResult.New()

			current:RaycastAll(self._pointerEventData, self._csList)

			if self._csList.Count > 0 then
				local raycastResult = self._csList[0]

				go = raycastResult.gameObject
			end
		end
	end

	if not gohelper.isNil(go) then
		logNormal(GMTool.util.setColorDesc(GameObjectHelper.GetPath(go), kGreen))
	end
end

function M:_getOpeningViewNameList()
	local openViewList = ViewMgr.instance:getOpenViewNameList() or {}
	local list = {}

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]
		local viewContainer = ViewMgr.instance:getContainer(viewName)

		if viewContainer and not ViewHelper.instance:checkIsGlobalIgnore(viewName) then
			table.insert(list, viewName)
		end
	end

	return list
end

function M:_showOpeningViewName()
	local viewNameList = self:_getOpeningViewNameList()

	if #viewNameList > 0 then
		local sb = {}

		table.insert(sb, "GM [正在打开的UI]:")

		for i, viewName in ipairs(viewNameList) do
			local str = GMTool.util.setColorDesc(i, kYellow) .. " " .. GMTool.util.setColorDesc(viewName, kGreen)

			table.insert(sb, str)
		end

		logError(tc(sb, "\n"))
	end
end

function M._hookLangSettings__luaLang_rawkey(SelfObj, key)
	return
end

function M:_hookLangSettings__luaLang(isUseOrigin)
	local f

	LangSettings[kLangSettingsLuaLangFuncName1] = isUseOrigin and GMMinusModel.instance:loadOriginalFunc(LangSettings, kLangSettingsLuaLangFuncName1) or function(SelfObj, key)
		return key
	end
end

function M:_hookLangSettings__lang(isUseOrigin)
	local f

	LangSettings[kLangSettingsLuaLangFuncName2] = isUseOrigin and GMMinusModel.instance:loadOriginalFunc(LangSettings, kLangSettingsLuaLangFuncName2) or function(SelfObj, key)
		return key
	end
end

function M:_switchLuaLang()
	local isActive = not self._mlStringEnable

	self:_hookLangSettings__luaLang(isActive)
	self:_hookLangSettings__lang(isActive)

	self._mlStringEnable = isActive
end

function M:_switchResLog()
	if self._resLogEnable == nil then
		self._resLogEnable = true
		csInstResLogMgr.Enable = true

		return
	end

	local isLogConsole = self._resLogEnable == true

	if isLogConsole then
		local inst = SLFramework.ResLogMgr.Instance
		local list = {}
		local csList = inst:GetList()
		local n = csList.Count

		if n > 0 then
			for i = 0, n - 1 do
				local resLog = csList[i]
				local cost = resLog.loadedTime - resLog.loadTime
				local item = {
					cost = cost,
					loadedTime = resLog.loadedTime,
					loadTime = resLog.loadTime,
					path = resLog.path,
					size = resLog.size,
					_id = i
				}

				ti(list, item)
			end
		end

		if #list > 0 then
			table.sort(list, function(a, b)
				local a_loadTime = a.loadTime
				local b_loadTime = b.loadTime

				if a_loadTime ~= b_loadTime then
					return a_loadTime < b_loadTime
				end

				local a_cost = a.cost
				local b_cost = b.cost

				if a_cost ~= b_cost then
					return b_cost < a_cost
				end

				local a_size = a.size
				local b_size = b.size

				if a_size ~= b_size then
					return b_size < a_size
				end

				return a._id < b._id
			end)
		end

		local strList = {}
		local lastLoadTime
		local seq = 0
		local tot_cost = 0
		local tot_sizeMB = 0

		for i, item in ipairs(list) do
			local cost = sf("%.3fs", item.cost)
			local loadTime = sf("%.2f", item.loadTime)

			if loadTime ~= lastLoadTime then
				seq = seq + 1
				lastLoadTime = loadTime

				if item.cost < 0 then
					return
				end

				if item.cost < 10 then
					tot_cost = tot_cost + item.cost
				end
			end

			local size = tonumber(tostring(item.size))
			local sizeMB = sf("%.4f MB", size / 1024 / 1024)

			tot_sizeMB = tot_sizeMB + size

			local s = sf("%s (%s): cost=%s, size=%s, path=%s", i, seq, cost, sizeMB, item.path)

			ti(strList, s)
		end

		tot_sizeMB = sf("%.4f MB", tot_sizeMB / 1024 / 1024)

		ti(strList, 1, sf("tot_cnt: %s, tot_size: %s, tot_cost: %s seconds", n, tot_sizeMB, tot_cost))
		logError(tc(strList, "\n"))
	end

	self._resLogEnable = not self._resLogEnable
	csInstResLogMgr.Enable = self._resLogEnable
end

function M:onClear()
	self._pointerEventData = nil
	self._csList = nil
	self._resLogEnable = nil

	if self._mlStringEnable == false then
		self:_switchLuaLang()
	else
		GMMinusModel.instance:saveOriginalFunc(LangSettings, kLangSettingsLuaLangFuncName1)
		GMMinusModel.instance:saveOriginalFunc(LangSettings, kLangSettingsLuaLangFuncName2)
	end

	self._mlStringEnable = true
	csInstResLogMgr.Enable = false

	return self
end

function M:onUpdate()
	local lAlt = Input.GetKey(KeyCode.LeftAlt)
	local rAlt = Input.GetKey(KeyCode.RightAlt)
	local alt = lAlt or rAlt
	local lShift = Input.GetKey(KeyCode.LeftShift)
	local rShift = Input.GetKey(KeyCode.RightShift)
	local lCtrl = Input.GetKey(KeyCode.LeftControl)
	local rCtrl = Input.GetKey(KeyCode.RightControl)
	local ctrl = lCtrl or rCtrl

	if Input.GetKeyDown(KeyCode.F12) then
		logNormal("F12 logout")
		_logout()
	elseif Input.GetKeyDown(KeyCode.F2) then
		logNormal("F2 super")
		self:_super()
	elseif ctrl and Input.GetMouseButtonUp(0) then
		logNormal("Ctrl + Left Mouse Click")
		self:_showMouseClickGoName()
	elseif ctrl and alt and Input.GetKeyDown(KeyCode.Alpha1) then
		logNormal("Ctrl + Alt + 1")
		self:_switchLuaLang()
	elseif ctrl and alt and Input.GetKeyDown(KeyCode.Alpha2) then
		logNormal("Ctrl + Alt + 2")
		self:_showOpeningViewName()
	elseif ctrl and alt and Input.GetKeyDown(KeyCode.Alpha3) then
		logNormal("Ctrl + Alt + 3")
		self:_switchResLog()
	end
end

GMTool._input = M:onClear()

return {}

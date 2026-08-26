-- chunkname: @modules/logic/gm/GMTool__ViewHooker.lua

local getGlobal = _G.getGlobal
local GMTool = _G.getGlobal("Partial_GMTool")
local addGlobalModule = _G.addGlobalModule
local sf = string.format
local M = {}

function M:onClear()
	self._sHookSet = self._sHookSet or {}

	ViewMgr.instance:unregisterCallback(ViewEvent.BeforeOpenView, self._onBeforeOpenView, self)

	return self
end

function M:_isInSet(k)
	if not k then
		return false
	end

	return self._sHookSet[k]
end

function M:_addInSet(k, v)
	if not k then
		return
	end

	self._sHookSet[k] = v
end

function M:_try_inject(clsName)
	if self:_isInSet(clsName) then
		return
	end

	local T = getGlobal(clsName)

	if not T then
		return
	end

	local hookFuncName = sf("_hook_%s", clsName)

	if not self[hookFuncName] then
		logError(sf("[GMTool__ViewHooker] please add M:%s(T)!!!", hookFuncName))

		return
	end

	self[hookFuncName](self, T)
	self:_addInSet(clsName, T)
end

local kPrefix = "GM_"

function M:_onBeforeOpenView(viewName)
	local GMName = kPrefix .. viewName
	local clsPath = _G.getModulePath(GMName)

	if not clsPath then
		local major, minor = string.match(viewName, "VersionActivity(%d+)_(%d+)DungeonMapView")

		if major and minor then
			clsPath = _G.getModulePath("GM_VersionActivity_DungeonMapView")

			local cls = addGlobalModule(clsPath)

			cls.register(tonumber(major), tonumber(minor))
		end

		return
	end

	local cls = addGlobalModule(clsPath)

	cls.register()
end

local module_views_GM = require("modules.setting.module_views_GM")

for viewName, setting in pairs(module_views_GM) do
	if ViewMgr.instance:getSetting(viewName) then
		logWarn("module_views_GM warning: 重复定义 ViewName." .. viewName)
	else
		ViewMgr.instance._viewSettings[viewName] = setting

		rawset(ViewName, viewName, viewName)
	end
end

GMTool._viewHooker = M:onClear()

ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, M._onBeforeOpenView, M)

local kHookList = {
	"GMToolView",
	"MainController"
}

function M:_hook_GMToolView(T)
	self:_onBeforeOpenView(ViewName.GMToolView)
end

function M:_hook_MainController(T)
	return
end

local function hookOnce()
	for _, clsName in ipairs(kHookList) do
		M:_try_inject(clsName)
	end
end

hookOnce()

return {}

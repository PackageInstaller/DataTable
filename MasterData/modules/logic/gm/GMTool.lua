-- chunkname: @modules/logic/gm/GMTool.lua

local kName11235 = "Partial_GMTool"
local debug_getupvalue = _G.debug.getupvalue
local tostring = _G.tostring
local tonumber = _G.tonumber
local assert = _G.assert
local string_find = _G.string.find
local type = _G.type
local tc = table.concat
local kGreen = "#00FF00"
local kWhite = "#FFFFFF"
local kYellow = "#FFFF00"

local function _clear(Self)
	UpdateBeat:Remove(Self._update, Self)

	for k, v in pairs(Self) do
		if type(v) == "table" and v.onClear then
			v:onClear()
			logNormal(k .. "<color=#00FF00> clear finished </color>")
		end
	end
end

local function _setColorDesc(desc, hexColor)
	if desc ~= nil and type(desc) ~= "string" then
		desc = tostring(desc)
	end

	if string.nilorempty(desc) then
		desc = "[None]"
	end

	return gohelper.getRichColorText(desc, hexColor or kWhite)
end

local function _colorBoolStr(isTrue)
	return isTrue and _setColorDesc("true", kGreen) or _setColorDesc("false", kYellow)
end

local function _getUpvalue(func, varName, st, ed)
	assert(varName)

	if ed then
		assert(tonumber(st) ~= nil)
	end

	for i = st or 1, ed or math.huge do
		local key, val = debug_getupvalue(func, i)

		if not key then
			break
		end

		if key == varName then
			return val
		end
	end
end

local function _startsWith(str, targetStr)
	if string.nilorempty(str) or string.nilorempty(targetStr) then
		return false
	end

	local s, _ = string_find(str, targetStr)

	return s == 1
end

local function _endsWith(str, targetStr)
	if string.nilorempty(str) or string.nilorempty(targetStr) then
		return false
	end

	local n = #str - #targetStr + 1

	if n < 1 then
		return false
	end

	return str:sub(n) == targetStr
end

local function _saveClipboard(str)
	ZProj.UGUIHelper.CopyText(str)
end

local function _usage()
	local sb = {}

	local function __add(shortCutKey, desc)
		if not desc then
			table.insert(sb, shortCutKey)
		else
			table.insert(sb, _setColorDesc(shortCutKey, kGreen) .. ": " .. _setColorDesc(desc, kYellow))
		end
	end

	__add("================= (海外GM) 使用方式 =================")
	__add("LCtrl(x2)", "                             可打印玩家信息")
	__add("Ctrl + 鼠标左键 + 点击UI", "可查看UI最顶层点击到的节点路径")
	__add("F2", "                                         通关所有关卡")
	__add("F12", "                                       退出登录")
	__add("Ctrl + Alt + 3", "                      开/关资源加载耗时Log")
	__add("Ctrl + Alt + 2", "                      查看正在打开的ViewNames")
	__add("Ctrl + Alt + 1", "                      显示/隐藏LangKey")

	return tc(sb, "\n")
end

local _oldM = getGlobal(kName11235)

if _oldM then
	logNormal("<color=#00FF00> hotfix finished </color>")
	_clear(_oldM)
else
	logNormal("<color=#00FF00>Hello World!</color>\n" .. _usage())
end

local M = _oldM or {}

setGlobal(kName11235, M)

function M._update()
	M._accountDummper:onUpdate()
	M._input:onUpdate()
end

M.util = {
	setColorDesc = _setColorDesc,
	getUpvalue = _getUpvalue,
	startsWith = _startsWith,
	endsWith = _endsWith,
	colorBoolStr = _colorBoolStr,
	saveClipboard = _saveClipboard
}

require("modules/logic/gm/GMTool__Input")
require("modules/logic/gm/GMTool__AccountDummper")
require("modules/logic/gm/GMTool__ViewHooker")
UpdateBeat:Add(M._update, M)

return {}

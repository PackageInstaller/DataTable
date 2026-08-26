-- chunkname: @modules/versionactivitybase/mainfixed/VersionActivityMainFixedHelper.lua

module("modules.versionactivitybase.mainfixed.VersionActivityMainFixedHelper", package.seeall)

local VersionActivityMainFixedHelper = class("VersionActivityMainFixedHelper")
local _version = {
	big = 3,
	small = 8
}

function VersionActivityMainFixedHelper.getActivityChapter()
	return DungeonEnum.ChapterId.Main1_13
end

function VersionActivityMainFixedHelper.getDungeonEnterReddot()
	local id = VersionActivityMainFixedHelper.getVersionActivityDungeonEnterReddotId()

	if not id then
		logError("VersionActivityMainFixedHelper.getDungeonEnterReddot id is nil")
	end

	return id
end

function VersionActivityMainFixedHelper.getDungeonTaskReddot()
	local id = VersionActivityMainFixedHelper.getVersionActivityDungeonTaskReddotId()

	if not id then
		logError("VersionActivityMainFixedHelper.getDungeonTaskReddot id is nil")
	end

	return id
end

function VersionActivityMainFixedHelper.getActivityCurrency()
	local id = VersionActivityMainFixedHelper.getVersionActivityCurrencyType()

	if not id then
		logError("VersionActivityMainFixedHelper.getActivityCurrency id is nil")
	end

	return id
end

local _versionTable
local foramt1 = "%s_%s"
local foramt2 = "V%sa%s"
local foramt3 = "v%sa%s"

local function _getVersion(big, small)
	return big or _version.big, small or _version.small
end

local function _getVersionFuncForamt(funcName, foramt, big, small)
	big, small = _getVersion(big, small)

	local _format = string.format(foramt, big, small)

	return string.format(funcName, _format)
end

local function _getVersionTable(big, small)
	big, small = _getVersion(big, small)
	_versionTable = _versionTable or {}
	_versionTable[big] = _versionTable[big] or {}
	_versionTable[big][small] = _versionTable[big][small] or {}

	return _versionTable[big][small]
end

function VersionActivityMainFixedHelper.setMainActivitySprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._MainActivitySpriteFunc

	if not func then
		func = _getVersionFuncForamt("set%sMainActivitySprite", foramt2, big, small)
		_versionTable[big][small]._MainActivitySpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityMainFixedHelper.setDungeonSprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonSpriteFunc

	if not func then
		func = _getVersionFuncForamt("set%sDungeonSprite", foramt2, big, small)
		_versionTable[big][small]._DungeonSpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityMainFixedHelper.setCustomDungeonStore(id)
	VersionActivityMainFixedHelper._customDungeonStore = id
end

function VersionActivityMainFixedHelper.getVersionActivityVer(big, small)
	big, small = _getVersion(big, small)

	return big, small
end

function VersionActivityMainFixedHelper.getVersionActivityVerFormat1(big, small)
	big, small = _getVersion(big, small)

	return string.format(foramt1, big, small)
end

function VersionActivityMainFixedHelper.getVersionActivityVerFormat2(big, small)
	big, small = _getVersion(big, small)

	return string.format(foramt2, big, small)
end

function VersionActivityMainFixedHelper.getVersionActivityVerFormat3(big, small)
	big, small = _getVersion(big, small)

	return string.format(foramt3, big, small)
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonStore(big, small)
	if VersionActivityMainFixedHelper._customDungeonStore then
		return VersionActivityMainFixedHelper._customDungeonStore
	end

	return VersionActivityMainFixedHelper.getVersionActivityEnum(big, small).ActivityId.DungeonStore
end

function VersionActivityMainFixedHelper.getVersionActivityEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._Enum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._Enum = _G[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityEnterViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._EnterViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnterView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._EnterViewName = ViewName[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityStoreViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sStoreView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._StoreViewName = ViewName[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityTaskViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._TaskViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sTaskView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._TaskViewName = ViewName[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._DungeonEnum = _G[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonEnterReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnter

	if not func then
		local title = _getVersionFuncForamt("%sDungeonEnter", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonEnter = RedDotEnum.DotNode[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonTaskReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonTask

	if not func then
		local title = _getVersionFuncForamt("%sDungeonTask", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonTask = RedDotEnum.DotNode[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityCurrencyType(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._CurrencyType

	if not func then
		local title = _getVersionFuncForamt("%sDungeon", foramt2, big, small)

		func = CurrencyEnum.CurrencyType[title]
		_versionTable[big][small]._CurrencyType = CurrencyEnum.CurrencyType[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityAudioBgmLayer(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._AudioBgmLayer

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sMain", foramt1, big, small)

		func = AudioBgmEnum.Layer[title]
		_versionTable[big][small]._AudioBgmLayer = AudioBgmEnum.Layer[title]
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityStoreRareIcon(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreRareIcon

	if not func then
		func = _getVersionFuncForamt("%s_store_quality_", foramt3, big, small)
		_versionTable[big][small]._StoreRareIcon = func
	end

	return func
end

function VersionActivityMainFixedHelper._getFixed(big, small, name)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table[name]

	if not func then
		local _format = "VersionActivity%s" .. name
		local title = _getVersionFuncForamt(_format, foramt1, big, small)
		local fixedTitle = string.format(_format, "MainFixed")

		func = _G[title] or _G[fixedTitle]
		_versionTable[big][small][name] = func
	end

	return func
end

function VersionActivityMainFixedHelper.getVersionActivityEnterController(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "EnterController")
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonController(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "DungeonController")
end

function VersionActivityMainFixedHelper.getVersionActivityStoreGoodsItem(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "StoreGoodsItem")
end

function VersionActivityMainFixedHelper.getVersionActivityStoreItem(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "StoreItem")
end

function VersionActivityMainFixedHelper.getVersionActivityStoreView(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "StoreView")
end

function VersionActivityMainFixedHelper.getVersionActivityTaskItem(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "TaskItem")
end

function VersionActivityMainFixedHelper.getVersionActivityTaskView(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "TaskView")
end

function VersionActivityMainFixedHelper.getVersionActivityDungeonEnterView(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "DungeonEnterView")
end

function VersionActivityMainFixedHelper.getVersionActivitySubAnimatorComp(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "SubAnimatorComp")
end

function VersionActivityMainFixedHelper.getVersionActivityEnterBgmView(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "EnterBgmView")
end

function VersionActivityMainFixedHelper.getVersionActivityEnterView(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "EnterView")
end

function VersionActivityMainFixedHelper.getVersionActivityEnterViewTabItem1(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "EnterViewTabItem1")
end

function VersionActivityMainFixedHelper.getVersionActivityEnterViewTabItem2(big, small)
	return VersionActivityMainFixedHelper._getFixed(big, small, "EnterViewTabItem2")
end

function VersionActivityMainFixedHelper.isTargetVersion(big, small)
	return _version.big == big and _version.small == small
end

return VersionActivityMainFixedHelper

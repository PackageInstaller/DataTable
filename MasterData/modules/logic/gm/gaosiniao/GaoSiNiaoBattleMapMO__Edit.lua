-- chunkname: @modules/logic/gm/gaosiniao/GaoSiNiaoBattleMapMO__Edit.lua

local sf = string.format
local ti = table.insert
local string_rep = string.rep
local ser = require("modules.logic.gm.gaosiniao.ser")
local readonly = require("modules.logic.gm.gaosiniao.readonly")
local RD = require("modules.logic.gm.gaosiniao.reverse_define")
local _B = Bitwise

GaoSiNiaoEnum.GridType._edit_BagPath = GaoSiNiaoEnum.GridType.__End + 1
GaoSiNiaoEnum.rZoneMask = RD(GaoSiNiaoEnum, "ZoneMask")
GaoSiNiaoEnum.rGridType = RD(GaoSiNiaoEnum, "GridType")
GaoSiNiaoEnum.rPathType = RD(GaoSiNiaoEnum, "PathType")
GaoSiNiaoEnum.rPathInfo = RD(GaoSiNiaoEnum, "PathInfo")
GaoSiNiaoEnum.rPathSpriteId = RD(GaoSiNiaoEnum, "PathSpriteId")

function GaoSiNiaoEnum._edit_nameOfGridType(eGridType)
	local E = GaoSiNiaoEnum.GridType

	if eGridType == E.Empty then
		return "空地"
	elseif eGridType == E.Start then
		return "起点"
	elseif eGridType == E.End then
		return "终点"
	elseif eGridType == E.Wall then
		return "墙"
	elseif eGridType == E.Portal then
		return "传送门"
	elseif eGridType == E.Path then
		return "固定路径"
	elseif eGridType == E._edit_BagPath then
		return "(Edit) 背包路径"
	else
		assert(false, "unsupported GaoSiNiaoEnum.GridType : " .. tostring(eGridType))
	end
end

function GaoSiNiaoEnum._edit_nameOfPathType(ePathType)
	local E = GaoSiNiaoEnum.PathType

	if ePathType == E.RB then
		return "→↓"
	elseif ePathType == E.LT then
		return "←↑"
	elseif ePathType == E.LRTB then
		return "↑→↓←"
	elseif ePathType == E.TB then
		return "↑↓"
	elseif ePathType == E.LB then
		return "←↓"
	elseif ePathType == E.RT then
		return "↑→"
	elseif ePathType == E.LR then
		return "←→"
	elseif ePathType == E.LTB then
		return "←↑↓"
	elseif ePathType == E.RTB then
		return "↑↓→"
	elseif ePathType == E.LRB then
		return "←↓→"
	elseif ePathType == E.LRT then
		return "←↑→"
	else
		assert(false, "unsupported GaoSiNiaoEnum.PathType : " .. tostring(ePathType))
	end
end

local kGreen = "#00FF00"
local kYellow = "#FFFF00"
local kBlue = "#0000FF"
local kWhite = "#FFFFFF"
local kBlack = "#000000"

local function _setColorDesc(desc, hexColor)
	if desc ~= nil and type(desc) ~= "string" then
		desc = tostring(desc)
	end

	if string.nilorempty(desc) then
		desc = "[None]"
	end

	return gohelper.getRichColorText(desc, hexColor or kWhite)
end

local function _isEmptyTable(tbl)
	if type(tbl) ~= "table" then
		return true
	end

	local hasSth = next(tbl) or #tbl > 0

	return not hasSth
end

local GaoSiNiaoBattleModel = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleModel")
local Base = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleMapMO")
local Info = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapInfo")
local GaoSiNiaoMapBag = require("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapBag")

module("modules.logic.gm.gaosiniao.GaoSiNiaoBattleMapMO__Edit", package.seeall)

local GaoSiNiaoBattleMapMO__Edit = class("GaoSiNiaoBattleMapMO__Edit", Base)
local kConfigAssetDir = "Assets/ZProj/Scripts/Lua/modules/configs/gaosiniao"
local kRuntimeClsName = "GaoSiNiaoBattleMapMO"
local kEditClsName = "GaoSiNiaoBattleMapMO__Edit"
local kMode = {
	Runtime = _B["<<"](1, 0),
	Edit = _B["<<"](1, 1)
}
local kSwitchState = {
	Unknown = -1,
	R2R = _B["|"](kMode.Runtime, kMode.Runtime),
	R2E = _B["|"](kMode.Edit, kMode.Runtime),
	E2R = _B["|"](kMode.Runtime, kMode.Edit),
	E2E = _B["|"](kMode.Edit, kMode.Edit)
}

local function _getMode(clsName)
	if clsName == kRuntimeClsName then
		return kMode.Runtime
	elseif clsName == kEditClsName then
		return kMode.Edit
	else
		assert(false, "unsupported clsName: " .. tostring(clsName))
	end
end

local function _getModeStr(clsName)
	if clsName == kRuntimeClsName then
		return "Game"
	elseif clsName == kEditClsName then
		return "Edit"
	else
		assert(false, "unsupported clsName: " .. tostring(clsName))
	end
end

local function _getSwitchState(fromSelf, toSelf)
	local ss = 0

	ss = _B["|"](ss, _getMode(fromSelf.class.__cname))
	ss = _B["|"](ss, _getMode(toSelf.class.__cname))

	return ss
end

function GaoSiNiaoBattleMapMO__Edit.default_ctor(Self, memberName, eVersion)
	local mapMO = GaoSiNiaoBattleMapMO__Edit.New()

	mapMO.__info = Info.New(eVersion or GaoSiNiaoEnum.Version.V1_0_0)
	Self[memberName] = mapMO
end

function GaoSiNiaoBattleMapMO__Edit.move_ctor(lSelf, lName, rSelf, rName)
	local rMapMO = assert(rSelf[rName])
	local lMapMO = GaoSiNiaoBattleMapMO__Edit.New()
	local mapId = rMapMO:mapId()
	local lastInfo = rMapMO.__info
	local lastMapCO = lastInfo._mapCO

	if lastMapCO then
		if not lastMapCO.width then
			local lastWidth = false

			if lastMapCO then
				if not lastMapCO.height then
					local lastHeight = false

					if lastMapCO then
						if not lastMapCO.gridList then
							local lastGridList = {}

							if lastMapCO then
								if not lastMapCO.bagList then
									local lastBagCOList = {}
									local ss = _getSwitchState(rMapMO, lMapMO)
									local isR2E = ss == kSwitchState.R2E
									local isE2E = ss == kSwitchState.E2E
									local isToEditMode = isR2E or isE2E

									lMapMO.__info = rMapMO.__info

									if isToEditMode then
										lMapMO.__info._mapCO = {
											id = mapId,
											width = lastWidth,
											height = lastHeight,
											gridList = lastGridList,
											bagList = isE2E and lastBagCOList or {}
										}
									end

									lMapMO._pt2BagDict = rMapMO._pt2BagDict

									if isR2E then
										for eName, eValue in pairs(GaoSiNiaoEnum.PathType) do
											if eValue ~= GaoSiNiaoEnum.PathType.__End and eValue ~= GaoSiNiaoEnum.PathType.None then
												lMapMO._pt2BagDict[eValue] = GaoSiNiaoMapBag.New(lMapMO, eValue, 0)
											end
										end
									end

									lMapMO._gridList = rMapMO._gridList
									rSelf[rName] = nil
									lSelf[lName] = lMapMO
								end
							end
						end
					end
				end
			end
		end
	end
end

function GaoSiNiaoBattleMapMO__Edit:_edit_showMsgBoxIfFailed(cond, str)
	if cond then
		MessageBoxController.instance:showMsgBoxByStr(str, MsgBoxEnum.BoxType.Yes)
	end

	return cond
end

function GaoSiNiaoBattleMapMO__Edit:__edit_getMapCOToSave()
	local mapCOToSave = {}
	local validPt2BagDict = {}

	for ePathType, bagItem in pairs(self._pt2BagDict) do
		if bagItem.count > 0 then
			validPt2BagDict[ePathType] = bagItem.count
		end
	end

	local gridList = {}

	self:foreachGrid(function(gridItem, i)
		gridList[i] = self.__info:make_gridCO(gridItem.type, gridItem.ePathType, gridItem.bMovable, gridItem.zRot)
	end)

	local bagList = {}

	for ePathType, count in pairs(validPt2BagDict) do
		ti(bagList, self.__info:make_bagCO(ePathType, count))
	end

	local w, h = self:mapSize()

	mapCOToSave.id = self:mapId()
	mapCOToSave.width = w
	mapCOToSave.height = h
	mapCOToSave.bagList = bagList
	mapCOToSave.gridList = gridList

	return mapCOToSave
end

function GaoSiNiaoBattleMapMO__Edit:_edit_getGridItemListIndexStr(refStrBuf, depth, gridItemList)
	if _isEmptyTable(gridItemList) then
		return
	end

	depth = depth or 0

	local tab = string_rep("\t", depth)

	ti(refStrBuf, tab)

	for _, gridItem in ipairs(gridItemList) do
		refStrBuf[#refStrBuf + 1] = refStrBuf[#refStrBuf + 1] .. " " .. gridItem:indexStr()
	end
end

function GaoSiNiaoBattleMapMO__Edit:_edit_checkValidMap()
	local savedMapCO = self:__edit_getMapCOToSave()
	local refStrBuf = {}

	GaoSiNiaoMapInfo.s_dump_raw(savedMapCO, refStrBuf)

	do return end

	self:_createMap(savedMapCO)

	local ok = true

	ok = ok and self:_edit_showMsgBoxIfFailed(#self._startGridList == 1, "必须要仅有一个起点")
	ok = ok and self:_edit_showMsgBoxIfFailed(#self._endGridList == 1, "必须至少有一个终点")
	ok = ok and self:_edit_showMsgBoxIfFailed(#self._portalGridList == 0 or #self._portalGridList == 2, string.format("传送门只能0个或者1对, 目前有%s个", self._portalGridList))
	ok = ok and self:_edit_showMsgBoxIfFailed(self:isCompleted(), "起点无法到达终点")

	return ok
end

function GaoSiNiaoBattleMapMO__Edit:_edit_confirmSaveOrNot(cb, cbObj)
	if not self:_edit_checkValidMap() then
		if cb then
			cb(cbObj)
		end

		return
	end

	MessageBoxController.instance:showMsgBoxByStr("Save?", MsgBoxEnum.BoxType.Yes_No, function()
		self:_edit_saveMap()

		if cb then
			cb(cbObj)
		end
	end, cb, nil, cbObj, cbObj, cbObj)
end

function GaoSiNiaoBattleMapMO__Edit:_edit_saveMap()
	self.__info:_edit_saveMap(self:__edit_getMapCOToSave())
end

function Base.move_ctor(lSelf, lName, rSelf, rName)
	local rMapMO = assert(rSelf[rName])
	local lMapMO = GaoSiNiaoBattleMapMO.New()
	local mapId = rMapMO:mapId()
	local lastInfo = rMapMO.__info
	local lastMapCO = lastInfo._mapCO

	if lastMapCO then
		if not lastMapCO.width then
			local lastWidth = false

			if lastMapCO then
				if not lastMapCO.height then
					local lastHeight = false

					if lastMapCO then
						if not lastMapCO.gridList then
							local lastGridList = {}

							if lastMapCO then
								if not lastMapCO.bagList then
									local lastBagCOList = {}
									local ss = _getSwitchState(rMapMO, lMapMO)
									local isR2R = ss == kSwitchState.R2R
									local isE2R = ss == kSwitchState.E2R
									local isToRuntime = isR2R or isE2R

									lMapMO.__info = rMapMO.__info

									local isFallbackToFileBagList = false

									if isToRuntime then
										local newMapCO = {
											id = mapId,
											width = lastWidth,
											height = lastHeight,
											gridList = lastGridList,
											bagList = isR2R and lastBagCOList or {}
										}

										if isE2R then
											local spt2count = {}

											for _, v in ipairs(lastBagCOList) do
												if v.count > 0 then
													spt2count[v.ptype] = spt2count[v.ptype] or 0
													spt2count[v.ptype] = spt2count[v.ptype] + v.count
												end
											end

											if next(spt2count) then
												for ptype, count in pairs(spt2count) do
													ti(newMapCO.bagList, rMapMO.__info:make_bagCO(ptype, count))
												end
											else
												lastInfo._mapCO = nil

												local newCopyMapCO = lastInfo:mapCO()

												newMapCO.bagList = newCopyMapCO.bagList
												isFallbackToFileBagList = true
											end
										end

										lMapMO.__info._mapCO = newMapCO
									end

									lMapMO._pt2BagDict = rMapMO._pt2BagDict

									if isE2R then
										for _, bagItem in pairs(lMapMO._pt2BagDict) do
											if bagItem.count <= 0 then
												lMapMO._pt2BagDict[bagItem.type] = nil
											end
										end
									end

									if isFallbackToFileBagList then
										lMapMO:_createBags(lMapMO.__info._mapCO)
									end

									lMapMO._gridList = rMapMO._gridList
									rSelf[rName] = nil
									lSelf[lName] = lMapMO
								end
							end
						end
					end
				end
			end
		end
	end
end

function Info._edit_getMapConfigAssetPath(selfObj)
	return kConfigAssetDir .. "/map_" .. selfObj.version .. ".lua"
end

function Info._edit_saveMap(selfObj, mapCO)
	local path = selfObj:_getMapRequireLuaPath()
	local mapCOList = require(path)
	local ok = false

	for k, _mapCO in ipairs(mapCOList) do
		if _mapCO.id == mapCO.id then
			mapCOList[k] = mapCO
			ok = true

			break
		end
	end

	if not ok then
		ti(mapCOList, mapCO)
	end

	selfObj:_edit_saveAllMaps(mapCOList)
end

function Info._edit_saveAllMaps(selfObj, mapCOList)
	do return end

	local dumpStr = ser(mapCOList)
	local assetPath = selfObj:_edit_getMapConfigAssetPath()

	SLFramework.FileHelper.WriteTextToPath(assetPath, dumpStr)
	logError("[GaoSiNiao] Save As: " .. tostring(assetPath))

	local path = selfObj:_getMapRequireLuaPath()

	package.loaded[path] = nil
end

function GaoSiNiaoBattleModel.dump(selfObj, refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)
	local modeStr = _setColorDesc(_getModeStr(selfObj._mapMO.class.__cname), kYellow)

	ti(refStrBuf, tab .. sf("Mode: %s", modeStr))

	local episodeId = selfObj:episodeId()

	ti(refStrBuf, tab .. sf("episodeId: %s", episodeId))
	ti(refStrBuf, tab .. "MapMO:")
	selfObj._mapMO:dump(refStrBuf, depth + 1)
end

function Base.dump(selfObj, refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)

	ti(refStrBuf, tab .. "__info:")
	selfObj.__info:dump(refStrBuf, depth + 1)
	ti(refStrBuf, tab .. "BagInfo:")

	if next(selfObj._pt2BagDict) then
		for ePathType = GaoSiNiaoEnum.PathType.None + 1, GaoSiNiaoEnum.PathType.__End - 1 do
			local item = selfObj._pt2BagDict[ePathType]

			if item then
				item:dump(refStrBuf, depth + 1)
			end
		end
	else
		ti(refStrBuf, tab .. tab .. "Invalid")
	end

	ti(refStrBuf, tab .. "GridInfo:")

	tab = string_rep("\t", depth + 1)

	if next(selfObj._gridList) then
		local _, col = selfObj:rowCol()

		ti(refStrBuf, tab .. "  ")

		for i = 0, col - 1 do
			refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. _setColorDesc(i, kYellow)
		end

		refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. _setColorDesc("X", kYellow)

		local lastY = -1

		selfObj:foreachGrid(function(gridItem)
			local x = gridItem:x()
			local y = gridItem:y()
			local desc = "*"

			if gridItem:_isConnedStart() then
				desc = _setColorDesc(desc, kGreen)
			elseif gridItem:isWall() then
				desc = _setColorDesc(desc, kBlack)
			elseif gridItem:isPortal() then
				desc = _setColorDesc(desc, kBlue)
			end

			local isSameRow = lastY == y

			if isSameRow then
				refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. desc
			else
				ti(refStrBuf, tab .. _setColorDesc(y, kYellow) .. " " .. desc)
			end

			lastY = y
		end)
		ti(refStrBuf, tab .. "Grid Union:")
		ti(refStrBuf, tab .. "  ")

		for i = 0, col - 1 do
			refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. _setColorDesc(i, kYellow)
		end

		refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. _setColorDesc("X", kYellow)
		lastY = -1

		selfObj:foreachGrid(function(gridItem)
			local x = gridItem:x()
			local y = gridItem:y()
			local desc = selfObj:rootId(gridItem)
			local isSameRow = lastY == y

			if isSameRow then
				refStrBuf[#refStrBuf] = refStrBuf[#refStrBuf] .. " " .. desc
			else
				ti(refStrBuf, tab .. _setColorDesc(y, kYellow) .. " " .. desc)
			end

			lastY = y
		end)
	else
		ti(refStrBuf, tab .. "Invalid")
	end

	ti(refStrBuf, tab .. _setColorDesc("Y", kYellow))

	tab = string_rep("\t", depth)

	if selfObj._whoActivedPortalGrid then
		ti(refStrBuf, tab .. "isActivedPortal: Yes from" .. selfObj._whoActivedPortalGrid:indexStr())
	else
		ti(refStrBuf, tab .. "isActivedPortal: No")
	end
end

function Info.dump(selfObj, refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)
	local mapId = selfObj.mapId
	local w, h = selfObj:mapSize()

	ti(refStrBuf, tab .. sf("mapId: %s (%sx%s)", mapId, w, h))
	ti(refStrBuf, tab .. "bagList:")

	local bagList = selfObj:bagList()

	tab = string_rep("\t", depth + 1)

	for _, v in ipairs(bagList) do
		local ptype = v.ptype
		local count = v.count
		local ePathTypeName = GaoSiNiaoEnum.rPathType[ptype]

		ti(refStrBuf, tab .. sf("%s: %s", ePathTypeName, count))
	end

	tab = string_rep("\t", depth)

	ti(refStrBuf, tab .. "gridList:")

	local gridList = selfObj:gridList()

	tab = string_rep("\t", depth + 1)

	local y = 0
	local i = 0

	while y < h do
		local x = 0
		local lineStr = ""

		while x < w do
			local gridInfo = gridList[i]
			local eGridType = gridInfo.gtype
			local eGridTypeName = GaoSiNiaoEnum.rGridType[eGridType]
			local n = string.len(eGridTypeName)

			for ii = n + 1, 6 do
				eGridTypeName = eGridTypeName .. " "
			end

			lineStr = lineStr .. sf("(%s,%s) %s", x, y, eGridTypeName)
			i = i + 1
			x = x + 1
		end

		ti(refStrBuf, tab .. lineStr)

		y = y + 1
	end

	tab = string_rep("\t", depth)
end

function Info.s_dump_raw(rawMapCO, refStrBuf, depth)
	if type(rawMapCO) ~= "table" then
		return
	end

	local fake = Info.New(11235)

	fake._mapCO = rawMapCO

	fake:dump(refStrBuf, depth)
end

function GaoSiNiaoMapBag.dump(selfObj, refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)
	local count = selfObj.count
	local ePathTypeName = GaoSiNiaoEnum.rPathType[selfObj.type]

	ti(refStrBuf, tab .. sf("%s: %s", ePathTypeName, _setColorDesc(count, kGreen)))
end

function GaoSiNiaoMapGrid._dump_ZoneMask(selfObj, refStrBuf, depth)
	depth = depth or 0

	local tab = string_rep("\t", depth)

	ti(refStrBuf, tab .. sf("%s: in=%s, out=%s", selfObj:indexStr(), GaoSiNiaoEnum.dirToStr(selfObj:in_ZoneMask()), GaoSiNiaoEnum.dirToStr(selfObj:out_ZoneMask())))
end

function Info._loadMapConfig(selfObj)
	local assetPath = selfObj:_edit_getMapConfigAssetPath()

	if not SLFramework.FileHelper.IsFileExists(assetPath) then
		return {}
	end

	local path = selfObj:_getMapRequireLuaPath()

	return readonly(require(path) or {})
end

return GaoSiNiaoBattleMapMO__Edit

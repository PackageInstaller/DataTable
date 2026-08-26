-- chunkname: @modules/logic/rouge/define/RougeLuaCompBase.lua

module("modules.logic.rouge.define.RougeLuaCompBase", package.seeall)

local RougeLuaCompBase = class("RougeLuaCompBase", ListScrollCellExtend)

function RougeLuaCompBase:init(go)
	self:__onInit()
	RougeLuaCompBase.super.init(self, go)
	self:initDLCs(go)
end

function RougeLuaCompBase:initDLCs(go)
	self._parentGo = go

	self:_collectAllClsAndLoadRes()
end

function RougeLuaCompBase:onUpdateDLC(...)
	return
end

function RougeLuaCompBase:tickUpdateDLCs(...)
	if not self._dlcComps or not self._resLoadDone then
		self.params = {
			...
		}

		return
	end

	for _, dlcComp in ipairs(self._dlcComps) do
		dlcComp:onUpdateDLC(...)
	end
end

function RougeLuaCompBase:_collectAllClsAndLoadRes()
	self._clsList = self:getUserDataTb_()

	local assetUrlList, assetUrlMap = {}, {}
	local season = RougeOutsideModel.instance:season()
	local versions = RougeModel.instance:getVersion()

	for _, version in ipairs(versions or {}) do
		local clsName = string.format("%s_%s_%s", self.__cname, season, version)
		local cls = _G[clsName]

		table.insert(self._clsList, cls)
		self:_collectNeedLoadRes(cls, assetUrlList, assetUrlMap)
	end

	self:_loadAllNeedRes(assetUrlList)
end

function RougeLuaCompBase:_collectNeedLoadRes(cls, assetUrlList, assetUrlMap)
	local needLoadRes = cls and cls.AssetUrl

	if needLoadRes then
		assetUrlMap[needLoadRes] = true

		table.insert(assetUrlList, needLoadRes)
	end
end

function RougeLuaCompBase:_loadAllNeedRes(assetUrlList)
	self._resLoadDone = false

	if not assetUrlList or #assetUrlList <= 0 then
		self:_resLoadDoneCallBack()

		return
	end

	self._abLoader = self._abLoader or MultiAbLoader.New()

	self._abLoader:setPathList(assetUrlList)
	self._abLoader:startLoad(self._resLoadDoneCallBack, self)
end

function RougeLuaCompBase:_resLoadDoneCallBack()
	self._dlcComps = self:getUserDataTb_()

	local unpackParams

	for _, cls in ipairs(self._clsList) do
		local createGO = self:_createGo(cls.ParentObjPath, cls.AssetUrl, cls.ResInitPosition)

		if createGO then
			local inst = MonoHelper.addNoUpdateLuaComOnceToGo(createGO, cls, self)

			inst:onUpdateDLC((self.params or nil) and unpack(self.params))
			table.insert(self._dlcComps, inst)
		end
	end

	self._resLoadDone = true
end

function RougeLuaCompBase:_createGo(parentObjPath, assetUrl, resInitPos)
	if string.nilorempty(parentObjPath) or string.nilorempty(assetUrl) or not self._abLoader then
		return
	end

	local assetItem = self._abLoader:getAssetItem(assetUrl)
	local res = assetItem and assetItem:GetResource(assetUrl)

	if not res then
		logError("无法找到指定资源 :" .. assetUrl)

		return
	end

	local goParent = gohelper.findChild(self._parentGo, parentObjPath)

	if gohelper.isNil(goParent) then
		logError("无法找到指定肉鸽DLC界面挂点:" .. tostring(parentObjPath))

		return
	end

	local createGO = gohelper.clone(res, goParent)

	if resInitPos then
		recthelper.setAnchor(createGO.transform, resInitPos.x or 0, resInitPos.y or 0)
	end

	return createGO
end

function RougeLuaCompBase:onDestroy()
	if self._abLoader then
		self._abLoader:dispose()

		self._abLoader = nil
	end

	RougeLuaCompBase.super.onDestroy(self)
	self:__onDispose()
end

return RougeLuaCompBase

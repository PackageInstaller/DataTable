-- chunkname: @modules/common/res/ResMgr.lua

module("modules.common.res.ResMgr", package.seeall)

local ResMgr = _M
local _assetPool = {}
local _moPool = {}
local _callBackDic = {}
local _callBackDicByUrl = {}
local _id = 0
local _cbPool

function ResMgr.getAbAsset(assetUrl, loadedCb, loadedObj, id)
	if _callBackDic[id] then
		local url = _callBackDic[id].url

		if assetUrl == url then
			return id
		end

		_callBackDicByUrl[url][id] = nil

		ResMgr._getCBPool():putObject(_callBackDic[id])

		_callBackDic[id] = nil
	end

	local assetMO = _assetPool[assetUrl]

	if assetMO then
		loadedCb(loadedObj, assetMO)
	else
		_id = _id + 1

		local luaCb = ResMgr._getCBPool():getObject()

		luaCb.callback = loadedCb
		luaCb.url = assetUrl
		luaCb.id = _id

		luaCb:setCbObj(loadedObj)

		_callBackDic[_id] = luaCb
		_callBackDicByUrl[assetUrl] = _callBackDicByUrl[assetUrl] or {}
		_callBackDicByUrl[assetUrl][_id] = luaCb

		loadAbAsset(assetUrl, false, ResMgr._onLoadCallback)

		if not _assetPool[assetUrl] then
			return _id
		end
	end
end

function ResMgr._getCBPool()
	_cbPool = _cbPool or LuaObjPool.New(200, LuaGeneralCallback._poolNew, LuaGeneralCallback._poolRelease, LuaGeneralCallback._poolReset)

	return _cbPool
end

function ResMgr.removeCallBack(id)
	if _callBackDic[id] then
		local url = _callBackDic[id].url

		_callBackDicByUrl[url][id] = nil

		ResMgr._getCBPool():putObject(_callBackDic[id])

		_callBackDic[id] = nil
	end
end

function ResMgr.removeAsset(assetMO)
	_assetPool[assetMO:getUrl()] = nil

	table.insert(_moPool, assetMO)
end

function ResMgr.ReleaseObj(obj)
	if obj and gohelper.isNil(obj) == false then
		local comp = MonoHelper.getLuaComFromGo(obj, AssetInstanceComp)

		if comp then
			comp:onDestroy()
			MonoHelper.removeLuaComFromGo(obj, AssetInstanceComp)
		end

		gohelper.destroy(obj)
	end
end

function ResMgr._onLoadCallback(assetItem)
	local url = assetItem.AssetUrl
	local assetMO = ResMgr._getAssetMO(assetItem, url)
	local callBackDic = _callBackDicByUrl[url]

	if callBackDic then
		for id, luaCb in pairs(callBackDic) do
			_callBackDic[id] = nil

			luaCb:invoke(assetMO)
			ResMgr._getCBPool():putObject(luaCb)
		end
	end

	_callBackDicByUrl[url] = nil
end

function ResMgr.getAssetPool()
	return _assetPool
end

function ResMgr._getAssetMO(assetItem, url)
	local assetMO = _assetPool[url]

	if assetMO == nil then
		local assetMO = table.remove(_moPool)

		if assetMO == nil then
			assetMO = AssetMO.New(assetItem)
		else
			assetMO:setAssetItem(assetItem)
		end

		_assetPool[url] = assetMO
	end

	return _assetPool[url]
end

return ResMgr

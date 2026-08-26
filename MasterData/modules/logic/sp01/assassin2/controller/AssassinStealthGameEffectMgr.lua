-- chunkname: @modules/logic/sp01/assassin2/controller/AssassinStealthGameEffectMgr.lua

module("modules.logic.sp01.assassin2.controller.AssassinStealthGameEffectMgr", package.seeall)

local AssassinStealthGameEffectMgr = class("AssassinStealthGameEffectMgr")

function AssassinStealthGameEffectMgr:init()
	self.path2AssetItemDic = {}
	self.resList = {}
	self.pathList = {}
	self.path2PointListDic = {}
end

function AssassinStealthGameEffectMgr:getEffectRes(resName, pointObj)
	local path = AssassinStealthGameHelper.getEffectUrl(resName)
	local assetItem = self.path2AssetItemDic[path]

	if assetItem then
		local go = gohelper.clone(assetItem:GetResource(path))

		gohelper.addChild(pointObj, go)
	else
		self.path2PointListDic[path] = self.path2PointListDic[path] or {}

		table.insert(self.path2PointListDic[path], pointObj)
		table.insert(self.pathList, path)
		loadAbAsset(path, false, self.onLoadCallback, self)
	end
end

function AssassinStealthGameEffectMgr:onLoadCallback(assetItem)
	if not self.resList then
		return
	end

	table.insert(self.resList, assetItem)

	local path = assetItem.ResPath

	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		self.path2AssetItemDic[path] = assetItem

		local pointObjList = self.path2PointListDic[path]

		if pointObjList then
			local prefab = assetItem:GetResource(path)

			for _, obj in ipairs(pointObjList) do
				if not gohelper.isNil(obj) then
					local effect = gohelper.clone(prefab)

					gohelper.addChild(obj, effect)
				end
			end

			tabletool.clear(self.path2PointListDic[path])
		end
	else
		logError(string.format("AssassinStealthGameEffectMgr:onLoadCallback error, load effect failed, path:%s", path))
	end
end

function AssassinStealthGameEffectMgr:dispose()
	if self.pathList and #self.resList < #self.pathList then
		for _, v in ipairs(self.pathList) do
			removeAssetLoadCb(v, self.onLoadCallback, self)
		end
	end

	if self.resList then
		for i, assetItem in ipairs(self.resList) do
			assetItem:Release()
			rawset(self.resList, i, nil)
		end
	end

	self.pathList = nil
	self.resList = nil
	self.path2AssetItemDic = nil
	self.path2PointListDic = nil
end

AssassinStealthGameEffectMgr.instance = AssassinStealthGameEffectMgr.New()

return AssassinStealthGameEffectMgr

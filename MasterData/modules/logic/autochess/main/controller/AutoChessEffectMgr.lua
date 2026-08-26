-- chunkname: @modules/logic/autochess/main/controller/AutoChessEffectMgr.lua

module("modules.logic.autochess.main.controller.AutoChessEffectMgr", package.seeall)

local AutoChessEffectMgr = class("AutoChessEffectMgr")

function AutoChessEffectMgr:init()
	self.pathList = {}
	self.resList = {}
	self.path2AssetItemDic = {}
	self.path2CallbackListDic = {}
	self.path2CallbackObjListDic = {}
	self.path2CallbackParamListDic = {}
end

function AutoChessEffectMgr:loadRes(param, callback, callbackObj)
	local effectName = param.effectName
	local path = AutoChessHelper.getEffectUrl(effectName)
	local assetItem = self.path2AssetItemDic[path]

	if assetItem then
		local go = gohelper.clone(assetItem:GetResource(path))

		callback(callbackObj, go, param)
	else
		if not self.path2CallbackListDic[path] then
			self.path2CallbackListDic[path] = {}
			self.path2CallbackObjListDic[path] = {}
			self.path2CallbackParamListDic[path] = {}
		end

		table.insert(self.path2CallbackListDic[path], callback)
		table.insert(self.path2CallbackObjListDic[path], callbackObj)
		table.insert(self.path2CallbackParamListDic[path], param)
		table.insert(self.pathList, path)
		loadAbAsset(path, false, self.onLoadCallback, self)
	end
end

function AutoChessEffectMgr:onLoadCallback(assetItem)
	if not self.resList then
		return
	end

	table.insert(self.resList, assetItem)

	local path = assetItem.ResPath

	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		self.path2AssetItemDic[path] = assetItem

		local callbackObjList = self.path2CallbackObjListDic[path]

		if callbackObjList then
			local prefab = assetItem:GetResource(path)

			for k, callbackObj in ipairs(callbackObjList) do
				if callbackObj then
					local callback = self.path2CallbackListDic[path][k]
					local param = self.path2CallbackParamListDic[path][k]
					local effectGo = gohelper.clone(prefab)

					callback(callbackObj, effectGo, param)
				end
			end

			tabletool.clear(self.path2CallbackListDic[path])
			tabletool.clear(self.path2CallbackObjListDic[path])
			tabletool.clear(self.path2CallbackParamListDic[path])
		end
	else
		logError(string.format("异常:自走棋特效加载失败%s", path))
	end
end

function AutoChessEffectMgr:dispose()
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
	self.path2CallbackListDic = nil
end

AutoChessEffectMgr.instance = AutoChessEffectMgr.New()

return AutoChessEffectMgr

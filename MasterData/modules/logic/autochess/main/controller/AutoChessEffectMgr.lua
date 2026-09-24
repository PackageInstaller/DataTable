-- chunkname: @modules/logic/autochess/main/controller/AutoChessEffectMgr.lua

module("modules.logic.autochess.main.controller.AutoChessEffectMgr", package.seeall)

local AutoChessEffectMgr = class("AutoChessEffectMgr")

function AutoChessEffectMgr:init()
	self.pathList = {}
	self.resList = {}
	self.path2AssetItemDic = {}
	self.path2CallbackListDic = {}
end

function AutoChessEffectMgr:loadRes(param, callback, callbackObj)
	local effectName = param.effectName
	local path = AutoChessHelper.getEffectUrl(effectName)
	local assetItem = self.path2AssetItemDic[path]

	if assetItem then
		local go = gohelper.clone(assetItem:GetResource(path))

		callback(callbackObj, go, param)
	else
		local isFirstRequest = not self.path2CallbackListDic[path]

		if isFirstRequest then
			self.path2CallbackListDic[path] = {}
		end

		table.insert(self.path2CallbackListDic[path], {
			callback,
			callbackObj,
			param
		})

		if isFirstRequest then
			table.insert(self.pathList, path)
			loadAbAsset(path, false, self.onLoadCallback, self)
		end
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

		local callbackList = self.path2CallbackListDic[path]

		if callbackList then
			local prefab = assetItem:GetResource(path)

			for _, info in ipairs(callbackList) do
				local cb, cbObj, cbParam = info[1], info[2], info[3]

				if cbObj then
					local effectGo = gohelper.clone(prefab)

					cb(cbObj, effectGo, cbParam)
				end
			end
		end
	else
		logError(string.format("异常:自走棋特效加载失败%s", path))
	end

	tabletool.clear(self.path2CallbackListDic[path])
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

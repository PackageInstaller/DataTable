-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/lang/LangPrefabLoader.lua

module("logiccommon.common.lang.LangPrefabLoader", package.seeall)

local LangPrefabLoader = class("LangPrefabLoader", PrefabLoader)

function PrefabLoader.Get(go)
	return Framework.LuaComponentContainer.Add(go, LangPrefabLoader)
end

function LangPrefabLoader:ctor(container)
	LangPrefabLoader.super.ctor(self, container)
end

function LangPrefabLoader:load(url, loadedHandler, loadedHandlerObj, needPreloadAsset)
	if self._url == url then
		return
	end

	self:clear()

	if url == nil then
		return
	end

	self._url = url
	self._loadedHandler = loadedHandler
	self._loadedHandlerObj = loadedHandlerObj
	needPreloadAsset = needPreloadAsset or false

	getres(langpath(self._url), self._onPrefabLoaded, self, nil, needPreloadAsset)
end

function LangPrefabLoader:_onPrefabLoaded(res)
	if res.IsSuccess and self._go and not goutil.isNil(self._go) and res.ResPath == self._url then
		self._prefabRes = res

		self._prefabRes:Retain()

		local asset = res:GetAsset(nil, nil)

		if not asset then
			asset = UnityEngine.GameObject.New()

			printError("PrefabLoader资源预制是null:" .. (res.IsDestroy and "资源已经销毁，" or "资源还没销毁") .. "  资源路径=" .. res.ResPath)
		end

		self._prefabInst = UnityEngine.GameObject.Instantiate(asset)

		goutil.addChildToParent(self._prefabInst, self._go)

		self._prefabInst.layer = self._go.layer

		local tempHandler = self._loadedHandler
		local tempHandlerObj = self._loadedHandlerObj

		self._loadedHandler = nil
		self._loadedHandlerObj = nil

		if tempHandler ~= nil then
			if tempHandlerObj == nil then
				self:_loadedHandler()
			else
				self._loadedHandler(tempHandlerObj, self)
			end
		end
	else
		self._loadedHandler = nil
		self._loadedHandlerObj = nil
	end
end

function LangPrefabLoader:clear()
	if self._url == nil then
		return
	end

	goutil.destroy(self._prefabInst)

	self._prefabInst = nil

	if self._prefabRes ~= nil then
		self._prefabRes:Release()
	end

	removeresl(langpath(self._url), self._onPrefabLoaded, self)

	self._prefabRes = nil
	self._url = nil
	self._loadedHandler = nil
	self._loadedHandlerObj = nil
end

return LangPrefabLoader

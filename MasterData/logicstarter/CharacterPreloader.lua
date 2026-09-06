-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/preload/CharacterPreloader.lua

module(..., package.seeall)

local CharacterPreloader = class("CharacterPreloader")

function CharacterPreloader:ctor()
	self._resDict = {}
	self._instDict = {}
	self._loader = MultiResLoader.New()
	self._resPaths = {}
	self._finishCallback = nil
	self._finishObj = nil
	self._container = goutil.find("AoUnityStarter").transform
end

function CharacterPreloader:load(finishCallback, finishObj)
	self._finishCallback = finishCallback
	self._finishObj = finishObj

	table.insert(self._resPaths, GameUrl.getSpineUrl(SceneMainPlayer.mainMalePlayerName))
	self._loader:setResPaths(self._resPaths)
	self._loader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function CharacterPreloader:_onOneLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res

		local prefab = res:GetMainAsset()
		local inst = Framework.GameObjectUtil.CloneAndSetParent(prefab, self._container, nil)

		inst:SetActive(false)

		self._instDict[res.ResPath] = inst
	end
end

function CharacterPreloader:_onAllLoaded(loader)
	self._loader:clear()

	if self._finishCallback then
		self._finishCallback(self._finishObj)
	end

	self._finishCallback = nil
	self._finishObj = nil
end

CharacterPreloader.instance = CharacterPreloader.New()

return CharacterPreloader

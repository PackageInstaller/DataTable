-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scene.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameSceneManager = (((CS.PixelNeko).P1).Scene).GameSceneManager
local Scene = class("Scene")
Scene.Ctor = function(self, tag, assetBundleName, sceneName, isSingle)
  -- function num : 0_0
  self._tag = tag
  self._assetBundleName = assetBundleName
  self._sceneName = sceneName
  self._isSingle = isSingle
  self._active = true
  self._rootGameObjectActive = true
  self._loading = true
  self._loadProcess = 0
  self._loadHandler = 0
end

Scene.SetActive = function(self, active)
  -- function num : 0_1 , upvalues : GameSceneManager
  self._active = active
  if not self._loading and active then
    (GameSceneManager.SetSceneActive)(self._sceneName)
  end
end

Scene.SetRootGameObjectActive = function(self, active)
  -- function num : 0_2 , upvalues : GameSceneManager
  self._rootGameObjectActive = active
  if not self._loading then
    (GameSceneManager.SetSceneRootGameObjectActive)(self._sceneName, active)
  end
end

Scene.SetLoadProcess = function(self, isDone, process)
  -- function num : 0_3
  if isDone then
    self._loading = false
    self._loadProcess = 1
    self:SetRootGameObjectActive(self._rootGameObjectActive)
  else
    self._loading = true
    self._loadProcess = process
  end
end

Scene.GetLoadProcess = function(self)
  -- function num : 0_4
  return self._loading, self._loadProcess
end

Scene.Load = function(self)
  -- function num : 0_5 , upvalues : GameSceneManager, _ENV
  if self._loadHandler == 0 then
    if self._isSingle then
      self._loadHandler = (GameSceneManager.LoadSingleScene)(self._assetBundleName, self._sceneName)
    else
      self._loadHandler = (GameSceneManager.LoadAdditiveScene)(self._assetBundleName, self._sceneName)
    end
  else
    LogError("Scene", "同一个场景不能Load两次")
  end
end

Scene.UnLoad = function(self)
  -- function num : 0_6 , upvalues : GameSceneManager
  if self._loadHandler > 0 then
    (GameSceneManager.ReleaseScene)(self._loadHandler)
    self._loadHandler = 0
  end
end

return Scene


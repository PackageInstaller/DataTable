local GameSceneManager = CS.PixelNeko.P1.Scene.GameSceneManager
local Scene = class("Scene")

function Scene:Ctor(tag, assetBundleName, sceneName, isSingle)
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

function Scene:SetActive(active)
  self._active = active
  if not self._loading and active then
    GameSceneManager.SetSceneActive(self._sceneName)
  end
end

function Scene:SetRootGameObjectActive(active)
  self._rootGameObjectActive = active
  if not self._loading then
    GameSceneManager.SetSceneRootGameObjectActive(self._sceneName, active)
  end
end

function Scene:SetLoadProcess(isDone, process)
  if isDone then
    self._loading = false
    self._loadProcess = 1
    self:SetRootGameObjectActive(self._rootGameObjectActive)
  else
    self._loading = true
    self._loadProcess = process
  end
end

function Scene:GetLoadProcess()
  return self._loading, self._loadProcess
end

function Scene:Load()
  if self._loadHandler == 0 then
    if self._isSingle then
      self._loadHandler = GameSceneManager.LoadSingleScene(self._assetBundleName, self._sceneName)
    else
      self._loadHandler = GameSceneManager.LoadAdditiveScene(self._assetBundleName, self._sceneName)
    end
  else
    LogError("Scene", "同一个场景不能Load两次")
  end
end

function Scene:UnLoad()
  if self._loadHandler > 0 then
    GameSceneManager.ReleaseScene(self._loadHandler)
    self._loadHandler = 0
  end
end

return Scene

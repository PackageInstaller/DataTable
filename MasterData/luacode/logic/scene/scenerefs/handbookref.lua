local SceneRef = require("logic.scene.scenerefs.sceneref")
local HandBookRef = class("HandBookRef", SceneRef)
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")

function HandBookRef:Init()
  HandBookRef.super.Init(self)
  local assetBundleName = CVarConfig:GetRecorder(46).Value
  local assetName = CVarConfig:GetRecorder(47).Value
  self._sceneObj = PrefabLoader.LoadAndInstantiatePrefab(assetBundleName, assetName)
  self._cinemachinesGameObject = TransformStaticFunctions.GetChild(self._sceneObj, "RelationCams")
  self._cinemachiesAnimator = self._cinemachinesGameObject:GetComponent("Animator")
  self._camera = GlobalCameras.GetCamera("HandBook")
  self._nodeParent = TransformStaticFunctions.GetChild(self._sceneObj, "Groups")
  self._nodeList = {}
  self._nodeList = SceneObjectClick.GetObjectClicksInChildren(self._nodeParent)
  local groupObjMap = CS.PixelNeko.P1.Scene.TrapHelper.GetObjectsWithID(self._nodeParent)
  self._groupAnimatorDic = {}
  for object, id in pairs(groupObjMap) do
    self._groupAnimatorDic[id] = AnimatorStaticFunctions.Get(object)
  end
  self._backgroundTimelineObjects = {}
  self._backgroundTimelineObjects[1] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/Chilora_Timeline"):GetComponent("PlayableDirector")
  self._backgroundTimelineObjects[2] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/Irminsul_Timeline"):GetComponent("PlayableDirector")
  self._backgroundTimelineObjects[3] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/Snegurochka_Timeline"):GetComponent("PlayableDirector")
  self._backgroundTimelineObjects[4] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/Cassiel_Timeline"):GetComponent("PlayableDirector")
  self._backgroundTimelineObjects[5] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/Uncharted_Timeline"):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects = {}
  self._backgroundToMainTimelineObjects[1] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/ChiloraToMain"):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects[2] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/IrminsulToMain"):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects[3] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/SnegurochkaToMain"):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects[4] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/CassielToMain"):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects[5] = TransformStaticFunctions.GetChild(self._camera.gameObject, "UI_RelationMain_bj/UnchartedToMain"):GetComponent("PlayableDirector")
end

function HandBookRef:GetCinemachiesAnimator()
  return self._cinemachiesAnimator
end

function HandBookRef:GetGroupById(id)
  return self._groupAnimatorDic[id]
end

return HandBookRef

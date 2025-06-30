-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/handbookref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local HandBookRef = class("HandBookRef", SceneRef)
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
HandBookRef.Init = function(self)
  -- function num : 0_0 , upvalues : HandBookRef, CVarConfig, PrefabLoader, TransformStaticFunctions, GlobalCameras, SceneObjectClick, _ENV, AnimatorStaticFunctions
  ((HandBookRef.super).Init)(self)
  local assetBundleName = (CVarConfig:GetRecorder(46)).Value
  local assetName = (CVarConfig:GetRecorder(47)).Value
  self._sceneObj = (PrefabLoader.LoadAndInstantiatePrefab)(assetBundleName, assetName)
  self._cinemachinesGameObject = (TransformStaticFunctions.GetChild)(self._sceneObj, "RelationCams")
  self._cinemachiesAnimator = (self._cinemachinesGameObject):GetComponent("Animator")
  self._camera = (GlobalCameras.GetCamera)("HandBook")
  self._nodeParent = (TransformStaticFunctions.GetChild)(self._sceneObj, "Groups")
  self._nodeList = {}
  self._nodeList = (SceneObjectClick.GetObjectClicksInChildren)(self._nodeParent)
  local groupObjMap = (((((CS.PixelNeko).P1).Scene).TrapHelper).GetObjectsWithID)(self._nodeParent)
  self._groupAnimatorDic = {}
  for object,id in pairs(groupObjMap) do
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

    (self._groupAnimatorDic)[id] = (AnimatorStaticFunctions.Get)(object)
  end
  self._backgroundTimelineObjects = {}
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundTimelineObjects)[1] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/Chilora_Timeline")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundTimelineObjects)[2] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/Irminsul_Timeline")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundTimelineObjects)[3] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/Snegurochka_Timeline")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC106: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundTimelineObjects)[4] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/Cassiel_Timeline")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC116: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundTimelineObjects)[5] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/Uncharted_Timeline")):GetComponent("PlayableDirector")
  self._backgroundToMainTimelineObjects = {}
  -- DECOMPILER ERROR at PC128: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundToMainTimelineObjects)[1] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/ChiloraToMain")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC138: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundToMainTimelineObjects)[2] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/IrminsulToMain")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC148: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundToMainTimelineObjects)[3] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/SnegurochkaToMain")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC158: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundToMainTimelineObjects)[4] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/CassielToMain")):GetComponent("PlayableDirector")
  -- DECOMPILER ERROR at PC168: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._backgroundToMainTimelineObjects)[5] = ((TransformStaticFunctions.GetChild)((self._camera).gameObject, "UI_RelationMain_bj/UnchartedToMain")):GetComponent("PlayableDirector")
end

HandBookRef.GetCinemachiesAnimator = function(self)
  -- function num : 0_1
  return self._cinemachiesAnimator
end

HandBookRef.GetGroupById = function(self, id)
  -- function num : 0_2
  return (self._groupAnimatorDic)[id]
end

return HandBookRef


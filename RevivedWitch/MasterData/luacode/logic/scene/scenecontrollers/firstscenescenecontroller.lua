-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/firstscenescenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FirstSceneWakeUp = (((CS.PixelNeko).P1).FirstScene).FirstSceneWakeUp
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local FirstSceneSceneController = class("FirstSceneSceneController", SceneController)
local HandleRockerMove = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("guide.moveguidedialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("guide.moveguidedialog")
  end
  if self._enableMove == false then
    return 
  end
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  self._needTips = false
  if (userInfo.axisVector).x > 0 then
    ((self._sceneRef):GetFirstScenePlayerMove()).Dir = 1
  else
    if (userInfo.axisVector).x < 0 then
      ((self._sceneRef):GetFirstScenePlayerMove()).Dir = -1
    else
      ;
      ((self._sceneRef):GetFirstScenePlayerMove()).Dir = 0
    end
  end
end

local HandleRockerStop = function(self, notification)
  -- function num : 0_1
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  ;
  ((self._sceneRef):GetFirstScenePlayerMove()).Dir = 0
end

FirstSceneSceneController.Ctor = function(self, sceneRef)
  -- function num : 0_2 , upvalues : FirstSceneSceneController
  ((FirstSceneSceneController.super).Ctor)(self, sceneRef)
  self._enableMove = false
  self._needTips = true
  self._totleTime = 0
  self._autoTimer = 0
end

FirstSceneSceneController.Init = function(self)
  -- function num : 0_3 , upvalues : FirstSceneSceneController, _ENV, HandleRockerMove, HandleRockerStop, FirstSceneWakeUp
  ((FirstSceneSceneController.super).Init)(self)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleRockerStop, Common.n_RockerEnd, nil)
  if ((NekoData.BehaviorManager).BM_Game):IsGM() then
    (DialogManager.CreateSingletonDialog)("firstscenejumpdialog")
  end
  ;
  (FirstSceneWakeUp.SetLuaWakeUpCallback)(self.OnWawkUp)
end

FirstSceneSceneController.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.DestroySingletonDialog)("firstscenejumpdialog")
end

FirstSceneSceneController.OnWawkUp = function()
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Voice):PlayVoice(20010001)
  local dialogEffect = (EffectFactory.CreateDialogEffect)(2, 71)
  dialogEffect:Run()
end

FirstSceneSceneController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_6 , upvalues : _ENV
  if ((self._sceneRef):GetFirstScenePlayerMove()).IsAuto then
    self._autoTimer = self._autoTimer + deltaTime
    if self._autoTimer > 60 then
      (LuaNotificationCenter.PostNotification)(Common.n_FirstSceneEnd, nil, nil)
    end
    ;
    ((self._sceneRef):GetFirstScenePlayerMove()).Dir = 0
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
    self._enableMove = false
    return 
  end
  if ((self._sceneRef):GetFirstScenePlayerMove()).enabled == true and self._needTips then
    self._totleTime = self._totleTime + deltaTime
    if self._totleTime > 3 then
      local moveguidedialog = (DialogManager.CreateSingletonDialog)("guide.moveguidedialog")
      local rockerdialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
      local positionDic = moveguidedialog:GetBackGroundPosition()
      rockerdialog:OnPointerDown({position = positionDic}, rockerdialog)
      rockerdialog:SwichTipAnim(true)
      self._needTips = false
    end
  end
  do
    if self._enableMove == false and ((self._sceneRef):GetFirstScenePlayerMove()).enabled == true then
      (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
      self._enableMove = true
      return 
    end
    if self._enableMove == true and ((self._sceneRef):GetFirstScenePlayerMove()).enabled == false then
      ((self._sceneRef):GetFirstScenePlayerMove()).Dir = 0
      self._enableMove = false
    end
  end
end

return FirstSceneSceneController


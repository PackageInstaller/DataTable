-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenerefs/trapref.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneRef = require("logic.scene.scenerefs.sceneref")
local TrapRef = class("TrapRef", SceneRef)
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local SceneObject = require("logic.manager.experimental.types.sceneobj")
local StatefulSceneObject = require("logic.scene.types.statefulsceneobject")
local Portal = require("logic.scene.types.portal")
TrapRef.Init = function(self)
  -- function num : 0_0 , upvalues : TrapRef, _ENV
  ((TrapRef.super).Init)(self)
  self.actor = {object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Actor")}
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).animator = ((self.actor).object):GetComponent("Animator")
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).emojiPoint = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "EmojiPoint")
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).camerafollow = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "CameraFollowPoint")
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).leftStep = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "StepL")
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).rightStep = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "StepR")
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.actor).light = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self.actor).object, "Point light")
  self:CollectObjects()
  self:CollectPortals()
  self.builder = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Builder")
end

TrapRef.CollectObjects = function(self)
  -- function num : 0_1 , upvalues : _ENV, SceneObject, UIInteraction, StatefulSceneObject
  self.objects = {}
  self.sceneobjects = {}
  self.statefulsceneobjects = {}
  self._trapRoot = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, "Map Data/Trap")
  if not self._trapRoot then
    return 
  end
  for id,gameobject in pairs((((((CS.PixelNeko).P1).Scene).TrapHelper).GetObjectsWithInfo)(self._trapRoot)) do
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

    (self.objects)[id] = {object = gameobject, animator = ((((CS.PixelNeko).Lua).AnimatorStaticFunctions).Get)(gameobject)}
  end
  local recorder = (BeanManager.GetTableByName)("sceneinteractive.cinteractiveconfig")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.SceneID == self:GetSceneID() then
      assert((self.objects)[record.index], "no object with trapid " .. record.index)
      local object = ((self.objects)[record.index]).object
      if ((((CS.PixelNeko).Lua).TransformStaticFunctions).IsAciveInHierarchy)(object) then
        local position = {}
        local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(object)
        position.x = (math.floor)(x / 0.4 + 0.5)
        position.y = (math.floor)(z / -0.56 + 0.5)
        local range = (string.split)(record.Range, ";")
        if range then
          position.w = tonumber(range[1])
          position.h = tonumber(range[2])
        else
          LogError("TrapRef", "wrong when create interactive object with data")
        end
        local interactiveObj = (SceneObject.Create)(record.id, record.SceneID, object, position, record.Type, record.Valueid, record.buttonText)
        interactiveObj:SetState(0)
        interactiveObj:SetRepeat(record.Repeatable)
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (self.sceneobjects)[#self.sceneobjects + 1] = {object = interactiveObj}
        if record.interactive == -1 then
          local success = (UIInteraction.AddSceneInteractiveObj)(interactiveObj)
          if success and UIInteraction.SetInteractiveData then
            (UIInteraction.SetInteractiveData)(record.id)
          end
        else
          do
            do
              local stateful = (StatefulSceneObject.Create)(record.id)
              ;
              (stateful:ToState(0)):Run()
              ;
              (table.insert)(self.statefulsceneobjects, stateful)
              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC172: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

TrapRef.CollectPortals = function(self)
  -- function num : 0_2 , upvalues : _ENV, Portal
  local sceneid = self:GetSceneID()
  self.portals = {}
  local recorder = (BeanManager.GetTableByName)("sceneinteractive.cgateconfig")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.SceneID == sceneid then
      local object = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._rootGameObject, record.path)
      if object then
        local portal = (Portal.Create)(i, object)
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.portals)[#self.portals + 1] = portal
      else
        do
          do
            LogErrorFormat("TrapRef", "cgateconfig id %s, gate path %s is wrong in scene id %s", record.id, record.path, record.SceneID)
            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

TrapRef.GetSceneControllerName = function(self)
  -- function num : 0_3
  return "logic.scene.trapscene.trapcontroller"
end

return TrapRef


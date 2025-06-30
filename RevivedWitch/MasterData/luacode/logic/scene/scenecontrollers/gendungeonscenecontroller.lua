-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/gendungeonscenecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local GenDungeonSceneController = class("GenDungeonSceneController", SceneController)
GenDungeonSceneController.Init = function(self)
  -- function num : 0_0 , upvalues : GenDungeonSceneController, _ENV
  ((GenDungeonSceneController.super).Init)(self)
  ;
  (LuaAudioManager.PlayBGM)(2)
end

GenDungeonSceneController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : GenDungeonSceneController, _ENV
  ((GenDungeonSceneController.super).OnDestroy)(self)
  self:HideUI()
  ;
  (EventManager.Clear)()
end

GenDungeonSceneController.RemoveEnemy = function(self, x, y)
  -- function num : 0_2 , upvalues : _ENV
  (((((CS.PixelNeko).P1).Scene).DungeonGenerator).RemoveEnemy)(x, y)
  LogInfo("event", "remove enemy at (" .. x .. ", " .. y .. ")")
end

GenDungeonSceneController.ShowUI = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.CreateSingletonDialog)("dungeon.settingmenu")
end

GenDungeonSceneController.HideUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.settingmenu")
end

GenDungeonSceneController.Restart = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (EventManager.Clear)()
  ;
  ((self._sceneRef).generator):restart()
end

GenDungeonSceneController.StopWalking = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(((self._sceneRef).actor).object, x, y)
end

GenDungeonSceneController.OnMouseButtonDown = function(self, x, y)
  -- function num : 0_7 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToScreenPos)(((self._sceneRef).actor).object, x, y)
end

GenDungeonSceneController.MoveTowards = function(self, x, y)
  -- function num : 0_8 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, 0)
end

return GenDungeonSceneController


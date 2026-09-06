local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local GenDungeonSceneController = class("GenDungeonSceneController", SceneController)

function GenDungeonSceneController:Init()
  GenDungeonSceneController.super.Init(self)
  LuaAudioManager.PlayBGM(2)
end

function GenDungeonSceneController:OnDestroy()
  GenDungeonSceneController.super.OnDestroy(self)
  self:HideUI()
  EventManager.Clear()
end

function GenDungeonSceneController:RemoveEnemy(x, y)
  CS.PixelNeko.P1.Scene.DungeonGenerator.RemoveEnemy(x, y)
  LogInfo("event", "remove enemy at (" .. x .. ", " .. y .. ")")
end

function GenDungeonSceneController:ShowUI()
  DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
  DialogManager.CreateSingletonDialog("dungeon.settingmenu")
end

function GenDungeonSceneController:HideUI()
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  DialogManager.DestroySingletonDialog("dungeon.settingmenu")
end

function GenDungeonSceneController:Restart()
  EventManager.Clear()
  self._sceneRef.generator:restart()
end

function GenDungeonSceneController:StopWalking()
  CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(self._sceneRef.actor.object, x, y)
end

function GenDungeonSceneController:OnMouseButtonDown(x, y)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveToScreenPos(self._sceneRef.actor.object, x, y)
end

function GenDungeonSceneController:MoveTowards(x, y)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTowards(self._sceneRef.actor.object, x, y, 0)
end

return GenDungeonSceneController

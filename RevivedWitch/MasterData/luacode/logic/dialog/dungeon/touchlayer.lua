-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/touchlayer.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TouchLayer = class("TouchLayer", Dialog)
TouchLayer.AssetBundleName = "ui/layouts.dungeon"
TouchLayer.AssetName = "Touch"
TouchLayer.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TouchLayer
  ((TouchLayer.super).Ctor)(self, ...)
  self._groupName = "Operation"
  self._muteCount = 0
end

TouchLayer.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnLayerClicked, self)
end

TouchLayer.OnDestroy = function(self)
  -- function num : 0_2
end

TouchLayer.EnableLongPress = function(self)
  -- function num : 0_3
  (self:GetRootWindow()):Subscribe_LongPressEvent(self.OnLayerLongPress, self)
end

TouchLayer.OnLayerClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  if not (DialogManager.GetDialog)("dungeon.rockerdialog") then
    if self._muteCount > 0 then
      return 
    end
    local pos = args.position
    local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if active_controller.OnMouseButtonDown then
      active_controller:OnMouseButtonDown(pos.x, pos.y)
    end
  end
end

TouchLayer.OnLayerLongPress = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  if not (DialogManager.GetDialog)("dungeon.rockerdialog") then
    if self._muteCount > 0 then
      return 
    end
    local pos = args.position
    local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if active_controller.MoveTowards then
      active_controller:MoveTowards(pos.x, pos.y)
    end
  end
end

TouchLayer.Mute = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local activeController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if activeController.StopWalking then
    activeController:StopWalking()
  end
  self._muteCount = self._muteCount + 1
end

TouchLayer.UnMute = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._muteCount = (math.max)(0, self._muteCount - 1)
end

return TouchLayer


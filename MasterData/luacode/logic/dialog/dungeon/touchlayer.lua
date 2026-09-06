local TouchLayer = class("TouchLayer", Dialog)
TouchLayer.AssetBundleName = "ui/layouts.dungeon"
TouchLayer.AssetName = "Touch"

function TouchLayer:Ctor(...)
  TouchLayer.super.Ctor(self, ...)
  self._groupName = "Operation"
  self._muteCount = 0
end

function TouchLayer:OnCreate()
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnLayerClicked, self)
end

function TouchLayer:OnDestroy()
end

function TouchLayer:EnableLongPress()
  self:GetRootWindow():Subscribe_LongPressEvent(self.OnLayerLongPress, self)
end

function TouchLayer:OnLayerClicked(args)
  if not DialogManager.GetDialog("dungeon.rockerdialog") then
    if self._muteCount > 0 then
      return
    end
    local pos = args.position
    local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if active_controller.OnMouseButtonDown then
      active_controller:OnMouseButtonDown(pos.x, pos.y)
    end
  end
end

function TouchLayer:OnLayerLongPress(args)
  if not DialogManager.GetDialog("dungeon.rockerdialog") then
    if self._muteCount > 0 then
      return
    end
    local pos = args.position
    local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if active_controller.MoveTowards then
      active_controller:MoveTowards(pos.x, pos.y)
    end
  end
end

function TouchLayer:Mute()
  local activeController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if activeController.StopWalking then
    activeController:StopWalking()
  end
  self._muteCount = self._muteCount + 1
end

function TouchLayer:UnMute()
  self._muteCount = math.max(0, self._muteCount - 1)
end

return TouchLayer

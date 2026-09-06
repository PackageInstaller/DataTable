local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CameraMoveEffect = class("CameraMoveEffect", EffectBase)
local EffectRunner = require("logic.scene.luaevent.effect.effectrunner")

function CameraMoveEffect:Ctor(target, duration, staytime)
  self._target = target
  self._camera = nil
  self._time = 0
  self._duration = duration or 0.5
  self._staytime = staytime or 0.5
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  self._camera = controller:GetCameraFollowPoint()
  self._op = {}
  if target.x == 0 and target.y == 0 and target.z == 0 then
    self._op.getPosition = CS.PixelNeko.Lua.TransformStaticFunctions.GetLocalPosition
    self._op.setPosition = CS.PixelNeko.Lua.TransformStaticFunctions.SetLocalPosition
  else
    self._op.getPosition = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition
    self._op.setPosition = CS.PixelNeko.Lua.TransformStaticFunctions.SetPosition
  end
end

local function on_update_end(self)
  EffectRunner.RemoveEffect(self._runnerID)
  LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  if self._callback then
    self._callback()
  end
end

function CameraMoveEffect:OnUpdate(deltaTime)
  if self._running then
    self._time = self._time + deltaTime
    self._tween:update(deltaTime)
    self._op.setPosition(self._camera, self._source.x, 0, self._source.z)
    if self._time > self._duration then
      self._running = false
      GameTimer.AddTask(self._staytime, 0, on_update_end, self)
    end
  end
end

function CameraMoveEffect:Run(args)
  if args and args.skip_camera or self._running then
    return
  end
  local x, y, z = self._op.getPosition(self._camera)
  if x ~= self._target.x or y ~= self._target.y or z ~= self._target.z then
    self._source = {
      x = x,
      y = y,
      z = z
    }
    self._tween = Tween.new(self._duration, self._source, self._target, "inOutQuad")
    self._running = true
    self._time = 0
    self._runnerID = EffectRunner.AddEffect(self)
  end
end

function CameraMoveEffect:Cancel()
  if self._running then
    on_update_end(self)
  end
end

function CameraMoveEffect:Then(callback)
  if self._running then
    self._callback = callback
  else
    CameraMoveEffect.super.Then(self, callback)
  end
end

return CameraMoveEffect

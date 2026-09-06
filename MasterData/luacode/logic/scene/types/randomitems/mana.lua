local RandomItem = require("logic.scene.types.randomitem")
local Mana = class("Mana", RandomItem)

function Mana:Ctor(data)
  Mana.super.Ctor(self, data)
end

function Mana:Destroy(instant)
  local cleanup = EffectFactory.CreateCustomEffect(function()
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._object)
    self._object = nil
  end)
  local pickup = EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.GetDialog("dungeon.dungeonhud")
    if dialog then
      dialog:OnRandomItemPick(self:GetKey(), self._data.x, self._data.z, self:GetType())
    end
  end)
  local result
  if not instant then
    local seq = EffectFactory.CreateComposedEffect()
    local ani = EffectFactory.CreateAnimatorStateChangeEffect("", "itemState", 1)
    ani:Bind(self._object)
    seq:AddEffect(ani)
    seq:AddEffect(pickup)
    seq:AddEffect(cleanup)
    result = seq
  end
  Mana.super.Destroy(self, instant)
  return result
end

function Mana:Activate(wx, wz)
  local recorder = BeanManager.GetTableByName("scene.cscenerandomreward"):GetRecorder(self._data.id)
  local event
  if wx and wz then
    event = EventManager.Builder.BuildRandomItemEvent(wx, wz, recorder.crashCubeHeight, recorder.crashCubeWidth, self._data.key)
  else
    event = EventManager.Builder.BuildRandomItemEvent(self._data.x * 0.4, self._data.z * -0.56, recorder.crashCubeHeight, recorder.crashCubeWidth, self._data.key)
  end
  self._eventID = event:GetID()
  EventManager.AddEvent(event)
end

function Mana:Deactivate()
  Mana.super.Deactivate(self)
end

function Mana:GetType()
  return 1
end

return Mana

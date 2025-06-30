-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/randomitems/mana.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RandomItem = require("logic.scene.types.randomitem")
local Mana = class("Mana", RandomItem)
Mana.Ctor = function(self, data)
  -- function num : 0_0 , upvalues : Mana
  ((Mana.super).Ctor)(self, data)
end

Mana.Destroy = function(self, instant)
  -- function num : 0_1 , upvalues : _ENV, Mana
  local cleanup = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : _ENV, self
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._object)
    self._object = nil
  end
)
  local pickup = ((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_1 , upvalues : _ENV, self
    local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
    if dialog then
      dialog:OnRandomItemPick(self:GetKey(), (self._data).x, (self._data).z, self:GetType())
    end
  end
))
  local result = nil
  if not instant then
    local seq = (EffectFactory.CreateComposedEffect)()
    local ani = (EffectFactory.CreateAnimatorStateChangeEffect)("", "itemState", 1)
    ani:Bind(self._object)
    seq:AddEffect(ani)
    seq:AddEffect(pickup)
    seq:AddEffect(cleanup)
    result = seq
  end
  do
    ;
    ((Mana.super).Destroy)(self, instant)
    return result
  end
end

Mana.Activate = function(self, wx, wz)
  -- function num : 0_2 , upvalues : _ENV
  local recorder = (((BeanManager.GetTableByName)("scene.cscenerandomreward")):GetRecorder((self._data).id))
  local event = nil
  if wx and wz then
    event = ((EventManager.Builder).BuildRandomItemEvent)(wx, wz, recorder.crashCubeHeight, recorder.crashCubeWidth, (self._data).key)
  else
    event = ((EventManager.Builder).BuildRandomItemEvent)((self._data).x * 0.4, (self._data).z * -0.56, recorder.crashCubeHeight, recorder.crashCubeWidth, (self._data).key)
  end
  self._eventID = event:GetID()
  ;
  (EventManager.AddEvent)(event)
end

Mana.Deactivate = function(self)
  -- function num : 0_3 , upvalues : Mana
  ((Mana.super).Deactivate)(self)
end

Mana.GetType = function(self)
  -- function num : 0_4
  return 1
end

return Mana


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/randomitems/recovershrine.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RandomItem = require("logic.scene.types.randomitem")
local RecoverShrine = class("RecoverShrine", RandomItem)
RecoverShrine.Ctor = function(self, data, context)
  -- function num : 0_0 , upvalues : RecoverShrine
  ((RecoverShrine.super).Ctor)(self, data)
  self._context = context
end

RecoverShrine.Destroy = function(self, instant, controller)
  -- function num : 0_1 , upvalues : _ENV, RecoverShrine
  local actor = nil
  if controller then
    actor = ((controller._sceneRef).actor).object
  end
  local recover = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : _ENV, actor
    (((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(actor, "TX_Prefab_ZhiLiao")):SetActive(true)
  end
)
  local over = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_1 , upvalues : _ENV, actor
    (((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(actor, "TX_Prefab_ZhiLiao")):SetActive(false)
  end
)
  local timeEffect = (EffectFactory.CreateDelayEffect)(1, self._context)
  if not instant then
    local seq = (EffectFactory.CreateComposedEffect)()
    local ani = (EffectFactory.CreateAnimatorStateChangeEffect)("", "trapState", 0)
    ani:Bind(self._object)
    seq:AddEffect(ani)
    seq:AddEffect(recover)
    seq:AddEffect(timeEffect)
    seq:AddEffect(over)
    seq:Run()
  end
  do
    ;
    ((RecoverShrine.super).Destroy)(self, instant)
  end
end

RecoverShrine.Activate = function(self)
  -- function num : 0_2 , upvalues : RandomItem
  local cfg = {
situation = {x = (self._data).x, y = (self._data).z}
, button_tip = 14}
  self._interactiveTri = ((RandomItem.RandomItemInteractiveTrigger).Create)((self._data).id, (self._data).key, cfg, self._object)
  ;
  (self._interactiveTri):Build()
  local animator = (self._object):GetComponent("Animator")
  if (self._data).status == 0 then
    animator:SetInteger("trapState", 1)
    animator:SetInteger("loadState", -1)
  else
    animator:SetInteger("trapState", 0)
    animator:SetInteger("loadState", -1)
  end
end

RecoverShrine.Deactivate = function(self)
  -- function num : 0_3 , upvalues : RecoverShrine
  ((RecoverShrine.super).Deactivate)(self)
end

RecoverShrine.GetType = function(self)
  -- function num : 0_4
  return 2
end

return RecoverShrine


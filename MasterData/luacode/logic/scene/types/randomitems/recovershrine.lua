local RandomItem = require("logic.scene.types.randomitem")
local RecoverShrine = class("RecoverShrine", RandomItem)

function RecoverShrine:Ctor(data, context)
  RecoverShrine.super.Ctor(self, data)
  self._context = context
end

function RecoverShrine:Destroy(instant, controller)
  local actor
  if controller then
    actor = controller._sceneRef.actor.object
  end
  local recover = EffectFactory.CreateCustomEffect(function()
    CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(actor, "TX_Prefab_ZhiLiao"):SetActive(true)
  end)
  local over = EffectFactory.CreateCustomEffect(function()
    CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(actor, "TX_Prefab_ZhiLiao"):SetActive(false)
  end)
  local timeEffect = EffectFactory.CreateDelayEffect(1, self._context)
  if not instant then
    local seq = EffectFactory.CreateComposedEffect()
    local ani = EffectFactory.CreateAnimatorStateChangeEffect("", "trapState", 0)
    ani:Bind(self._object)
    seq:AddEffect(ani)
    seq:AddEffect(recover)
    seq:AddEffect(timeEffect)
    seq:AddEffect(over)
    seq:Run()
  end
  RecoverShrine.super.Destroy(self, instant)
end

function RecoverShrine:Activate()
  local cfg = {
    situation = {
      x = self._data.x,
      y = self._data.z
    },
    button_tip = 14
  }
  self._interactiveTri = RandomItem.RandomItemInteractiveTrigger.Create(self._data.id, self._data.key, cfg, self._object)
  self._interactiveTri:Build()
  local animator = self._object:GetComponent("Animator")
  if self._data.status == 0 then
    animator:SetInteger("trapState", 1)
    animator:SetInteger("loadState", -1)
  else
    animator:SetInteger("trapState", 0)
    animator:SetInteger("loadState", -1)
  end
end

function RecoverShrine:Deactivate()
  RecoverShrine.super.Deactivate(self)
end

function RecoverShrine:GetType()
  return 2
end

return RecoverShrine

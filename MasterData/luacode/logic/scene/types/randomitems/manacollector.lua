local RandomItem = require("logic.scene.types.randomitem")
local ManaCollector = class("ManaCollector", RandomItem)

function ManaCollector:Ctor(data)
  ManaCollector.super.Ctor(self, data)
end

function ManaCollector:Destroy(instant, controller)
  local spillMana = EffectFactory.CreateCustomEffect(function()
    if controller and controller.AddRandomItemsRandomly then
      controller:AddRandomItemsRandomly(NekoData.BehaviorManager.BM_Dungeon:GetNewRandomItemsList(self._data.key), self:GetGirdPosition())
      local list = NekoData.BehaviorManager.BM_Dungeon:GetDungeonManaCollectorItemList()
      if list then
        DialogManager.CreateSingletonDialog("dungeon.dungeonitemaccountdialog"):SetData(list)
      end
    else
      LogWarning("RandomItem", "there is no AddRandomItemsRandomly function in current scene")
    end
    controller:RemoveMapIcon(RandomItemManager.Type.ManaCollector, self:GetKey())
  end)
  if not instant then
    local ani = EffectFactory.CreateAnimatorStateChangeEffect("", "trapState", 0)
    ani:Bind(self._object)
    ani:Run()
    spillMana:Run()
  end
  ManaCollector.super.Destroy(self, instant)
end

function ManaCollector:Activate()
  local cfg = {
    situation = {
      x = self._data.x,
      y = self._data.z
    },
    button_tip = 15
  }
  self._interactiveTri = RandomItem.RandomItemInteractiveTrigger.Create(self._data.id, self._data.key, cfg, self._object)
  self._interactiveTri:Build()
  local animator = self._object:GetComponent("Animator")
  if self._data.status == 0 then
    animator:SetInteger("trapState", 1)
    animator:SetInteger("loadState", 1)
  else
    animator:SetInteger("trapState", 0)
    animator:SetInteger("loadState", 0)
  end
end

function ManaCollector:Deactivate()
  ManaCollector.super.Deactivate(self)
end

function ManaCollector:GetType()
  return 3
end

return ManaCollector

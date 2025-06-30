-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/randomitems/manacollector.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RandomItem = require("logic.scene.types.randomitem")
local ManaCollector = class("ManaCollector", RandomItem)
ManaCollector.Ctor = function(self, data)
  -- function num : 0_0 , upvalues : ManaCollector
  ((ManaCollector.super).Ctor)(self, data)
end

ManaCollector.Destroy = function(self, instant, controller)
  -- function num : 0_1 , upvalues : _ENV, ManaCollector
  local spillMana = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_1_0 , upvalues : controller, _ENV, self
    if controller and controller.AddRandomItemsRandomly then
      controller:AddRandomItemsRandomly(((NekoData.BehaviorManager).BM_Dungeon):GetNewRandomItemsList((self._data).key), self:GetGirdPosition())
      local list = ((NekoData.BehaviorManager).BM_Dungeon):GetDungeonManaCollectorItemList()
      if list then
        ((DialogManager.CreateSingletonDialog)("dungeon.dungeonitemaccountdialog")):SetData(list)
      end
    else
      do
        LogWarning("RandomItem", "there is no AddRandomItemsRandomly function in current scene")
        controller:RemoveMapIcon((RandomItemManager.Type).ManaCollector, self:GetKey())
      end
    end
  end
)
  do
    if not instant then
      local ani = (EffectFactory.CreateAnimatorStateChangeEffect)("", "trapState", 0)
      ani:Bind(self._object)
      ani:Run()
      spillMana:Run()
    end
    ;
    ((ManaCollector.super).Destroy)(self, instant)
  end
end

ManaCollector.Activate = function(self)
  -- function num : 0_2 , upvalues : RandomItem
  local cfg = {
situation = {x = (self._data).x, y = (self._data).z}
, button_tip = 15}
  self._interactiveTri = ((RandomItem.RandomItemInteractiveTrigger).Create)((self._data).id, (self._data).key, cfg, self._object)
  ;
  (self._interactiveTri):Build()
  local animator = (self._object):GetComponent("Animator")
  if (self._data).status == 0 then
    animator:SetInteger("trapState", 1)
    animator:SetInteger("loadState", 1)
  else
    animator:SetInteger("trapState", 0)
    animator:SetInteger("loadState", 0)
  end
end

ManaCollector.Deactivate = function(self)
  -- function num : 0_3 , upvalues : ManaCollector
  ((ManaCollector.super).Deactivate)(self)
end

ManaCollector.GetType = function(self)
  -- function num : 0_4
  return 3
end

return ManaCollector


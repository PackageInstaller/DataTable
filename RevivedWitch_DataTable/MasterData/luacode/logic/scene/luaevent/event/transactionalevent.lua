-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/event/transactionalevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Event = require("logic.scene.luaevent.event.event")
local TransactionalEvent = class("TransactionalEvent", Event)
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
TransactionalEvent.Ctor = function(self, id, repeate, type)
  -- function num : 0_0 , upvalues : TransactionalEvent, ComposedEffect
  ((TransactionalEvent.super).Ctor)(self, id, repeate)
  self._root = (ComposedEffect.Create)()
  self._type = type or 1
end

TransactionalEvent.AddEffect = function(self, effect)
  -- function num : 0_1
  (self._root):AddEffect(effect)
end

TransactionalEvent.AddAlternativeEffect = function(self, effect)
  -- function num : 0_2 , upvalues : ComposedEffect
  if not self._alternativeRoot then
    self._alternativeRoot = (ComposedEffect.Create)()
  end
  ;
  (self._alternativeRoot):AddEffect(effect)
end

local fire = function(self, root, args)
  -- function num : 0_3 , upvalues : _ENV
  self._running = true
  ;
  (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
    -- function num : 0_3_0 , upvalues : self, _ENV, root, args
    if (notification.userInfo).id == self:GetConfigID() and (notification.userInfo).type == self._type then
      (LuaNotificationCenter.RemoveObserver)(self)
      ;
      (DialogManager.DestroySingletonDialog)("login.eventreconnectdialog")
      local effect = (EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_3_0_0 , upvalues : _ENV, self
      ((EffectFactory.CreateFreezeEffect)()):Run()
      ;
      ((NekoData.BehaviorManager).BM_Dungeon):CommitTransaction(self:GetConfigID(), self._type)
      self._running = false
    end
)
      do
        effect:SetParam("runoninit")
        root:Run(args)
        root:Then(function()
      -- function num : 0_3_0_1 , upvalues : effect, args
      effect:Run(args)
    end
)
      end
    end
  end
, Common.n_DungeonTransactionStart, nil)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    controller:BeginTransaction(self:GetConfigID(), self._type)
  else
    ;
    ((NekoData.BehaviorManager).BM_Dungeon):BeginTransaction(self:GetConfigID(), self._type)
  end
  ;
  (DialogManager.CreateSingletonDialog)("login.eventreconnectdialog")
end

TransactionalEvent.Fire = function(self, args)
  -- function num : 0_4 , upvalues : fire
  if not self._running then
    fire(self, self._root, args)
  end
end

TransactionalEvent.FireAlternative = function(self, args)
  -- function num : 0_5
  if not self._alternativeRoot then
    (self._root):Run(args)
  end
end

return TransactionalEvent


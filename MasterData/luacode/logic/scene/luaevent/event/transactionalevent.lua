local Event = require("logic.scene.luaevent.event.event")
local TransactionalEvent = class("TransactionalEvent", Event)
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")

function TransactionalEvent:Ctor(id, repeate, type)
  TransactionalEvent.super.Ctor(self, id, repeate)
  self._root = ComposedEffect.Create()
  self._type = type or 1
end

function TransactionalEvent:AddEffect(effect)
  self._root:AddEffect(effect)
end

function TransactionalEvent:AddAlternativeEffect(effect)
  if not self._alternativeRoot then
    self._alternativeRoot = ComposedEffect.Create()
  end
  self._alternativeRoot:AddEffect(effect)
end

local function fire(self, root, args)
  self._running = true
  LuaNotificationCenter.AddObserver(self, function(observer, notification)
    if notification.userInfo.id == self:GetConfigID() and notification.userInfo.type == self._type then
      LuaNotificationCenter.RemoveObserver(self)
      DialogManager.DestroySingletonDialog("login.eventreconnectdialog")
      local effect = EffectFactory.CreateCustomEffect(function()
        EffectFactory.CreateFreezeEffect():Run()
        NekoData.BehaviorManager.BM_Dungeon:CommitTransaction(self:GetConfigID(), self._type)
        self._running = false
      end)
      effect:SetParam("runoninit")
      root:Run(args)
      root:Then(function()
        effect:Run(args)
      end)
    end
  end, Common.n_DungeonTransactionStart, nil)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    controller:BeginTransaction(self:GetConfigID(), self._type)
  else
    NekoData.BehaviorManager.BM_Dungeon:BeginTransaction(self:GetConfigID(), self._type)
  end
  DialogManager.CreateSingletonDialog("login.eventreconnectdialog")
end

function TransactionalEvent:Fire(args)
  if not self._running then
    fire(self, self._root, args)
  end
end

function TransactionalEvent:FireAlternative(args)
  ;(self._alternativeRoot or self._root):Run(args)
end

return TransactionalEvent

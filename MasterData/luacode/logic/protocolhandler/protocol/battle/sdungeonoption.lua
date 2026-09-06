local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local UIInteraction = require("logic.scene.interaction.uiinteraction")

local function p1(protocol)
  DialogManager.DestroySingletonDialog("login.eventreconnectdialog")
  local effect, reconnect
  if protocol.optionId == 0 then
    effect, reconnect = EffectFactory.CreateComposedEffect(), false
  else
    effect, reconnect = StaticEvent.CreateInteractiveEffect(protocol.optionId)
  end
  if #protocol.items ~= 0 then
    local show = EffectFactory.CreateCustomEffect(function()
      DialogManager.CreateSingletonDialog("dungeon.dungeonitemaccountdialog"):SetData(protocol)
    end)
    effect:AddEffect(show)
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if protocol.optionId ~= 0 then
    local object = controller:GetPathResolver():GetSceneObject(protocol.optionId)
    effect:BindOnDemand(object:GetObj())
    effect:AddEffect(EffectFactory.CreateCustomEffect(function()
      object:SetState(1)
      if not object:IsRepeat() then
        UIInteraction.RemoveActButton(object:GetInteractiveId())
      end
    end))
  end
  if reconnect then
    EffectFactory.CreateFreezeEffect():Run()
    local event = EventManager.CreateTransactionalEvent(false, 3)
    event:SetConfigID(protocol.optionId)
    event:AddEffect(EffectFactory.CreateCustomEffect(function()
      EffectFactory.CreateThawEffect():Run()
    end))
    event:AddEffect(effect)
    event:AddEffect(EffectFactory.CreateCustomEffect(function()
      LuaNotificationCenter.PostNotification(Common.n_SceneObjectTouched, nil, protocol)
    end))
    event:Fire()
  else
    effect:Run()
    EffectFactory.CreateThawEffect():Run()
    LuaNotificationCenter.PostNotification(Common.n_SceneObjectTouched, nil, protocol)
  end
end

local function p2(protocol, client)
end

return {p1, p2}

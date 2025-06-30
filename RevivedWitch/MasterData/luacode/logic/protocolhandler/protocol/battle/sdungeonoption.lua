-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sdungeonoption.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, StaticEvent, UIInteraction
  (DialogManager.DestroySingletonDialog)("login.eventreconnectdialog")
  local effect, reconnect = nil, nil
  if protocol.optionId == 0 then
    effect = (EffectFactory.CreateComposedEffect)()
  else
    -- DECOMPILER ERROR at PC17: Overwrote pending register: R2 in 'AssignReg'

    effect = (StaticEvent.CreateInteractiveEffect)(protocol.optionId)
  end
  do
    if #protocol.items ~= 0 then
      local show = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_0 , upvalues : _ENV, protocol
    ((DialogManager.CreateSingletonDialog)("dungeon.dungeonitemaccountdialog")):SetData(protocol)
  end
)
      effect:AddEffect(show)
    end
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    do
      do
        if protocol.optionId ~= 0 then
          local object = (controller:GetPathResolver()):GetSceneObject(protocol.optionId)
          effect:BindOnDemand(object:GetObj())
          effect:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_1 , upvalues : object, UIInteraction
    object:SetState(1)
    if not object:IsRepeat() then
      (UIInteraction.RemoveActButton)(object:GetInteractiveId())
    end
  end
))
        end
        if reconnect then
          ((EffectFactory.CreateFreezeEffect)()):Run()
          local event = (EventManager.CreateTransactionalEvent)(false, 3)
          event:SetConfigID(protocol.optionId)
          event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_2 , upvalues : _ENV
    ((EffectFactory.CreateThawEffect)()):Run()
  end
))
          event:AddEffect(effect)
          event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_3 , upvalues : _ENV, protocol
    (LuaNotificationCenter.PostNotification)(Common.n_SceneObjectTouched, nil, protocol)
  end
))
          event:Fire()
        else
          do
            effect:Run()
            ;
            ((EffectFactory.CreateThawEffect)()):Run()
            ;
            (LuaNotificationCenter.PostNotification)(Common.n_SceneObjectTouched, nil, protocol)
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}


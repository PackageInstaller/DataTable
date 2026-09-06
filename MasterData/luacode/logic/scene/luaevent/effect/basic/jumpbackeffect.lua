local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local SceneBackEffect = class("SceneBackEffect", EffectBase)

function SceneBackEffect:Ctor(type)
  self._type = type
end

local function send(type)
  local req = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  req.enterCityType = type or 0
  req:Send()
end

function SceneBackEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  DialogManager.CreateSingletonDialog("login.eventreconnectdialog")
  if not self._type or self._type == "normal" then
    send(0)
  elseif self._type == "fail" then
    local dialog = DialogManager.CreateSingletonDialog("battle.battleaccount.battlelosedialog")
    if dialog then
      LuaNotificationCenter.AddObserver(SceneBackEffect, function()
        LuaNotificationCenter.RemoveObserver(SceneBackEffect)
        send(1)
      end, Common.n_BattleLoseAnimationEnd, nil)
    end
  else
    send(self._type)
  end
end

return SceneBackEffect

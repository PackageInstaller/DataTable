-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/jumpbackeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local SceneBackEffect = class("SceneBackEffect", EffectBase)
SceneBackEffect.Ctor = function(self, type)
  -- function num : 0_0
  self._type = type
end

local send = function(type)
  -- function num : 0_1 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  req.enterCityType = type or 0
  req:Send()
end

SceneBackEffect.Run = function(self)
  -- function num : 0_2 , upvalues : _ENV, send, SceneBackEffect
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  ;
  (DialogManager.CreateSingletonDialog)("login.eventreconnectdialog")
  if not self._type or self._type == "normal" then
    send(0)
  else
    if self._type == "fail" then
      local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlelosedialog")
      if dialog then
        (LuaNotificationCenter.AddObserver)(SceneBackEffect, function()
    -- function num : 0_2_0 , upvalues : _ENV, SceneBackEffect, send
    (LuaNotificationCenter.RemoveObserver)(SceneBackEffect)
    send(1)
  end
, Common.n_BattleLoseAnimationEnd, nil)
      end
    else
      do
        send(self._type)
      end
    end
  end
end

return SceneBackEffect


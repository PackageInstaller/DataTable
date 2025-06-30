-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/buttoneffect/20.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
return function(sceneobject)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(47, nil, function()
    -- function num : 0_0_0 , upvalues : _ENV, sceneobject
    (DialogManager.CreateSingletonDialog)("login.eventreconnectdialog")
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cdungeonoption")
    req.optionId = sceneobject:GetInteractiveId()
    req:Send()
  end
, nil, function()
    -- function num : 0_0_1 , upvalues : _ENV
    ((EffectFactory.CreateTimelineEffect)(1214)):Run()
  end
, nil)
end



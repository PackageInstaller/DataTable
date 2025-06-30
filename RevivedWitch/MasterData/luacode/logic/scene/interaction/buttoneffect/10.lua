-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/buttoneffect/10.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local send = function(id)
  -- function num : 0_0 , upvalues : _ENV
  local req = (LuaNetManager.CreateProtocol)("protocol.battle.copendungeonbox")
  req.boxId = id
  req:Send()
end

local check = function(itemid)
  -- function num : 0_1 , upvalues : _ENV
  do return ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(itemid) > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local checksend = function(id, itemid)
  -- function num : 0_2 , upvalues : check, _ENV, send
  if not check(itemid) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100085)
  else
    send(id)
  end
end

return function(sceneobject)
  -- function num : 0_3 , upvalues : _ENV, send, checksend
  local id = (math.tointeger)(sceneobject:GetInteractiveId() * -1 / 10000)
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local chest = (controller:GetPathResolver()):GetChest(id)
  local hint = chest:GetHintType()
  if hint == 0 then
    send(id)
    return 
  else
  end
  if (hint ~= 1 or hint == 2) and ((NekoData.BehaviorManager).BM_Game):GetChestOpenMode() == "direct" then
    checksend(id, chest:GetKeyID())
    return 
  end
  ;
  ((EffectFactory.CreateFreezeEffect)()):Run()
  local dialog = (DialogManager.CreateSingletonDialog)("confirmbox.chestconfirmdialog")
  dialog:PushDialogSetting(chest:GetKeyID(), function()
    -- function num : 0_3_0 , upvalues : checksend, id, chest, _ENV
    checksend(id, chest:GetKeyID())
    ;
    ((EffectFactory.CreateThawEffect)()):Run()
  end
, nil, function()
    -- function num : 0_3_1 , upvalues : _ENV
    ((EffectFactory.CreateThawEffect)()):Run()
  end
)
end



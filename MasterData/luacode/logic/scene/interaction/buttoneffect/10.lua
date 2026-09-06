local function send(id)
  local req = LuaNetManager.CreateProtocol("protocol.battle.copendungeonbox")
  
  req.boxId = id
  req:Send()
end

local function check(itemid)
  return NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(itemid) > 0
end

local function checksend(id, itemid)
  if not check(itemid) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100085)
  else
    send(id)
  end
end

return function(sceneobject)
  local id = math.tointeger(sceneobject:GetInteractiveId() * -1 / 10000)
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local chest = controller:GetPathResolver():GetChest(id)
  local hint = chest:GetHintType()
  if hint == 0 then
    send(id)
    return
  elseif hint == 1 then
  elseif hint == 2 and NekoData.BehaviorManager.BM_Game:GetChestOpenMode() == "direct" then
    checksend(id, chest:GetKeyID())
    return
  end
  EffectFactory.CreateFreezeEffect():Run()
  local dialog = DialogManager.CreateSingletonDialog("confirmbox.chestconfirmdialog")
  dialog:PushDialogSetting(chest:GetKeyID(), function()
    checksend(id, chest:GetKeyID())
    EffectFactory.CreateThawEffect():Run()
  end, nil, function()
    EffectFactory.CreateThawEffect():Run()
  end)
end

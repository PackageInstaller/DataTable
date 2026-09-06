local function p1(protocol)
  local function doNext()
    NekoData.DataManager.DM_Game:OnSCompleteZone(protocol)
    
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller then
      controller:OpenAccountDialogWhenCompleteZone()
    end
    NekoData.BehaviorManager.BM_Dungeon:ClearDungeonConquestList()
  end
  
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" then
    local dialog = DialogManager.CreateSingletonDialog("battle.finishexploredialog")
    if dialog then
      dialog:SetSpiritGiveData(protocol.money)
      dialog:SetCallBackFunc(doNext)
    else
      doNext()
    end
  else
    doNext()
  end
end

local function p2(protocol, client)
end

return {p1, p2}

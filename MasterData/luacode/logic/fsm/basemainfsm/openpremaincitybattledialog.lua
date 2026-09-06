local State = {}
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local ResourceStageTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")

function State.OnEnter(controller, lastState)
  LogInfo("BaseMainFSM", "OpenPreMainCityBattleDialog Enter")
  controller._baseMainFSM:SetBoolean("haveFSMHandleOrMainCityGuide", false)
  controller._baseMainFSM:SetBoolean("mainFSMEnd", false)
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.StarMirageUnlock) then
    DialogManager.CreateSingletonDialog("activity.starmirageunlockdialog")
  elseif NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.Anniversary) then
    DialogManager.CreateSingletonDialog("activity.anniversarypackage.anniversarypackagemaindialog")
  else
    local battleType = NekoData.BehaviorManager.BM_SBattleEnd:GetBattleType()
    local id = NekoData.BehaviorManager.BM_SBattleEnd:GetID()
    if battleType == CBattleStartProtocol.RESOURCE then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        local stageRecord = ResourceStageTable:GetRecorder(id)
        if stageRecord then
          dialog:ItemTipsJump({
            gainType = DataCommon.GainTypeEnum.Resource,
            worldId = math.floor(stageRecord.dungeonID / 100),
            info = stageRecord
          })
        end
      end
    elseif battleType == CBattleStartProtocol.BOSS_RUSH then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        dialog:OpenBossRushPanel()
      end
    elseif battleType == CBattleStartProtocol.WEEK_BOSS then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        dialog:OnActivityInfo()
        dialog:OpenWeekBossDialog()
      end
    elseif battleType == CBattleStartProtocol.SHATTERED then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        dialog:OnTypeFourBtnClicked()
        local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetshatteredzonesinfo")
        csend:Send()
      end
    elseif battleType == CBattleStartProtocol.ARENA then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        dialog:OnTypeFourBtnClicked()
        local csend = LuaNetManager.CreateProtocol("protocol.battle.copenarenapanel")
        csend:Send()
      end
    elseif battleType == CBattleStartProtocol.STARRY then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("activity.starmirage.selectlevelmaindialog")
      if dialog then
        local stageRecord = CStarrymirrorlevel:GetRecorder(id)
        if stageRecord then
          dialog:SetTabType(stageRecord.difficulty)
          local tabCell = dialog._tabFrame:GetCellAtIndex(dialog._tabType)
          tabCell._willShowDetail = true
          tabCell:SelectLevelById(id)
        end
      end
    elseif battleType == CBattleStartProtocol.ANNIVERSARY then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("activity.anniversary.anniversarymaindialog")
      if dialog then
        local stageRecord = CAnniversarylevel:GetRecorder(id)
        if stageRecord then
          dialog:SetTabType(stageRecord.difficulty)
          local tabCell = dialog._tabFrame:GetCellAtIndex(dialog._tabType)
          tabCell._willShowDetail = true
          tabCell:SelectLevelById(id)
        end
      end
    elseif battleType == CBattleStartProtocol.STARRY_MIRROR then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      local dialog = DialogManager.CreateSingletonDialog("activity.starmirage1.maindialog")
      if dialog then
        local stageRecord = CStarrymirrorlevel:GetRecorder(id)
        if stageRecord then
          dialog:SetTabType(stageRecord.difficulty)
          local tabCell = dialog._tabFrame:GetCellAtIndex(dialog._tabType)
          tabCell._willShowDetail = true
          tabCell:SelectLevelById(id)
        end
      end
    elseif battleType == CBattleStartProtocol.CHRISTMAS then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Christmas) then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetchristmasactivityinfo")
        if protocol then
          protocol:Send()
        end
      end
    elseif battleType == CBattleStartProtocol.LOVER then
      NekoData.DataManager.DM_SBattleEnd:Clear()
      if NekoData.BehaviorManager.BM_Activity:IsActivityOpen(DataCommon.Activities.Lover) then
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetloveractivityinfo")
        if protocol then
          protocol:Send()
        end
      end
    elseif NekoData.BehaviorManager.BM_Game:GetLastDungeonType() == 6 then
      NekoData.DataManager.DM_Game:ClearLastDungeonType()
      local bagDialog = DialogManager.GetDialog("equip.bagdialog")
      if bagDialog then
      else
        local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
        if dialog then
          dialog:Init(controller)
          dialog:OnTypeFourBtnClicked()
        end
      end
    elseif NekoData.BehaviorManager.BM_Game:GetLastDungeonType() == 7 then
      NekoData.DataManager.DM_Game:ClearLastDungeonType()
      local dialog = DialogManager.CreateSingletonDialog("mainline.mainline.mainlineworlddialog")
      if dialog then
        dialog:Init(controller)
        dialog:OnTypeFiveBtnClicked()
      end
    end
  end
  NekoData.DataManager.DM_SBattleEnd:Clear()
  NekoData.DataManager.DM_Game:ClearLastDungeonType()
  NekoData.DataManager.DM_Game:ClearLastAutoDungeonType()
end

function State.Update(controller)
end

function State.GoMainLine()
  local id = NekoData.BehaviorManager.BM_Game:GetLastFloorId()
  local list = NekoData.BehaviorManager.BM_Game:GetDungeonList()
  local three
  local cdungeonselectmainline = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
  for _, data in pairs(list) do
    local found = false
    three = {
      data = {},
      curZone = nil
    }
    three.curZone = data.curZone
    three.worldId = data.worldId
    three.clearZones = data.clearZones
    three.totalZones = data.totalZones
    three.isReceived = data.isReceived
    for _, d in ipairs(data.floorDetail) do
      local recorder = cdungeonselectmainline:GetRecorder(d.floor)
      found = found or recorder.sceneid == id
      local temp = {}
      temp.id = d.floor
      temp.spirit = d.spirit
      temp.firstGet = d.firstGet
      temp.isReceived = d.isReceived
      temp.openedBoxes = d.openedBoxes
      temp.totalBoxes = d.totalBoxes
      temp.checkPointOpenBoxex = d.checkPointOpenBoxex
      temp.checkPointTotalBoxes = d.checkPointTotalBoxes
      temp.autoExplore = d.autoExplore
      temp.smallPoint = d.smallPoint
      if not found then
        for _, v in pairs(d.smallPoint) do
          if v.sceneId == id then
            found = true
            break
          end
        end
      end
      table.insert(three.data, temp)
    end
    if found then
      table.sort(three.data, function(a, b)
        return a.id < b.id
      end)
      break
    end
  end
  DialogManager.CreateSingletonDialog("mainline.mainline.newmainlinefloordialog"):SetData(three)
end

function State.OnExit(controller, nextState)
  LogInfo("BaseMainFSM", "OpenPreMainCityBattleDialog Exit")
end

return State

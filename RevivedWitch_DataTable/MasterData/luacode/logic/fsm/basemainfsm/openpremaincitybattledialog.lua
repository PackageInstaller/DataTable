-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/basemainfsm/openpremaincitybattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, CBattleStartProtocol, ResourceStageTable, CStarrymirrorlevel, CAnniversarylevel
  LogInfo("BaseMainFSM", "OpenPreMainCityBattleDialog Enter")
  ;
  (controller._baseMainFSM):SetBoolean("haveFSMHandleOrMainCityGuide", false)
  ;
  (controller._baseMainFSM):SetBoolean("mainFSMEnd", false)
  if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).StarMirageUnlock) then
    (DialogManager.CreateSingletonDialog)("activity.starmirageunlockdialog")
  else
    if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).Anniversary) then
      (DialogManager.CreateSingletonDialog)("activity.anniversarypackage.anniversarypackagemaindialog")
    else
      local battleType = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleType()
      local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
      if battleType == CBattleStartProtocol.RESOURCE then
        ((NekoData.DataManager).DM_SBattleEnd):Clear()
        local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
        if dialog then
          dialog:Init(controller)
          local stageRecord = ResourceStageTable:GetRecorder(id)
          if stageRecord then
            dialog:ItemTipsJump({gainType = (DataCommon.GainTypeEnum).Resource, worldId = (math.floor)(stageRecord.dungeonID / 100), info = stageRecord})
          end
        end
      else
        do
          if battleType == CBattleStartProtocol.BOSS_RUSH then
            ((NekoData.DataManager).DM_SBattleEnd):Clear()
            local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
            if dialog then
              dialog:Init(controller)
              dialog:OpenBossRushPanel()
            end
          else
            do
              if battleType == CBattleStartProtocol.WEEK_BOSS then
                ((NekoData.DataManager).DM_SBattleEnd):Clear()
                local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                if dialog then
                  dialog:Init(controller)
                  dialog:OnActivityInfo()
                  dialog:OpenWeekBossDialog()
                end
              else
                do
                  if battleType == CBattleStartProtocol.SHATTERED then
                    ((NekoData.DataManager).DM_SBattleEnd):Clear()
                    local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                    if dialog then
                      dialog:Init(controller)
                      dialog:OnTypeFourBtnClicked()
                      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetshatteredzonesinfo")
                      csend:Send()
                    end
                  else
                    do
                      if battleType == CBattleStartProtocol.ARENA then
                        ((NekoData.DataManager).DM_SBattleEnd):Clear()
                        local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                        if dialog then
                          dialog:Init(controller)
                          dialog:OnTypeFourBtnClicked()
                          local csend = (LuaNetManager.CreateProtocol)("protocol.battle.copenarenapanel")
                          csend:Send()
                        end
                      else
                        do
                          if battleType == CBattleStartProtocol.STARRY then
                            ((NekoData.DataManager).DM_SBattleEnd):Clear()
                            local dialog = (DialogManager.CreateSingletonDialog)("activity.starmirage.selectlevelmaindialog")
                            if dialog then
                              local stageRecord = CStarrymirrorlevel:GetRecorder(id)
                              if stageRecord then
                                dialog:SetTabType(stageRecord.difficulty)
                                local tabCell = (dialog._tabFrame):GetCellAtIndex(dialog._tabType)
                                tabCell._willShowDetail = true
                                tabCell:SelectLevelById(id)
                              end
                            end
                          else
                            do
                              if battleType == CBattleStartProtocol.ANNIVERSARY then
                                ((NekoData.DataManager).DM_SBattleEnd):Clear()
                                local dialog = (DialogManager.CreateSingletonDialog)("activity.anniversary.anniversarymaindialog")
                                if dialog then
                                  local stageRecord = CAnniversarylevel:GetRecorder(id)
                                  if stageRecord then
                                    dialog:SetTabType(stageRecord.difficulty)
                                    local tabCell = (dialog._tabFrame):GetCellAtIndex(dialog._tabType)
                                    tabCell._willShowDetail = true
                                    tabCell:SelectLevelById(id)
                                  end
                                end
                              else
                                do
                                  if battleType == CBattleStartProtocol.STARRY_MIRROR then
                                    ((NekoData.DataManager).DM_SBattleEnd):Clear()
                                    local dialog = (DialogManager.CreateSingletonDialog)("activity.starmirage1.maindialog")
                                    if dialog then
                                      local stageRecord = CStarrymirrorlevel:GetRecorder(id)
                                      if stageRecord then
                                        dialog:SetTabType(stageRecord.difficulty)
                                        local tabCell = (dialog._tabFrame):GetCellAtIndex(dialog._tabType)
                                        tabCell._willShowDetail = true
                                        tabCell:SelectLevelById(id)
                                      end
                                    end
                                  else
                                    do
                                      if battleType == CBattleStartProtocol.CHRISTMAS then
                                        ((NekoData.DataManager).DM_SBattleEnd):Clear()
                                        if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Christmas) then
                                          local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetchristmasactivityinfo")
                                          if protocol then
                                            protocol:Send()
                                          end
                                        end
                                      else
                                        do
                                          if battleType == CBattleStartProtocol.LOVER then
                                            ((NekoData.DataManager).DM_SBattleEnd):Clear()
                                            if ((NekoData.BehaviorManager).BM_Activity):IsActivityOpen((DataCommon.Activities).Lover) then
                                              local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetloveractivityinfo")
                                              if protocol then
                                                protocol:Send()
                                              end
                                            end
                                          else
                                            do
                                              if ((NekoData.BehaviorManager).BM_Game):GetLastDungeonType() == 6 then
                                                ((NekoData.DataManager).DM_Game):ClearLastDungeonType()
                                                local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                                                if dialog then
                                                  dialog:Init(controller)
                                                  dialog:OnTypeFourBtnClicked()
                                                end
                                              else
                                                do
                                                  if ((NekoData.BehaviorManager).BM_Game):GetLastDungeonType() == 7 then
                                                    ((NekoData.DataManager).DM_Game):ClearLastDungeonType()
                                                    local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                                                    if dialog then
                                                      dialog:Init(controller)
                                                      dialog:OnTypeFiveBtnClicked()
                                                    end
                                                  end
                                                  do
                                                    ;
                                                    ((NekoData.DataManager).DM_SBattleEnd):Clear()
                                                    ;
                                                    ((NekoData.DataManager).DM_Game):ClearLastDungeonType()
                                                    ;
                                                    ((NekoData.DataManager).DM_Game):ClearLastAutoDungeonType()
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

State.Update = function(controller)
  -- function num : 0_1
end

State.GoMainLine = function()
  -- function num : 0_2 , upvalues : _ENV
  local id = ((NekoData.BehaviorManager).BM_Game):GetLastFloorId()
  ;
  (((NekoData.BehaviorManager).BM_Game):GetDungeonList())
  local list = nil
  local three = nil
  local cdungeonselectmainline = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
  for _,data in pairs(list) do
    local found = false
    three = {
data = {}
, curZone = nil}
    three.curZone = data.curZone
    three.worldId = data.worldId
    three.clearZones = data.clearZones
    three.totalZones = data.totalZones
    three.isReceived = data.isReceived
    for _,d in ipairs(data.floorDetail) do
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
        for _,v in pairs(d.smallPoint) do
          if v.sceneId == id then
            found = true
            break
          end
        end
      end
      ;
      (table.insert)(three.data, temp)
    end
    if found then
      (table.sort)(three.data, function(a, b)
    -- function num : 0_2_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      break
    end
  end
  ;
  ((DialogManager.CreateSingletonDialog)("mainline.mainline.newmainlinefloordialog")):SetData(three)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

State.OnExit = function(controller, nextState)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("BaseMainFSM", "OpenPreMainCityBattleDialog Exit")
end

return State


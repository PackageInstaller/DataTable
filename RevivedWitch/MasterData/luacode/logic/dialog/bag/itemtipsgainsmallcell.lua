-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgainsmallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local ResourceDungeonInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeoninfo")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local CItemAccessType = (BeanManager.GetTableByName)("item.citemaccesstype")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local BM_Buildings = {}
BM_Buildings[DataCommon.MagicTree] = (NekoData.BehaviorManager).BM_MagicTree
BM_Buildings[DataCommon.Explore] = (NekoData.BehaviorManager).BM_Explore
BM_Buildings[DataCommon.Firefly] = (NekoData.BehaviorManager).BM_Firefly
BM_Buildings[DataCommon.Alchemy] = (NekoData.BehaviorManager).BM_Alchemy
local CourtYardAnimatorState = {}
CourtYardAnimatorState[DataCommon.MagicTree] = 1
CourtYardAnimatorState[DataCommon.Explore] = 2
CourtYardAnimatorState[DataCommon.Firefly] = 5
CourtYardAnimatorState[DataCommon.Alchemy] = 3
local ItemTipsGainSmallCell = class("ItemTipsGainSmallCell", Dialog)
ItemTipsGainSmallCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainSmallCell.AssetName = "ItemTipsNewGet2"
ItemTipsGainSmallCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainSmallCell
  ((ItemTipsGainSmallCell.super).Ctor)(self, ...)
  self._gainType = nil
  self._way = nil
  self._record = nil
  self._worldId = nil
  self._tag = true
  self._inCourtYard = ""
end

ItemTipsGainSmallCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Txt2")
  self._goBtn = self:GetChild("GoBtn")
  self._gonBtnText = self:GetChild("GoBtn/Text")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

ItemTipsGainSmallCell.OnDestroy = function(self)
  -- function num : 0_2
end

ItemTipsGainSmallCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, MainLineTable, WorldTable, CItemAccessType, ResourceStageTable, ResourceDungeonInfoTable, CShopTypeConfig, CCourtyardNameCfg, BM_Buildings
  self._tag = (((self._delegate)._delegate)._delegate)._canJump
  self._inCourtYard = (((self._delegate)._delegate)._delegate)._inCourtYard
  ;
  (self._goBtn):SetActive(self._tag)
  self._gainType = ((self._delegate)._cellData).type
  local str = nil
  local tag = false
  if self._gainType == (DataCommon.GainTypeEnum).MainLine then
    self._record = MainLineTable:GetRecorder(data)
    str = (TextManager.GetText)((self._record).nameTextID)
    local dungeonList = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
    if dungeonList then
      for i,v in ipairs(dungeonList) do
        for index,value in ipairs(v.floorDetail) do
          if value.floor == data and (self._record).unlockLv <= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
            self._worldId = v.worldId
            tag = true
            break
          end
        end
      end
    end
  else
    do
      if self._gainType == (DataCommon.GainTypeEnum).MainLine_NotSelect then
        self._record = WorldTable:GetRecorder(data)
        str = (TextManager.GetText)((self._record).worldTextID)
        local dungeonList = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
        if dungeonList then
          for i,worldTemp in ipairs(dungeonList) do
            if worldTemp.worldId == data and ((NekoData.BehaviorManager).BM_Game):GetUnlockWorldPlayerLevelWithWorldId(data) <= (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel then
              self._worldId = data
              tag = true
              break
            end
          end
        end
      else
        do
          if self._gainType == (DataCommon.GainTypeEnum).ResourceMain then
            tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource)
            str = (TextManager.GetText)((CItemAccessType:GetRecorder(self._gainType)).type)
          else
            if self._gainType == (DataCommon.GainTypeEnum).Resource then
              self._record = ResourceStageTable:GetRecorder(data)
              str = (TextManager.GetText)((self._record).typeNameTextID)
              if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource) then
                local resourcePanelList = ((NekoData.BehaviorManager).BM_Game):GetResourcePanelList()
                for i,v in ipairs(resourcePanelList) do
                  if not v.lock and v.open then
                    for index,value in ipairs(v.detailInfo) do
                      if value.open then
                        for index_,stage in ipairs(value.stageList) do
                          if stage.id == data and not stage.lock and (self._record).level <= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
                            self._worldId = v.id
                            tag = true
                            break
                          end
                        end
                      end
                    end
                  end
                end
              end
            else
              do
                if self._gainType == (DataCommon.GainTypeEnum).Resource_NotSelect then
                  self._record = ResourceDungeonInfoTable:GetRecorder(data)
                  str = (TextManager.GetText)((self._record).nameTextID)
                  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Resource) then
                    local resourcePanelList = ((NekoData.BehaviorManager).BM_Game):GetResourcePanelList()
                    for i,v in ipairs(resourcePanelList) do
                      if v.id == (self._record).typeID and not v.lock and v.open then
                        local littleTypeInfo = (v.detailInfo)[(self._record).sortID]
                        if littleTypeInfo and littleTypeInfo.open then
                          self._worldId = v.id
                          tag = true
                          break
                        end
                      end
                    end
                  end
                else
                  do
                    if self._gainType == (DataCommon.GainTypeEnum).Tower then
                      str = (TextManager.GetText)((CItemAccessType:GetRecorder((DataCommon.GainTypeEnum).Tower)).type)
                      if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Tower) then
                        tag = ((NekoData.BehaviorManager).BM_TowerV2):IsOpen()
                        if self._gainType == (DataCommon.GainTypeEnum).Fragment then
                          str = (TextManager.GetText)((CItemAccessType:GetRecorder((DataCommon.GainTypeEnum).Fragment)).type)
                          tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Fragment)
                        else
                          if self._gainType == (DataCommon.GainTypeEnum).Shop then
                            local record = CShopTypeConfig:GetRecorder(data)
                            str = (TextManager.GetText)(record.NameTextID)
                            tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Shop)
                            self._shopId = data
                          else
                            do
                              if self._gainType == (DataCommon.GainTypeEnum).Yard then
                                local buildingLv = data % 10
                                self._buildingId = data - buildingLv
                                local record = CCourtyardNameCfg:GetRecorder(self._buildingId)
                                str = (TextManager.GetText)(record.nameTextID) .. ((NekoData.BehaviorManager).BM_Message):GetString(1285, {buildingLv})
                                tag = not BM_Buildings[self._buildingId] or buildingLv <= (BM_Buildings[self._buildingId]):GetLevel()
                              elseif self._gainType == (DataCommon.GainTypeEnum).UndecidedRoad then
                                str = (TextManager.GetText)((CItemAccessType:GetRecorder((DataCommon.GainTypeEnum).UndecidedRoad)).type)
                                tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).UndecidedRoad)
                              elseif self._gainType == (DataCommon.GainTypeEnum).WeekBoss then
                                str = (TextManager.GetText)((CItemAccessType:GetRecorder((DataCommon.GainTypeEnum).WeekBoss)).type)
                                tag = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BossRush)
                              end
                              ;
                              (self._text):SetText(str)
                              if tag then
                                (self._goBtn):SetInteractable(self._tag)
                                if tag then
                                  (self._gonBtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1315))
                                else
                                  (self._gonBtnText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1316))
                                end
                                -- DECOMPILER ERROR: 8 unprocessed JMP targets
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

ItemTipsGainSmallCell.OnGoBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CourtYardAnimatorState
  if self._gainType then
    ((DialogManager.GetGroup)("SecondConfirm")):CloseAllDialog()
    if self._gainType == (DataCommon.GainTypeEnum).Shop then
      ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(self._cellData)
      if self._inCourtYard == "" then
        local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
        if dialog then
          ((DialogManager.GetGroup)("Modal")):ReturnModalDialog(dialog)
        else
          ;
          ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
          local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
          if protocol then
            protocol:Send()
          end
        end
      else
        do
          ;
          ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard("Shop")
          do
            local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
            csend:Send()
            if self._gainType == (DataCommon.GainTypeEnum).Yard then
              if self._inCourtYard ~= "" then
                local yardController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                if yardController and yardController._state ~= CourtYardAnimatorState[self._buildingId] then
                  ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
                  if (yardController._yardFSM):GetCurrentState() == "Init" then
                    yardController:SetCameraAnimatorState(CourtYardAnimatorState[self._buildingId])
                  else
                    ;
                    (yardController._yardFSM):SetNumber("sceneId", 0)
                    ;
                    (yardController._yardFSM):SetNumber("cameraAnimatorState", CourtYardAnimatorState[self._buildingId])
                  end
                end
              else
                do
                  ;
                  ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
                  ;
                  ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard(CourtYardAnimatorState[self._buildingId])
                  do
                    local csend = (LuaNetManager.CreateProtocol)("protocol.yard.copenyard")
                    csend:Send()
                    if self._inCourtYard == "" then
                      ((DialogManager.GetGroup)("Modal")):CloseAllDialog()
                      local dialog = (DialogManager.CreateSingletonDialog)("mainline.mainline.mainlineworlddialog")
                      if dialog then
                        local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
                        dialog:Init(sceneController)
                        dialog:ItemTipsJump({gainType = self._gainType, worldId = self._worldId, info = self._record})
                      end
                    else
                      do
                        ;
                        ((NekoData.DataManager).DM_Game):SetFastMenuSignFromCourtyard("Dungeon", {gainType = self._gainType, worldId = self._worldId, info = self._record})
                        do
                          local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
                          csend:Send()
                          ;
                          ((DialogManager.GetGroup)("Tip")):CloseAllDialog()
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

return ItemTipsGainSmallCell


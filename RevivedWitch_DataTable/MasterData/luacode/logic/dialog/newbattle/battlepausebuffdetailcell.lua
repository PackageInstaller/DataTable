-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepausebuffdetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfig = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CCBuffConfig = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local BattlePauseBuffDetailCell = class("BattlePauseBuffDetailCell", Dialog)
BattlePauseBuffDetailCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseBuffDetailCell.AssetName = "BattlePauseCellBuff"
local ImgIdType = {Monster = 12233, Boss = 12232}
local OneLineBuffNum = 3
BattlePauseBuffDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattlePauseBuffDetailCell
  ((BattlePauseBuffDetailCell.super).Ctor)(self, ...)
end

BattlePauseBuffDetailCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._charImg = self:GetChild("CharBack/Image")
  self._charName = self:GetChild("Name")
  self._buffPanel = self:GetChild("BuffFrame")
  self._empty = self:GetChild("Empty")
  self._buffFrame = (TableFrame.Create)(self._buffPanel, self, true, false)
  self._rootWindowHeigthAnchor = (self:GetRootWindow()):GetHeight()
  self._buffPanelRectX = (self._buffPanel):GetRectSize()
  self._theBuffCell = (DialogManager.CreateDialog)("newbattle.battlepausebuffdetailcellcellbuffcell", (self._buffPanel):GetUIObject())
  ;
  ((self._theBuffCell):GetRootWindow()):SetPosition(0, 100000, 0, 0)
end

BattlePauseBuffDetailCell.OnDestroy = function(self)
  -- function num : 0_2
  if self._buffFrame then
    (self._buffFrame):Destroy()
    self._buffFrame = nil
  end
  ;
  (self._theBuffCell):Destroy()
  ;
  (self._theBuffCell):RootWindowDestroy()
end

BattlePauseBuffDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Role, CMonsterConfig, ImgIdType, CImagePathTable, CCBuffConfig
  local nameTextId = (data.battler):GetNameTextId()
  if (data.battler):IsLeftCamp() then
    do
      if nameTextId > 0 then
        local name = (TextManager.GetText)(nameTextId)
        ;
        (self._charName):SetText((string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username))
      end
      if (data.battler):IsRole() then
        local role = (Role.Create)((data.battler):GetConfigId())
        local imgRecord = role:GetSkillHeadImageRecord()
        if imgRecord then
          (self._charImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        end
      else
        do
          local recorder = CMonsterConfig:GetRecorder((data.battler):GetConfigId())
          if recorder then
            local imageId = ImgIdType.Monster
            if recorder.bossOrNot == 1 then
              imageId = ImgIdType.Boss
            end
            if not CImagePathTable:GetRecorder(imageId) then
              local imageRecord = DataCommon.DefaultImageAsset
            end
            ;
            (self._charImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
          end
          do
            if nameTextId > 0 then
              local name = (TextManager.GetText)(nameTextId)
              local protocol = ((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()
              local userName = ((NekoData.BehaviorManager).BM_Battle):GetArenaEnemyNameByBattleID(protocol.battleid) or ""
              name = (string.gsub)(name, "%$heroine%$", userName)
              ;
              (self._charName):SetText(name)
            end
            do
              local recorder = CMonsterConfig:GetRecorder((data.battler):GetConfigId())
              if recorder then
                local imageId = ImgIdType.Monster
                if recorder.bossOrNot == 1 then
                  imageId = ImgIdType.Boss
                end
                if not CImagePathTable:GetRecorder(imageId) then
                  local imageRecord = DataCommon.DefaultImageAsset
                end
                ;
                (self._charImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
              else
                do
                  local role = (Role.Create)((data.battler):GetConfigId())
                  do
                    local imgRecord = role:GetSkillHeadImageRecord()
                    if imgRecord then
                      (self._charImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                    end
                    self._buffList = {}
                    for buffId,_ in pairs(data.buffList) do
                      local recorder = CCBuffConfig:GetRecorder(buffId)
                      if recorder.buffTextID ~= -1 then
                        (table.insert)(self._buffList, buffId)
                      end
                    end
                    ;
                    (table.sort)(self._buffList, function(a, b)
    -- function num : 0_3_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
                    local data = {}
                    local i = 1
                    local oneLineLength = 0
                    for _,v in ipairs(self._buffList) do
                      local recorder = CCBuffConfig:GetRecorder(v)
                      local thisLength = (self._theBuffCell):GetCellActualWidth((TextManager.GetText)(recorder.buffTextID))
                      oneLineLength = oneLineLength + thisLength
                      if data[i] then
                        if self._buffPanelRectX < oneLineLength then
                          i = i + 1
                          data[i] = {}
                          oneLineLength = thisLength
                        end
                        ;
                        (table.insert)(data[i], v)
                      else
                        data[i] = {}
                        ;
                        (table.insert)(data[i], v)
                      end
                    end
                    self._data = {}
                    for i = #data, 1, -1 do
                      (table.insert)(self._data, data[i])
                    end
                    ;
                    (self._buffFrame):ReloadAllCell()
                    local totalLength = (self._buffFrame):GetTotalLength()
                    if self._buffPanelRectY < totalLength then
                      (self:GetRootWindow()):SetHeight(self._rootWindowHeigthAnchor, self._rootWindowHeigthOffset + totalLength - self._buffPanelRectY)
                    else
                      ;
                      (self:GetRootWindow()):SetHeight(self._rootWindowHeigthAnchor, self._rootWindowHeigthOffset)
                    end
                    ;
                    (self._buffFrame):ReloadAllCell()
                    if #self._data == 0 then
                      (self._empty):SetActive(true)
                    else
                      ;
                      (self._empty):SetActive(false)
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

BattlePauseBuffDetailCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._buffFrame then
    return #self._data
  end
end

BattlePauseBuffDetailCell.CellAtIndex = function(self, frame)
  -- function num : 0_5
  if frame == self._buffFrame then
    return "newbattle.battlepausebuffdetailcellcell"
  end
end

BattlePauseBuffDetailCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._buffFrame then
    return (self._data)[index]
  end
end

return BattlePauseBuffDetailCell


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguabattleselectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CBeatMelonConfig = (BeanManager.GetTableByName)("activity.cbeatmelonconfig")
local XiGuaBattleSelectDialog = class("XiGuaBattleSelectDialog", Dialog)
XiGuaBattleSelectDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaBattleSelectDialog.AssetName = "ActivitySummerXiGua"
XiGuaBattleSelectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaBattleSelectDialog
  ((XiGuaBattleSelectDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._totalData = {}
end

XiGuaBattleSelectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._panel = self:GetChild("Frame")
  self._rankBtn = self:GetChild("RankBtn")
  self._frame = (TableFrame.Create)(self._panel, self, false, false)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSreceiveWatermelonReward, Common.n_OnSreceiveWatermelonReward)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReturnFromBattle, Common.n_ReturnFromBattle)
end

XiGuaBattleSelectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

XiGuaBattleSelectDialog.SetData = function(self, data)
  -- function num : 0_3
  self._constructionLevel = data.constructionLevel
  self._functionIDs = data.functionIDs
  self._constructionId = data.constructionID
  self:GetServerData()
end

XiGuaBattleSelectDialog.GetServerData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LogInfo("XiGuaBattleSelectDialog", "GetServerData")
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.copenwatermelonbosspanel")
  if protocol then
    protocol:Send()
  end
end

XiGuaBattleSelectDialog.OnSOpenWatermelonBossPanel = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  LogInfo("XiGuaBattleSelectDialog", "OnSOpenWatermelonBossPanel")
  LogInfoFormat("XiGuaBattleSelectDialog", "The server boss data length is %d", #protocol.bosses)
  self._serverData = protocol.bosses
  self:RefreshTotalData()
end

XiGuaBattleSelectDialog.RefreshTotalData = function(self)
  -- function num : 0_6 , upvalues : _ENV, CBeatMelonConfig
  for key,_ in pairs(self._totalData) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._totalData)[key] = nil
  end
  for _,bossBean in pairs(self._serverData) do
    local record = CBeatMelonConfig:GetRecorder(bossBean.id)
    if record.unlockLevel > self._constructionLevel then
      do
        (table.insert)(self._totalData, {info = bossBean, cfg = record, isUnlock = not record})
        -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (table.sort)(self._totalData, function(a, b)
    -- function num : 0_6_0
    do return (a.cfg).sort < (b.cfg).sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  LogInfoFormat("XiGuaBattleSelectDialog", "The total data length is %d", #self._totalData)
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

XiGuaBattleSelectDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  return #self._totalData
end

XiGuaBattleSelectDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "activity.swimsuit.xiguabattleselectcell"
end

XiGuaBattleSelectDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return {index = index, data = (self._totalData)[index]}
end

XiGuaBattleSelectDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

XiGuaBattleSelectDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

XiGuaBattleSelectDialog.OnRankBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuit.xiguarankdialog")
  if dialog then
    dialog:SetData({constructionID = self._constructionId, totalData = self._totalData})
  end
end

XiGuaBattleSelectDialog.OnSreceiveWatermelonReward = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  LogInfo("XiGuaBattleSelectDialog", "OnSreceiveWatermelonReward")
  self:GetServerData()
end

XiGuaBattleSelectDialog.OnReturnFromBattle = function(self)
  -- function num : 0_14 , upvalues : _ENV
  LogInfo("XiGuaBattleSelectDialog", "OnReturnFromBattle")
  self:GetServerData()
end

return XiGuaBattleSelectDialog


local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CBeatMelonConfig = BeanManager.GetTableByName("activity.cbeatmelonconfig")
local XiGuaBattleSelectDialog = class("XiGuaBattleSelectDialog", Dialog)
XiGuaBattleSelectDialog.AssetBundleName = "ui/layouts.activitysummer"
XiGuaBattleSelectDialog.AssetName = "ActivitySummerXiGua"

function XiGuaBattleSelectDialog:Ctor(...)
  XiGuaBattleSelectDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._totalData = {}
end

function XiGuaBattleSelectDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  self._rankBtn = self:GetChild("RankBtn")
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn = self:GetChild("BackBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSreceiveWatermelonReward, Common.n_OnSreceiveWatermelonReward)
  LuaNotificationCenter.AddObserver(self, self.OnReturnFromBattle, Common.n_ReturnFromBattle)
end

function XiGuaBattleSelectDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function XiGuaBattleSelectDialog:SetData(data)
  self._constructionLevel = data.constructionLevel
  self._functionIDs = data.functionIDs
  self._constructionId = data.constructionID
  self:GetServerData()
end

function XiGuaBattleSelectDialog:GetServerData()
  LogInfo("XiGuaBattleSelectDialog", "GetServerData")
  local protocol = LuaNetManager.CreateProtocol("protocol.battle.copenwatermelonbosspanel")
  if protocol then
    protocol:Send()
  end
end

function XiGuaBattleSelectDialog:OnSOpenWatermelonBossPanel(protocol)
  LogInfo("XiGuaBattleSelectDialog", "OnSOpenWatermelonBossPanel")
  LogInfoFormat("XiGuaBattleSelectDialog", "The server boss data length is %d", #protocol.bosses)
  self._serverData = protocol.bosses
  self:RefreshTotalData()
end

function XiGuaBattleSelectDialog:RefreshTotalData()
  for key, _ in pairs(self._totalData) do
    self._totalData[key] = nil
  end
  for _, bossBean in pairs(self._serverData) do
    local record = CBeatMelonConfig:GetRecorder(bossBean.id)
    if record then
      table.insert(self._totalData, {
        info = bossBean,
        cfg = record,
        isUnlock = self._constructionLevel >= record.unlockLevel
      })
    end
  end
  table.sort(self._totalData, function(a, b)
    return a.cfg.sort < b.cfg.sort
  end)
  LogInfoFormat("XiGuaBattleSelectDialog", "The total data length is %d", #self._totalData)
  self._frame:ReloadAllCell()
end

function XiGuaBattleSelectDialog:NumberOfCell(frame, index)
  return #self._totalData
end

function XiGuaBattleSelectDialog:CellAtIndex(frame, index)
  return "activity.swimsuit.xiguabattleselectcell"
end

function XiGuaBattleSelectDialog:DataAtIndex(frame, index)
  return {
    index = index,
    data = self._totalData[index]
  }
end

function XiGuaBattleSelectDialog:OnBackBtnClicked()
  self:Destroy()
end

function XiGuaBattleSelectDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function XiGuaBattleSelectDialog:OnRankBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.xiguarankdialog")
  if dialog then
    dialog:SetData({
      constructionID = self._constructionId,
      totalData = self._totalData
    })
  end
end

function XiGuaBattleSelectDialog:OnSreceiveWatermelonReward(notification)
  LogInfo("XiGuaBattleSelectDialog", "OnSreceiveWatermelonReward")
  self:GetServerData()
end

function XiGuaBattleSelectDialog:OnReturnFromBattle()
  LogInfo("XiGuaBattleSelectDialog", "OnReturnFromBattle")
  self:GetServerData()
end

return XiGuaBattleSelectDialog

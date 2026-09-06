local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cinterentry")
local CChrisfinal = BeanManager.GetTableByName("dungeonselect.cchrisfinal")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasStoryEndScoreDialog = class("ChristmasStoryEndScoreDialog", Dialog)
ChristmasStoryEndScoreDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasStoryEndScoreDialog.AssetName = "ActivityChristmasEndScore"

function ChristmasStoryEndScoreDialog:Ctor(...)
  ChristmasStoryEndScoreDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID)
end

function ChristmasStoryEndScoreDialog:OnCreate()
  self._charChip = self:GetChild("Back/CharChip")
  self._name = self:GetChild("Back/Name")
  self._levelImg = self:GetChild("Level")
  self._nums = {}
  for i = 1, 3 do
    self._nums[i] = {}
    self._nums[i].Num = self:GetChild("NumBack" .. i .. "/Num")
  end
  self._sing = self:GetChild("NumBack1/Sing")
  self._show = self:GetChild("NumBack2/Show")
  self._jump = self:GetChild("NumBack3/Jump")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self._getBtn = self:GetChild("GetBtn")
  self._closeBtn = self:GetChild("CloseBtn")
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSUpdateConstructionEvent, Common.n_OnSUpdateChristmasConstructionEvent, nil)
end

function ChristmasStoryEndScoreDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
  end
end

function ChristmasStoryEndScoreDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local currencyItem = Item.Create(DataCommon.ChristmasSing)
  self._sing:SetText(currencyItem:GetName())
  local currencyItem = Item.Create(DataCommon.ChristmasExpressiveForce)
  self._show:SetText(currencyItem:GetName())
  local currencyItem = Item.Create(DataCommon.ChristmasJump)
  self._jump:SetText(currencyItem:GetName())
  self._nums[1].Num:SetText(self._bm:GetScoreByType(DataCommon.ChristmasSing))
  self._nums[2].Num:SetText(self._bm:GetScoreByType(DataCommon.ChristmasExpressiveForce))
  self._nums[3].Num:SetText(self._bm:GetScoreByType(DataCommon.ChristmasJump))
  local recorder = CChrisfinal:GetRecorder(self._functionID)
  self._itemData = {}
  if recorder then
    for i, v in ipairs(recorder.collectbonus) do
      local temp = {
        tag = "item",
        itemID = v,
        count = recorder.collectbonusnum[i]
      }
      table.insert(self._itemData, temp)
    end
    self._frame:ReloadAllCell()
    self._name:SetText(TextManager.GetText(recorder.textID))
    local imageRecord = CImagePathTable:GetRecorder(recorder.picid) or DataCommon.DefaultImageAsset
    self._charChip:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._getBtn:SetInteractable(recorder.type == 1)
  else
    LogErrorFormat("ChristmasStoryEndScoreDialog", "CChrisfinal NO Exist Id %s", self._functionID)
  end
end

function ChristmasStoryEndScoreDialog:OnGetBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
  csend.constructionID = self._constructionID
  csend.eventID = self._functionID
  csend:Send()
end

function ChristmasStoryEndScoreDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChristmasStoryEndScoreDialog:OnSUpdateConstructionEvent(notification)
  if self._constructionID and CInterEntry:GetRecorder(self._constructionID) then
    local recorder = CInterEntry:GetRecorder(self._constructionID)
    local pos = recorder.posId
    for _, event in ipairs(notification.userInfo.updates) do
      if next(event.events) ~= nil then
        local recorder = CInterEntry:GetRecorder(event.construction)
        if pos == recorder.posId then
          self:SetData({
            functionID = event.events[1],
            constructionID = event.construction
          })
          break
        end
      end
    end
  end
end

function ChristmasStoryEndScoreDialog:NumberOfCell(frame)
  return #self._itemData
end

function ChristmasStoryEndScoreDialog:CellAtIndex(frame, index)
  return "activity.christmas.christmasbattleitemcell"
end

function ChristmasStoryEndScoreDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ChristmasStoryEndScoreDialog

local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CPosterGirlNpc = BeanManager.GetTableByName("welfare.cpostergirlnpc")
local CDungeonSelectMainLine = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CHomeChatConfig = BeanManager.GetTableByName("dialog.chomechatconfig")
local CHomeChatList = BeanManager.GetTableByName("dialog.chomechatlist")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CMonthloginMonth = BeanManager.GetTableByName("welfare.cmonthloginmonth")
local WitchCalendarTabCell = class("WitchCalendarTabCell", Dialog)
WitchCalendarTabCell.AssetBundleName = "ui/layouts.welfare"
WitchCalendarTabCell.AssetName = "MonthLogin"

function WitchCalendarTabCell:Ctor(...)
  WitchCalendarTabCell.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_Welfare
  self._cellData = {}
end

function WitchCalendarTabCell:OnCreate()
  self._titleImg = self:GetChild("BackImage/Title")
  self._live2D = self:GetChild("BackImage/Role/Live2D")
  self._photo = self:GetChild("BackImage/Role/Photo")
  self._clickPanel = self:GetChild("BackImage/Role/Live2D/Live2dClick")
  self._dialogPanel = self:GetChild("BackImage/Role/Dialog")
  self._dialogPanel_Text = self:GetChild("BackImage/Role/Dialog/Text")
  self._dialogPanel:SetActive(false)
  self._tipBtn = self:GetChild("BackImage/DetailBtn")
  self._tipBtn_Txt = self:GetChild("BackImage/DetailBtn/Txt")
  self._tipBtn_Txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1967))
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = GridFrame.Create(self._cellPanel, self, true, 7, false)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshTabCell, Common.n_RefreshWitchCalendar, nil)
  self:Init()
end

function WitchCalendarTabCell:OnDestroy()
  self._cellFrame:Destroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
end

function WitchCalendarTabCell:Init()
  self._roleId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundRole
  self._skinId = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().backgroundSkin
  if self._roleId == 0 then
    self:SetAiLinNa()
  else
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._roleId)
    local fashionData
    if self._skinId > 0 then
      fashionData = CSkin:GetRecorder(self._skinId)
    end
    self:SetLive2D(self._role, fashionData)
  end
end

function WitchCalendarTabCell:RefreshTabCell(refresh)
  local data = NekoData.BehaviorManager.BM_Welfare:GetWitchCalendarInfo()
  if data and (not self._init or refresh) then
    self._data = data
    local month = data.month
    local record = CMonthloginMonth:GetRecorder(month)
    local image = CImagePathTable:GetRecorder(record.monthPicID) or DataCommon.DefaultImageAsset
    self._titleImg:SetSprite(image.assetBundle, image.assetName)
    if refresh and self._delegate._selectedTab == self._delegate.WelfareType.witchCalendar then
      DialogManager.CreateSingletonDialog("guide.blockclickdialog")
      if self._timer then
        GameTimer.RemoveTask(self._timer)
        self._timer = nil
      end
      self._timer = GameTimer.AddTask(0.5, -1, function()
        local protocol = LuaNetManager.CreateProtocol("protocol.activity.cmonthlysign")
        protocol.dayId = self._data.today
        protocol:Send()
        DialogManager.DestroySingletonDialog("guide.blockclickdialog")
      end, nil)
    end
    while self._cellData[#self._cellData] do
      table.remove(self._cellData, #self._cellData)
    end
    local haveLock
    for id, record in pairs(self._data.cfgs) do
      if self._data.receivedIds[id] then
        table.insert(self._cellData, {
          id = id,
          record = record,
          tag = "received"
        })
      elseif id < self._data.today then
        table.insert(self._cellData, {
          id = id,
          record = record,
          tag = "pending"
        })
      elseif id == self._data.today then
        table.insert(self._cellData, {
          id = id,
          record = record,
          tag = "today"
        })
      else
        table.insert(self._cellData, {
          id = id,
          record = record,
          tag = "lock"
        })
      end
    end
    table.sort(self._cellData, function(a, b)
      return a.record.id < b.record.id
    end)
    self._cellFrame:ReloadAllCell()
  end
end

function WitchCalendarTabCell:OnTipBtnClick()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(5)
end

function WitchCalendarTabCell:NumberOfCell(frame)
  return #self._cellData
end

function WitchCalendarTabCell:CellAtIndex(frame, index)
  return "welfare.witchcalendar.witchcalendarsigncell"
end

function WitchCalendarTabCell:DataAtIndex(frame, index)
  return self._cellData[index]
end

function WitchCalendarTabCell:SetAiLinNa()
  local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
  local record = CNpcShapeTable:GetRecorder(aiLinNaRecorder.shapeId)
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    self._photo:SetActive(true)
    local recorder = CImagePathTable:GetRecorder(record.lihuiID) or DataCommon.DefaultImageAsset
    self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
    local scale = record.photoScale
    self._photo:SetLocalScale(scale, scale, scale)
    self._photo:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
  end
  self._clickPanel:SetActive(true)
end

function WitchCalendarTabCell:SetLive2D(data, fashionData)
  if not data and not fashionData then
    return
  end
  local theRoleID = data:GetId()
  local theFashionID = data:GetDefaultFashion()
  local record = data:GetShapeLive2DRecord()
  if fashionData then
    local shapeId = fashionData.shapeID
    record = CNpcShapeTable:GetRecorder(shapeId)
    theRoleID = fashionData.roleid
    theFashionID = fashionData.id
  end
  self._picTouchData = {
    NekoData.BehaviorManager.BM_RoleTouch:GetPicTouchInfo(theRoleID, theFashionID)
  }
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if fashionData.shapeType == 2 and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    self._live2D:SetLive2DAnimatorInteger(self._handler, "isLoop", 1)
    if not self._live2D:OnlyFor0916Func() then
      self._clickPanel:SetActive(true)
    else
      local touchRecordList = NekoData.BehaviorManager.BM_RoleTouch:GetLive2DTouchInfo(theRoleID, theFashionID)
      if 0 < #touchRecordList then
        self._live2D:AddPointerDownListener(self._handler, function(_, posName)
          self:OnLive2DPointerDown(posName, theRoleID, theFashionID, touchRecordList)
        end, self)
        self._clickPanel:SetActive(false)
      else
        self._clickPanel:SetActive(true)
      end
    end
  else
    self._clickPanel:SetActive(true)
    self._photo:SetActive(true)
    if fashionData then
      local recorder = CImagePathTable:GetRecorder(record.lihuiID)
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local scale = record.photoScale
      self._photo:SetLocalScale(scale, scale, scale)
      self._photo:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
    else
      local recorder = data:GetShapeLiHuiImageRecord()
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local scale = data:GetPhotoScale()
      self._photo:SetLocalScale(scale, scale, scale)
      local photoPos = data:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  end
end

return WitchCalendarTabCell

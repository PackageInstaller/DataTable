-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/witchcalendar/witchcalendartabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CPosterGirlNpc = (BeanManager.GetTableByName)("welfare.cpostergirlnpc")
local CDungeonSelectMainLine = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CHomeChatConfig = (BeanManager.GetTableByName)("dialog.chomechatconfig")
local CHomeChatList = (BeanManager.GetTableByName)("dialog.chomechatlist")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CMonthloginMonth = (BeanManager.GetTableByName)("welfare.cmonthloginmonth")
local WitchCalendarTabCell = class("WitchCalendarTabCell", Dialog)
WitchCalendarTabCell.AssetBundleName = "ui/layouts.welfare"
WitchCalendarTabCell.AssetName = "MonthLogin"
WitchCalendarTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : WitchCalendarTabCell, _ENV
  ((WitchCalendarTabCell.super).Ctor)(self, ...)
  self._bm = (NekoData.BehaviorManager).BM_Welfare
  self._cellData = {}
end

WitchCalendarTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, GridFrame
  self._titleImg = self:GetChild("BackImage/Title")
  self._live2D = self:GetChild("BackImage/Role/Live2D")
  self._photo = self:GetChild("BackImage/Role/Photo")
  self._clickPanel = self:GetChild("BackImage/Role/Live2D/Live2dClick")
  self._dialogPanel = self:GetChild("BackImage/Role/Dialog")
  self._dialogPanel_Text = self:GetChild("BackImage/Role/Dialog/Text")
  ;
  (self._dialogPanel):SetActive(false)
  self._tipBtn = self:GetChild("BackImage/DetailBtn")
  self._tipBtn_Txt = self:GetChild("BackImage/DetailBtn/Txt")
  ;
  (self._tipBtn_Txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1967))
  self._cellPanel = self:GetChild("BackImage/Frame")
  self._cellFrame = (GridFrame.Create)(self._cellPanel, self, true, 7, false)
  ;
  (self._tipBtn):Subscribe_PointerClickEvent(self.OnTipBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTabCell, Common.n_RefreshWitchCalendar, nil)
  self:Init()
end

WitchCalendarTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
end

WitchCalendarTabCell.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CSkin
  self._roleId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundRole
  self._skinId = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).backgroundSkin
  if self._roleId == 0 then
    self:SetAiLinNa()
  else
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(self._roleId)
    local fashionData = nil
    if self._skinId > 0 then
      fashionData = CSkin:GetRecorder(self._skinId)
    end
    self:SetLive2D(self._role, fashionData)
  end
end

WitchCalendarTabCell.RefreshTabCell = function(self, refresh)
  -- function num : 0_4 , upvalues : _ENV, CMonthloginMonth, CImagePathTable
  local data = ((NekoData.BehaviorManager).BM_Welfare):GetWitchCalendarInfo()
  if data and (not self._init or refresh) then
    self._data = data
    local month = data.month
    local record = CMonthloginMonth:GetRecorder(month)
    if not CImagePathTable:GetRecorder(record.monthPicID) then
      local image = DataCommon.DefaultImageAsset
    end
    ;
    (self._titleImg):SetSprite(image.assetBundle, image.assetName)
    if refresh and (self._delegate)._selectedTab == ((self._delegate).WelfareType).witchCalendar then
      (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
      if self._timer then
        (GameTimer.RemoveTask)(self._timer)
        self._timer = nil
      end
      self._timer = (GameTimer.AddTask)(0.5, -1, function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cmonthlysign")
    protocol.dayId = (self._data).today
    protocol:Send()
    ;
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  end
, nil)
    end
    while (self._cellData)[#self._cellData] do
      (table.remove)(self._cellData, #self._cellData)
    end
    local haveLock = nil
    for id,record in pairs((self._data).cfgs) do
      if ((self._data).receivedIds)[id] then
        (table.insert)(self._cellData, {id = id, record = record, tag = "received"})
      else
        if id < (self._data).today then
          (table.insert)(self._cellData, {id = id, record = record, tag = "pending"})
        else
          if id == (self._data).today then
            (table.insert)(self._cellData, {id = id, record = record, tag = "today"})
          else
            ;
            (table.insert)(self._cellData, {id = id, record = record, tag = "lock"})
          end
        end
      end
    end
    ;
    (table.sort)(self._cellData, function(a, b)
    -- function num : 0_4_1
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._cellFrame):ReloadAllCell()
  end
end

WitchCalendarTabCell.OnTipBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):OpenInstructionsTipDialog(5)
end

WitchCalendarTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._cellData
end

WitchCalendarTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  return "welfare.witchcalendar.witchcalendarsigncell"
end

WitchCalendarTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return (self._cellData)[index]
end

WitchCalendarTabCell.SetAiLinNa = function(self)
  -- function num : 0_9 , upvalues : CPosterGirlNpc, CNpcShapeTable, _ENV, CImagePathTable
  local aiLinNaRecorder = CPosterGirlNpc:GetRecorder(0)
  local record = CNpcShapeTable:GetRecorder(aiLinNaRecorder.shapeId)
  if self._handler then
    (self._live2D):Release(self._handler)
    self._handler = nil
  end
  if (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    ;
    (self._photo):SetActive(true)
    if not CImagePathTable:GetRecorder(record.lihuiID) then
      local recorder = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(recorder.assetBundle, recorder.assetName)
    local scale = record.photoScale
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    ;
    (self._photo):SetAnchoredPosition((record.photoLocation)[1], (record.photoLocation)[2])
  end
  do
    ;
    (self._clickPanel):SetActive(true)
  end
end

WitchCalendarTabCell.SetLive2D = function(self, data, fashionData)
  -- function num : 0_10 , upvalues : CNpcShapeTable, _ENV, CImagePathTable
  if not data and not fashionData then
    return 
  end
  local theRoleID = data:GetId()
  local theFashionID = data:GetDefaultFashion()
  local record = data:GetShapeLive2DRecord()
  do
    if fashionData then
      local shapeId = fashionData.shapeID
      do
        record = CNpcShapeTable:GetRecorder(shapeId)
        theRoleID = fashionData.roleid
        theFashionID = fashionData.id
      end
    end
    self._picTouchData = {((NekoData.BehaviorManager).BM_RoleTouch):GetPicTouchInfo(theRoleID, theFashionID)}
    if self._handler then
      (self._live2D):Release(self._handler)
      self._handler = nil
    end
    if fashionData.shapeType == 2 and (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
      (self._photo):SetActive(false)
      self._handler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
      ;
      (self._live2D):SetLive2DAnimatorInteger(self._handler, "isLoop", 1)
      if not (self._live2D):OnlyFor0916Func() then
        (self._clickPanel):SetActive(true)
      else
        local touchRecordList = ((NekoData.BehaviorManager).BM_RoleTouch):GetLive2DTouchInfo(theRoleID, theFashionID)
        if #touchRecordList > 0 then
          (self._live2D):AddPointerDownListener(self._handler, function(_, posName)
    -- function num : 0_10_0 , upvalues : self, theRoleID, theFashionID, touchRecordList
    self:OnLive2DPointerDown(posName, theRoleID, theFashionID, touchRecordList)
  end
, self)
          ;
          (self._clickPanel):SetActive(false)
        else
          ;
          (self._clickPanel):SetActive(true)
        end
      end
    else
      do
        ;
        (self._clickPanel):SetActive(true)
        ;
        (self._photo):SetActive(true)
        if fashionData then
          local recorder = CImagePathTable:GetRecorder(record.lihuiID)
          ;
          (self._photo):SetSprite(recorder.assetBundle, recorder.assetName)
          local scale = record.photoScale
          ;
          (self._photo):SetLocalScale(scale, scale, scale)
          ;
          (self._photo):SetAnchoredPosition((record.photoLocation)[1], (record.photoLocation)[2])
        else
          do
            local recorder = data:GetShapeLiHuiImageRecord()
            ;
            (self._photo):SetSprite(recorder.assetBundle, recorder.assetName)
            local scale = data:GetPhotoScale()
            ;
            (self._photo):SetLocalScale(scale, scale, scale)
            local photoPos = data:GetPhotoPosition()
            ;
            (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
          end
        end
      end
    end
  end
end

return WitchCalendarTabCell


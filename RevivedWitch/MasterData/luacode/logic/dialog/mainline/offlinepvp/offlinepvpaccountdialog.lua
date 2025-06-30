-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local TableFrame = require("framework.ui.frame.table.tableframe")
local OfflinePvpAccountDialog = class("OfflinePvpAccountDialog", Dialog)
OfflinePvpAccountDialog.AssetBundleName = "ui/layouts.offlinepvp"
OfflinePvpAccountDialog.AssetName = "OffLinePVPAccount"
local CellCount = 3
OfflinePvpAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OfflinePvpAccountDialog
  ((OfflinePvpAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

OfflinePvpAccountDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._rolePanel = self:GetChild("Panel/Role")
  self._live2D = self:GetChild("Panel/Role/Live2D")
  self._photo = self:GetChild("Panel/Role/Photo")
  self._title = self:GetChild("Panel/Frame/Title")
  self._titleBack = self:GetChild("Panel/Frame/TitleBack/ImageFazhen")
  self._titleBack1 = self:GetChild("Panel/Frame/TitleBack/Text/Image")
  self._titleBack2 = self:GetChild("Panel/Frame/TitleBack/Text (2)")
  self._camp1Name = self:GetChild("Panel/Frame/Txt1/Txt")
  self._camp1Num = self:GetChild("Panel/Frame/Txt1/Num")
  self._camp2Name = self:GetChild("Panel/Frame/Txt2/Txt")
  self._camp2Num = self:GetChild("Panel/Frame/Txt2/Num")
  self._battleTimes = self:GetChild("Panel/Frame/Txt3/Num")
  self._winTimes = self:GetChild("Panel/Frame/Txt4/Num")
  self._getNum = self:GetChild("Panel/Frame/Txt5/Num")
  self._totleGetNum = self:GetChild("Panel/Frame/Txt6/Num")
  self._goOnBtn = self:GetChild("Panel/Frame/GoOnBtn")
  self._itemPanel = self:GetChild("Panel/Frame/ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._goOnBtn):Subscribe_PointerClickEvent(self.OnGoOnBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

OfflinePvpAccountDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

OfflinePvpAccountDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CArenaSeasonConfig, CImagePathTable, CNpcShapeTable
  self._data = {}
  for k,v in pairs(data.reward) do
    local temp = {}
    if v.gain == 1 then
      temp.itemId = ((NekoData.BehaviorManager).BM_BagInfo):GetItemID(v.id)
    else
      temp.itemId = v.id
    end
    temp.count = v.number
    ;
    (table.insert)(self._data, temp)
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._camp1Num):SetText((data.campsResult)[1])
  ;
  (self._camp2Num):SetText((data.campsResult)[2])
  ;
  (self._battleTimes):SetText(data.totalNum)
  ;
  (self._winTimes):SetText(data.victoryNum)
  ;
  (self._getNum):SetText(data.pithy)
  ;
  (self._totleGetNum):SetText(data.totalPithy)
  local recorder = CArenaSeasonConfig:GetRecorder(data.arenaId)
  ;
  (self._camp1Name):SetText((TextManager.GetText)(recorder.factionName1))
  ;
  (self._camp2Name):SetText((TextManager.GetText)(recorder.factionName2))
  local dialogId, shapeid = nil, nil
  if data.camp == 1 then
    shapeid = recorder.factionShape1
    if data.victory == 1 then
      dialogId = recorder.victoryDialog1
    else
      dialogId = recorder.defeatDialog1
    end
  else
    if data.camp == 2 then
      shapeid = recorder.factionShape2
      if data.victory == 1 then
        dialogId = recorder.victoryDialog2
      else
        dialogId = recorder.defeatDialog2
      end
    end
  end
  local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
  if dialog then
    dialog:SetDialogLibraryId(dialogId, true, (dialog.DialogType).Arena)
  end
  local name = ((TextManager.GetText)(recorder.seasonName))
  local titleStr, imgRecord, imgRecord1, imgRecord2 = nil, nil, nil, nil
  if data.victory == 1 then
    titleStr = (TextManager.GetText)(700795)
    imgRecord = CImagePathTable:GetRecorder(13056)
    imgRecord1 = CImagePathTable:GetRecorder(13054)
    imgRecord2 = CImagePathTable:GetRecorder(13055)
  else
    titleStr = (TextManager.GetText)(700796)
    imgRecord = CImagePathTable:GetRecorder(13053)
    imgRecord1 = CImagePathTable:GetRecorder(13051)
    imgRecord2 = CImagePathTable:GetRecorder(13052)
  end
  titleStr = (string.gsub)(titleStr, "%$parameter1%$", name)
  ;
  (self._titleBack):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._titleBack1):SetSprite(imgRecord1.assetBundle, imgRecord1.assetName)
  ;
  (self._titleBack2):SetSprite(imgRecord2.assetBundle, imgRecord2.assetName)
  ;
  (self._title):SetText(titleStr)
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  ;
  (self._rolePanel):SetAnimatorTrigger("loadReady")
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    if self._handler then
      (self._live2D):Release(self._handler)
      self._live2D = nil
      self._handler = nil
    end
    ;
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
      local lihuiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetActive(true)
    ;
    (self._photo):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    ;
    (self._photo):SetLocalScale(scale, scale, scale)
    ;
    (self._photo):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
  end
  do
    ;
    (self._goOnBtn):SetActive(data.open == 1)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

OfflinePvpAccountDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

OfflinePvpAccountDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.offlinepvp.offlinepvpaccountcell"
end

OfflinePvpAccountDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

OfflinePvpAccountDialog.OnGoOnBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.copenarenapanel")
  if protocol then
    protocol:Send()
  end
  self:Destroy()
end

OfflinePvpAccountDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

OfflinePvpAccountDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return OfflinePvpAccountDialog


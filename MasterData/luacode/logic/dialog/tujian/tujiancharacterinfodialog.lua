local TabFrame = require("framework.ui.frame.tab.tabframe")
local CRoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local Status = LuaNetManager.GetBeanDef("protocol.login.favorawardinfo")
local TuJianCharacterInfoDialog = class("TuJianCharacterInfoDialog", Dialog)
TuJianCharacterInfoDialog.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoDialog.AssetName = "TuJianCharInfo"

function TuJianCharacterInfoDialog:Ctor(...)
  TuJianCharacterInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = nil
  self._buttonList = {}
  self._selectList = {}
  self._noSelectList = {}
end

function TuJianCharacterInfoDialog:OnCreate()
  self._photo = self:GetChild("Photo")
  self._live2D = self:GetChild("Live2D")
  self._chatBtn = self:GetChild("CharName/ChatBtn")
  self._name = self:GetChild("CharName/Back/Name")
  self._rank = self:GetChild("CharName/Rank")
  self._jobImg = self:GetChild("CharName/JobImg")
  self._cvName = self:GetChild("CharName/CVName")
  self._rightPanelFrame = self:GetChild("BackGround/RightPanel")
  self._groupButton1 = self:GetChild("BackGround/RightPanel/GroupButton1")
  self._groupButton2 = self:GetChild("BackGround/RightPanel/GroupButton2")
  self._select1 = self:GetChild("BackGround/RightPanel/Select1")
  self._select2 = self:GetChild("BackGround/RightPanel/Select3")
  self._noSelect1 = self:GetChild("BackGround/RightPanel/GroupButton1/NoSelected")
  self._noSelect2 = self:GetChild("BackGround/RightPanel/GroupButton2/NoSelected")
  self._leftArrow = self:GetChild("BackGround/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/RightArrow")
  self._hint = self:GetChild("BackGround/RightPanel/GroupButton2/Hint")
  table.insert(self._buttonList, self._groupButton1)
  table.insert(self._buttonList, self._groupButton2)
  table.insert(self._selectList, self._select1)
  table.insert(self._selectList, self._select2)
  table.insert(self._noSelectList, self._noSelect1)
  table.insert(self._noSelectList, self._noSelect2)
  self._frame = TabFrame.Create(self._rightPanelFrame, self)
  self._groupButton1:Subscribe_PointerClickEvent(self.OnGroupButton1PointerClick, self)
  self._groupButton2:Subscribe_PointerClickEvent(self.OnGroupButton2PointerClick, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  UIBackManager.SwitchToNext()
end

function TuJianCharacterInfoDialog:OnDestroy()
  self._frame:Destroy()
end

function TuJianCharacterInfoDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

function TuJianCharacterInfoDialog:Refresh(data, tag)
  self._data = data
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  local shapeRecord = CNpcShapeTable:GetRecorder(roleConfig.shapeID)
  if self._handler then
    self._live2D:Release(self._handler)
  end
  if Live2DManager.CanUse() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    self._photo:SetActive(true)
    self._photo:SetSprite((CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DataCommon.DefaultImageAsset).assetBundle, (CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset).assetName)
    local scale = shapeRecord.photoScale
    self._photo:SetLocalScale(scale, scale, scale)
    self._photo:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
  local name = TextManager.GetText(roleConfig.nameTextID)
  self._name:SetText(tostring(string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)))
  local record
  if roleConfig.rarity == 1 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 2 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgSR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 3 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgSSR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 4 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgUR) or DataCommon.DefaultImageAsset
  elseif roleConfig.rarity == 5 then
    record = CImagePathTable:GetRecorder(CVocationCfgTable:GetRecorder(roleConfig.vocation).imgEX) or DataCommon.DefaultImageAsset
  end
  self._jobImg:SetSprite(record.assetBundle, record.assetName)
  self._cvName:SetText(roleConfig.cv)
  if data.id ~= 1 then
    self._rank:SetActive(true)
    record = CImagePathTable:GetRecorder(CRoleRarityCfgTable:GetRecorder(roleConfig.rarity).imgid) or DataCommon.DefaultImageAsset
    self._rank:SetSprite(record.assetBundle, record.assetName)
  else
    self._rank:SetActive(false)
  end
  self._hint:SetActive(false)
  local relation = NekoData.BehaviorManager.BM_HandBook:GetRelationById(data.id)
  if relation then
    for _, v in pairs(relation.favorAward) do
      if v.status == Status.STATUS_ABLE then
        self._hint:SetActive(true)
        break
      end
    end
  end
  if self._panel and tag then
    self._frame:ToPage(self._panel)
    local cell = self._frame:GetCellAtIndex(self._panel)
    cell:RefreshCell(self._data)
  else
    self._panel = "Button1"
    self._frame:ToPage(self._panel)
    if not self._initCell1 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell1 = true
    end
  end
end

function TuJianCharacterInfoDialog:DidToPage(window, orderIndex)
  if orderIndex == "Button1" then
    for i, v in ipairs(self._buttonList) do
      if v ~= self._groupButton1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _, v in pairs(self._selectList) do
      if v ~= self._select1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._noSelectList) do
      if v ~= self._noSelect1 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  elseif orderIndex == "Button2" then
    for i, v in ipairs(self._buttonList) do
      if v ~= self._groupButton2 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _, v in pairs(self._selectList) do
      if v ~= self._select2 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._noSelectList) do
      if v ~= self._noSelect2 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  end
end

function TuJianCharacterInfoDialog:ReturnFrame()
  return self._frame
end

function TuJianCharacterInfoDialog:OnGroupButton1PointerClick()
  if self._panel ~= "Button1" then
    self._panel = "Button1"
    UIBackManager.SwitchToNext()
    self._frame:ToPage(self._panel)
    if not self._initCell1 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell1 = true
    end
  end
end

function TuJianCharacterInfoDialog:OnGroupButton2PointerClick()
  if self._panel ~= "Button2" then
    self._panel = "Button2"
    UIBackManager.SwitchToNext()
    self._frame:ToPage(self._panel)
    if not self._initCell2 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell2 = true
    end
  end
end

function TuJianCharacterInfoDialog:OnLeftArrowClick()
  local dialog = DialogManager.GetDialog("tujian.tujianpagedialog")
  if dialog then
    local data = dialog:ReturnData()
    if 1 < #data then
      local pos
      for i, v in pairs(data) do
        if v.id == self._data.id then
          pos = i - 1
          break
        end
      end
      if pos then
        if pos <= 0 then
          pos = pos + #data
        end
        self:Refresh(data[pos], true)
      end
    end
  end
end

function TuJianCharacterInfoDialog:OnRightArrowClick()
  local dialog = DialogManager.GetDialog("tujian.tujianpagedialog")
  if dialog then
    local data = dialog:ReturnData()
    if 1 < #data then
      local pos
      for i, v in pairs(data) do
        if v.id == self._data.id then
          pos = i + 1
          break
        end
      end
      if pos then
        if pos > #data then
          pos = pos - #data
        end
        self:Refresh(data[pos], true)
      end
    end
  end
end

function TuJianCharacterInfoDialog:CellAtIndex(frame, index)
  if index == "Button1" then
    return "tujian.tujiancharacterinfopagecell"
  elseif index == "Button2" then
  end
end

function TuJianCharacterInfoDialog:DataAtIndex(frame, index)
  return self._data
end

return TuJianCharacterInfoDialog

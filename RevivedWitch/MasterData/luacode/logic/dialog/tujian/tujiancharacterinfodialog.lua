-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local Status = (LuaNetManager.GetBeanDef)("protocol.login.favorawardinfo")
local TuJianCharacterInfoDialog = class("TuJianCharacterInfoDialog", Dialog)
TuJianCharacterInfoDialog.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoDialog.AssetName = "TuJianCharInfo"
TuJianCharacterInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterInfoDialog
  ((TuJianCharacterInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = nil
  self._buttonList = {}
  self._selectList = {}
  self._noSelectList = {}
end

TuJianCharacterInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
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
  ;
  (table.insert)(self._buttonList, self._groupButton1)
  ;
  (table.insert)(self._buttonList, self._groupButton2)
  ;
  (table.insert)(self._selectList, self._select1)
  ;
  (table.insert)(self._selectList, self._select2)
  ;
  (table.insert)(self._noSelectList, self._noSelect1)
  ;
  (table.insert)(self._noSelectList, self._noSelect2)
  self._frame = (TabFrame.Create)(self._rightPanelFrame, self)
  ;
  (self._groupButton1):Subscribe_PointerClickEvent(self.OnGroupButton1PointerClick, self)
  ;
  (self._groupButton2):Subscribe_PointerClickEvent(self.OnGroupButton2PointerClick, self)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  ;
  (UIBackManager.SwitchToNext)()
end

TuJianCharacterInfoDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TuJianCharacterInfoDialog.OnBackPressed = function(self)
  -- function num : 0_3
  self:Destroy()
  return true, true
end

TuJianCharacterInfoDialog.Refresh = function(self, data, tag)
  -- function num : 0_4 , upvalues : CRoleConfigTable, CNpcShapeTable, _ENV, CImagePathTable, CVocationCfgTable, CRoleRarityCfgTable, Status
  self._data = data
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  local shapeRecord = CNpcShapeTable:GetRecorder(roleConfig.shapeID)
  if self._handler then
    (self._live2D):Release(self._handler)
  end
  if (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    (self._photo):SetActive(false)
    self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  else
    ;
    (self._photo):SetActive(true)
    if CImagePathTable:GetRecorder(shapeRecord.lihuiID) or not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
      (self._photo):SetSprite(((DataCommon.DataCommon).DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
      do
        local scale = shapeRecord.photoScale
        ;
        (self._photo):SetLocalScale(scale, scale, scale)
        ;
        (self._photo):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
        local name = (TextManager.GetText)(roleConfig.nameTextID)
        ;
        (self._name):SetText(tostring((string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)))
        local record = nil
        if roleConfig.rarity == 1 then
          if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgR) then
            record = DataCommon.DefaultImageAsset
            if roleConfig.rarity == 2 then
              if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgSR) then
                record = DataCommon.DefaultImageAsset
                if roleConfig.rarity == 3 then
                  if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgSSR) then
                    record = DataCommon.DefaultImageAsset
                    if roleConfig.rarity == 4 then
                      if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgUR) then
                        record = DataCommon.DefaultImageAsset
                        if roleConfig.rarity == 5 and not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgEX) then
                          record = DataCommon.DefaultImageAsset
                        end
                        ;
                        (self._jobImg):SetSprite(record.assetBundle, record.assetName)
                        ;
                        (self._cvName):SetText(roleConfig.cv)
                        if data.id ~= 1 then
                          (self._rank):SetActive(true)
                          if not CImagePathTable:GetRecorder((CRoleRarityCfgTable:GetRecorder(roleConfig.rarity)).imgid) then
                            record = DataCommon.DefaultImageAsset
                          end
                          ;
                          (self._rank):SetSprite(record.assetBundle, record.assetName)
                        else
                          ;
                          (self._rank):SetActive(false)
                        end
                        ;
                        (self._hint):SetActive(false)
                        local relation = ((NekoData.BehaviorManager).BM_HandBook):GetRelationById(data.id)
                        if relation then
                          for _,v in pairs(relation.favorAward) do
                            if v.status == Status.STATUS_ABLE then
                              (self._hint):SetActive(true)
                              break
                            end
                          end
                        end
                        do
                          if self._panel and tag then
                            (self._frame):ToPage(self._panel)
                            local cell = (self._frame):GetCellAtIndex(self._panel)
                            cell:RefreshCell(self._data)
                          else
                            do
                              self._panel = "Button1"
                              ;
                              (self._frame):ToPage(self._panel)
                              if not self._initCell1 then
                                local cell = (self._frame):GetCellAtIndex(self._panel)
                                cell:RefreshCell(self._data)
                                self._initCell1 = true
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

TuJianCharacterInfoDialog.DidToPage = function(self, window, orderIndex)
  -- function num : 0_5 , upvalues : _ENV
  if orderIndex == "Button1" then
    for i,v in ipairs(self._buttonList) do
      if v ~= self._groupButton1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _,v in pairs(self._selectList) do
      if v ~= self._select1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _,v in pairs(self._noSelectList) do
      if v ~= self._noSelect1 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  else
    do
      if orderIndex == "Button2" then
        for i,v in ipairs(self._buttonList) do
          if v ~= self._groupButton2 then
            v:SetSelected(false)
          else
            v:SetSelected(true)
          end
        end
        for _,v in pairs(self._selectList) do
          if v ~= self._select2 then
            v:SetActive(false)
          else
            v:SetActive(true)
          end
        end
        for _,v in pairs(self._noSelectList) do
          if v ~= self._noSelect2 then
            v:SetActive(true)
          else
            v:SetActive(false)
          end
        end
      end
    end
  end
end

TuJianCharacterInfoDialog.ReturnFrame = function(self)
  -- function num : 0_6
  return self._frame
end

TuJianCharacterInfoDialog.OnGroupButton1PointerClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._panel ~= "Button1" then
    self._panel = "Button1"
    ;
    (UIBackManager.SwitchToNext)()
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell1 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell1 = true
    end
  end
end

TuJianCharacterInfoDialog.OnGroupButton2PointerClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._panel ~= "Button2" then
    self._panel = "Button2"
    ;
    (UIBackManager.SwitchToNext)()
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell2 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell2 = true
    end
  end
end

TuJianCharacterInfoDialog.OnLeftArrowClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("tujian.tujianpagedialog")
  if dialog then
    local data = dialog:ReturnData()
    if #data > 1 then
      local pos = nil
      for i,v in pairs(data) do
        if v.id == (self._data).id then
          pos = i - 1
          break
        end
      end
      do
        if pos then
          if pos <= 0 then
            pos = pos + #data
          end
          self:Refresh(data[pos], true)
        end
      end
    end
  end
end

TuJianCharacterInfoDialog.OnRightArrowClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("tujian.tujianpagedialog")
  if dialog then
    local data = dialog:ReturnData()
    if #data > 1 then
      local pos = nil
      for i,v in pairs(data) do
        if v.id == (self._data).id then
          pos = i + 1
          break
        end
      end
      do
        if pos then
          if #data < pos then
            pos = pos - #data
          end
          self:Refresh(data[pos], true)
        end
      end
    end
  end
end

TuJianCharacterInfoDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  if index == "Button1" then
    return "tujian.tujiancharacterinfopagecell"
  else
  end
  if index == "Button2" then
  end
end

TuJianCharacterInfoDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return self._data
end

return TuJianCharacterInfoDialog


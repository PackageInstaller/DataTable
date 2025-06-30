-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/resonance/resonancedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRuneResults = (BeanManager.GetTableByName)("welfare.cruneresults")
local UIManager = ((CS.PixelNeko).UI).UIManager
local NPC_ShapeID = 11
local ResonanceDialog = class("ResonanceDialog", Dialog)
ResonanceDialog.AssetBundleName = "ui/layouts.welfare"
ResonanceDialog.AssetName = "GongMing"
ResonanceDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResonanceDialog
  ((ResonanceDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._itemList = {}
end

ResonanceDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._role = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._photo = self:GetChild("Role/Photo")
  self._resonancePanel = self:GetChild("Back")
  self._clickPanel = self:GetChild("Click")
  self._resultPanel = self:GetChild("GongMingResult")
  self._symbol = self:GetChild("GongMingResult/Symbol")
  self._title = self:GetChild("GongMingResult/Text")
  self._dialogTxt = self:GetChild("GongMingResult/Dialog/Text")
  self._itemPanel = self:GetChild("GongMingResult/ItemFrame")
  self._backBtn = self:GetChild("GongMingResult/BackBtn")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false)
  self:Init()
  self._local_posX = (self._clickPanel):GetLocalPosition()
  self._width = (self._clickPanel):GetRectSize()
  self._range_x_min = self._local_posX - self._width / 2
  self._range_x_max = self._local_posX + self._width / 2
  self._range_y_min = self._local_posY - self._height / 2
  self._range_y_max = self._local_posY + self._height / 2
  ;
  (self._clickPanel):Subscribe_PointerUpEvent(self.OnPointerUp, self)
  ;
  (self._clickPanel):Subscribe_BeginLongPressEvent(self.OnClickPanelBeginLongPress, self)
  ;
  (self._clickPanel):Subscribe_LongPressEvent(self.OnClickPanelLongPress, self)
  ;
  (self._clickPanel):Subscribe_EndLongPressEvent(self.OnClickPanelEndLongPress, self)
  ;
  (self._clickPanel):Subscribe_CancelLongPressEvent(self.OnClickPanelCancelLongPress, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnShowResult, Common.n_ReceiveResonanceResult, nil)
end

ResonanceDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
end

ResonanceDialog.OnShowResult = function(self, notification)
  -- function num : 0_3 , upvalues : CRuneResults, CImagePathTable, _ENV, ItemTypeEnum, Item, Equip, Skill
  (self._resonancePanel):SetActive(false)
  ;
  (self._clickPanel):SetActive(false)
  ;
  (self._resultPanel):SetActive(true)
  if self._live2DHandler then
    (self._live2D):DisableLookAtMouse(self._live2DHandler)
  end
  local runeResultRecord = CRuneResults:GetRecorder((notification.userInfo).runeId)
  local imageRecord = CImagePathTable:GetRecorder(runeResultRecord.imgId)
  ;
  (self._symbol):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local txtTitle = (TextManager.GetText)(runeResultRecord.txtTitleTextID)
  ;
  (self._title):SetText(txtTitle)
  local txtContent = (TextManager.GetText)(runeResultRecord.txtContentTextID)
  ;
  (self._dialogTxt):SetText(txtContent)
  local itemList = (notification.userInfo).itemList
  for i,v in ipairs(itemList) do
    local itemInfo = {}
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          itemInfo.item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
        end
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = (Item.Create)(v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          itemInfo.item = (Equip.Create)(v.id)
        else
          if v.itemtype == ItemTypeEnum.SKILL then
            itemInfo.item = (Skill.Create)(v.id)
          end
        end
      end
      ;
      (itemInfo.item):InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    ;
    (table.insert)(self._itemList, itemInfo)
  end
  ;
  (self._itemFrame):ReloadAllCell()
end

ResonanceDialog.Init = function(self)
  -- function num : 0_4 , upvalues : CNPCShape, NPC_ShapeID, _ENV, CImagePathTable
  (self._resonancePanel):SetActive(true)
  ;
  (self._clickPanel):SetActive(true)
  ;
  (self._resultPanel):SetActive(false)
  local shape = CNPCShape:GetRecorder(NPC_ShapeID)
  if (Live2DManager.CanUse)() and shape.live2DPrefabName ~= "" and shape.live2DPrefabName ~= "" then
    self._live2DHandler = (self._live2D):AddLive2D(shape.live2DAssetBundleName, shape.live2DPrefabName, shape.live2DScale)
    ;
    (self._live2D):EnableLookAtMouse(self._live2DHandler)
  else
    local imageRecord = CImagePathTable:GetRecorder(shape.lihuiID)
    if imageRecord then
      (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local scale = shape.photoScale
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      ;
      (self._photo):SetAnchoredPosition((shape.photoLocation)[1], (shape.photoLocation)[2])
    end
  end
end

ResonanceDialog.OnPointerUp = function(self)
  -- function num : 0_5
end

ResonanceDialog.OnClickPanelBeginLongPress = function(self)
  -- function num : 0_6
  (self:GetRootWindow()):SetAnimatorInteger("isTouching", 1)
  if self._live2DHandler then
    (self._live2D):SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 1)
  end
end

ResonanceDialog.OnClickPanelLongPress = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, (args.position).x, (args.position).y)
  if x < self._range_x_min or self._range_x_max < x or y < self._range_y_min or self._range_y_max < y then
    (self:GetRootWindow()):SetAnimatorInteger("isTouching", 0)
    if self._live2DHandler then
      (self._live2D):SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
    end
  end
end

ResonanceDialog.OnClickPanelEndLongPress = function(self)
  -- function num : 0_8
  (self:GetRootWindow()):SetAnimatorInteger("isTouching", 0)
  if self._live2DHandler then
    (self._live2D):SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
  end
end

ResonanceDialog.OnClickPanelCancelLongPress = function(self)
  -- function num : 0_9
  (self:GetRootWindow()):SetAnimatorInteger("isTouching", 0)
  if self._live2DHandler then
    (self._live2D):SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
  end
end

ResonanceDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

ResonanceDialog.OnAnimationEnter = function(self, handle, statename, normalizedTime)
  -- function num : 0_11 , upvalues : _ENV
  if statename == "Over" then
    local crune = (LuaNetManager.CreateProtocol)("protocol.rune.crune")
    crune:Send()
  end
end

ResonanceDialog.NumberOfCell = function(self, frame)
  -- function num : 0_12
  return #self._itemList
end

ResonanceDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_13
  return "resonance.resultitemcell"
end

ResonanceDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_14
  return (self._itemList)[index]
end

return ResonanceDialog


local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRuneResults = BeanManager.GetTableByName("welfare.cruneresults")
local UIManager = CS.PixelNeko.UI.UIManager
local NPC_ShapeID = 11
local ResonanceDialog = class("ResonanceDialog", Dialog)
ResonanceDialog.AssetBundleName = "ui/layouts.welfare"
ResonanceDialog.AssetName = "GongMing"

function ResonanceDialog:Ctor(...)
  ResonanceDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._itemList = {}
end

function ResonanceDialog:OnCreate()
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
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, false)
  self:Init()
  self._local_posX, self._local_posY = self._clickPanel:GetLocalPosition()
  self._width, self._height = self._clickPanel:GetRectSize()
  self._range_x_min = self._local_posX - self._width / 2
  self._range_x_max = self._local_posX + self._width / 2
  self._range_y_min = self._local_posY - self._height / 2
  self._range_y_max = self._local_posY + self._height / 2
  self._clickPanel:Subscribe_PointerUpEvent(self.OnPointerUp, self)
  self._clickPanel:Subscribe_BeginLongPressEvent(self.OnClickPanelBeginLongPress, self)
  self._clickPanel:Subscribe_LongPressEvent(self.OnClickPanelLongPress, self)
  self._clickPanel:Subscribe_EndLongPressEvent(self.OnClickPanelEndLongPress, self)
  self._clickPanel:Subscribe_CancelLongPressEvent(self.OnClickPanelCancelLongPress, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  LuaNotificationCenter.AddObserver(self, self.OnShowResult, Common.n_ReceiveResonanceResult, nil)
end

function ResonanceDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
end

function ResonanceDialog:OnShowResult(notification)
  self._resonancePanel:SetActive(false)
  self._clickPanel:SetActive(false)
  self._resultPanel:SetActive(true)
  if self._live2DHandler then
    self._live2D:DisableLookAtMouse(self._live2DHandler)
  end
  local runeResultRecord = CRuneResults:GetRecorder(notification.userInfo.runeId)
  local imageRecord = CImagePathTable:GetRecorder(runeResultRecord.imgId)
  self._symbol:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local txtTitle = TextManager.GetText(runeResultRecord.txtTitleTextID)
  self._title:SetText(txtTitle)
  local txtContent = TextManager.GetText(runeResultRecord.txtContentTextID)
  self._dialogTxt:SetText(txtContent)
  local itemList = notification.userInfo.itemList
  for i, v in ipairs(itemList) do
    local itemInfo = {}
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(v.bagtype, v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v.id)
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        itemInfo.item = Item.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.EQUIP then
        itemInfo.item = Equip.Create(v.id)
      elseif v.itemtype == ItemTypeEnum.SKILL then
        itemInfo.item = Skill.Create(v.id)
      end
      itemInfo.item:InitWithItemInfo(v)
    end
    itemInfo.num = v.number
    table.insert(self._itemList, itemInfo)
  end
  self._itemFrame:ReloadAllCell()
end

function ResonanceDialog:Init()
  self._resonancePanel:SetActive(true)
  self._clickPanel:SetActive(true)
  self._resultPanel:SetActive(false)
  local shape = CNPCShape:GetRecorder(NPC_ShapeID)
  if Live2DManager.CanUse() and shape.live2DPrefabName ~= "" and shape.live2DPrefabName ~= "" then
    self._live2DHandler = self._live2D:AddLive2D(shape.live2DAssetBundleName, shape.live2DPrefabName, shape.live2DScale)
    self._live2D:EnableLookAtMouse(self._live2DHandler)
  else
    local imageRecord = CImagePathTable:GetRecorder(shape.lihuiID)
    if imageRecord then
      self._photo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local scale = shape.photoScale
      self._photo:SetLocalScale(scale, scale, scale)
      self._photo:SetAnchoredPosition(shape.photoLocation[1], shape.photoLocation[2])
    end
  end
end

function ResonanceDialog:OnPointerUp()
end

function ResonanceDialog:OnClickPanelBeginLongPress()
  self:GetRootWindow():SetAnimatorInteger("isTouching", 1)
  if self._live2DHandler then
    self._live2D:SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 1)
  end
end

function ResonanceDialog:OnClickPanelLongPress(args)
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, args.position.x, args.position.y)
  if x < self._range_x_min or x > self._range_x_max or y < self._range_y_min or y > self._range_y_max then
    self:GetRootWindow():SetAnimatorInteger("isTouching", 0)
    if self._live2DHandler then
      self._live2D:SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
    end
  end
end

function ResonanceDialog:OnClickPanelEndLongPress()
  self:GetRootWindow():SetAnimatorInteger("isTouching", 0)
  if self._live2DHandler then
    self._live2D:SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
  end
end

function ResonanceDialog:OnClickPanelCancelLongPress()
  self:GetRootWindow():SetAnimatorInteger("isTouching", 0)
  if self._live2DHandler then
    self._live2D:SetLive2DAnimatorInteger(self._live2DHandler, "isTouching", 0)
  end
end

function ResonanceDialog:OnBackBtnClicked()
  self:Destroy()
end

function ResonanceDialog:OnAnimationEnter(handle, statename, normalizedTime)
  if statename == "Over" then
    local crune = LuaNetManager.CreateProtocol("protocol.rune.crune")
    crune:Send()
  end
end

function ResonanceDialog:NumberOfCell(frame)
  return #self._itemList
end

function ResonanceDialog:CellAtIndex(frame, index)
  return "resonance.resultitemcell"
end

function ResonanceDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

return ResonanceDialog

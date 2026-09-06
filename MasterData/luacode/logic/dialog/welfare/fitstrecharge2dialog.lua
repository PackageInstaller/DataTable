local Role = require("logic.manager.experimental.types.role")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CFirstRechargeReward = BeanManager.GetTableByName("welfare.cfirstrechargereward")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CFirstGift = BeanManager.GetTableByName("welfare.cfirstgift")
local CFirstGiftParamater = BeanManager.GetTableByName("welfare.cfirstgiftparamater")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local Num = 7
local StartIndex = 3
local ItemCellNum = 6
local FitstRecharge2Dialog = class("FitstRecharge2Dialog", Dialog)
FitstRecharge2Dialog.AssetBundleName = "ui/layouts.welfare"
FitstRecharge2Dialog.AssetName = "FirstRecharge2"
local ItemIdType = {Role = 27, Equip = 299}
local State = {
  NoRecharge = 1,
  RewardOneLock = 2,
  RewardOneUnlock = 3,
  RewardTwoLock = 4,
  RewardTwoUnLock = 5,
  Finishi = 6
}

function FitstRecharge2Dialog:Ctor(...)
  FitstRecharge2Dialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._state = -1
  self._which = 0
end

function FitstRecharge2Dialog:OnCreate()
  self._frame1FinishBtn = self:GetChild("BackImage/Frame1/FinishBtn")
  self._goBtn = self:GetChild("BackImage/Up/GoBtn")
  self._goBtnText = self:GetChild("BackImage/Up/GoBtn/Text")
  self._goBtnDone = self:GetChild("BackImage/Up/GoBtn/Done")
  self._tipsText = self:GetChild("BackImage/TipTxt")
  self._tipsText:SetText(TextManager.GetText(CStringRes:GetRecorder(2275).msgTextID))
  self._iBtn = self:GetChild("BackImage/Ibtn")
  self._iBtn:Subscribe_PointerClickEvent(self.IButtonClick, self)
  self._leftArrowBtn = self:GetChild("LeftArrow")
  self._leftArrowBtn:Subscribe_PointerClickEvent(self.OnLeftArrowBtnClicked, self)
  self._rightArrowBtn = self:GetChild("RightArrow")
  self._rightArrowBtn:Subscribe_PointerClickEvent(self.OnRightArrowBtnClicked, self)
  self._closeBtn = self:GetChild("CloseBtn")
  self._itemBack = self:GetChild("BackImage/Frame1/Back")
  self._itemBack:SetActive(false)
  self._itemBackFrames = {}
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, ItemCellNum do
    self._itemBackFrames[i] = self:GetChild("BackImage/Frame1/Item" .. i)
    self._itemBackFrames[i]:SetActive(false)
    self._itemCells[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround")
    if i == 1 then
      self._itemBacks[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/Frame")
    else
      self._itemBacks[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/Image")
    end
    self._itemIcons[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_BackGround/Icon")
    self._itemCounts[i] = self:GetChild("BackImage/Frame1/Item" .. i .. "/ItemCell/_Count")
    self._itemCells[i]:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end, self)
  end
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._groupBtn = {}
  for i = 1, Num do
    self._groupBtn[i] = self:GetChild("BackImage/GroupBtn" .. i)
    self._groupBtn[i]:Subscribe_PointerClickEvent(function()
      self:OnSelectWhich(i)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, self.SetButtonState, Common.n_FirstRechargeGiftState, nil)
end

function FitstRecharge2Dialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function FitstRecharge2Dialog:IButtonClick()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(19)
end

function FitstRecharge2Dialog:OnSelectWhich(index)
  if self._which == index then
    return
  end
  for i = 1, Num do
    self._groupBtn[i]:SetSelected(i == index)
  end
  self._which = index
  self:OnRefresh(self._which + 2)
end

function FitstRecharge2Dialog:Init()
  local roleIdData = Role.Create(30)
  local record = roleIdData:GetShapeLive2DRecord()
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DPrefabName then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
  else
    self._photo:SetActive(true)
    self._photo:SetSprite(roleIdData:GetShapeLiHuiImageRecord().assetBundle, roleIdData:GetShapeLiHuiImageRecord().assetName)
    local scale = roleIdData:GetPhotoScale()
    self._photo:SetLocalScale(scale, scale, scale)
    local photoPos = roleIdData:GetPhotoPosition()
    self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
  end
  self:SetButtonState()
end

function FitstRecharge2Dialog:OnRefreshItem(CurDayIndex)
  local FirstGifConfig = CFirstGift:GetRecorder(CurDayIndex)
  if not FirstGifConfig then
    return
  end
  self._items = {}
  local itemscount = {}
  for i, v in ipairs(FirstGifConfig.reward) do
    if v ~= "0" then
      local itemStr = string.split(v, "@")
      local itemTemp = Item.Create(tonumber(itemStr[1]))
      table.insert(self._items, itemTemp)
      table.insert(itemscount, tonumber(itemStr[2]))
    end
  end
  for i = 1, ItemCellNum do
    self._itemBackFrames[i]:SetActive(false)
  end
  for i, item in ipairs(self._items) do
    if i <= ItemCellNum then
      self._itemBackFrames[i]:SetActive(true)
      local imageRecord = item:GetPinJiImage()
      self._itemBacks[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = item:GetIcon()
      self._itemIcons[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._itemCounts[i]:SetText(NumberManager.GetShowNumber(itemscount[i]))
    end
  end
end

function FitstRecharge2Dialog:OnRefresh(CurDayIndex)
  self._goBtn:SetInteractable(true)
  self._frame1FinishBtn:SetActive(false)
  local AwardData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeAwardById(CurDayIndex)
  if not AwardData then
    str = CStringRes:GetRecorder(1429).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.NoRecharge
    return
  end
  local FirstChargeData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeData()
  if AwardData.statue == 0 then
    if not FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(5).param] then
      str = CStringRes:GetRecorder(1429).msgTextID
      str = TextManager.GetText(str)
      self._goBtnText:SetText(str)
      self._goBtnText:SetActive(true)
      self._goBtnDone:SetActive(false)
      self._state = State.NoRecharge
    else
      str = CStringRes:GetRecorder(2277).msgTextID
      str = TextManager.GetText(str)
      self._goBtnText:SetText(str)
      self._goBtnText:SetActive(true)
      self._goBtnDone:SetActive(false)
      self._state = State.RewardOneUnlock
      if self._which <= FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(5).param] then
        self._goBtn:SetInteractable(true)
      else
        self._goBtn:SetInteractable(false)
      end
    end
  elseif AwardData.statue == 1 then
    str = CStringRes:GetRecorder(2277).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.RewardOneUnlock
    if self._which <= FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(5).param] then
      self._goBtn:SetInteractable(true)
    else
      self._goBtn:SetInteractable(false)
    end
  elseif AwardData.statue == 2 then
    self._goBtnText:SetActive(false)
    self._goBtnDone:SetActive(true)
    self._goBtn:SetInteractable(false)
    self._state = State.Finishi
  end
  self._frame1FinishBtn:SetActive(AwardData.statue == 2)
  self:OnRefreshItem(CurDayIndex)
end

function FitstRecharge2Dialog:GetCurDayIndex()
  local FirstChargeData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeData()
  if not FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(5).param] then
    return StartIndex
  end
  for k, v in pairs(FirstChargeData.awards) do
    if v.id >= StartIndex and v.statue < 2 then
      return v.id
    end
  end
  return StartIndex
end

function FitstRecharge2Dialog:SetButtonState()
  local str
  self._frame1FinishBtn:SetActive(false)
  local FirstChargeData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeData()
  if not FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(5).param] then
    str = CStringRes:GetRecorder(1429).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.NoRecharge
    local CurDayIndex = self:GetCurDayIndex()
    self:OnSelectWhich(CurDayIndex - 2)
    return
  end
  local CurDayIndex = self:GetCurDayIndex()
  self:OnSelectWhich(CurDayIndex - 2)
end

function FitstRecharge2Dialog:OnGoBtnClick()
  if self._state == State.NoRecharge then
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
    self:Destroy()
  elseif self._state == State.RewardOneUnlock then
    self:GetFirstRechargeGift()
  end
end

function FitstRecharge2Dialog:GetFirstRechargeGift()
  if self._which > 0 then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cfirstchargegetreward")
    csend.id = self._which + 2
    csend:Send()
  end
end

function FitstRecharge2Dialog:OnCellClick(index)
  if not self._items then
    return
  end
  local item = self._items[index]
  if not item then
    return
  end
  local dialog
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = CRoleItem:GetRecorder(item:GetID()).roleid
    dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
        roleIdList = {roleID},
        cfgIdList = {4},
        index = 1
      }, dialog.ShowType.BaseLevelInfo)
    end
  elseif item:GetItemTypeId() == ItemIdType.Equip then
    dialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if dialog then
      dialog:Init(item:GetID())
      dialog:SetTipsParmFunc(function()
        local width, height = self._itemBacks[index]:GetRectSize()
        local pos = self._itemBacks[index]:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  else
    dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if dialog then
      dialog:Init({item = item})
    end
  end
end

function FitstRecharge2Dialog:OnBackBtnClicked()
  self:Destroy()
end

function FitstRecharge2Dialog:OnLeftArrowBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrechargedialog")
  if dialog then
    dialog:Init()
    self:Destroy()
  end
end

function FitstRecharge2Dialog:OnRightArrowBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrechargedialog")
  if dialog then
    dialog:Init()
    self:Destroy()
  end
end

return FitstRecharge2Dialog

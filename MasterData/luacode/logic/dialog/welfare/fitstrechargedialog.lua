local Role = require("logic.manager.experimental.types.role")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local CFirstRechargeReward = BeanManager.GetTableByName("welfare.cfirstrechargereward")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CFirstGift = BeanManager.GetTableByName("welfare.cfirstgift")
local CFirstGiftParamater = BeanManager.GetTableByName("welfare.cfirstgiftparamater")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local ItemCellNum = 4
local FitstRechargeDialog = class("FitstRechargeDialog", Dialog)
FitstRechargeDialog.AssetBundleName = "ui/layouts.welfare"
FitstRechargeDialog.AssetName = "FirstRecharge"
local ItemIdType = {Role = 27, Equip = 299}
local State = {
  NoRecharge = 1,
  RewardOneLock = 2,
  RewardOneUnlock = 3,
  RewardTwoLock = 4,
  RewardTwoUnLock = 5,
  Finishi = 6
}

function FitstRechargeDialog:Ctor(...)
  FitstRechargeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._state = -1
end

function FitstRechargeDialog:OnCreate()
  self._model = self:GetChild("BackImage/Frame2/Model")
  self._model:Subscribe_PointerClickEvent(self.ModelClick, self)
  self._frame1FinishBtn = self:GetChild("BackImage/Frame1/FinishBtn")
  self._frame2FinishBtn = self:GetChild("BackImage/Frame2/FinishBtn")
  self._iBtn = self:GetChild("BackImage/Frame2/Ibtn")
  self._goBtn = self:GetChild("BackImage/Up/GoBtn")
  self._goBtnText = self:GetChild("BackImage/Up/GoBtn/Text")
  self._goBtnDone = self:GetChild("BackImage/Up/GoBtn/Done")
  self._leftArrowBtn = self:GetChild("LeftArrow")
  self._leftArrowBtn:Subscribe_PointerClickEvent(self.OnLeftArrowBtnClicked, self)
  self._rightArrowBtn = self:GetChild("RightArrow")
  self._rightArrowBtn:Subscribe_PointerClickEvent(self.OnRightArrowBtnClicked, self)
  self._closeBtn = self:GetChild("CloseBtn")
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, 4 do
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
  self._iBtn:Subscribe_PointerClickEvent(self.IButtonClick, self)
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  LuaNotificationCenter.AddObserver(self, self.SetButtonState, Common.n_FirstRechargeGiftState, nil)
end

function FitstRechargeDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function FitstRechargeDialog:Init()
  self:OnRefreshItem()
  local roleIdData = Role.Create(59)
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

function FitstRechargeDialog:OnRefreshItem()
  local FirstGifConfig = CFirstGift:GetRecorder(1)
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
  for i, item in ipairs(self._items) do
    if i <= ItemCellNum then
      local imageRecord = item:GetPinJiImage()
      self._itemBacks[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = item:GetIcon()
      self._itemIcons[i]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._itemCounts[i]:SetText(NumberManager.GetShowNumber(itemscount[i]))
    end
  end
end

function FitstRechargeDialog:SetButtonState()
  local str
  self._frame1FinishBtn:SetActive(false)
  self._frame2FinishBtn:SetActive(false)
  local FirstChargeData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeData()
  if not FirstChargeData.chargeDays[CFirstGiftParamater:GetRecorder(4).param] then
    str = CStringRes:GetRecorder(1429).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.NoRecharge
    return
  end
  local OneAwardData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeAwardById(1)
  if not OneAwardData then
    str = CStringRes:GetRecorder(1429).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.NoRecharge
    return
  end
  local TwoAwardData = NekoData.BehaviorManager.BM_Welfare:GetFirstChargeAwardById(2)
  if OneAwardData.statue == 0 then
    str = CStringRes:GetRecorder(1429).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.NoRecharge
  elseif OneAwardData.statue == 1 then
    str = CStringRes:GetRecorder(1430).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.RewardOneUnlock
  elseif TwoAwardData.statue == 0 then
    str = CStringRes:GetRecorder(1431).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.RewardTwoLock
  elseif TwoAwardData.statue == 1 then
    str = CStringRes:GetRecorder(1431).msgTextID
    str = TextManager.GetText(str)
    self._goBtnText:SetText(str)
    self._goBtnText:SetActive(true)
    self._goBtnDone:SetActive(false)
    self._state = State.RewardTwoUnLock
  elseif OneAwardData.statue == 2 and TwoAwardData.statue == 2 then
    self._goBtnText:SetActive(false)
    self._goBtnDone:SetActive(true)
    self._goBtn:SetInteractable(false)
    self._state = State.Finishi
  end
  self._frame1FinishBtn:SetActive(OneAwardData.statue == 2)
  self._frame2FinishBtn:SetActive(TwoAwardData.statue == 2)
end

function FitstRechargeDialog:ModelClick()
  local animator = AnimatorStaticFunctions.Get(self._model._uiObject)
  animator:SetTrigger("onClick")
end

function FitstRechargeDialog:IButtonClick()
  DialogManager.CreateSingletonDialog("welfare.firtstrechargetip")
end

function FitstRechargeDialog:OnGoBtnClick()
  if self._state == State.NoRecharge then
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
    self:Destroy()
  elseif self._state == State.RewardOneUnlock then
    self:GetFirstRechargeGift(1)
  elseif self._state == State.RewardTwoLock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100239)
  elseif self._state == State.RewardTwoUnLock then
    self:GetFirstRechargeGift(2)
  end
end

function FitstRechargeDialog:GetFirstRechargeGift(id)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cfirstchargegetreward")
  csend.id = id
  csend:Send()
end

function FitstRechargeDialog:OnCellClick(index)
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

function FitstRechargeDialog:OnBackBtnClicked()
  self:Destroy()
end

function FitstRechargeDialog:OnLeftArrowBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrecharge2dialog")
  if dialog then
    dialog:Init()
    self:Destroy()
  end
end

function FitstRechargeDialog:OnRightArrowBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("welfare.fitstrecharge2dialog")
  if dialog then
    dialog:Init()
    self:Destroy()
  end
end

return FitstRechargeDialog

local CharFashionPart = class("CharFashionPart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ModelAnimation = require("logic.manager.experimental.types.modelanimation")
local self
local BtnStatus = {
  None = 0,
  InUse = 1,
  InSelling = 2,
  CanChange = 3,
  InOther = 4
}

function CharFashionPart.OnCreate(delegate)
  self = delegate
  self._showBtn = self:GetChild("BackGround/Frame/CharClothes/ShowBtn")
  self._modelPanel = self:GetChild("BackGround/Frame/CharClothes/Back/Model/ModelBack")
  self._model = self:GetChild("BackGround/Frame/CharClothes/Back/Model/ModelBack/Model")
  self._fashionName = self:GetChild("BackGround/Frame/CharClothes/Back/Model/Name")
  self._artistName = self:GetChild("BackGround/Frame/CharClothes/Back/Model/ArtistName")
  self._desc = self:GetChild("BackGround/Frame/CharClothes/Back/Model/Describe")
  self._fashion_frame = self:GetChild("BackGround/Frame/CharClothes/Back/Frame")
  self._changeBtn = self:GetChild("BackGround/Frame/CharClothes/Back/ChangeBtn")
  self._btnText = self:GetChild("BackGround/Frame/CharClothes/Back/ChangeBtn/_Text")
  self._leftArrow = self:GetChild("BackGround/Frame/CharClothes/Back/Left")
  self._rightArrow = self:GetChild("BackGround/Frame/CharClothes/Back/Right")
  self._fashionFrame = TableFrame.Create(self._fashion_frame, self, false, true)
  self._modelPanel:Subscribe_PointerClickEvent(CharFashionPart.OnModelBackClick, self)
  self._showBtn:Subscribe_PointerClickEvent(CharFashionPart.OnShowBtnClick, self)
  self._changeBtn:Subscribe_PointerClickEvent(CharFashionPart.OnChangeBtnClick, self)
  self._fashionHandler = nil
  self._curFashionData = nil
  self._curSelectIdx = 0
  self._changeBtnStatus = 0
  self._modelId = 0
  self._firstOpen = true
  LuaNotificationCenter.AddObserver(self, self.RefreshFashionInfo, Common.n_RefreshFashion, nil)
  LuaNotificationCenter.AddObserver(CharFashionPart, CharFashionPart.OnRefreshSkinRedDot, Common.n_RedPointNumChanged, nil)
end

function CharFashionPart:OnModelBackClick()
  if self._modelPrefabName == nil then
    return
  end
  if self._modelAnimation == nil then
    local modelObj = self._model:GetUIObject().transform:GetChild(0):GetChild(0).gameObject
    self._modelAnimation = ModelAnimation.Create(self._modelPrefabName, modelObj)
    self._modelAnimation:SetSkillList(CSkin:GetRecorder(self._modelSkinId).action)
  end
  if self._modelAnimation then
    self._modelAnimation:PlaySkillCyclically()
  end
end

function CharFashionPart.Clear()
  if self._fashionHandler then
    self._model:ReleaseModel(self._fashionHandler)
    self._fashionHandler = nil
  end
  self._curFashionData = nil
  self._curSelectIdx = 0
  self._changeBtnStatus = 0
  self._modelId = 0
  self._modelSkinId = 0
  self._fashionList = {}
  self._fashionFrame:ReloadAllCell()
  self._firstOpen = true
  self:SetLive2D(self._data)
end

function CharFashionPart.OnDestroy()
  self._fashionFrame:Destroy()
  if self._fashionHandler then
    self._model:ReleaseModel(self._fashionHandler)
    self._fashionHandler = nil
  end
  if self._modelAnimation ~= nil then
    self._modelAnimation:Destroy()
    self._modelAnimation = nil
  end
  self = nil
  LuaNotificationCenter.RemoveObserver(CharFashionPart)
end

function CharFashionPart.RefreshFashionInfo()
  if self._modelAnimation ~= nil then
    self._modelAnimation:Destroy()
    self._modelAnimation = nil
  end
  self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId())
  local allData = self._data:GetFashionData()
  self._allFashionData = allData
  self._fashionList = {}
  for k, v in pairs(allData.list) do
    local skinId = v.skinID
    local skin = CSkin:GetRecorder(skinId)
    if skin.skinType ~= 16 then
      table.insert(self._fashionList, v)
    else
      local a = 1
    end
  end
  self._fashionFrame:ReloadAllCell()
  local num = #self._fashionList
  self._leftArrow:SetActive(3 < num)
  self._rightArrow:SetActive(3 < num)
  if #self._fashionList > 0 then
    local wearIdx = allData.default
    for k, v in ipairs(self._fashionList) do
      if v.skinID == wearIdx then
        wearIdx = k
        break
      end
    end
    if wearIdx == 0 then
      for k, v in ipairs(self._fashionList) do
        if v.hasGotten then
          wearIdx = k
          break
        end
      end
      if wearIdx == 0 then
        wearIdx = 1
      end
    end
    CharFashionPart.UpdateInfo(self._fashionList[wearIdx])
  end
end

function CharFashionPart.UpdateInfo(skinData)
  warn(">> CharFashionPart.UpdateInfo: ", self._curSelectIdx, skinData.index, skinData.skinID, skinData.isSelling, skinData.hasGotten)
  if self._modelSkinId == skinData.skinID then
    return
  end
  self._showBtn:SetActive(skinData.hasGotten)
  self._fashionFrame:FireEvent("select", skinData.index)
  local skinId = skinData.skinID
  local skin = CSkin:GetRecorder(skinId)
  self._modelSkinId = skinData.skinID
  self._curSelectIdx = skinData.index
  self._curFashionData = skin
  self._fashionName:SetText(TextManager.GetText(skin.skinNameTextID))
  self._artistName:SetText(TextManager.GetText(skin.artistTextID))
  self._desc:SetText(TextManager.GetText(skin.discribeTextID))
  self:SetLive2D(self._data, skin, not skinData.hasGotten)
  NekoData.BehaviorManager.BM_AllRoles:SetSkinRedDotChecked(skin)
  local curWearId = self._data:GetDefaultFashion()
  
  local function setModel(self)
    if self._modelId == skin.shapeID then
      return
    end
    self._modelId = skin.shapeID
    local shapeRecord = CNpcShapeTable:GetRecorder(skin.shapeID)
    if self._fashionHandler then
      self._model:ReleaseModel(self._fashionHandler)
      self._fashionHandler = nil
    end
    self._modelPrefabName = nil
    if shapeRecord.assetBundleName and shapeRecord.prefabNameUI then
      self._modelPrefabName = shapeRecord.prefabNameUI
      self._fashionHandler = self._model:AddModelSync(shapeRecord.assetBundleName, shapeRecord.prefabNameUI)
    end
  end
  
  if self._firstOpen then
    GameTimer.AddTask(0.5, -1, setModel, self)
    self._firstOpen = false
  else
    setModel(self)
  end
  if skinData.isSelling then
    self._changeBtn:SetActive(true)
    self._btnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1313).msgTextID))
    self._changeBtnStatus = BtnStatus.InSelling
  elseif skinData.hasGotten then
    self._changeBtn:SetActive(true)
    if curWearId == skinId or curWearId == 0 then
      self._btnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1311).msgTextID))
      self._changeBtnStatus = BtnStatus.InUse
    else
      self._btnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1312).msgTextID))
      self._changeBtnStatus = BtnStatus.CanChange
    end
  elseif self._curFashionData.skinType == 15 and NekoData.BehaviorManager.BM_Shop:GetHalloweenShopOpenState() == 1 then
    self._changeBtn:SetActive(true)
    self._changeBtnStatus = BtnStatus.InOther
    self._btnText:SetText(TextManager.GetText(CStringRes:GetRecorder(1313).msgTextID))
  else
    self._changeBtn:SetActive(false)
  end
end

function CharFashionPart.OnShowBtnClick()
  if not self._curFashionData then
    warn("nil data")
    return
  end
  DialogManager.CreateSingletonDialog("character.characterfashionshowdialog"):SetData(self._curFashionData.id)
end

function CharFashionPart.OnChangeBtnClick()
  local status = self._changeBtnStatus
  if status == BtnStatus.InSelling then
    self:Destroy()
    NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(6)
  elseif status == BtnStatus.CanChange then
    local cmd = LuaNetManager.CreateProtocol("protocol.item.cchangeskin")
    cmd.roleId = self._data:GetId()
    cmd.skin2Change = self._curFashionData.id
    cmd:Send()
  elseif status == BtnStatus.InOther and self._curFashionData.skinType == 15 and NekoData.BehaviorManager.BM_Shop:GetHalloweenShopOpenState() == 1 then
    self:Destroy()
    local dialog = DialogManager.CreateSingletonDialog("activity.halloween.halloweenmaindialog")
    if dialog then
      dialog:OnSheetBtnClicked(3)
    end
  end
end

function CharFashionPart.OnRefreshSkinRedDot(observer, notification)
  if notification.userInfo.redPointID == 7 and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._fashionFrame:FireEvent("RefreshRedDot")
  end
end

return CharFashionPart

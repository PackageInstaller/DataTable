local C7DaySPopUpGift = BeanManager.GetTableByName("topup.c7dayspopupgift")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkin = BeanManager.GetTableByName("role.cskin")
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CommonAwardStatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local Num = 4
local timeutils = require("logic.utils.timeutils")
local UIManager = CS.PixelNeko.UI.UIManager
local PopUpGift7DayDialog = class("PopUpGift7DayDialog", Dialog)
PopUpGift7DayDialog.AssetBundleName = "ui/layouts.welfare"
PopUpGift7DayDialog.AssetName = "Promotions7Days"

function PopUpGift7DayDialog:Ctor(...)
  PopUpGift7DayDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._list = {}
  self._itemList = {}
  self._selectId = nil
  self._skinId = nil
  self._skinItemId = nil
  self._initRolePanel = false
  self._activityClose = false
end

function PopUpGift7DayDialog:OnCreate()
  self._closeBtn = self:GetChild("AnimationKey/CloseBtn")
  self._iBtn = self:GetChild("AnimationKey/BackImage/Frame2/Ibtn")
  self._timeIBtn = self:GetChild("AnimationKey/Frame/TimeTxt/TimeIbtn")
  self._rolePanel = self:GetChild("AnimationKey/Role")
  self._photo = self:GetChild("AnimationKey/Role/Photo")
  self._live2D = self:GetChild("AnimationKey/Role/Live2D")
  self._rank = self:GetChild("AnimationKey/BackImage/Up/NameBack/Rank")
  self._name = self:GetChild("AnimationKey/BackImage/Up/CharName/CharName")
  self._skinName = self:GetChild("AnimationKey/BackImage/Up/CharName/Txt")
  self._jobImg = self:GetChild("AnimationKey/BackImage/Up/NameBack/Image (1)")
  self._jobTxt = self:GetChild("AnimationKey/BackImage/Up/NameBack/Text")
  self._model = self:GetChild("AnimationKey/BackImage/Frame2/Model")
  self._modelGot = self:GetChild("AnimationKey/BackImage/Frame2/FinishBtn")
  self._saleBtn = self:GetChild("AnimationKey/BackImage/Up/GoBtn")
  self._saleBtn_got = self:GetChild("AnimationKey/BackImage/Up/GoBtn/Done")
  self._saleBtn_text = self:GetChild("AnimationKey/BackImage/Up/GoBtn/Text")
  self._leftTime = self:GetChild("AnimationKey/Frame/TimeTxt")
  self._panel = self:GetChild("AnimationKey/BackImage/Frame1/Frame")
  self._btnPanel = self:GetChild("AnimationKey/BtnFrame")
  self._goodsFrame = TableFrame.Create(self._panel, self, false, false, false)
  self._btnFrame = TableFrame.Create(self._btnPanel, self, false, false, false)
  self._itemFrame_width, self._itemFrame_height = self._panel:GetRectSize()
  self._itemFrame_anchoredx, self._itemFrame_anchoredy = self._panel:GetAnchoredPosition()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._saleBtn:Subscribe_PointerClickEvent(self.OnSaleBtnClicked, self)
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._timeIBtn:Subscribe_PointerClickEvent(self.OnTimeIBtnClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshPopUpGift, Common.n_RefreshPopUpGift7Day, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  self:GetChild("AnimationKey/Frame/Back2/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1982))
  self:GetChild("AnimationKey/BackImage/Frame1/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2229))
  self:GetChild("AnimationKey/BackImage/Frame2/NameBack/Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2228))
end

function PopUpGift7DayDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._goodsFrame then
    self._goodsFrame:Destroy()
  end
  if self._btnFrame then
    self._btnFrame:Destroy()
  end
end

function PopUpGift7DayDialog:OnRefreshPopUpGift(notification)
  if not NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day() then
    self._leftTime:SetActive(false)
    if self._timer then
      GameTimer.RemoveTask(self._timer)
      self._timer = nil
    end
    self._activityClose = true
  else
    self:Init()
  end
end

function PopUpGift7DayDialog:Init()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  self._data = NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day()
  if not self._data or next(self._data) == nil then
    LogError("Data is nil or Data Count Eq 0.")
    return
  end
  while self._list[#self._list] do
    table.remove(self._list, #self._list)
  end
  for k, v in pairs(self._data.rewards) do
    local record = C7DaySPopUpGift:GetRecorder(k)
    if record then
      table.insert(self._list, {
        id = k,
        status = v,
        record = record
      })
    else
      LogErrorFormat("BM_Activity", "Can not find record by activityId: %s in c7dayspopupgift", k)
    end
  end
  table.sort(self._list, function(a, b)
    return a.record.days < b.record.days
  end)
  self._leftTime:SetActive(true)
  self._timer = GameTimer.AddTask(0, 1, function()
    local leftTime = 0
    if NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day() then
      leftTime = NekoData.BehaviorManager.BM_Activity:GetPopUpGift7Day().leftTime
    end
    local day = leftTime // 1000 // 3600 // 24
    local hour = (leftTime - day * 24 * 3600 * 1000) // 1000 // 3600
    local minute = (leftTime - day * 24 * 3600 * 1000 - hour * 3600 * 1000) // 1000 // 60
    local second = (leftTime - day * 24 * 3600 * 1000 - hour * 3600 * 1000 - minute * 60 * 1000) // 1000
    local str = ""
    if 0 < day then
      if self._data.hasBought == 0 then
        str = NekoData.BehaviorManager.BM_Message:GetString(2230, {
          day,
          hour,
          minute,
          second
        })
      else
        str = NekoData.BehaviorManager.BM_Message:GetString(2234, {
          day,
          hour,
          minute,
          second
        })
      end
    elseif 0 < hour then
      if self._data.hasBought == 0 then
        str = NekoData.BehaviorManager.BM_Message:GetString(2231, {
          hour,
          minute,
          second
        })
      else
        str = NekoData.BehaviorManager.BM_Message:GetString(2235, {
          hour,
          minute,
          second
        })
      end
    elseif 0 < minute then
      if self._data.hasBought == 0 then
        str = NekoData.BehaviorManager.BM_Message:GetString(2232, {minute, second})
      else
        str = NekoData.BehaviorManager.BM_Message:GetString(2236, {minute, second})
      end
    elseif self._data.hasBought == 0 then
      str = NekoData.BehaviorManager.BM_Message:GetString(2233, {second})
    else
      str = NekoData.BehaviorManager.BM_Message:GetString(2237, {second})
    end
    self._leftTime:SetText(str)
  end)
  if not self._selectId then
    self._selectId = self._list[1].id
  end
  self._skinId = self._list[#self._list].record.skinID
  self._modelGot:SetActive(self._list[#self._list].status == CommonAwardStatus.FETCHED)
  self:RefreshBySelectId()
  self._btnFrame:ReloadAllCell()
end

function PopUpGift7DayDialog:GetDataBySelectId()
  for i, v in ipairs(self._list) do
    if v.id == self._selectId then
      return v
    end
  end
end

function PopUpGift7DayDialog:RefreshBySelectId()
  local data = self:GetDataBySelectId()
  if not self._initRolePanel then
    self._initRolePanel = true
    local role
    local skin = CSkin:GetRecorder(self._skinId)
    if skin then
      role = Role.Create(skin.roleid)
      self._skinItemId = skin.skinItemID
    else
      LogErrorFormat("PopUpGift7DayDialog", "skin with id %s is not exist in cskin", self._skinId)
    end
    role:SetFashionId(self._skinId)
    self._rolePanel:SetAnimatorTrigger("loadReady")
    if self._handler then
      self._live2D:Release(self._handler)
      self._handler = nil
    end
    local record = role:GetShapeLive2DRecord()
    if Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" then
      self._photo:SetActive(false)
      self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      self._photo:SetActive(true)
      local recorder = role:GetShapeLiHuiImageRecord()
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local photoScale = role:GetPhotoScale()
      self._photo:SetLocalScale(photoScale, photoScale, photoScale)
      local photoPos = role:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
    self._rank:SetSprite(role:GetRoleInfoRarityImageRecord().assetBundle, role:GetRoleInfoRarityImageRecord().assetName)
    self._jobImg:SetSprite(role:GetVocationDescribeImageRecord().assetBundle, role:GetVocationDescribeImageRecord().assetName)
    self._jobTxt:SetText(role:GetVocationName())
    self._name:SetText(role:GetRoleName())
    self._skinName:SetText(TextManager.GetText(skin.skinNameTextID))
    if self._modelHandler and self._modelHandler ~= 0 then
      self._model:ReleaseModel(self._modelHandler)
      self._modelHandler = 0
    end
    local skinAsset = role:GetModelRecord()
    if skinAsset.assetBundle and skinAsset.assetName then
      self._modelHandler = self._model:AddModelSync(skinAsset.assetBundle, skinAsset.assetName)
    end
  end
  while self._itemList[#self._itemList] do
    table.remove(self._itemList, #self._itemList)
  end
  for i, v in ipairs(data.record.items) do
    local item = Item.Create(v)
    table.insert(self._itemList, {
      item = item,
      num = data.record.nums[i]
    })
  end
  self._goodsFrame:ReloadAllCell()
  local cellPanelWidth = self._itemFrame_width / Num * #self._itemList
  local cellPanelHeight = self._goodsFrame:GetTotalLength()
  self._panel:SetSize(0, cellPanelWidth, 0, self._itemFrame_height)
  self._panel:SetAnchoredPosition(self._itemFrame_anchoredx, self._itemFrame_anchoredy)
  self._goodsFrame:ReloadAllCell()
  if self._data.hasBought == 0 then
    local gear = self._list[1].record.gear
    self._saleBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2238, {gear}))
  else
    self._saleBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2239))
    if data.status == CommonAwardStatus.LOCKED then
      self._saleBtn:SetInteractable(false)
    elseif data.status == CommonAwardStatus.UNLOCKED then
      self._saleBtn:SetInteractable(true)
    elseif data.status == CommonAwardStatus.FETCHED then
      self._saleBtn:SetInteractable(false)
      self._saleBtn_text:SetText(NekoData.BehaviorManager.BM_Message:GetString(2240))
    end
  end
end

function PopUpGift7DayDialog:SetSelectId(id)
  if id ~= self._selectId then
    self._selectId = id
    self._btnFrame:FireEvent("SetSelectId", self._selectId)
    self:RefreshBySelectId()
  end
end

function PopUpGift7DayDialog:OnSaleBtnClicked()
  local data = self:GetDataBySelectId()
  if self._data.hasBought == 0 then
    if self._activityClose then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100116)
    else
      local cmd = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
      cmd.goodId = self._data.goodId
      cmd:Send()
    end
  elseif data.status == CommonAwardStatus.UNLOCKED then
    local cmd = LuaNetManager.CreateProtocol("protocol.activity.creceivesevendaypopgift")
    cmd.rewardId = self._selectId
    cmd:Send()
  end
end

function PopUpGift7DayDialog:OnIBtnClicked()
  local dlg = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
  local data = {}
  table.insert(data, {
    itemId = self._skinId
  })
  dlg:SetData(dlg.TargetType.OnlyShow, data)
end

function PopUpGift7DayDialog:OnTimeIBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(18)
end

function PopUpGift7DayDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if self._willDestroy and stateName == "Promotions" then
    self:Destroy()
  end
end

function PopUpGift7DayDialog:OnBackBtnClicked()
  if not self._willDestroy then
    self._willDestroy = true
    self._rootWindow:PlayAnimation("Promotions")
  end
end

function PopUpGift7DayDialog:AddNewModal(dialog)
  if dialog._dialogName == "gacha.gachamoviedialog" then
    UIManager.SetLayer(self._rootWindow._uiObject.transform, Layers.InvisibleLayerID)
  end
end

function PopUpGift7DayDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "gacha.gachamoviedialog" then
    UIManager.SetLayer(self._rootWindow._uiObject.transform, self._rootWindow._uiObject.transform.parent.gameObject.layer)
  end
end

function PopUpGift7DayDialog:NumberOfCell(frame, index)
  if frame == self._goodsFrame then
    return #self._itemList
  elseif frame == self._btnFrame then
    return #self._list
  end
end

function PopUpGift7DayDialog:CellAtIndex(frame, index)
  if frame == self._goodsFrame then
    return "welfare.popupgift7dayitemcell"
  elseif frame == self._btnFrame then
    return "welfare.popupgift7daybtncell"
  end
end

function PopUpGift7DayDialog:DataAtIndex(frame, index)
  if frame == self._goodsFrame then
    return self._itemList[index]
  elseif frame == self._btnFrame then
    return self._list[index]
  end
end

return PopUpGift7DayDialog

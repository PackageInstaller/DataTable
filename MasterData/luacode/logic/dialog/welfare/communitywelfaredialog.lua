local CCommunityLink = BeanManager.GetTableByName("ui.ccommunitylink")
local Item = require("logic.manager.experimental.types.item")
local CommunityWelfareDialog = class("CommunityWelfareDialog", Dialog)
CommunityWelfareDialog.AssetBundleName = "ui/layouts.welfare"
CommunityWelfareDialog.AssetName = "CommunityWelfare"

function CommunityWelfareDialog:Ctor(...)
  CommunityWelfareDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._items = {}
end

function CommunityWelfareDialog:OnCreate()
  self._backImage = self:GetChild("BackImage")
  self._btn1 = self:GetChild("BackImage/GoBtn")
  self._btn2 = self:GetChild("BackImage/ClaimBtn")
  self._closeBtn = self:GetChild("BackImage/BackBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._gotoBtn = self:GetChild("BackImage/GoBtn")
  self._gotoBtn:Subscribe_PointerClickEvent(self.OnGotoBtnClicked, self)
  self._claimBtn = self:GetChild("BackImage/ClaimBtn")
  self._claimBtn:Subscribe_PointerClickEvent(self.OnClaimBtnClicked, self)
  self._itemIcon = {}
  self._itemNum = {}
  for i = 1, 3 do
    self._itemIcon[i] = self:GetChild("BackImage/Reward/Item" .. i)
    self._itemIcon[i]:Subscribe_PointerClickEvent(function()
      self:OnItemCellClicked(i)
    end)
    self._itemIcon[i]:SetActive(false)
    self._itemNum[i] = self:GetChild("BackImage/Reward/Num" .. i)
    self._itemNum[i]:SetText("")
    self._itemNum[i]:SetActive(false)
  end
  self:OnRefreshClaimBtn()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshClaimBtn, Common.n_CommunityWelfareRedPoint, nil)
end

function CommunityWelfareDialog:OnItemCellClicked(index)
  if self._items[index] then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._items[index]
      })
      local width, height = self._items[index].itemCell:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._items[index].itemCell:GetLocalPointInUiRootPanel())
    end
  end
end

function CommunityWelfareDialog:Init(serverData)
  local index = 0
  for k, v in pairs(serverData.award) do
    index = index + 1
    if index <= 3 then
      local item = Item.Create(k)
      self._items[index] = item
      local imageRecord = item:GetIcon()
      self._itemIcon[index]:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._itemIcon[index]:SetActive(true)
      self._itemNum[index]:SetText(v)
      self._itemNum[index]:SetActive(true)
    end
  end
end

function CommunityWelfareDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CommunityWelfareDialog:OnRefreshClaimBtn()
  local CommunityShareInfo = NekoData.BehaviorManager.BM_Welfare:GetCommunityShareInfo()
  if CommunityShareInfo then
    local Record = CCommunityLink:GetRecorder(CommunityShareInfo.pictureID)
    if Record then
      self._backImage:SetSprite(Record.path, Record.name)
    end
    if CommunityShareInfo.statue == 1 then
      self._claimBtn:SetInteractable(true)
    else
      self._claimBtn:SetInteractable(false)
    end
  else
    self._claimBtn:SetInteractable(false)
  end
end

function CommunityWelfareDialog:OnBackBtnClicked()
  self:Destroy()
end

function CommunityWelfareDialog:OnGotoBtnClicked()
  local CommunityShareInfo = NekoData.BehaviorManager.BM_Welfare:GetCommunityShareInfo()
  if CommunityShareInfo then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(CommunityShareInfo.shareUrl)
    local csend = LuaNetManager.CreateProtocol("protocol.activity.ccommunityshareactive")
    csend:Send()
  end
end

function CommunityWelfareDialog:OnClaimBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.ccommunitysharegetreward")
  csend:Send()
end

return CommunityWelfareDialog

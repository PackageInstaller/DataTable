local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CVarCfg = BeanManager.GetTableByName("var.cvarconfig")
local Limit = tonumber(CVarCfg:GetRecorder(71).Value)
local BackgroundStoryCell = class("BackgroundStoryCell", Dialog)
BackgroundStoryCell.AssetBundleName = "ui/layouts.tujian"
BackgroundStoryCell.AssetName = "CharStoryCell2"

function BackgroundStoryCell:Ctor(...)
  BackgroundStoryCell.super.Ctor(self, ...)
end

function BackgroundStoryCell:OnCreate()
  self._sortId = self:GetChild("Text")
  self._unlockPanel = self:GetChild("Back")
  self._unlockPanel_txt = self:GetChild("Back/Detail")
  self._unlockBtn = self:GetChild("UnlockBtn")
  self._lockPanel = self:GetChild("Lock")
  self._lockPanel_heartInfo = {}
  for i = 1, 5 do
    self._lockPanel_heartInfo[i] = {}
    self._lockPanel_heartInfo[i].back = self:GetChild("Lock/Heart" .. i .. "Back")
    self._lockPanel_heartInfo[i].light = self:GetChild("Lock/Heart" .. i)
  end
  self._lockPanel_conditionTxt = self:GetChild("Lock/Detail")
  self._unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BackgroundStoryCell:OnDestroy()
end

local function chsize(char)
  if not char then
    print("not char")
    return 0
  elseif 240 < char then
    return 4
  elseif 225 < char then
    return 3
  elseif 192 < char then
    return 2
  else
    return 1
  end
end

function utf8len(str)
  local len = 0
  local currentIndex = 1
  while currentIndex <= #str do
    local char = string.byte(str, currentIndex)
    currentIndex = currentIndex + chsize(char)
    len = len + 1
  end
  return len
end

local function utf8sub(str, startChar, numChars)
  local startIndex = 1
  while 1 < startChar do
    local char = string.byte(str, startIndex)
    startIndex = startIndex + chsize(char)
    startChar = startChar - 1
  end
  local currentIndex = startIndex
  while 0 < numChars and currentIndex <= #str do
    local char = string.byte(str, currentIndex)
    currentIndex = currentIndex + chsize(char)
    numChars = numChars - 1
  end
  return string.sub(str, startIndex, currentIndex - 1)
end

function BackgroundStoryCell:RefreshCell(data)
  local id = data.reward.rewardId
  self._sortId:SetText(TextManager.GetText(data.favourPresentRecord.storynumtxtid[id]))
  if data.reward.received then
    self._unlockPanel:SetActive(true)
    self._unlockBtn:SetActive(false)
    self._lockPanel:SetActive(false)
    local str = TextManager.GetText(data.bookRecord.backStoryTextID[id])
    str = string.gsub(str, "%$B%$", "")
    self._unlockPanel_txt:SetText(str)
    local count = utf8.len(str)
    if count > Limit then
      local curChar = utf8sub(str, 1, Limit)
      self._unlockPanel_txt:SetText(curChar .. NekoData.BehaviorManager.BM_Message:GetString(1435))
    end
  elseif data.reward.favourLv <= self._delegate._favourLv then
    self._unlockPanel:SetActive(false)
    self._unlockBtn:SetActive(true)
    self._lockPanel:SetActive(false)
  else
    self._unlockPanel:SetActive(false)
    self._unlockBtn:SetActive(false)
    self._lockPanel:SetActive(true)
    self._lockPanel_conditionTxt:SetText(string.gsub(TextManager.GetText(502721), "%$parameter1%$", data.reward.favourLv))
    local maxHeartNum = self._delegate._maxHeartNum
    local record = CFavourExp:GetRecorder(data.reward.favourLv)
    local curHeartNum = record.heartnum / 10
    local integer, decimal = math.modf(curHeartNum)
    for i, v in ipairs(self._lockPanel_heartInfo) do
      if i > maxHeartNum then
        v.back:SetActive(false)
        v.light:SetActive(false)
      elseif curHeartNum > i - 1 and i > curHeartNum then
        v.light:SetFillAmount(decimal)
      elseif i <= curHeartNum then
        v.light:SetFillAmount(1)
      else
        v.light:SetFillAmount(0)
      end
    end
  end
end

function BackgroundStoryCell:OnUnlockBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.good.creceiveaward")
  csend.roleId = self._delegate._roleId
  csend.level = self._cellData.reward.favourLv
  csend:Send()
end

function BackgroundStoryCell:OnCellClicked()
  if self._cellData.reward.received then
    DialogManager.CreateSingletonDialog("handbook.favour.storydetaildialog"):SetData(self._cellData, self._delegate._maxHeartNum)
  end
end

return BackgroundStoryCell

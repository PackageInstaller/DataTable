local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local MailDetailCell = class("MailDetailCell", Dialog)
MailDetailCell.AssetBundleName = "ui/layouts.mail"
MailDetailCell.AssetName = "MailDetailNew"

function MailDetailCell:Ctor(...)
  MailDetailCell.super.Ctor(self, ...)
  self._tag = "ShowEquipTips"
end

function MailDetailCell:OnCreate()
  self._title = self:GetChild("Title")
  self._time = self:GetChild("Time")
  self._sendTitle = self:GetChild("SendTitle/Txt2")
  self._timeDay = self:GetChild("SendTime/Txt2")
  self._timeSec = self:GetChild("SendTime/Txt3")
  self._cellPanel = self:GetChild("CellPanel")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._detail = self:GetChild("Detail")
  self._itemFrame = TableFrame.Create(self._cellPanel, self, false)
  self._itemFrame:SetMargin(20, 0)
  self._detailFrame = TableFrame.Create(self._detail, self, true)
  self._detailFrame:SetMargin(15, 25)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnClickLeftBtn, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnClickRightBtn, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

function MailDetailCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
  self._detailFrame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

function MailDetailCell:RefreshCell(data)
  self._title:SetText(tostring(data.title))
  local time = data.deleteTime - ServerGameTimer.GetServerTime()
  local str
  if 0 < time then
    local dayTime = math.floor(time // 1000 / 60 / 60 / 24)
    str = TextManager.GetText(CstringCfg:GetRecorder(1001).msgTextID)
    local day = tostring(dayTime)
    local hour = tostring(math.ceil((time - dayTime * 24 * 60 * 60 * 1000) / 1000 / 60 / 60))
    str = string.gsub(str, "%$parameter1%$", day)
    str = string.gsub(str, "%$parameter2%$", hour)
  else
    str = TextManager.GetText(CstringCfg:GetRecorder(1002).msgTextID)
  end
  self._time:SetText(str)
  local stime = os.date("%Y-%m-%d", data.receiveTime // 1000)
  self._timeDay:SetText(stime)
  stime = nil
  stime = os.date("%H:%M:%S", data.receiveTime // 1000)
  self._timeSec:SetText(stime)
  self._sendTitle:SetText(data.signature)
  if data.questId == 0 then
    self._delegate:AttaBtnChangeStatus(data.status == 0 and 0 < #data.attachmentList)
    self._delegate._surveyBtn:SetActive(false)
  else
    self._delegate:SurveytnChangeStatus(data.status == 0 and 0 < #data.attachmentList)
    self._delegate._getAttaBtn:SetActive(false)
  end
  if data.id == 2456 or data.id == DataCommon.ReturnBattlePass_MailId then
    self._delegate:AttaBtnChangeStatus(data.status ~= 3)
    self._delegate._surveyBtn:SetActive(false)
  end
  if #data.attachmentList <= 2 then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
    self._itemFrame:SetSlide(false)
  else
    self._leftArrow:SetActive(true)
    self._rightArrow:SetActive(true)
    self._itemFrame:SetSlide(true)
  end
  self._itemFrame:ReloadAllCell()
  self._detailFrame:ReloadAllCell()
end

function MailDetailCell:OnClickLeftBtn()
  local rightIndex = self._itemFrame:GetRightIndex()
  self._itemFrame:MoveRightToIndex(rightIndex - 1, true)
end

function MailDetailCell:OnClickRightBtn()
  local leftIndex = self._itemFrame:GetLeftIndex()
  if leftIndex and 1 <= leftIndex then
    self._itemFrame:MoveLeftToIndex(leftIndex + 1, true)
  end
end

function MailDetailCell:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._itemFrame:FireEvent("ChangedSelected", nil)
  end
end

function MailDetailCell:ShouldLengthChange()
  return true
end

function MailDetailCell:OnCurPosChange(frame, tag)
  if frame == self._itemFrame and #self._cellData.attachmentList > 2 then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
    local width, _ = self._cellPanel:GetRectSize()
    if width >= self._itemFrame:GetTotalLength() then
      self._leftArrow:SetActive(false)
      self._rightArrow:SetActive(false)
    end
  end
end

function MailDetailCell:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._cellData.attachmentList
  end
  if frame == self._detailFrame then
    return 1
  end
end

function MailDetailCell:CellAtIndex(frame)
  if frame == self._itemFrame then
    return "mail.mailitemcell"
  end
  if frame == self._detailFrame then
    return "mail.maildetailtextcell"
  end
end

function MailDetailCell:DataAtIndex(frame, index)
  local data = {}
  if frame == self._itemFrame then
    local info = self._cellData.attachmentList[index]
    local item
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = Item.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.EQUIP then
      item = Equip.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.SKILL then
      item = Skill.Create(info.id)
    end
    item:InitWithFull(info)
    if self._cellData.status == 0 then
      item:SetKey(0)
    end
    data.item = item
  end
  if frame == self._detailFrame then
    data.name = self._cellData.appellation
    data.detail = self._cellData.content
    data.signature = self._cellData.signature
  end
  return data
end

function MailDetailCell:OnEvent(eventName, arg)
  if not self._cellData then
    return
  end
  if eventName == "sreceivemails" and self._cellData.uniqueId == arg then
    if #self._cellData.attachmentList > 0 then
      self._cellData.status = 2
      self._itemFrame:ReloadAllCell()
    else
      self._cellData.status = 1
    end
    if self._cellData.id == 2456 or self._cellData.id == DataCommon.ReturnBattlePass_MailId then
      self._cellData.status = 3
    end
  end
end

return MailDetailCell

-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/maildetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local MailDetailCell = class("MailDetailCell", Dialog)
MailDetailCell.AssetBundleName = "ui/layouts.mail"
MailDetailCell.AssetName = "MailDetailNew"
MailDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailDetailCell
  ((MailDetailCell.super).Ctor)(self, ...)
  self._tag = "ShowEquipTips"
end

MailDetailCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._title = self:GetChild("Title")
  self._time = self:GetChild("Time")
  self._sendTitle = self:GetChild("SendTitle/Txt2")
  self._timeDay = self:GetChild("SendTime/Txt2")
  self._timeSec = self:GetChild("SendTime/Txt3")
  self._cellPanel = self:GetChild("CellPanel")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._detail = self:GetChild("Detail")
  self._itemFrame = (TableFrame.Create)(self._cellPanel, self, false)
  ;
  (self._itemFrame):SetMargin(20, 0)
  self._detailFrame = (TableFrame.Create)(self._detail, self, true)
  ;
  (self._detailFrame):SetMargin(15, 25)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnClickLeftBtn, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnClickRightBtn, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

MailDetailCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
  ;
  (self._detailFrame):Destroy()
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
end

MailDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CstringCfg
  (self._title):SetText(tostring(data.title))
  local time = data.deleteTime - (ServerGameTimer.GetServerTime)()
  local str = nil
  if time > 0 then
    local dayTime = (math.floor)(time // 1000 / 60 / 60 / 24)
    str = (TextManager.GetText)((CstringCfg:GetRecorder(1001)).msgTextID)
    local day = tostring(dayTime)
    local hour = tostring((math.ceil)((time - dayTime * 24 * 60 * 60 * 1000) / 1000 / 60 / 60))
    str = (string.gsub)(str, "%$parameter1%$", day)
    str = (string.gsub)(str, "%$parameter2%$", hour)
  else
    do
      str = (TextManager.GetText)((CstringCfg:GetRecorder(1002)).msgTextID)
      ;
      (self._time):SetText(str)
      local stime = (os.date)("%Y-%m-%d", data.receiveTime // 1000)
      ;
      (self._timeDay):SetText(stime)
      stime = nil
      stime = (os.date)("%H:%M:%S", data.receiveTime // 1000)
      ;
      (self._timeSec):SetText(stime)
      ;
      (self._sendTitle):SetText(data.signature)
      if data.status ~= 0 or #data.attachmentList <= 0 then
        (self._delegate):AttaBtnChangeStatus(data.questId ~= 0)
        ;
        ((self._delegate)._surveyBtn):SetActive(false)
        ;
        (self._delegate):SurveytnChangeStatus(data.status == 0 and #data.attachmentList > 0)
        ;
        ((self._delegate)._getAttaBtn):SetActive(false)
        if data.status == 3 then
          (self._delegate):AttaBtnChangeStatus(data.id ~= 2456 and data.id ~= DataCommon.ReturnBattlePass_MailId)
          ;
          ((self._delegate)._surveyBtn):SetActive(false)
          if #data.attachmentList <= 2 then
            (self._leftArrow):SetActive(false)
            ;
            (self._rightArrow):SetActive(false)
            ;
            (self._itemFrame):SetSlide(false)
          else
            (self._leftArrow):SetActive(true)
            ;
            (self._rightArrow):SetActive(true)
            ;
            (self._itemFrame):SetSlide(true)
          end
          ;
          (self._itemFrame):ReloadAllCell()
          ;
          (self._detailFrame):ReloadAllCell()
          -- DECOMPILER ERROR: 10 unprocessed JMP targets
        end
      end
    end
  end
end

MailDetailCell.OnClickLeftBtn = function(self)
  -- function num : 0_4
  local rightIndex = (self._itemFrame):GetRightIndex()
  ;
  (self._itemFrame):MoveRightToIndex(rightIndex - 1, true)
end

MailDetailCell.OnClickRightBtn = function(self)
  -- function num : 0_5
  local leftIndex = (self._itemFrame):GetLeftIndex()
  if leftIndex and leftIndex >= 1 then
    (self._itemFrame):MoveLeftToIndex(leftIndex + 1, true)
  end
end

MailDetailCell.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_6
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._itemFrame):FireEvent("ChangedSelected", nil)
  end
end

MailDetailCell.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

MailDetailCell.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_8
  if tag == 0 then
    (self._leftArrow):SetActive(frame ~= self._itemFrame or #(self._cellData).attachmentList <= 2)
    ;
    (self._rightArrow):SetActive(tag ~= 1)
    do
      local width, _ = (self._cellPanel):GetRectSize()
      if (self._itemFrame):GetTotalLength() <= width then
        (self._leftArrow):SetActive(false)
        ;
        (self._rightArrow):SetActive(false)
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

MailDetailCell.NumberOfCell = function(self, frame)
  -- function num : 0_9
  if frame == self._itemFrame then
    return #(self._cellData).attachmentList
  end
  if frame == self._detailFrame then
    return 1
  end
end

MailDetailCell.CellAtIndex = function(self, frame)
  -- function num : 0_10
  if frame == self._itemFrame then
    return "mail.mailitemcell"
  end
  if frame == self._detailFrame then
    return "mail.maildetailtextcell"
  end
end

MailDetailCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_11 , upvalues : ItemTypeEnum, Item, Equip, Skill
  local data = {}
  if frame == self._itemFrame then
    local info = ((self._cellData).attachmentList)[index]
    local item = nil
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = (Item.Create)(info.id)
    else
      if info.itemtype == ItemTypeEnum.EQUIP then
        item = (Equip.Create)(info.id)
      else
        if info.itemtype == ItemTypeEnum.SKILL then
          item = (Skill.Create)(info.id)
        end
      end
    end
    item:InitWithFull(info)
    if (self._cellData).status == 0 then
      item:SetKey(0)
    end
    data.item = item
  end
  do
    if frame == self._detailFrame then
      data.name = (self._cellData).appellation
      data.detail = (self._cellData).content
      data.signature = (self._cellData).signature
    end
    return data
  end
end

MailDetailCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_12 , upvalues : _ENV
  if not self._cellData then
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if eventName == "sreceivemails" and (self._cellData).uniqueId == arg then
    if #(self._cellData).attachmentList > 0 then
      (self._cellData).status = 2
      ;
      (self._itemFrame):ReloadAllCell()
    else
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._cellData).status = 1
    end
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    if (self._cellData).id == 2456 or (self._cellData).id == DataCommon.ReturnBattlePass_MailId then
      (self._cellData).status = 3
    end
  end
end

return MailDetailCell


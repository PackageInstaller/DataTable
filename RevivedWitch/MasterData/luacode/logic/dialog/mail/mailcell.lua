-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local MailCell = class("MailCell", Dialog)
MailCell.AssetBundleName = "ui/layouts.mail"
MailCell.AssetName = "MailCellNew"
MailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailCell
  ((MailCell.super).Ctor)(self, ...)
end

MailCell.OnCreate = function(self)
  -- function num : 0_1
  self._normalBack = self:GetChild("Normal")
  self._selectBack = self:GetChild("Select")
  self._gotBack = self:GetChild("Get")
  self._mailTitle = self:GetChild("BackImage/MailTitle")
  self._normalMailTitle = self:GetChild("BackImage/MailTitleNormal")
  self._time = self:GetChild("Time/TimeNormal")
  self._selectTime = self:GetChild("Time/TimeSelect")
  self._openImage = self:GetChild("OpenImage")
  self._closeImage = self:GetChild("CloseImage")
  self._getAttaImage = self:GetChild("OpenImageItem")
  self._attaImage = self:GetChild("CloseImageItem")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
end

MailCell.OnDestroy = function(self)
  -- function num : 0_2
end

MailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CstringCfg
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
      (self._mailTitle):SetText(data.title)
      ;
      (self._normalMailTitle):SetText(data.title)
      ;
      (self._selectTime):SetText(str)
      ;
      (self._time):SetText(str)
      if data.uniqueId == (self._delegate)._selectedID then
        (self._selectBack):SetActive(true)
      else
        ;
        (self._selectBack):SetActive(false)
      end
      ;
      (self._openImage):SetActive(data.status ~= 0 and #data.attachmentList == 0)
      ;
      (self._closeImage):SetActive(data.status == 0 and #data.attachmentList == 0)
      ;
      (self._getAttaImage):SetActive(data.status ~= 0 and #data.attachmentList > 0)
      ;
      (self._attaImage):SetActive(data.status == 0 and #data.attachmentList > 0)
      local got = data.status ~= 0
      ;
      (self._normalBack):SetActive(not got)
      ;
      (self._gotBack):SetActive(got)
      ;
      (self._mailTitle):SetActive(got)
      ;
      (self._normalMailTitle):SetActive(not got)
      ;
      (self._time):SetActive(not got)
      ;
      (self._selectTime):SetActive(got)
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

MailCell.OnMouseClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._selectBack):SetActive(true)
  local IsRefresh = false
  if (self._cellData).status == 0 and #(self._cellData).attachmentList <= 0 then
    IsRefresh = true
  end
  ;
  (self._delegate):SetSelectedID((self._cellData).uniqueId, IsRefresh)
  ;
  (self._delegate):ShowMailDetail(self._cellData)
  local copenMail = (LuaNetManager.CreateProtocol)("protocol.mail.copenmail")
  if copenMail then
    copenMail.uniqueId = (self._cellData).uniqueId
    copenMail:Send()
  end
  if (self._cellData).status == 0 and #(self._cellData).attachmentList <= 0 and (self._cellData).id ~= 2456 and (self._cellData).id ~= DataCommon.ReturnBattlePass_MailId then
    ((NekoData.BehaviorManager).BM_Mail):ChangeStatus((self._cellData).uniqueId)
    ;
    (self._delegate):OnRefresh()
    ;
    (self._delegate):OnRefreshCellByUniqueId((self._cellData).uniqueId)
  end
end

MailCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).uniqueId ~= arg then
    do
      local tag = eventName ~= "ChangedSelected"
      ;
      (self._selectBack):SetActive(tag)
      if eventName == "RefreshCell" and (self._cellData).uniqueId == arg.uniqueId then
        self:RefreshCell(arg)
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

return MailCell


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/backgroundstorycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local CVarCfg = (BeanManager.GetTableByName)("var.cvarconfig")
local Limit = tonumber((CVarCfg:GetRecorder(71)).Value)
local BackgroundStoryCell = class("BackgroundStoryCell", Dialog)
BackgroundStoryCell.AssetBundleName = "ui/layouts.tujian"
BackgroundStoryCell.AssetName = "CharStoryCell2"
BackgroundStoryCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BackgroundStoryCell
  ((BackgroundStoryCell.super).Ctor)(self, ...)
end

BackgroundStoryCell.OnCreate = function(self)
  -- function num : 0_1
  self._sortId = self:GetChild("Text")
  self._unlockPanel = self:GetChild("Back")
  self._unlockPanel_txt = self:GetChild("Back/Detail")
  self._unlockBtn = self:GetChild("UnlockBtn")
  self._lockPanel = self:GetChild("Lock")
  self._lockPanel_heartInfo = {}
  for i = 1, 5 do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

    (self._lockPanel_heartInfo)[i] = {}
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._lockPanel_heartInfo)[i]).back = self:GetChild("Lock/Heart" .. i .. "Back")
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._lockPanel_heartInfo)[i]).light = self:GetChild("Lock/Heart" .. i)
  end
  self._lockPanel_conditionTxt = self:GetChild("Lock/Detail")
  ;
  (self._unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BackgroundStoryCell.OnDestroy = function(self)
  -- function num : 0_2
end

local chsize = function(char)
  -- function num : 0_3 , upvalues : _ENV
  if not char then
    print("not char")
    return 0
  else
    if char > 240 then
      return 4
    else
      if char > 225 then
        return 3
      else
        if char > 192 then
          return 2
        else
          return 1
        end
      end
    end
  end
end

utf8len = function(str)
  -- function num : 0_4 , upvalues : _ENV, chsize
  local len = 0
  local currentIndex = 1
  do
    while currentIndex <= #str do
      local char = (string.byte)(str, currentIndex)
      currentIndex = currentIndex + chsize(char)
      len = len + 1
    end
    return len
  end
end

local utf8sub = function(str, startChar, numChars)
  -- function num : 0_5 , upvalues : _ENV, chsize
  local startIndex = 1
  do
    while startChar > 1 do
      local char = (string.byte)(str, startIndex)
      startIndex = startIndex + chsize(char)
      startChar = startChar - 1
    end
    local currentIndex = startIndex
    do
      while numChars > 0 and currentIndex <= #str do
        local char = (string.byte)(str, currentIndex)
        currentIndex = currentIndex + chsize(char)
        numChars = numChars - 1
      end
      return (string.sub)(str, startIndex, currentIndex - 1)
    end
  end
end

BackgroundStoryCell.RefreshCell = function(self, data)
  -- function num : 0_6 , upvalues : _ENV, Limit, utf8sub, CFavourExp
  local id = (data.reward).rewardId
  ;
  (self._sortId):SetText((TextManager.GetText)(((data.favourPresentRecord).storynumtxtid)[id]))
  if (data.reward).received then
    (self._unlockPanel):SetActive(true)
    ;
    (self._unlockBtn):SetActive(false)
    ;
    (self._lockPanel):SetActive(false)
    local str = (TextManager.GetText)(((data.bookRecord).backStoryTextID)[id])
    str = (string.gsub)(str, "%$B%$", "")
    ;
    (self._unlockPanel_txt):SetText(str)
    local count = (utf8.len)(str)
    if Limit < count then
      local curChar = utf8sub(str, 1, Limit)
      ;
      (self._unlockPanel_txt):SetText(curChar .. ((NekoData.BehaviorManager).BM_Message):GetString(1435))
    end
  else
    do
      if (data.reward).favourLv <= (self._delegate)._favourLv then
        (self._unlockPanel):SetActive(false)
        ;
        (self._unlockBtn):SetActive(true)
        ;
        (self._lockPanel):SetActive(false)
      else
        ;
        (self._unlockPanel):SetActive(false)
        ;
        (self._unlockBtn):SetActive(false)
        ;
        (self._lockPanel):SetActive(true)
        ;
        (self._lockPanel_conditionTxt):SetText((string.gsub)((TextManager.GetText)(502721), "%$parameter1%$", (data.reward).favourLv))
        local maxHeartNum = (self._delegate)._maxHeartNum
        local record = CFavourExp:GetRecorder((data.reward).favourLv)
        local curHeartNum = record.heartnum / 10
        local integer, decimal = (math.modf)(curHeartNum)
        for i,v in ipairs(self._lockPanel_heartInfo) do
          if maxHeartNum < i then
            (v.back):SetActive(false)
            ;
            (v.light):SetActive(false)
          else
            if i - 1 < curHeartNum and curHeartNum < i then
              (v.light):SetFillAmount(decimal)
            else
              if i <= curHeartNum then
                (v.light):SetFillAmount(1)
              else
                ;
                (v.light):SetFillAmount(0)
              end
            end
          end
        end
      end
    end
  end
end

BackgroundStoryCell.OnUnlockBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.good.creceiveaward")
  csend.roleId = (self._delegate)._roleId
  csend.level = ((self._cellData).reward).favourLv
  csend:Send()
end

BackgroundStoryCell.OnCellClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if ((self._cellData).reward).received then
    ((DialogManager.CreateSingletonDialog)("handbook.favour.storydetaildialog")):SetData(self._cellData, (self._delegate)._maxHeartNum)
  end
end

return BackgroundStoryCell


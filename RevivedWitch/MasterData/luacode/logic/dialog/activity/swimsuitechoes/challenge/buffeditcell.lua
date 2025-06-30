-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/buffeditcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CentryConfig = (BeanManager.GetTableByName)("dungeonselect.centryconfig")
local BuffEditCell = class("BuffEditCell", Dialog)
BuffEditCell.AssetBundleName = "ui/layouts.activitysummer2"
BuffEditCell.AssetName = "ActivitySummer2ChallengeBuffCell"
BuffEditCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuffEditCell
  ((BuffEditCell.super).Ctor)(self, ...)
end

BuffEditCell.OnCreate = function(self)
  -- function num : 0_1
  self._unlockTxt = self:GetChild("Lock/Black/Txt")
  self._nomalbackImg = self:GetChild("Normal/Back/BackImg2")
  self._backImg2 = self:GetChild("Normal/Back/BackImg")
  self._lockNode = self:GetChild("Lock")
  self._buffTxt = self:GetChild("Normal/Text/BuffTxt")
  self._select = self:GetChild("Select")
  ;
  (self._nomalbackImg):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BuffEditCell.OnDestroy = function(self)
  -- function num : 0_2
end

BuffEditCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._buffTxt):SetText((TextManager.GetText)((data.cfg).nameID))
  ;
  (self._lockNode):SetActive(not data.isUnlock)
  ;
  (self._unlockTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2179, {(data.cfg).unlockCondition}))
  ;
  (self._backImg2):SetActive(data.state ~= -1)
  ;
  (self._select):SetActive(data.state == 1)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BuffEditCell.OnCellClicked = function(self)
  -- function num : 0_4
  if (self._cellData).isUnlock then
    (self._delegate):OnCellClicked((self._cellData).id)
  end
end

BuffEditCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

  if eventName == "CancelSelection" and args.entrytype == ((self._cellData).cfg).typeID then
    (self._backImg2):SetActive(true)
    ;
    (self._select):SetActive(false)
  end
  if eventName == "Selection" and args.entrytype == ((self._cellData).cfg).typeID then
    if tonumber(args.id) == tonumber(((self._cellData).cfg).id) then
      (self._select):SetActive(true)
      ;
      (self._backImg2):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
      ;
      (self._backImg2):SetActive(false)
    end
  end
end

return BuffEditCell


-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/spiritrecoverconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local SpiritRecoverConfirmDialog = class("SpiritRecoverConfirmDialog", Dialog)
SpiritRecoverConfirmDialog.AssetBundleName = "ui/layouts.spirit"
SpiritRecoverConfirmDialog.AssetName = "SpiritSecondConfirm"
SpiritRecoverConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SpiritRecoverConfirmDialog
  ((SpiritRecoverConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

SpiritRecoverConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._destribe = self:GetChild("Text1")
  self._beforeAP = self:GetChild("Before/Text2")
  self._afterAPTitle = self:GetChild("After/Text1")
  self._afterAP = self:GetChild("After/Text2")
  self._cancleBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

SpiritRecoverConfirmDialog.Refresh = function(self, data, name, deltime)
  -- function num : 0_2 , upvalues : CstringCfg, _ENV
  self._itemID = data.id
  self._itemNum = data.currencynums
  self._itemDeltime = deltime
  local str = (CstringCfg:GetRecorder(1019)).msgTextID
  if self._itemID == DataCommon.SpringFestivalFuRecoverItem then
    str = (TextManager.GetText)(701761)
    ;
    (self._afterAPTitle):SetText((TextManager.GetText)(701762))
  else
    str = (TextManager.GetText)(str)
  end
  str = (string.gsub)(str, "%$parameter1%$", data.currencynums)
  str = (string.gsub)(str, "%$parameter2%$", name)
  if data.itemnums == -1 then
    str = (string.gsub)(str, "%$parameter3%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
  else
    if data.itemnums == -2 then
      str = (string.gsub)(str, "%$parameter3%$", (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2))
    else
      str = (string.gsub)(str, "%$parameter3%$", data.itemnums)
    end
  end
  if self._itemID == DataCommon.SpriteEvidence then
    str = (TextManager.GetText)((CstringCfg:GetRecorder(2100)).msgTextID)
  end
  ;
  (self._destribe):SetText(str)
  str = (CstringCfg:GetRecorder(1022)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Currency):GetSpirit())
  str = (string.gsub)(str, "%$parameter2%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
  ;
  (self._beforeAP):SetText(str)
  str = (CstringCfg:GetRecorder(1022)).msgTextID
  str = (TextManager.GetText)(str)
  local addnum = data.itemnums
  if addnum == -1 then
    addnum = ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull()
  else
    if addnum == -2 then
      addnum = (math.ceil)(((NekoData.BehaviorManager).BM_Currency):GetSpiritFull() / 2)
    end
  end
  if self._itemID == DataCommon.SpringFestivalFuRecoverItem then
    str = (string.gsub)(str, "%$parameter1%$", (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpringSpirit() + addnum)
    str = (string.gsub)(str, "%$parameter2%$", (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SpringFestivalActivityManagerID)):GetSpiritLimit())
  else
    str = (string.gsub)(str, "%$parameter1%$", ((NekoData.BehaviorManager).BM_Currency):GetSpirit() + addnum)
    str = (string.gsub)(str, "%$parameter2%$", ((NekoData.BehaviorManager).BM_Currency):GetSpiritFull())
  end
  ;
  (self._afterAP):SetText(str)
end

SpiritRecoverConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

SpiritRecoverConfirmDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CItemTable
  if self._itemDeltime and self._itemDeltime - (ServerGameTimer.GetServerTime)() < 0 then
    ((NekoData.BehaviorManager).BM_Message):AddConfirmDialog((TextManager.GetText)(700689), function()
    -- function num : 0_4_0 , upvalues : self
    self:Destroy()
  end
)
    return 
  end
  local CRecoverSpirit = nil
  local itemRecorder = CItemTable:GetRecorder(self._itemID)
  if itemRecorder.itemtypeid == DataCommon.SpringSpiritItemType then
    CRecoverSpirit = (LuaNetManager.CreateProtocol)("protocol.activity.crecoverspringspirit")
  else
    CRecoverSpirit = (LuaNetManager.CreateProtocol)("protocol.item.crecoverspirit")
  end
  if CRecoverSpirit then
    CRecoverSpirit.itemId = self._itemID
    CRecoverSpirit:Send()
  end
  self:Destroy()
end

return SpiritRecoverConfirmDialog


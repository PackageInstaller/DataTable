-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/changecabinnamedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MaxWordCount, MinWordCount = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).CabinName)
local ChangeCabinNameDialog = class("ChangeCabinNameDialog", Dialog)
ChangeCabinNameDialog.AssetBundleName = "ui/layouts.yard"
ChangeCabinNameDialog.AssetName = "HouseChangeName"
ChangeCabinNameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChangeCabinNameDialog
  ((ChangeCabinNameDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

ChangeCabinNameDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MinWordCount, MaxWordCount
  self._name = self:GetChild("Back/InputField")
  self._inputTextNum = self:GetChild("Back/Textnew1")
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._confirmBtn = self:GetChild("Back/ConfirmBtn")
  ;
  (self:GetChild("Back/Txt1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1572, {MinWordCount, MaxWordCount}))
  ;
  (self._name):Subscribe_ValueChangedEvent(self.OnNameUpdate, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self:Init()
end

ChangeCabinNameDialog.OnDestroy = function(self)
  -- function num : 0_2
end

ChangeCabinNameDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._name):SetText(((NekoData.BehaviorManager).BM_Cabin):GetName())
end

ChangeCabinNameDialog.OnNameUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV, MaxWordCount
  local name = (self._name):GetText()
  name = (string.trim)(name)
  self._changeName = name
  local count = (utf8.len)(name)
  if MaxWordCount < count then
    (self._inputTextNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1570, {count, MaxWordCount}))
  else
    ;
    (self._inputTextNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {count, MaxWordCount}))
  end
end

ChangeCabinNameDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

ChangeCabinNameDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local cchangroomName = (LuaNetManager.CreateProtocol)("protocol.yard.cchangroomname")
  if cchangroomName then
    cchangroomName.name = self._changeName
    cchangroomName:Send()
  end
end

return ChangeCabinNameDialog


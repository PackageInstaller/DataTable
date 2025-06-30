-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerchallengingdetailtips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CTowerDungeonType = (BeanManager.GetTableByName)("dungeonselect.ctowerdungeontype")
local cfloorname = (BeanManager.GetTableByName)("dungeonselect.cfloorname")
local TowerChallengingDetailTips = class("TowerChallengingDetailTips", Dialog)
TowerChallengingDetailTips.AssetBundleName = "ui/layouts.mainline"
TowerChallengingDetailTips.AssetName = "TowerDetailChallenge"
TowerChallengingDetailTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerChallengingDetailTips
  ((TowerChallengingDetailTips.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

TowerChallengingDetailTips.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Back/Title")
  self._name = self:GetChild("Back/Text2")
  self._cancelBtn = self:GetChild("Back/CancelButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
end

TowerChallengingDetailTips.OnDestroy = function(self)
  -- function num : 0_2
end

TowerChallengingDetailTips.SetData = function(self, id)
  -- function num : 0_3 , upvalues : CTowerDungeonType, _ENV, cfloorname
  self._id = id
  local record = CTowerDungeonType:GetRecorder(id)
  ;
  (self._title):SetText((TextManager.GetText)(record.nameTextID))
  local floorname = (TextManager.GetText)((cfloorname:GetRecorder(((NekoData.BehaviorManager).BM_Tower):GetDialogFloors())).floorName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID) .. floorname)
end

TowerChallengingDetailTips.OnConfirmBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.cstarttowerexplore")
  if protocol then
    protocol.tower = self._id
    protocol:Send()
  end
  ;
  (DialogManager.DestroySingletonDialog)("tower.towerchallengingdetailtips")
end

TowerChallengingDetailTips.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("tower.towerchallengingdetailtips")
end

return TowerChallengingDetailTips


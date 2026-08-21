-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/booklistcharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCardRoleConfig_HandBook = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local BookListCharCell = class("BookListCharCell", Dialog)
BookListCharCell.AssetBundleName = "ui/layouts.tujiannew"
BookListCharCell.AssetName = "BookListCharCell"
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
BookListCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BookListCharCell
  ((BookListCharCell.super).Ctor)(self, ...)
  self._lock = true
  self._id = nil
end

BookListCharCell.OnCreate = function(self)
  -- function num : 0_1
  self._jobIcon = self:GetChild("Cell/Job")
  self._rankIcon = self:GetChild("Cell/Rank")
  self._rankIconBack = self:GetChild("Cell/RankBack")
  self._photo = self:GetChild("Cell/Photo")
  self._frame = self:GetChild("Cell/Frame")
  self._lockIcon = self:GetChild("Cell/Lock")
  self._element = self:GetChild("Cell/Element")
  self._handbookNumber = self:GetChild("Cell/SortText")
  ;
  (self._rankIcon):SetActive(false)
  ;
  (self._rankIconBack):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BookListCharCell.OnDestroy = function(self)
  -- function num : 0_2
end

BookListCharCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCardRoleConfig_HandBook, _ENV
  local handbookNumber = (CCardRoleConfig_HandBook:GetRecorder(data:GetId())).sortText
  ;
  (self._handbookNumber):SetText(handbookNumber)
  local spriteRecord = data:GetVocationImageRecord()
  ;
  (self._jobIcon):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetShapeLittleHeadImageRecord()
  ;
  (self._photo):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetSmallRarityFrameRecord()
  ;
  (self._frame):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  spriteRecord = data:GetElementImageRecord()
  ;
  (self._element):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._id = data:GetId()
  self._lock = not ((NekoData.BehaviorManager).BM_AllRoles):GetRoleIsUnlock(self._id)
  ;
  (self._lockIcon):SetActive(self._lock)
end

BookListCharCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._lock then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("handbook.roledetailinfodialog")
  if dialog then
    dialog:Refresh(self._id)
  end
end

return BookListCharCell


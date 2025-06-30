-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/booklistnpccell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BookListNPCCell = class("BookListNPCCell", Dialog)
BookListNPCCell.AssetBundleName = "ui/layouts.tujiannew"
BookListNPCCell.AssetName = "BookListNPCCell"
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
BookListNPCCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BookListNPCCell
  ((BookListNPCCell.super).Ctor)(self, ...)
  self._lock = true
  self._id = nil
end

BookListNPCCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Num")
  self._photo = self:GetChild("Normal/NPC")
  self._lockIcon = self:GetChild("Lock")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BookListNPCCell.OnDestroy = function(self)
  -- function num : 0_2
end

BookListNPCCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePath, _ENV, HandBookTypeEnum
  if not CImagePath:GetRecorder(data.imageID) then
    local spriteRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._photo):SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  self._id = data.id
  self._lock = not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(self._id, HandBookTypeEnum.NPC)
  ;
  (self._lockIcon):SetActive(self._lock)
  if self._lock then
    (self._name):SetText("-")
  else
    ;
    (self._name):SetText((TextManager.GetText)(data.nameTextId))
  end
end

BookListNPCCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._lock then
    return 
  end
  local dialog = (DialogManager.CreateSingletonDialog)("handbook.npcdetailinfodialog")
  if dialog then
    dialog:Refresh(self._id)
  end
end

return BookListNPCCell


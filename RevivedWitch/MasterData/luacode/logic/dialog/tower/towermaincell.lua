-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towermaincell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CTowerDungeonType = (BeanManager.GetTableByName)("dungeonselect.ctowerdungeontype")
local TowerMainCell = class("TowerMainCell", Dialog)
TowerMainCell.AssetBundleName = "ui/layouts.mainline"
TowerMainCell.AssetName = "towermaincell"
TowerMainCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerMainCell
  ((TowerMainCell.super).Ctor)(self, ...)
end

TowerMainCell.OnCreate = function(self)
  -- function num : 0_1
  self._normalBoard = self:GetChild("Normal")
  self._img = self:GetChild("Normal/Img")
  self._name = self:GetChild("Normal/Title")
  self._battlePower = self:GetChild("Normal/Txt2")
  self._star = self:GetChild("Normal/Star")
  self._blackBoard = self:GetChild("Normal/Black")
  self._lockBoard = self:GetChild("Lock")
  self._lockTxt = self:GetChild("Lock/Txt")
  self._lockImage = self:GetChild("Lock/ImgGrey")
  self._changeBoard = self:GetChild("Challenge")
  self._changeTxt = self:GetChild("Challenge/Txt")
  self._click = self:GetChild("Click")
  ;
  (self._click):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

TowerMainCell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerMainCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CTowerDungeonType, _ENV, CImagePathTable
  self._data = data
  local record = CTowerDungeonType:GetRecorder(data.id)
  if record then
    (self._battlePower):SetText(record.recommendStrength)
    ;
    (self._name):SetText((TextManager.GetText)(record.nameTextID))
    ;
    (self._changeBoard):SetActive((data.islock ~= 0 and data.ischallenging))
    if data.islock == 0 then
      (self._normalBoard):SetActive(false)
    else
      (self._normalBoard):SetActive(true)
      if (self._delegate)._challengingID == 0 then
        (self._blackBoard):SetActive(false)
      else
        (self._blackBoard):SetActive(not data.ischallenging)
      end
    end
    if not CImagePathTable:GetRecorder(record.image) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._lockImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._blackBoard):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._lockBoard):SetActive(data.islock == 0)
    ;
    (self._star):SetText(record.star)
    ;
    (self._lockTxt):SetText((TextManager.GetText)(record.unlockdescribeTextID))
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

TowerMainCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).islock == 0 then
    return 
  end
  if (self._delegate)._challengingID ~= 0 and not (self._data).ischallenging then
    return 
  end
  if (self._data).ischallenging then
    ((DialogManager.CreateSingletonDialog)("tower.towerchallengingdetailtips")):SetData((self._data).id)
  else
    ;
    ((DialogManager.CreateSingletonDialog)("tower.towerchallengedetailtips")):SetData((self._data).id)
  end
end

return TowerMainCell


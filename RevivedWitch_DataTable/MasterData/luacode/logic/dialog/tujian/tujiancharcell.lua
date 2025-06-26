-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local TuJianCharCell = class("TuJianCharCell", Dialog)
TuJianCharCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharCell.AssetName = "TuJianCharCell"
TuJianCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharCell
  ((TuJianCharCell.super).Ctor)(self, ...)
end

TuJianCharCell.OnCreate = function(self)
  -- function num : 0_1
  self._unlockedBack = self:GetChild("BackUnLocked")
  self._lockedBack = self:GetChild("BackLocked")
  self._photo = self:GetChild("Mask/Photo")
  self._rank = self:GetChild("Rank")
  self._job = self:GetChild("Job")
  self._title = self:GetChild("Title")
  self._name = self:GetChild("Name")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

TuJianCharCell.OnDestroy = function(self)
  -- function num : 0_2
end

TuJianCharCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CRoleConfigTable, CImagePathTable, CNpcShapeTable, _ENV, CRoleRarityCfgTable, CVocationCfgTable
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  if not CImagePathTable:GetRecorder((CNpcShapeTable:GetRecorder(roleConfig.shapeID)).bustID) then
    local record = DataCommon.DefaultImageAsset
  end
  ;
  (self._photo):SetSprite(record.assetBundle, record.assetName)
  if data.id ~= 1 then
    (self._rank):SetActive(true)
    if not CImagePathTable:GetRecorder((CRoleRarityCfgTable:GetRecorder(roleConfig.rarity)).imgid) then
      record = DataCommon.DefaultImageAsset
    end
    ;
    (self._rank):SetSprite(record.assetBundle, record.assetName)
  else
    ;
    (self._rank):SetActive(false)
  end
  if roleConfig.rarity == 1 then
    if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgR) then
      record = DataCommon.DefaultImageAsset
      if roleConfig.rarity == 2 then
        if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgSR) then
          record = DataCommon.DefaultImageAsset
          if roleConfig.rarity == 3 then
            if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgSSR) then
              record = DataCommon.DefaultImageAsset
              if roleConfig.rarity == 4 then
                if not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgUR) then
                  record = DataCommon.DefaultImageAsset
                  if roleConfig.rarity == 5 and not CImagePathTable:GetRecorder((CVocationCfgTable:GetRecorder(roleConfig.vocation)).imgEX) then
                    record = DataCommon.DefaultImageAsset
                  end
                  ;
                  (self._job):SetSprite(record.assetBundle, record.assetName)
                  ;
                  (self._title):SetText(tostring((TextManager.GetText)(roleConfig.titleTextID)))
                  local name = (TextManager.GetText)(roleConfig.nameTextID)
                  ;
                  (self._name):SetText(tostring((string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)))
                  if data.own then
                    (self._lockedBack):SetActive(false)
                    ;
                    (self._unlockedBack):SetActive(true)
                  else
                    ;
                    (self._lockedBack):SetActive(true)
                    ;
                    (self._unlockedBack):SetActive(false)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

TuJianCharCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("tujian.tujiancharacterinfodialog")):Refresh(self._cellData)
end

TuJianCharCell.OnBackPressed = function(self)
  -- function num : 0_5
  self:Destroy()
  return true, true
end

return TuJianCharCell


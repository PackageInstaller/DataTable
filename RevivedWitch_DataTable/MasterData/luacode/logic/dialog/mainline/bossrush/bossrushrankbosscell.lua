-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossrushrankbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BossRushRankBossCell = class("BossRushRankBossCell", Dialog)
BossRushRankBossCell.AssetBundleName = "ui/layouts.mainline"
BossRushRankBossCell.AssetName = "BossRushRankBossCell"
local TableFrame = require("framework.ui.frame.table.tableframe")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
BossRushRankBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossRushRankBossCell
  ((BossRushRankBossCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

BossRushRankBossCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Boss")
  self._name = self:GetChild("Text")
  self._select = self:GetChild("Select")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BossRushRankBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

BossRushRankBossCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : cimagepath
  local image = cimagepath:GetRecorder((self._cellData).image)
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._name):SetText((self._cellData).name)
  ;
  (self._select):SetActive((self._cellData).id == (self._delegate)._selectBossRushId)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BossRushRankBossCell.OnCellClicked = function(self)
  -- function num : 0_4
  if not self._cellData then
    return 
  end
  ;
  (self._delegate):OnSelectBossCell(self._cellData)
end

BossRushRankBossCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._cellData and eventName == "ChooseBossRush" then
    if (self._cellData).id == arg then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return BossRushRankBossCell


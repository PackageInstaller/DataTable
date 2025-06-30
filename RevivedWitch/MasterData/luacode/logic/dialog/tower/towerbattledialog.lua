-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerbattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TowerBattleDialog = class("TowerBattleDialog", Dialog)
TowerBattleDialog.AssetBundleName = "ui/layouts.mainline"
TowerBattleDialog.AssetName = "TowerEventBattle"
TowerBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerBattleDialog
  ((TowerBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

TowerBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._confirmTxt = self:GetChild("Back/Text3")
  self._monsterArea = self:GetChild("MonsterFrame")
  self._monsterFrame = (TableFrame.Create)(self._monsterArea, self, false, false)
  self._itemArea = self:GetChild("ItemFrame")
  self._itemFrame = (TableFrame.Create)(self._itemArea, self, false, false)
  self._goBtn = self:GetChild("GoBtn")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._back = self:GetChild("BackBtn")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

TowerBattleDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._monsterFrame):Destroy()
  ;
  (self._itemFrame):Destroy()
end

local mid = function(helper, frame)
  -- function num : 0_3
  local length = helper:GetTotalLength()
  frame:SetXPosition(0.5, -length / 2)
end

TowerBattleDialog.SetData = function(self, index, data)
  -- function num : 0_4 , upvalues : mid
  self._index = index
  self._data = data
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._monsterFrame):ReloadAllCell()
  mid(self._itemFrame, self._itemArea)
  mid(self._monsterFrame, self._monsterArea)
end

TowerBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if frame == self._monsterFrame then
    return #self._data
  else
    return #(self._data).awards
  end
end

TowerBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemFrame then
    return "tower.towerchallengedetailcell"
  else
    return "tower.towerbattlemonstercell"
  end
end

TowerBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._monsterFrame then
    return (self._data)[index]
  else
    return {id = (((self._data).awards)[index]):GetID()}
  end
end

TowerBattleDialog.OnGoBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("teamedit.teameditprewardialog")
  if dialog then
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller then
      controller:Freeze()
    end
    ;
    (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
    -- function num : 0_8_0 , upvalues : dialog, _ENV
    if (notification.userInfo)._dialogKey == dialog._dialogKey then
      local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
      if controller then
        controller:Thaw()
      end
      ;
      (DialogManager.DestroySingletonDialog)("tower.towerbattledialog")
    end
  end
, Common.n_DialogWillDestroy, nil)
    dialog:GoTowerBattle(self._index)
  end
end

TowerBattleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("tower.towerbattledialog")
end

return TowerBattleDialog


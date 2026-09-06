local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TowerBattleDialog = class("TowerBattleDialog", Dialog)
TowerBattleDialog.AssetBundleName = "ui/layouts.mainline"
TowerBattleDialog.AssetName = "TowerEventBattle"

function TowerBattleDialog:Ctor(...)
  TowerBattleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function TowerBattleDialog:OnCreate()
  self._title = self:GetChild("TitleBack/Title")
  self._name = self:GetChild("Title")
  self._confirmTxt = self:GetChild("Back/Text3")
  self._monsterArea = self:GetChild("MonsterFrame")
  self._monsterFrame = TableFrame.Create(self._monsterArea, self, false, false)
  self._itemArea = self:GetChild("ItemFrame")
  self._itemFrame = TableFrame.Create(self._itemArea, self, false, false)
  self._goBtn = self:GetChild("GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._back = self:GetChild("BackBtn")
  self._back:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function TowerBattleDialog:OnDestroy()
  self._monsterFrame:Destroy()
  self._itemFrame:Destroy()
end

local function mid(helper, frame)
  local length = helper:GetTotalLength()
  frame:SetXPosition(0.5, -length / 2)
end

function TowerBattleDialog:SetData(index, data)
  self._index = index
  self._data = data
  self._itemFrame:ReloadAllCell()
  self._monsterFrame:ReloadAllCell()
  mid(self._itemFrame, self._itemArea)
  mid(self._monsterFrame, self._monsterArea)
end

function TowerBattleDialog:NumberOfCell(frame)
  if frame == self._monsterFrame then
    return #self._data
  else
    return #self._data.awards
  end
end

function TowerBattleDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "tower.towerchallengedetailcell"
  else
    return "tower.towerbattlemonstercell"
  end
end

function TowerBattleDialog:DataAtIndex(frame, index)
  if frame == self._monsterFrame then
    return self._data[index]
  else
    return {
      id = self._data.awards[index]:GetID()
    }
  end
end

function TowerBattleDialog:OnGoBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("teamedit.teameditprewardialog")
  if dialog then
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller then
      controller:Freeze()
    end
    LuaNotificationCenter.AddObserver(self, function(observer, notification)
      if notification.userInfo._dialogKey == dialog._dialogKey then
        local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
        if controller then
          controller:Thaw()
        end
        DialogManager.DestroySingletonDialog("tower.towerbattledialog")
      end
    end, Common.n_DialogWillDestroy, nil)
    dialog:GoTowerBattle(self._index)
  end
end

function TowerBattleDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("tower.towerbattledialog")
end

return TowerBattleDialog

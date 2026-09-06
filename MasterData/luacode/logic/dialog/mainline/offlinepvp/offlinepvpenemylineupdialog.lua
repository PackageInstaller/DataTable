local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local OffLinePvpEnemyLineupDialog = class("OffLinePvpEnemyLineupDialog", Dialog)
OffLinePvpEnemyLineupDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePvpEnemyLineupDialog.AssetName = "OffLinePVPEnemy"
local TableFrame = require("framework.ui.frame.table.tableframe")

function OffLinePvpEnemyLineupDialog:Ctor(...)
  OffLinePvpEnemyLineupDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
end

function OffLinePvpEnemyLineupDialog:OnCreate()
  self._name = self:GetChild("TeamBack/TeamName/Name")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._frame = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._helper = TableFrame.Create(self._frame, self, false, false, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

function OffLinePvpEnemyLineupDialog:OnDestroy()
  self._helper:Destroy()
end

function OffLinePvpEnemyLineupDialog:InitDataInfo(data)
  self._data = data
  self._name:SetText(data.enemyUserData.userName)
  self._roleList = {}
  for index = 1, 3 do
    local v = data.enemyRoleList[index]
    if v then
      local info = {}
      info.index = index
      info.roleId = data.enemyRoleList[index].id
      info.level = data.enemyRoleList[index].lv
      info.breakLv = data.enemyRoleList[index].breakLv
      info.userId = data.enemyUserData.userId
      info.userName = data.enemyUserData.userName
      info.skin = data.enemyRoleList[index].skin
      table.insert(self._roleList, info)
    else
      local info = {}
      info.nodata = true
      table.insert(self._roleList, info)
    end
  end
  self._helper:ReloadAllCell()
end

function OffLinePvpEnemyLineupDialog:GetRoleList()
  local temp = {}
  for i, v in pairs(self._data.enemyRoleList) do
    table.insert(temp, v)
  end
  return temp
end

function OffLinePvpEnemyLineupDialog:NumberOfCell(helper)
  return 3
end

function OffLinePvpEnemyLineupDialog:CellAtIndex(helper, index)
  return "mainline.offlinepvp.offlinepvpenemylinecell"
end

function OffLinePvpEnemyLineupDialog:DataAtIndex(helper, index)
  return self._roleList[index]
end

function OffLinePvpEnemyLineupDialog:OnBackBtnClicked()
  self:Destroy()
end

function OffLinePvpEnemyLineupDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return OffLinePvpEnemyLineupDialog

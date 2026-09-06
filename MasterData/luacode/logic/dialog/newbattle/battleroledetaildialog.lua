local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local BattleRoleDetailDialog = class("BattleRoleDetailDialog", Dialog)
BattleRoleDetailDialog.AssetBundleName = "ui/layouts.battlenew"
BattleRoleDetailDialog.AssetName = "BattleDetail2"

function BattleRoleDetailDialog:Ctor(...)
  BattleRoleDetailDialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._frame = nil
  self._name = nil
  self._level = nil
end

function BattleRoleDetailDialog:OnCreate()
  self._name = self:GetChild("Back/Prop/Name")
  self._level = self:GetChild("Back/Prop/LevelNum")
  self._frame = self:GetChild("Back/Prop/Frame")
  self._charBack = self:GetChild("Back/Prop/CharBack")
  self._charPhoto = self:GetChild("Back/Prop/CharBack/Image")
  self._tableFrame = GridFrame.Create(self._frame, self, true, 2, true)
  self._closeBtn = self:GetChild("CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
end

function BattleRoleDetailDialog:OnDestroy()
  self._tableFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleRoleDetailDialog:SetData(battler)
  self._battler = battler
  local nameTextId = self._battler:GetNameTextId()
  if 0 < nameTextId then
    local name = TextManager.GetText(nameTextId)
    self._name:SetText(string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username))
  else
    self._name:SetText("")
  end
  self._level:SetText(self._battler:GetAttribute().level)
  self._dataInfo = {
    10,
    20,
    30,
    50,
    60,
    90,
    100,
    110,
    120,
    130,
    140,
    170,
    180,
    190,
    200,
    210,
    220,
    250,
    260,
    270,
    830,
    1060
  }
  self._attrNameStrInfo = {
    "hp",
    "hpmax",
    "atk",
    "def",
    "mdef",
    "physicalbonus",
    "physicalreduce",
    "magicbonus",
    "magicreduce",
    "physicalcritrate",
    "physicalcritdegree",
    "attackspeed",
    "physicalevasion",
    "physicallifesteal",
    "magiclifesteal",
    "physicalblock",
    "magicblock",
    "physicaldefbreak",
    "magicdefbreak",
    "critrateresistance",
    "critdegreeresistance",
    "damagereduce"
  }
  self._tableFrame:ReloadAllCell()
  self._tableFrame:MoveToTop()
  if battler:IsRole() then
    self._charBack:SetActive(true)
    local tempRole = Role.Create(battler:GetConfigId())
    local record = tempRole:GetSkillHeadImageRecord()
    if record then
      self._charPhoto:SetSprite(record.assetBundle, record.assetName)
    end
  else
    self._charBack:SetActive(false)
  end
end

function BattleRoleDetailDialog:NumberOfCell(frame)
  return #self._dataInfo
end

function BattleRoleDetailDialog:CellAtIndex(frame)
  return "newbattle.battleroledetailcell"
end

function BattleRoleDetailDialog:DataAtIndex(frame, index)
  local data = {}
  local attrId = self._dataInfo[index]
  local name = BeanManager.GetTableByName("role.cattreffectidname"):GetRecorder(attrId).classnameTextID
  name = TextManager.GetText(name)
  data.name = name
  data.num = math.ceil(self._battler:GetAttribute()[self._attrNameStrInfo[index]])
  if attrId == 130 or attrId == 140 or attrId == 270 or attrId == 830 or attrId == 1060 then
    data.num = tostring(data.num // 10) .. "%"
  end
  return data
end

function BattleRoleDetailDialog:OnBattleEnd()
  self:Destroy()
end

function BattleRoleDetailDialog:OnBackBtnClicked()
  self:Destroy()
end

return BattleRoleDetailDialog

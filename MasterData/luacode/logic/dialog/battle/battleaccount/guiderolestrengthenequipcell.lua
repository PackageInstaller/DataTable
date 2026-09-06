local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local GuideRoleStrengthenEquipCell = class("GuideRoleStrengthenEquipCell", Dialog)
GuideRoleStrengthenEquipCell.AssetBundleName = "ui/layouts.battlelose"
GuideRoleStrengthenEquipCell.AssetName = "DefeatGuideEquipCell"

function GuideRoleStrengthenEquipCell:Ctor(...)
  GuideRoleStrengthenEquipCell.super.Ctor(self, ...)
end

function GuideRoleStrengthenEquipCell:OnCreate()
  self._frame = self:GetChild("CharSmallCell/Frame")
  self._photo = self:GetChild("CharSmallCell/Photo")
  self._downRankBack = self:GetChild("CharSmallCell/DownRankBack")
  self._level = self:GetChild("CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("CharSmallCell/RankBack")
  self._rank = self:GetChild("CharSmallCell/Rank")
  self._job = self:GetChild("CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("CharSmallCell/BreakLevel")
  self._element = self:GetChild("CharSmallCell/Element")
  self._grey = self:GetChild("CharSmallCell/Grey")
  self._select = self:GetChild("CharSmallCell/Select")
  self._equipNodes = {
    [EquipTypeEnum.WEAPON] = {},
    [EquipTypeEnum.ARMOR] = {},
    [EquipTypeEnum.JEWELRY] = {}
  }
  for i = 1, 3 do
    local type
    if i == 1 then
      type = EquipTypeEnum.WEAPON
    elseif i == 2 then
      type = EquipTypeEnum.ARMOR
    else
      type = EquipTypeEnum.JEWELRY
    end
    local map = self._equipNodes[type]
    map.index = i
    map.equipCell = self:GetChild("Equip" .. i .. "/EquipCell")
    map.equipCellEmpty = self:GetChild("Equip" .. i .. "/EquipCellEmpty")
    self:GetChild("Equip" .. i .. "/Lock"):SetActive(false)
    map.equipCell_frame = self:GetChild("Equip" .. i .. "/EquipCell/BackGround/Frame")
    map.equipCell_icon = self:GetChild("Equip" .. i .. "/EquipCell/BackGround/Icon")
    map.equipCell_pinJiStat = self:GetChild("Equip" .. i .. "/EquipCell/BackGround/BreakPoint")
    map.equipCell_lv = self:GetChild("Equip" .. i .. "/EquipCell/BackGround/Level/Num")
    map.equipCell_select = self:GetChild("Equip" .. i .. "/EquipCell/BackGround/Select")
    self:GetChild("Equip" .. i):Subscribe_PointerClickEvent(function()
      self:OnEquipClick(type)
    end)
  end
  self._txt = self:GetChild("Txt")
  self._goBtn = self:GetChild("GoBtn")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function GuideRoleStrengthenEquipCell:OnDestroy()
end

function GuideRoleStrengthenEquipCell:RefreshCell(data)
  local str = TextManager.GetText(701097)
  str = string.gsub(str, "%$parameter1%$", self._delegate._selectGuideType.recommendEquipLevel)
  self._txt:SetText(str)
  local image = data.role:GetShapeLittleHeadImageRecord()
  self._photo:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetSmallRarityFrameRecord()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetRarityBottomBackRecord()
  self._downRankBack:SetSprite(image.assetBundle, image.assetName)
  self._level:SetText(data.role:GetShowLv())
  image = data.role:GetRarityImageRecord()
  self._rank:SetSprite(image.assetBundle, image.assetName)
  image = data.role:GetVocationImageRecord()
  self._job:SetSprite(image.assetBundle, image.assetName)
  local breakLv = data.role:GetBreakLv()
  self._breakLevelBackBlack:SetActive(breakLv == 0)
  self._breakLevelBack:SetActive(0 < breakLv)
  self._breakLevelNum:SetActive(0 < breakLv)
  if 0 < breakLv then
    image = data.role:GetCurBreakFrame1ImageRecord()
    self._breakLevelBack:SetSprite(image.assetBundle, image.assetName)
    self._breakLevelNum:SetText(breakLv)
  end
  image = data.role:GetElementImageRecord()
  self._element:SetSprite(image.assetBundle, image.assetName)
  for type, map in pairs(self._equipNodes) do
    local equip = data.equips[type]
    if equip then
      map.equipCell:SetActive(true)
      map.equipCellEmpty:SetActive(false)
      imgRecord = equip:GetPinJiImage()
      map.equipCell_frame:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      imgRecord = equip:GetIcon()
      map.equipCell_icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      map.equipCell_pinJiStat:SetText(equip:GetEquipStarStr())
      map.equipCell_lv:SetText(equip:GetStrengthenLevel())
      map.equipCell_select:SetActive(type == data.selectEquipType)
    else
      map.equipCell:SetActive(false)
      map.equipCellEmpty:SetActive(true)
    end
  end
end

function GuideRoleStrengthenEquipCell:OnEquipClick(type)
  if type ~= self._cellData.selectEquipType and self._cellData.equips[type] then
    self._cellData.selectEquipType = type
    for key, map in pairs(self._equipNodes) do
      local equip = self._cellData.equips[key]
      if equip then
        map.equipCell_select:SetActive(key == type)
      end
    end
  end
end

function GuideRoleStrengthenEquipCell:OnGoBtnClick()
  DialogManager.CreateSingletonDialog("equipforge.equipforgedialog"):Init(self._cellData.equips[self._cellData.selectEquipType]:GetKey())
end

function GuideRoleStrengthenEquipCell:OnEvent(eventName, arg)
  if eventName == "RefreshEquip" then
    for type, map in pairs(self._equipNodes) do
      local equip = self._cellData.equips[type]
      if equip then
        map.equipCell_pinJiStat:SetText(equip:GetEquipStarStr())
        map.equipCell_lv:SetText(equip:GetStrengthenLevel())
      end
    end
  end
end

return GuideRoleStrengthenEquipCell

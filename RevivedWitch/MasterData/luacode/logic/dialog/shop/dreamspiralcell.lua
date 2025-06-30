-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/dreamspiralcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local Role = require("logic.manager.experimental.types.role")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local Collection = (LuaNetManager.CreateBean)("protocol.activity.collection")
local DreamSpiralCell = class("DreamSpiralCell", Dialog)
DreamSpiralCell.AssetBundleName = "ui/layouts.baseshop"
DreamSpiralCell.AssetName = "BattlePassCell"
DreamSpiralCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DreamSpiralCell
  ((DreamSpiralCell.super).Ctor)(self, ...)
end

DreamSpiralCell.OnCreate = function(self)
  -- function num : 0_1
  self._lv = self:GetChild("Panel/LVNum")
  self._lvUnlock = self:GetChild("Panel/LevelBack")
  self._lvLock = self:GetChild("Panel/LevelBackLock")
  self._normal = {item = self:GetChild("Panel/Normal/ItemCell"), get = self:GetChild("Panel/Normal/Get"), lock = self:GetChild("Panel/Normal/Lock"), selected = self:GetChild("Panel/Normal/Select"), reddot = self:GetChild("Panel/Normal/RedDot"), effect = self:GetChild("Panel/Normal/Effect")}
  ;
  ((self._normal).reddot):SetActive(false)
  self._advance = {item = self:GetChild("Panel/Advance/ItemCell"), char = self:GetChild("Panel/Advance/CharCell"), get = self:GetChild("Panel/Advance/Get"), lock = self:GetChild("Panel/Advance/Lock"), selected = self:GetChild("Panel/Advance/Select"), reddot = self:GetChild("Panel/Advance/RedDot"), effect = self:GetChild("Panel/Advance/Effect")}
  ;
  ((self._advance).reddot):SetActive(false)
  local addListener = function(obj, kind)
    -- function num : 0_1_0 , upvalues : self
    local icon = obj:FindChild("_BackGround/Icon")
    icon:Subscribe_PointerClickEvent(function()
      -- function num : 0_1_0_0 , upvalues : self, kind
      self:OnCellClicked(kind)
    end
, self)
  end

  addListener((self._normal).item, 1)
  ;
  ((self._normal).lock):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:OnCellClicked(1)
  end
, self)
  addListener((self._advance).item, 2)
  ;
  ((self._advance).lock):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_2 , upvalues : self
    self:OnCellClicked(2)
  end
, self)
  local frame = ((self._advance).char):FindChild("Frame")
  frame:Subscribe_PointerClickEvent(function()
    -- function num : 0_1_3 , upvalues : self
    self:OnCellClicked(3)
  end
, self)
end

DreamSpiralCell.OnDestroy = function(self)
  -- function num : 0_2
end

DreamSpiralCell.SetItem = function(self, obj, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  if not obj then
    return 
  end
  local frame = obj:FindChild("_BackGround/Frame")
  local icon = obj:FindChild("_BackGround/Icon")
  local choose = obj:FindChild("_BackGround/Select")
  choose:SetActive(false)
  local count = obj:FindChild("_Count")
  local item = (Item.Create)(data.itemId)
  icon:SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
  local imageRecord = item:GetPinJiImage()
  frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  count:SetText((NumberManager.GetShowNumber)(data.itemNum))
end

DreamSpiralCell.SetCharInfo = function(self, obj, data, type)
  -- function num : 0_4
  if not obj then
    return 
  end
  local frame = obj:FindChild("Frame")
  local Photo = obj:FindChild("Photo")
  if type == 27 then
    local img = data:GetSmallRarityBackRecord()
    frame:SetSprite(img.assetBundle, img.assetName)
    img = data:GetShapeLittleHeadImageRecord()
    Photo:SetSprite(img.assetBundle, img.assetName)
  else
    do
      frame:SetSprite((data.quality).assetBundle, (data.quality).assetName)
      local img = data.photo
      Photo:SetSprite(img.assetBundle, img.assetName)
    end
  end
end

local showItemTips = function(obj, itemid)
  -- function num : 0_5 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(itemid)})
    local width, height = obj:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, obj:GetLocalPointInUiRootPanel())
  end
end

local GetReward = function(rewardType, lv)
  -- function num : 0_6 , upvalues : _ENV
  local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.creceivecollection")
  cmd.CollectionType = rewardType
  cmd.level = lv or 1
  cmd:Send()
end

DreamSpiralCell.OnCellClicked = function(self, kind)
  -- function num : 0_7 , upvalues : Collection, GetReward, showItemTips, Item, CRoleItem, _ENV, CSkinItem
  if kind == 1 then
    local common = (self._data).common
    if common.state == Collection.UN_RECEIVE then
      GetReward(1, (self._data).level)
    else
      showItemTips((self._normal).item, common.itemId)
    end
  else
    do
      if kind == 2 or kind == 3 then
        local high = (self._data).high
        if high.state == Collection.UN_RECEIVE then
          GetReward(2, (self._data).level)
        else
          local item = (Item.Create)(high.itemId)
          local itemType = item:GetItemTypeId()
          if itemType == 27 then
            local cfg = CRoleItem:GetRecorder(high.itemId)
            local dlg = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
            dlg:Init({
roleIdList = {cfg.roleid}
, 
cfgIdList = {2}
, index = 1}, 3)
          else
            do
              if itemType == 91 then
                local cfg = CSkinItem:GetRecorder(high.itemId)
                local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
                local data = {}
                ;
                (table.insert)(data, {itemId = cfg.Skinid})
                dlg:SetData((dlg.TargetType).OnlyShow, data)
              else
                do
                  showItemTips((self._normal).item, high.itemId)
                end
              end
            end
          end
        end
      end
    end
  end
end

DreamSpiralCell.RefreshCell = function(self, data)
  -- function num : 0_8 , upvalues : Collection, _ENV, Item, CRoleItem, Role, CSkinItem, CSkin, CImagePathTable, CNpcShapeTable
  self._data = data
  ;
  (self._lv):SetText(data.level)
  local common = data.common
  self:SetItem((self._normal).item, common)
  ;
  ((self._normal).lock):SetActive(common.state == Collection.LOCK)
  ;
  ((self._normal).get):SetActive(common.state == Collection.RECEIVE)
  local show = common.state == Collection.UN_RECEIVE
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

  if show and not (self._normal).effectHandler then
    (self._normal).effectHandler = ((self._normal).effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1126))
  elseif not show and (self._normal).effectHandler then
    ((self._normal).effect):ReleaseEffect((self._normal).effectHandler)
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._normal).effectHandler = nil
  end
  local high = data.high
  local item = (Item.Create)(high.itemId)
  local itemType = item:GetItemTypeId()
  if itemType == 27 then
    ((self._advance).item):SetActive(false)
    ;
    ((self._advance).char):SetActive(true)
    local rec = CRoleItem:GetRecorder(high.itemId)
    local roleId = rec.roleid
    local role = (Role.Create)(roleId)
    self:SetCharInfo((self._advance).char, role, 27)
  elseif itemType == 91 then
    ((self._advance).item):SetActive(false)
    ;
    ((self._advance).char):SetActive(true)
    local skinCfg = CSkinItem:GetRecorder(high.itemId)
    local skin = CSkin:GetRecorder(skinCfg.Skinid)
    local role = (Role.Create)(skin.roleid)
    local quality = role:GetRarityFrameRecord()
    local photo = CImagePathTable:GetRecorder((CNpcShapeTable:GetRecorder(skin.shapeID)).littleHeadID)
    self:SetCharInfo((self._advance).char, {quality = quality, photo = photo}, 91)
  else
    ((self._advance).item):SetActive(true)
    ;
    ((self._advance).char):SetActive(false)
    self:SetItem((self._advance).item, high)
  end
  ;
  ((self._advance).lock):SetActive(high.state == Collection.LOCK)
  ;
  ((self._advance).get):SetActive(high.state == Collection.RECEIVE)
  show = high.state == Collection.UN_RECEIVE
  -- DECOMPILER ERROR at PC199: Confused about usage of register: R7 in 'UnsetPending'

  if show and not (self._advance).effectHandler then
    (self._advance).effectHandler = ((self._advance).effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1126))
  elseif not show and (self._advance).effectHandler then
    ((self._advance).effect):ReleaseEffect((self._advance).effectHandler)
    -- DECOMPILER ERROR at PC214: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._advance).effectHandler = nil
  end
  local unlock = common.state ~= Collection.LOCK and high.state ~= Collection.LOCK
  ;
  (self._lvUnlock):SetActive(unlock)
  ;
  (self._lvLock):SetActive(not unlock)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

DreamSpiralCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_9
  if (eventName ~= "selectNormal" or eventName == "selectHigh") then
  end
end

return DreamSpiralCell


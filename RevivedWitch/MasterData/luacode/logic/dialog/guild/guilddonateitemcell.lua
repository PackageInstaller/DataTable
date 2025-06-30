-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guilddonateitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local GuildDonateItemCell = class("GuildDonateItemCell", Dialog)
GuildDonateItemCell.AssetBundleName = "ui/layouts.guild"
GuildDonateItemCell.AssetName = "GuildDonateItemCell"
GuildDonateItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildDonateItemCell
  ((GuildDonateItemCell.super).Ctor)(self, ...)
end

GuildDonateItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._selectCountBack = self:GetChild("Grey")
  self._selectCountText = self:GetChild("Grey/Text")
  ;
  (self._select):SetActive(false)
  ;
  (self._selectCountBack):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GuildDonateItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GuildDonateItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetNumber((data.item):GetCount())
  ;
  (self._select):SetActive((self._cellData).isSelect)
  if (self._cellData).selectCount == 0 then
    (self._selectCountBack):SetActive(false)
  else
    ;
    (self._selectCountBack):SetActive(true)
    ;
    (self._selectCountText):SetText((self._cellData).selectCount)
  end
end

GuildDonateItemCell.OnCellClicked = function(self, args)
  -- function num : 0_4
  local data = {key = ((self._cellData).item):GetKey(), selectCount = (self._cellData).selectCount, maxCount = ((self._cellData).item):GetCount()}
  ;
  (self._delegate):SetSelectedItemData(data)
end

GuildDonateItemCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if ((self._cellData).item):GetKey() ~= arg then
    do
      local flg = eventName ~= "SetItemSelectedState"
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._cellData).isSelect = flg
      ;
      (self._select):SetActive((self._cellData).isSelect)
      if (self._cellData).isSelect then
        (self._selectCountBack):SetActive(true)
        ;
        (self._selectCountText):SetText((self._cellData).selectCount)
      elseif (self._cellData).selectCount == 0 then
        (self._selectCountBack):SetActive(false)
      end
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

      -- DECOMPILER ERROR at PC51: Unhandled construct in 'MakeBoolean' P1

      if eventName == "ChangeItemSelectCount" and ((self._cellData).item):GetKey() == arg.key then
        (self._cellData).selectCount = arg.count
        ;
        (self._selectCountText):SetText((self._cellData).selectCount)
      end
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

      if eventName == "ClearSelectData" then
        (self._cellData).selectCount = 0
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self._cellData).isSelect = false
        ;
        (self._select):SetActive(false)
        ;
        (self._selectCountBack):SetActive(false)
      end
      -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end
  end
end

return GuildDonateItemCell


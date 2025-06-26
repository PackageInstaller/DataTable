-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonconquestcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local DungeonConquestCell = class("DungeonConquestCell", Dialog)
DungeonConquestCell.AssetBundleName = "ui/layouts.dungeon"
DungeonConquestCell.AssetName = "DungeonTrophiesCell"
local Way = {BOX = 1, BATTLE = 2, TASK = 3, GROUND = 4}
DungeonConquestCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonConquestCell
  ((DungeonConquestCell.super).Ctor)(self, ...)
end

DungeonConquestCell.OnCreate = function(self)
  -- function num : 0_1
  self._iconPanel = self:GetChild("ItemCell")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemNum")
  self._getWay = self:GetChild("Text")
  self._name = self:GetChild("ItemName")
  self._cross = self:GetChild("Txt")
  self._leftBracket = self:GetChild("ItemNameLeft")
  self._rightBracket = self:GetChild("ItemNameRight")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._leftBracketTxt = (self._leftBracket):GetText()
  self._rightBracketTxt = (self._rightBracket):GetText()
end

DungeonConquestCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonConquestCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, CStringRes, _ENV, Way, CWordColor
  self._item = (Item.Create)(data.id)
  if (self._item):GetItemAttr() then
    local imageRecord = (self._item):GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = (self._item):GetPinJiImage()
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local str = (CStringRes:GetRecorder(1115)).msgTextID
    str = (TextManager.GetText)(str)
    local pinjiId = (self._item):GetPinJiID()
    if data.way == Way.TASK then
      str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(4)).wordcolor)
    else
      if pinjiId == 3 then
        str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(1)).wordcolor)
      else
        if pinjiId == 2 then
          str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(2)).wordcolor)
        else
          if pinjiId == 1 then
            str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(3)).wordcolor)
          else
            if pinjiId == 5 then
              str = (string.gsub)(str, "%$parameter1%$", (CWordColor:GetRecorder(7)).wordcolor)
            end
          end
        end
      end
    end
    local strShow = (string.gsub)(str, "%$parameter2%$", (self._item):GetName())
    ;
    (self._name):SetText((self._item):GetName())
    local width2 = (self._leftBracket):GetPreferredSize()
    local width3 = (self._name):GetPreferredSize()
    local width4 = (self._rightBracket):GetPreferredSize()
    ;
    (self._name):SetText(strShow)
    strShow = (string.gsub)(str, "%$parameter2%$", self._leftBracketTxt)
    ;
    (self._leftBracket):SetText(strShow)
    strShow = (string.gsub)(str, "%$parameter2%$", self._rightBracketTxt)
    ;
    (self._rightBracket):SetText(strShow)
    ;
    (self._count):SetText(tostring(data.num))
    str = ""
    if data.way == Way.BOX then
      str = (CStringRes:GetRecorder(1117)).msgTextID
      str = (TextManager.GetText)(str)
    else
      if data.way == Way.BATTLE then
        str = (CStringRes:GetRecorder(1116)).msgTextID
        str = (TextManager.GetText)(str)
      else
        if data.way == Way.TASK then
          str = (CStringRes:GetRecorder(1118)).msgTextID
          str = (TextManager.GetText)(str)
        else
          if data.way == Way.GROUND then
            str = (CStringRes:GetRecorder(1119)).msgTextID
            str = (TextManager.GetText)(str)
          end
        end
      end
    end
    ;
    (self._getWay):SetText(str)
    local width1 = (self._getWay):GetPreferredSize()
    local width5 = (self._cross):GetPreferredSize()
    local width6 = (self._count):GetPreferredSize()
    local iconRectX = (self._iconPanel):GetRectSize()
    local posX1, posOX1, posY1, posOY1 = (self._getWay):GetPosition()
    local sizeX1, sizeOX1, sizeY1, sizeOY1 = (self._getWay):GetSize()
    ;
    (self._getWay):SetPosition(0, iconRectX, posY1, posOY1)
    ;
    (self._getWay):SetSize(0, width1, sizeY1, sizeOY1)
    local posX2, posOX2, posY2, posOY2 = (self._leftBracket):GetPosition()
    local sizeX2, sizeOX2, sizeY2, sizeOY2 = (self._leftBracket):GetSize()
    ;
    (self._leftBracket):SetPosition(0, iconRectX + width1, posY2, posOY2)
    ;
    (self._leftBracket):SetSize(0, width2, sizeY2, sizeOY2)
    local posX3, posOX3, posY3, posOY3 = (self._name):GetPosition()
    local sizeX3, sizeOX3, sizeY3, sizeOY3 = (self._name):GetSize()
    ;
    (self._name):SetPosition(0, iconRectX + width1 + width2, posY3, posOY3)
    ;
    (self._name):SetSize(0, width3, sizeY3, sizeOY3)
    local posX4, posOX4, posY4, posOY4 = (self._rightBracket):GetPosition()
    local sizeX4, sizeOX4, sizeY4, sizeOY4 = (self._rightBracket):GetSize()
    ;
    (self._rightBracket):SetPosition(0, iconRectX + width1 + width2 + width3, posY4, posOY4)
    ;
    (self._rightBracket):SetSize(0, width4, sizeY4, sizeOY4)
    local posX5, posOX5, posY5, posOY5 = (self._cross):GetPosition()
    local sizeX5, sizeOX5, sizeY5, sizeOY5 = (self._cross):GetSize()
    ;
    (self._cross):SetPosition(0, iconRectX + width1 + width2 + width3 + width4, posY5, posOY5)
    ;
    (self._cross):SetSize(0, width5, sizeY5, sizeOY5)
    local posX6, posOX6, posY6, posOY6 = (self._count):GetPosition()
    local sizeX6, sizeOX6, sizeY6, sizeOY6 = (self._count):GetSize()
    ;
    (self._count):SetPosition(0, iconRectX + width1 + width2 + width3 + width4 + width5, posY6, posOY6)
    ;
    (self._count):SetSize(0, width6, sizeY6, sizeOY6)
  end
end

DungeonConquestCell.OnCellClicked = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  if not self._item then
    return 
  end
  local tipsDialog = nil
  if (self._item):GetItemType() == ItemTypeEnum.EQUIP then
    tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:Init((self._cellData).key)
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._item})
    end
  end
end

return DungeonConquestCell


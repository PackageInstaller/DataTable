-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/seasonpvp/seasonpvpthemetips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CArenaLoopReward = (BeanManager.GetTableByName)("dungeonselect.carenaloopreward")
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
local UIRootPanelOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
local SeasonPvpThemeTips = class("SeasonPvpThemeTips", Dialog)
SeasonPvpThemeTips.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpThemeTips.AssetName = "SeasonPVPThemeTips"
SeasonPvpThemeTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SeasonPvpThemeTips
  ((SeasonPvpThemeTips.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SeasonPvpThemeTips.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, SeasonPvpThemeTips
  self._title = self:GetChild("Back/Title")
  ;
  (self._title):SetText("")
  self._tips = self:GetChild("Back/Txt2")
  ;
  (self._tips):SetText("")
  self._width = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, SeasonPvpThemeTips.HandleBattleStart, Common.n_BattleStart, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

SeasonPvpThemeTips.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SeasonPvpThemeTips.HandleBattleStart = function(self)
  -- function num : 0_3
  self:Destroy()
end

SeasonPvpThemeTips.OnDialogClicked = function(self, args)
  -- function num : 0_4
  self:Destroy()
end

SeasonPvpThemeTips.Init = function(self, TopicRecorder)
  -- function num : 0_5 , upvalues : _ENV
  (self._title):SetText((TextManager.GetText)(TopicRecorder.topicName))
  ;
  (self._tips):SetText((TextManager.GetText)(TopicRecorder.topicTips))
end

local SetTipsPosition = function(self, cell_width, cell_height, posX, posY)
  -- function num : 0_6 , upvalues : UIRootOffsetMax, UIRootPanelOffsetMax
  local newPos = {}
  local rightSpaceWidth = UIRootOffsetMax.x - (posX + cell_width / 2)
  if self._width < rightSpaceWidth then
    newPos.x = posX + cell_width / 2 + self._width / 2
  else
    newPos.x = posX - cell_width / 2 - self._width / 2
  end
  if posY + cell_height / 2 - self._height < -UIRootPanelOffsetMax.y then
    newPos.y = -UIRootPanelOffsetMax.y + self._height / 2
  else
    newPos.y = posY + cell_height / 2 - self._height / 2
  end
  ;
  (self:GetRootWindow()):SetAnchoredPosition(newPos.x, newPos.y)
end

SeasonPvpThemeTips.OnUpdate = function(self)
  -- function num : 0_7 , upvalues : UIRootOffsetMax, UIManager, SetTipsPosition
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width = (self:GetRootWindow()):GetRectSize()
    UIRootOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
    if self._parmFunc then
      local parms = (self._parmFunc)()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

SeasonPvpThemeTips.SetTipsParmFunc = function(self, parmFunc)
  -- function num : 0_8 , upvalues : SetTipsPosition
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

SeasonPvpThemeTips.OnScreenPixelChanged = function(self)
  -- function num : 0_9
  self._screenPixelChanged = true
end

return SeasonPvpThemeTips


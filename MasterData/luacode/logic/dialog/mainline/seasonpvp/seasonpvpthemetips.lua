local CArenaLoopReward = BeanManager.GetTableByName("dungeonselect.carenaloopreward")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local UIRootPanelOffsetMax = UIManager.GetUiRootPanelOffsetMax()
local SeasonPvpThemeTips = class("SeasonPvpThemeTips", Dialog)
SeasonPvpThemeTips.AssetBundleName = "ui/layouts.seasonpvp"
SeasonPvpThemeTips.AssetName = "SeasonPVPThemeTips"

function SeasonPvpThemeTips:Ctor(...)
  SeasonPvpThemeTips.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SeasonPvpThemeTips:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._title:SetText("")
  self._tips = self:GetChild("Back/Txt2")
  self._tips:SetText("")
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, SeasonPvpThemeTips.HandleBattleStart, Common.n_BattleStart, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

function SeasonPvpThemeTips:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SeasonPvpThemeTips:HandleBattleStart()
  self:Destroy()
end

function SeasonPvpThemeTips:OnDialogClicked(args)
  self:Destroy()
end

function SeasonPvpThemeTips:Init(TopicRecorder)
  self._title:SetText(TextManager.GetText(TopicRecorder.topicName))
  self._tips:SetText(TextManager.GetText(TopicRecorder.topicTips))
end

local function SetTipsPosition(self, cell_width, cell_height, posX, posY)
  local newPos = {}
  local rightSpaceWidth = UIRootOffsetMax.x - (posX + cell_width / 2)
  if rightSpaceWidth > self._width then
    newPos.x = posX + cell_width / 2 + self._width / 2
  else
    newPos.x = posX - cell_width / 2 - self._width / 2
  end
  if posY + cell_height / 2 - self._height < -UIRootPanelOffsetMax.y then
    newPos.y = -UIRootPanelOffsetMax.y + self._height / 2
  else
    newPos.y = posY + cell_height / 2 - self._height / 2
  end
  self:GetRootWindow():SetAnchoredPosition(newPos.x, newPos.y)
end

function SeasonPvpThemeTips:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width, self._height = self:GetRootWindow():GetRectSize()
    UIRootOffsetMax = UIManager.GetUiRootPanelOffsetMax()
    if self._parmFunc then
      local parms = self._parmFunc()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

function SeasonPvpThemeTips:SetTipsParmFunc(parmFunc)
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

function SeasonPvpThemeTips:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

return SeasonPvpThemeTips

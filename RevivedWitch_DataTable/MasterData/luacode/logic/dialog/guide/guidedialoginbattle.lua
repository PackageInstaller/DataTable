-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/guidedialoginbattle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasGroupStaticFunction = ((CS.PixelNeko).Lua).CanvasGroupStaticFunction
local GuideDialog = require("logic.dialog.guide.guidedialog")
local GuideDialogInBattle = class("GuideDialogInBattle", GuideDialog)
GuideDialogInBattle.OnDestroy = function(self)
  -- function num : 0_0 , upvalues : GuideDialogInBattle, _ENV
  ((GuideDialogInBattle.super).OnDestroy)(self)
  ;
  ((NekoData.DataManager).DM_TimeScale):CancelBattleGuidePause()
end

GuideDialogInBattle.SetEmptyPoint = function(self, blackPanelParmFunc)
  -- function num : 0_1
  self._blackPanelParmFunc = blackPanelParmFunc
  if self._blackPanelParmFunc then
    local blackPanelParm = blackPanelParmFunc()
    ;
    (self._blackPanel):SetActive(true)
    self:SetGuidePoint(blackPanelParm.width, blackPanelParm.height, blackPanelParm.posX, blackPanelParm.posY)
    ;
    (self._leftUpPanel):SetAlpha(self._blackAlpha)
    ;
    (self._leftDownPanel):SetAlpha(self._blackAlpha)
    ;
    (self._rightUpPanel):SetAlpha(self._blackAlpha)
    ;
    (self._righDownPanel):SetAlpha(self._blackAlpha)
  else
    do
      ;
      (self._blackPanel):SetActive(false)
      ;
      (self._emptyPanel):SetActive(false)
    end
  end
end

return GuideDialogInBattle


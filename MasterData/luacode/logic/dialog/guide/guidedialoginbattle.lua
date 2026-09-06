local CanvasGroupStaticFunction = CS.PixelNeko.Lua.CanvasGroupStaticFunction
local GuideDialog = require("logic.dialog.guide.guidedialog")
local GuideDialogInBattle = class("GuideDialogInBattle", GuideDialog)

function GuideDialogInBattle:OnDestroy()
  GuideDialogInBattle.super.OnDestroy(self)
  NekoData.DataManager.DM_TimeScale:CancelBattleGuidePause()
end

function GuideDialogInBattle:SetEmptyPoint(blackPanelParmFunc)
  self._blackPanelParmFunc = blackPanelParmFunc
  if self._blackPanelParmFunc then
    local blackPanelParm = blackPanelParmFunc()
    self._blackPanel:SetActive(true)
    self:SetGuidePoint(blackPanelParm.width, blackPanelParm.height, blackPanelParm.posX, blackPanelParm.posY)
    self._leftUpPanel:SetAlpha(self._blackAlpha)
    self._leftDownPanel:SetAlpha(self._blackAlpha)
    self._rightUpPanel:SetAlpha(self._blackAlpha)
    self._righDownPanel:SetAlpha(self._blackAlpha)
  else
    self._blackPanel:SetActive(false)
    self._emptyPanel:SetActive(false)
  end
end

return GuideDialogInBattle

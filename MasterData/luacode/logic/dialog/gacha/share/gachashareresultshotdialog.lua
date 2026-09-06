local GachaShareResultShotDialog = class("GachaShareResultShotDialog", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local cimagepath = BeanManager.GetTableByName("ui.cimagepath")
GachaShareResultShotDialog.AssetBundleName = "ui/layouts.share"
GachaShareResultShotDialog.AssetName = "GachaShareTenShot"

function GachaShareResultShotDialog:Ctor(...)
  GachaShareResultShotDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GachaShareResultShotDialog:OnCreate()
  self._cellPanel = self:GetChild("Panel/CellPanel")
  self._cellPanelTwo = self:GetChild("Panel/CellPanel2")
  self._frame = GridFrame.Create(self._cellPanel, self, true, 5, false)
end

function GachaShareResultShotDialog:OnDestroy()
  self._frame:Destroy()
  if self._frameTwo then
    self._frameTwo:Destroy()
    self._frameTwo = nil
  end
  if self._timer then
    GameTimer.RemoveTask(self._timer)
  end
end

function GachaShareResultShotDialog:SetData(cardList)
  self._list = cardList
  self:Refresh()
  self._timer = GameTimer.AddTask(1, 0, function()
    self._timer = nil
    self:OnShareClick()
  end)
end

function GachaShareResultShotDialog:Refresh()
  self._roleList = {}
  self._haveURRole = false
  for k, v in pairs(self._list) do
    local role = Role.Create(v.cardId)
    table.insert(self._roleList, {
      role = role,
      keyTag = k,
      isNew = v.isNew == 1
    })
    if not self._haveURRole and role and role:GetRarityId() == 4 then
      self._haveURRole = true
    end
  end
  self._frame:ReloadAllCell()
  if self._list then
    if #self._list <= 5 then
      local width, height = self._cellPanel:GetRectSize()
      local cellPanelWidth = width / 5 * #self._list
      local cellPanelHeight = self._frame:GetTotalLength()
      self._cellPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
      local rootWindowAnchoredx, rootWindowAnchoredy = self:GetRootWindow():GetAnchoredPosition()
      self._cellPanel:SetAnchoredPosition(rootWindowAnchoredx, 45)
      self._frame:ReloadAllCell()
    else
      if self._frameTwo then
        self._frameTwo:Destroy()
        self._frameTwo = nil
      end
      self._frameTwo = GridFrame.Create(self._cellPanelTwo, self, true, 5, false)
      self._frameTwo:ReloadAllCell()
    end
  end
end

function GachaShareResultShotDialog:OnShareClick(args)
  self._runner = self:GetRootWindow():GetUIObject():AddComponent(typeof(CS.PixelNeko.Tools.ScreenShot))
  self._runner:StartCoroutine(xLuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    local texture = CS.UnityEngine.ScreenCapture.CaptureScreenshotAsTexture()
    self._timer = GameTimer.AddTask(0.2, 0, function()
      DialogManager.CreateSingletonDialog("gacha.share.gachashareresultdialog"):SetData(self._list, texture)
      DialogManager.DestroySingletonDialog("gacha.share.gachashareresultshotdialog")
      self._timer = nil
    end)
  end))
end

function GachaShareResultShotDialog:NumberOfCell(frame, index)
  if frame == self._frame then
    return math.min(#self._roleList, 5)
  else
    return #self._roleList - 5
  end
end

function GachaShareResultShotDialog:CellAtIndex(frame, index)
  if frame == self._frame then
    if self._roleList[index].role:GetRarityId() == 3 then
      return "gacha.firstlevelcardcell"
    elseif self._roleList[index].role:GetRarityId() == 2 then
      return "gacha.secondlevelcardcell"
    elseif self._roleList[index].role:GetRarityId() == 1 then
      return "gacha.thirdlevelcardcell"
    elseif self._roleList[index].role:GetRarityId() == 4 then
      return "gacha.urlevelcardcell"
    elseif self._roleList[index].role:GetRarityId() == 5 then
      return "gacha.exlevelcardcell"
    else
      LogError("角色品级不是1，2，3, 4, 5")
    end
  elseif self._roleList[index + 5].role:GetRarityId() == 3 then
    return "gacha.firstlevelcardcell"
  elseif self._roleList[index + 5].role:GetRarityId() == 2 then
    return "gacha.secondlevelcardcell"
  elseif self._roleList[index + 5].role:GetRarityId() == 1 then
    return "gacha.thirdlevelcardcell"
  elseif self._roleList[index + 5].role:GetRarityId() == 4 then
    return "gacha.urlevelcardcell"
  elseif self._roleList[index].role:GetRarityId() == 5 then
    return "gacha.exlevelcardcell"
  else
    LogError("角色品级不是1，2，3, 4, 5")
  end
end

function GachaShareResultShotDialog:DataAtIndex(frame, index)
  local data
  if frame == self._frame then
    data = clone(self._roleList[index])
  else
    data = clone(self._roleList[index + 5])
  end
  data.isNew = false
  return data
end

return GachaShareResultShotDialog

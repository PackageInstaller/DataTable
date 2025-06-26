-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/share/gachashareresultshotdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GachaShareResultShotDialog = class("GachaShareResultShotDialog", Dialog)
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
GachaShareResultShotDialog.AssetBundleName = "ui/layouts.share"
GachaShareResultShotDialog.AssetName = "GachaShareTenShot"
GachaShareResultShotDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaShareResultShotDialog
  ((GachaShareResultShotDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GachaShareResultShotDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._cellPanel = self:GetChild("Panel/CellPanel")
  self._cellPanelTwo = self:GetChild("Panel/CellPanel2")
  self._qrcode = self:GetChild("UI/Code")
  self._frame = (GridFrame.Create)(self._cellPanel, self, true, 5, false)
end

GachaShareResultShotDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  if self._frameTwo then
    (self._frameTwo):Destroy()
    self._frameTwo = nil
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
end

GachaShareResultShotDialog.SetData = function(self, cardList)
  -- function num : 0_3 , upvalues : _ENV
  self._list = cardList
  self:Refresh()
  self._timer = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_3_0 , upvalues : self
    self._timer = nil
    self:OnShareClick()
  end
)
end

GachaShareResultShotDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV, Role, GridFrame, cimagepath
  self._roleList = {}
  self._haveURRole = false
  for k,v in pairs(self._list) do
    local role = (Role.Create)(v.cardId)
    ;
    (table.insert)(self._roleList, {role = role, keyTag = k, isNew = v.isNew == 1})
    if not self._haveURRole and role and role:GetRarityId() == 4 then
      self._haveURRole = true
    end
  end
  ;
  (self._frame):ReloadAllCell()
  if self._list then
    if #self._list <= 5 then
      local width, height = (self._cellPanel):GetRectSize()
      local cellPanelWidth = width / 5 * #self._list
      local cellPanelHeight = (self._frame):GetTotalLength()
      ;
      (self._cellPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
      local rootWindowAnchoredx, rootWindowAnchoredy = (self:GetRootWindow()):GetAnchoredPosition()
      ;
      (self._cellPanel):SetAnchoredPosition(rootWindowAnchoredx, 45)
      ;
      (self._frame):ReloadAllCell()
    else
      if self._frameTwo then
        (self._frameTwo):Destroy()
        self._frameTwo = nil
      end
      self._frameTwo = (GridFrame.Create)(self._cellPanelTwo, self, true, 5, false)
      ;
      (self._frameTwo):ReloadAllCell()
    end
  end
  local qrCodeID = ((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID()
  if qrCodeID == -1 then
    (self._qrcode):SetActive(false)
  else
    local img = cimagepath:GetRecorder(qrCodeID)
    ;
    (self._qrcode):SetSprite(img.assetBundle, img.assetName)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

GachaShareResultShotDialog.OnShareClick = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
  ;
  (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.5))
    local texture = (((CS.UnityEngine).ScreenCapture).CaptureScreenshotAsTexture)()
    self._timer = (GameTimer.AddTask)(0.2, 0, function()
      -- function num : 0_5_0_0 , upvalues : _ENV, self, texture
      ((DialogManager.CreateSingletonDialog)("gacha.share.gachashareresultdialog")):SetData(self._list, texture)
      ;
      (DialogManager.DestroySingletonDialog)("gacha.share.gachashareresultshotdialog")
      self._timer = nil
    end
)
  end
))
end

GachaShareResultShotDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_6 , upvalues : _ENV
  if frame == self._frame then
    return (math.min)(#self._roleList, 5)
  else
    return #self._roleList - 5
  end
end

GachaShareResultShotDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7 , upvalues : _ENV
  if frame == self._frame then
    if (((self._roleList)[index]).role):GetRarityId() == 3 then
      return "gacha.firstlevelcardcell"
    else
      if (((self._roleList)[index]).role):GetRarityId() == 2 then
        return "gacha.secondlevelcardcell"
      else
        if (((self._roleList)[index]).role):GetRarityId() == 1 then
          return "gacha.thirdlevelcardcell"
        else
          if (((self._roleList)[index]).role):GetRarityId() == 4 then
            return "gacha.urlevelcardcell"
          else
            if (((self._roleList)[index]).role):GetRarityId() == 5 then
              return "gacha.exlevelcardcell"
            else
              LogError("角色品级不是1，2，3, 4, 5")
            end
          end
        end
      end
    end
  else
    if (((self._roleList)[index + 5]).role):GetRarityId() == 3 then
      return "gacha.firstlevelcardcell"
    else
      if (((self._roleList)[index + 5]).role):GetRarityId() == 2 then
        return "gacha.secondlevelcardcell"
      else
        if (((self._roleList)[index + 5]).role):GetRarityId() == 1 then
          return "gacha.thirdlevelcardcell"
        else
          if (((self._roleList)[index + 5]).role):GetRarityId() == 4 then
            return "gacha.urlevelcardcell"
          else
            if (((self._roleList)[index]).role):GetRarityId() == 5 then
              return "gacha.exlevelcardcell"
            else
              LogError("角色品级不是1，2，3, 4, 5")
            end
          end
        end
      end
    end
  end
end

GachaShareResultShotDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8 , upvalues : _ENV
  local data = nil
  if frame == self._frame then
    data = clone((self._roleList)[index])
  else
    data = clone((self._roleList)[index + 5])
  end
  data.isNew = false
  return data
end

return GachaShareResultShotDialog


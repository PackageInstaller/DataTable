-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/share/gachasharesingleshotdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GachaShareSingleShotDialog = class("GachaShareSingleShotDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local MaterialStaticFunctions = ((CS.PixelNeko).Lua).MaterialStaticFunctions
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local CCardGetItem = (BeanManager.GetTableByName)("item.ccardgetitem")
local cimagepath = (BeanManager.GetTableByName)("ui.cimagepath")
GachaShareSingleShotDialog.AssetBundleName = "ui/layouts.share"
GachaShareSingleShotDialog.AssetName = "GachaShareOneShot"
GachaShareSingleShotDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaShareSingleShotDialog
  ((GachaShareSingleShotDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GachaShareSingleShotDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CRoleItemTable, CItemTable
  self._preview = self:GetChild("Panel/GachaGetCard")
  self._photo = self:GetChild("Panel/GachaGetCard/Role/Photo")
  self._live2d = self:GetChild("Panel/GachaGetCard/Role/Live2D")
  self._ui = self:GetChild("Panel/GachaGetCard/UI")
  self._title = self:GetChild("Panel/GachaGetCard/UI/ShortInfo/ShortName")
  self._name = self:GetChild("Panel/GachaGetCard/UI/ShortInfo/Name")
  self._rank = self:GetChild("Panel/GachaGetCard/UI/Rank")
  self._rankSubimg = self:GetChild("Panel/GachaGetCard/UI/Rank/RankSubimg")
  self._job = self:GetChild("Panel/GachaGetCard/UI/Job")
  self._jobTxt = self:GetChild("Panel/GachaGetCard/UI/JobTxt")
  self._skipBtn = self:GetChild("Panel/GachaGetCard/UI/SkipBtn")
  self._new = self:GetChild("Panel/GachaGetCard/UI/GetNew")
  self._repeatCharPanel = self:GetChild("Panel/GachaGetCard/UI/Same")
  self._repeatCharPanel_title = self:GetChild("Panel/GachaGetCard/UI/Same/Txt")
  self._repeatCharPanel_itemsPanel = self:GetChild("Panel/GachaGetCard/UI/Same/Frame")
  self._itemsFrame = (TableFrame.Create)(self._repeatCharPanel_itemsPanel, self, false, false)
  self._effect = self:GetChild("Panel/GachaGetCard/Effect")
  self._qrcode = self:GetChild("UI/Code")
  self._linesText = self:GetChild("Panel/GachaGetCard/UI/Back/Text")
  self._text_size_x = (self._linesText):GetSize()
  self._text_pos_x = (self._linesText):GetPosition()
  self._initialAnchorMinX = (self._linesText):GetXPosition()
  self._textMaxWidth = (self._linesText):GetRectSize()
  _ = (self._linesText):GetPreferredSize()
  ;
  (self._preview):Subscribe_StateEnterEvent(self.OnAnimationEnter, self)
  self._cRoleItemTable = {}
  for _,id in ipairs(CRoleItemTable:GetAllIds()) do
    (table.insert)(self._cRoleItemTable, CRoleItemTable:GetRecorder(id))
  end
  self._cItemTable = {}
  for _,id in ipairs(CItemTable:GetAllIds()) do
    (table.insert)(self._cItemTable, CItemTable:GetRecorder(id))
  end
  self:SetEffect()
  self._itemList = {}
end

GachaShareSingleShotDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
  ;
  (self._itemsFrame):Destroy()
end

GachaShareSingleShotDialog.SetData = function(self, card)
  -- function num : 0_3
  self._card = card
  self:Refresh()
end

GachaShareSingleShotDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : Role, _ENV, CCardGetItem, Item, cimagepath
  (self._linesText):SetActive(false)
  ;
  (self._linesText):SetText("")
  self._tag = false
  local repeatCard = false
  self._role = (Role.Create)((self._card).cardId)
  if not self._role then
    LogErrorFormat("GachaShare", "role id %s received from server is wrong", (self._card).cardId)
  end
  if (self._card).isNew == 1 then
    repeatCard = false
    ;
    (self._new):SetActive(true)
  else
    repeatCard = true
    ;
    (self._new):SetActive(false)
  end
  if self._handler and self._handler ~= 0 then
    (self._live2d):Release(self._handler)
    self._handler = 0
  end
  local cardGetItemRecord = nil
  if self._role then
    local record = (self._role):GetShapeLive2DRecord()
    if (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName then
      (self._photo):SetActive(false)
      self._handler = (self._live2d):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
      ;
      (self._live2d):SetColorTint(self._handler, 1, 1, 1, 0)
    else
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite(((self._role):GetShapeLiHuiImageRecord()).assetBundle, ((self._role):GetShapeLiHuiImageRecord()).assetName)
      local scale = (self._role):GetPhotoScale()
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      local photoPos = (self._role):GetPhotoPosition()
      ;
      (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
    end
    do
      do
        local rarityId = (self._role):GetRarityId()
        if rarityId == 1 then
          (self._preview):PlayAnimation("R")
        else
          if rarityId == 2 then
            (self._preview):PlayAnimation("SR")
          else
            if rarityId == 3 then
              (self._preview):PlayAnimation("SSR")
            else
              if rarityId == 4 then
                (self._preview):PlayAnimation("UR")
              else
                if rarityId == 5 then
                  (self._preview):PlayAnimation("UR")
                end
              end
            end
          end
        end
        ;
        (self._name):SetText((self._role):GetRoleName())
        ;
        (self._title):SetText((self._role):GetTitle())
        ;
        (self._rank):SetSprite(((self._role):GetBigRarityImageRecord()).assetBundle, ((self._role):GetBigRarityImageRecord()).assetName)
        ;
        (self._rankSubimg):SetSprite(((self._role):GetBigRarityImageRecord()).assetBundle, ((self._role):GetBigRarityImageRecord()).assetName)
        ;
        (self._job):SetSprite(((self._role):GetVocationImgDrawRecord()).assetBundle, ((self._role):GetVocationImgDrawRecord()).assetName)
        ;
        (self._jobTxt):SetText((self._role):GetVocationName())
        cardGetItemRecord = CCardGetItem:GetRecorder(rarityId)
        ;
        (self._repeatCharPanel):SetActive(true)
        if repeatCard then
          (self._repeatCharPanel_title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1428))
          if not self._otherWayGet then
            (table.insert)(self._itemList, {itemId = cardGetItemRecord.item2, itemNum = cardGetItemRecord.num2})
          end
          local roleId = (self._card).cardId
          local itemId = nil
          local isLeader = false
          if roleId == 1 then
            isLeader = true
          end
          if isLeader then
            (self._repeatCharPanel):SetActive(false)
          else
            for _,v in ipairs(self._cRoleItemTable) do
              if v.roleid == roleId then
                itemId = v.id
                break
              end
            end
            do
              if itemId then
                local roleItem = (Item.Create)(itemId)
                local resolveItemIdList = roleItem:GetResolveItemId()
                local resolveItemNumList = roleItem:GetResolveItemNum()
                for i,itemId in ipairs(resolveItemIdList) do
                  if itemId ~= 0 then
                    (table.insert)(self._itemList, {itemId = itemId, itemNum = resolveItemNumList[i]})
                  end
                end
              else
                do
                  do
                    LogErrorFormat("GachaGetCardDialog", "role ID %s doesnt have item ID in croleitem", roleId)
                    if not self._otherWayGet then
                      (self._repeatCharPanel_title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1427))
                      ;
                      (table.insert)(self._itemList, {itemId = cardGetItemRecord.item1, itemNum = cardGetItemRecord.num1})
                    else
                      ;
                      (self._repeatCharPanel):SetActive(false)
                    end
                    ;
                    (self._itemsFrame):ReloadAllCell()
                    local img = cimagepath:GetRecorder(((NekoData.BehaviorManager).BM_Gacha):GetShareQRCodeID())
                    ;
                    (self._qrcode):SetSprite(img.assetBundle, img.assetName)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

GachaShareSingleShotDialog.SetEffect = function(self)
  -- function num : 0_5 , upvalues : MaterialStaticFunctions
  self._effects = (MaterialStaticFunctions.CopyAndUseMaterialsInChildren)((self._effect)._uiObject, true)
  if self._effects ~= nil then
    for i = 0, (self._effects).Length - 1 do
      local effect = (self._effects)[i]
      effect:SetFloat("_ZTest", 8)
    end
  end
end

GachaShareSingleShotDialog.OnAnimationEnter = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == "GachaSSR" or stateName == "GachaSR" or stateName == "GachaR" or stateName == "GachaUR" or stateName == "GachaEX" then
    self:OnShareClick()
  end
end

GachaShareSingleShotDialog.OnShareClick = function(self, args)
  -- function num : 0_7 , upvalues : _ENV
  self._runner = ((self:GetRootWindow()):GetUIObject()):AddComponent(typeof(((CS.PixelNeko).Tools).ScreenShot))
  ;
  (self._runner):StartCoroutine((xLuaUtil.cs_generator)(function()
    -- function num : 0_7_0 , upvalues : _ENV, self
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(0.25))
    local texture = (((CS.UnityEngine).ScreenCapture).CaptureScreenshotAsTexture)()
    self._timer = (GameTimer.AddTask)(0.2, 0, function()
      -- function num : 0_7_0_0 , upvalues : _ENV, texture, self
      ((DialogManager.CreateSingletonDialog)("gacha.share.gachasharesingledialog")):SetData(texture)
      ;
      (DialogManager.DestroySingletonDialog)("gacha.share.gachasharesingleshotdialog")
      self._timer = nil
    end
)
  end
))
end

GachaShareSingleShotDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
  return #self._itemList
end

GachaShareSingleShotDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  return "gacha.gachagetcarditemcell"
end

GachaShareSingleShotDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  return (self._itemList)[index]
end

return GachaShareSingleShotDialog


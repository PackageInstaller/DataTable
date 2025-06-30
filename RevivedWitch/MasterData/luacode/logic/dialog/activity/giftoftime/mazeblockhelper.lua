-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/mazeblockhelper.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local MazeAwardBlockDef = (LuaNetManager.GetBeanDef)("protocol.activity.mazeawardblock")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local MazeBlockHelper = class("MazeBlockHelper")
MazeBlockHelper.Ctor = function(self, rootElement, indexNum)
  -- function num : 0_0 , upvalues : AnimatorStaticFunctions, _ENV
  self._rootElement = rootElement
  self._indexNum = indexNum
  ;
  (self._rootElement):Subscribe_PointerClickEvent(self.OnRootClicked, self)
  self._rootWindowAnimator = (AnimatorStaticFunctions.Get)((self._rootElement):GetUIObject())
  self._img = (self._rootElement):FindChild("CellBack/Img")
  self._text = (self._rootElement):FindChild("CellBack/Text")
  self._itemCell = (self._rootElement):FindChild("ItemCell")
  self._itemCellIcon = (self._rootElement):FindChild("ItemCell/_BackGround/Icon")
  self._itemCellFrame = (self._rootElement):FindChild("ItemCell/_BackGround/Frame")
  self._itemCellCount = (self._rootElement):FindChild("ItemCell/_Count")
  self._gotImg = (self._rootElement):FindChild("GotImg")
  self._player = (self._rootElement):FindChild("Player")
  self._dm = ((NekoData.DataManager).DM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  if self._text then
    (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1981))
  end
end

MazeBlockHelper.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

MazeBlockHelper.RefreshCell = function(self, data, dontTrigger)
  -- function num : 0_2 , upvalues : MazeAwardBlockDef, Item
  self._data = data
  if ((self._data).serverData).blockType == 0 then
    (self._img):SetActive(true)
    ;
    (self._itemCell):SetActive(false)
  else
    if ((self._data).serverData).status == MazeAwardBlockDef.FETCHED then
      (self._img):SetActive(((self._data).serverData).blockType ~= 1)
      ;
      (self._itemCell):SetActive(((self._data).serverData).status == MazeAwardBlockDef.FETCHED)
      ;
      (self._img):SetActive(false)
      ;
      (self._itemCell):SetActive(true)
      if ((self._data).serverData).itemId > 0 then
        self._item = (Item.Create)(((self._data).serverData).itemId)
        local imageRecord = (self._item):GetIcon()
        ;
        (self._itemCellIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = (self._item):GetPinJiImage()
        ;
        (self._itemCellFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._itemCellCount):SetText(((self._data).serverData).itemNum)
      end
      ;
      (self._gotImg):SetActive(((self._data).serverData).status == MazeAwardBlockDef.FETCHED)
      if (self._data).hilight and not dontTrigger then
        (self._rootWindowAnimator):SetTrigger("show")
      end
      ;
      (self._rootWindowAnimator):SetTrigger("hide")
      ;
      (self._player):SetActive((self._data).player)
      -- DECOMPILER ERROR: 8 unprocessed JMP targets
    end
  end
end

MazeBlockHelper.OnRootClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if ((self._data).serverData).itemId > 0 then
    local width, height = (self._itemCellIcon):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._item})
      tipsDialog:SetTipsPosition(width, height, (self._itemCellIcon):GetLocalPointInUiRootPanel())
    end
  end
end

return MazeBlockHelper


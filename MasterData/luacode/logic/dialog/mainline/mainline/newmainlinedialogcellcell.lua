local WorldInfoTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local NewMainlineDialogCellCell = class("NewMainlineDialogCellCell", Dialog)
NewMainlineDialogCellCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineDialogCellCell.AssetName = "MainLineWorldPanelCell"
local worldSelectType = {
  OneWorld = 1,
  SecondWorld = 2,
  ThirdWorld = 3
}

function NewMainlineDialogCellCell:Ctor(...)
  NewMainlineDialogCellCell.super.Ctor(self, ...)
  self._effectHandler = nil
end

function NewMainlineDialogCellCell:OnCreate()
  self._cell = {}
  self._lockImg = {}
  self._unlockImg = {}
  self._namePanel = {}
  self._nameTxt = {}
  self._chapter = {}
  self._lock = {}
  self._new = {}
  self._redDot = {}
  self._effect = {}
  self._levelLimit = {}
  self._levelLimitText = {}
  for i = 1, 3 do
    local indexStr = ""
    if 1 < i then
      indexStr = tostring(i)
    end
    self._cell[i] = self:GetChild("Cell" .. indexStr)
    self._lockImg[i] = self:GetChild("Cell" .. indexStr .. "/MapGrey" .. indexStr)
    self._unlockImg[i] = self:GetChild("Cell" .. indexStr .. "/Map" .. indexStr)
    self._namePanel[i] = self:GetChild("Cell" .. indexStr .. "/WorldName")
    self._nameTxt[i] = self:GetChild("Cell" .. indexStr .. "/WorldName/Name")
    self._chapter[i] = self:GetChild("Cell" .. indexStr .. "/WorldName/Chapter")
    self._lock[i] = self:GetChild("Cell" .. indexStr .. "/Lock")
    self._new[i] = self:GetChild("Cell" .. indexStr .. "/New")
    self._redDot[i] = self:GetChild("Cell" .. indexStr .. "/RedDot")
    self._effect[i] = self:GetChild("Cell" .. indexStr .. "/WorldEffect")
    self._levelLimit[i] = self:GetChild("Cell" .. indexStr .. "/LevelLimit")
    self._levelLimitText[i] = self:GetChild("Cell" .. indexStr .. "/LevelLimit/Txt")
  end
  for k, v in pairs(self._cell) do
    self._cell[k]:Subscribe_PointerClickEvent(function()
      self:OnCellClicked(k)
    end, self)
  end
  LuaNotificationCenter.AddObserver(self, self.OnReceiveDungeonPointAward, Common.n_ReceiveDungeonPointAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnReceiveDungeonWorldAward, Common.n_ReceiveDungeonWorldAward, nil)
end

function NewMainlineDialogCellCell:OnDestroy()
  if self._effectHandler then
    self._effect[self._newSelecttype]:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function NewMainlineDialogCellCell:RefreshCell(data)
  self._data = data
  for k, v in pairs(self._cell) do
    self._cell[k]:SetActive(false)
  end
  for i, v in ipairs(self._data) do
    self._cell[v.selecttype]:SetActive(true)
    if v.lock or v.unlockLv > NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel then
      self._lockImg[v.selecttype]:SetActive(true)
      self._lock[v.selecttype]:SetActive(true)
      local worldOneLine = WorldInfoTable:GetRecorder(v.worldId)
      local image = ImageTable:GetRecorder(worldOneLine.worldimagegrey)
      if image then
        self._lockImg[v.selecttype]:SetSprite(image.assetBundle, image.assetName)
      end
      self._unlockImg[v.selecttype]:SetActive(false)
      if v.selecttype == worldSelectType.ThirdWorld then
        self._namePanel[v.selecttype]:SetActive(false)
      else
        self._namePanel[v.selecttype]:SetActive(true)
        self._nameTxt[v.selecttype]:SetText(TextManager.GetText(CStringRes:GetRecorder(1279).msgTextID))
        self._chapter[v.selecttype]:SetText("")
      end
      self._new[v.selecttype]:SetActive(false)
      self._redDot[v.selecttype]:SetActive(false)
      self._effect[v.selecttype]:SetActive(false)
      if not v.lock then
        self._levelLimit[v.selecttype]:SetActive(true)
        local str = CStringRes:GetRecorder(1374).msgTextID
        str = TextManager.GetText(str)
        str = string.gsub(str, "%$parameter1%$", v.unlockLv)
        self._levelLimitText[v.selecttype]:SetText(str)
      else
        self._levelLimit[v.selecttype]:SetActive(false)
      end
    else
      local worldLine = WorldInfoTable:GetRecorder(v.worldId)
      self._lockImg[v.selecttype]:SetActive(false)
      self._unlockImg[v.selecttype]:SetActive(true)
      self._lock[v.selecttype]:SetActive(false)
      local image = ImageTable:GetRecorder(worldLine.worldimage)
      if image then
        self._unlockImg[v.selecttype]:SetSprite(image.assetBundle, image.assetName)
      end
      self._namePanel[v.selecttype]:SetActive(true)
      self._nameTxt[v.selecttype]:SetText(TextManager.GetText(worldLine.worldTextID))
      self._chapter[v.selecttype]:SetText(TextManager.GetText(worldLine.chapterTextID))
      if v.clearZones == v.totalZones then
        self._new[v.selecttype]:SetActive(false)
        self._effect[v.selecttype]:SetActive(false)
      else
        self._new[v.selecttype]:SetActive(true)
        self._effect[v.selecttype]:SetActive(true)
        if self._effectHandler then
          self._effect[v.selecttype]:ReleaseEffect(self._effectHandler)
          self._effectHandler = nil
        end
        self._effectHandler = self._effect[v.selecttype]:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(worldLine.mainlineListEffect))
        self._newSelecttype = v.selecttype
      end
      if NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
        self._redDot[v.selecttype]:SetActive(false)
      else
        self._redDot[v.selecttype]:SetActive(true)
      end
      self._levelLimit[v.selecttype]:SetActive(false)
    end
  end
end

function NewMainlineDialogCellCell:OnCellClicked(index)
  if DialogManager.GetDialog("mainline.mainline.mainlineworlddialog") then
    for i, v in ipairs(self._data) do
      if v.selecttype == index then
        if not v.lock then
          if v.unlockLv > NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel then
            local dialog = DialogManager.CreateSingletonDialog("dungeon.levellimitconfirmdialog")
            if dialog then
              dialog:Init(v.unlockLv, true)
            end
            return
          end
          local three = {
            data = {},
            curZone = nil
          }
          three.curZone = v.curZone
          three.worldId = v.worldId
          three.clearZones = v.clearZones
          three.totalZones = v.totalZones
          three.isReceived = v.isReceived
          for _, d in ipairs(v.floorDetail) do
            local temp = {}
            temp.id = d.floor
            temp.spirit = d.spirit
            temp.firstGet = d.firstGet
            temp.isReceived = d.isReceived
            temp.openedBoxes = d.openedBoxes
            temp.totalBoxes = d.totalBoxes
            temp.checkPointOpenBoxex = d.checkPointOpenBoxex
            temp.checkPointTotalBoxes = d.checkPointTotalBoxes
            temp.autoExplore = d.autoExplore
            temp.smallPoint = d.smallPoint
            table.insert(three.data, temp)
          end
          table.sort(three.data, function(a, b)
            return a.id < b.id
          end)
          DialogManager.CreateSingletonDialog("mainline.mainline.newmainlinefloordialog"):SetData(three)
        end
        break
      end
    end
  end
end

function NewMainlineDialogCellCell:OnReceiveDungeonPointAward(notification)
  for i, v in ipairs(self._data) do
    if not v.lock then
      for _, d in ipairs(v.floorDetail) do
        if notification.userInfo.id == d.floor then
          d.isReceived = 1
          break
        end
      end
    end
  end
end

function NewMainlineDialogCellCell:OnReceiveDungeonWorldAward(notification)
  for i, v in ipairs(self._data) do
    if not v.lock and v.worldId == notification.userInfo.id then
      v.isReceived = 1
    end
  end
end

function NewMainlineDialogCellCell:OnEvent(eventName, arg)
  if eventName == "RefreshRedDot" then
    for i, v in ipairs(self._data) do
      if not v.lock then
        if NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldAwardReceiveByWorldId(v.worldId) and NekoData.BehaviorManager.BM_Game:GetIfDungeonWorldAllZoneAwardReceive(v.worldId) then
          self._redDot[v.selecttype]:SetActive(false)
        else
          self._redDot[v.selecttype]:SetActive(true)
        end
      end
    end
  end
end

return NewMainlineDialogCellCell

local TaskCfg = BeanManager.GetTableByName("mission.ccoinmissionconfig")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local timeutils = require("logic.utils.timeutils")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CVarconfig = BeanManager.GetTableByName("var.cvarconfig")
local TaskStatus = LuaNetManager.CreateBean("protocol.task.taskstatus")
local DelegateTaskCell = class("DelegateTaskCell", Dialog)
DelegateTaskCell.AssetBundleName = "ui/layouts.basetasklist"
DelegateTaskCell.AssetName = "BattlePassTaskCell"
local Status = LuaNetManager.CreateBean("protocol.task.taskstatus")

function DelegateTaskCell:Ctor(...)
  DelegateTaskCell.super.Ctor(self, ...)
  self._groupName = "Cell"
  self._itemId = 0
end

function DelegateTaskCell:OnCreate()
  self._panel = self:GetChild("Panel")
  self._back = self:GetChild("Panel/Back")
  self._done = self:GetChild("Panel/Done")
  self._taskName = self:GetChild("Panel/TaskName")
  self._getBtn = self:GetChild("Panel/GetBtn")
  self._goBtn = self:GetChild("Panel/GoBtn")
  self._item = self:GetChild("Panel/ItemCell")
  self._item:FindChild("_BackGround/Icon"):Subscribe_PointerClickEvent(self.ItemClick, self)
  self._item:FindChild("_BackGround/Frame"):Subscribe_PointerClickEvent(self.ItemClick, self)
  self._taskPanel = self:GetChild("Panel/OnGoing")
  self._taskInfo = {
    desc = self:GetChild("Panel/OnGoing/Task"),
    progress = self:GetChild("Panel/OnGoing/Loading/BackGround/Progress"),
    num = self:GetChild("Panel/OnGoing/Loading/Num/Num"),
    status = 0
  }
  self._new = self:GetChild("New")
  self._newInfo = {
    task = self:GetChild("New/TaskName"),
    time = self:GetChild("New/Time"),
    num = self:GetChild("New/Num")
  }
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetTaskClick, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClick, self)
end

function DelegateTaskCell:OnDestroy()
end

function DelegateTaskCell:SetItem(obj, data)
  if not obj then
    return
  end
  local frame = obj:FindChild("_BackGround/Frame")
  local icon = obj:FindChild("_BackGround/Icon")
  local choose = obj:FindChild("_BackGround/Select")
  choose:SetActive(false)
  local count = obj:FindChild("_Count")
  local item = Item.Create(data.itemid)
  self._itemId = data.itemid
  icon:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
  local imageRecord = item:GetPinJiImage()
  frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  count:SetText(NumberManager.GetShowNumber(data.itemnum))
end

function DelegateTaskCell:ItemClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(self._itemId)
    })
    local width, height = self._item:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._item:GetLocalPointInUiRootPanel())
  end
end

function DelegateTaskCell:RefreshCell(data)
  self._cellData = data
  self._task = data.task
  local taskKey = data.key
  local task = data.task
  if task then
    self._panel:SetActive(true)
    self._new:SetActive(false)
    self._done:SetActive(false)
    local cfg = TaskCfg:GetRecorder(task.taskid)
    local taskName = TextManager.GetText(cfg.missionnameTextID)
    self._taskName:SetText(taskName)
    self:SetItem(self._item, cfg)
    local taskStatus = task.taskstatus
    if taskStatus == TaskStatus.PROCESSING then
      self._getBtn:SetActive(false)
      self._taskPanel:SetActive(true)
      local val = task.conditions[1]
      local v, d = val.value, val.destValue
      self._taskInfo.num:SetText(string.format("%d/%d", v, d))
      if d == 0 then
        d = 1
      end
      self._taskInfo.progress:SetFillAmount(v / d)
      self._taskInfo.desc:SetText(TextManager.GetText(cfg.descriptionTextID))
      self._goBtn:SetActive(true)
    elseif taskStatus == TaskStatus.FINISHED then
      self._getBtn:SetActive(true)
      self._done:SetActive(true)
      self._taskPanel:SetActive(false)
      self._goBtn:SetActive(false)
    end
  else
    self._panel:SetActive(false)
    self._new:SetActive(true)
    local serverTime = ServerGameTimer.GetServerTime()
    local delta = data.refreshTime - serverTime
    if delta <= 0 then
      delta = 0
    end
    warn(">>> remain time: ", delta, serverTime, data.refreshTime)
    warn(timeutils.getLeftTimeStr(delta))
    self._newInfo.time:SetText(timeutils.getLeftTimeStr(delta))
    local str = TextManager.GetText(CStringRes:GetRecorder(1333).msgTextID)
    str = string.gsub(str, "%$parameter1%$", CVarconfig:GetRecorder(56).Value)
    self._newInfo.num:SetText(str)
    self._goBtn:SetActive(false)
  end
end

function DelegateTaskCell:OnGetTaskClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.task.ccommittask")
  protocol.taskid = self._cellData.key
  protocol.agCoinTask = 1
  protocol:Send()
end

function DelegateTaskCell:OnGoBtnClick()
  local manager = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AgCoinActivityID)
  manager:HandleTask(self._task.taskid)
end

return DelegateTaskCell

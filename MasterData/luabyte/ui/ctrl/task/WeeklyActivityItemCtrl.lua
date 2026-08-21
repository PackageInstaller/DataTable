local WeeklyActivityItemCtrl = BaseClass("WeeklyActivityItemCtrl")
local M = WeeklyActivityItemCtrl

function M:__init(view)
    self._view = view
    self._data = nil

    self._view.rectClickArea:onClick(Bind(self, self.OnActivityClick))
end

function M:OnDispose()
    self._data = nil
    self._view.rectClickArea:onClick(nil)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self._data = data

    self:_SetIcon(data.reward)
    self._view.txtValue:SetText(tostring(data.value + data.increment))
    self._view.rectDoing:SetActive(data.uiState == TaskConst.TaskUIState.Lock)
    self._view.rectReceive:SetActive(data.uiState == TaskConst.TaskUIState.Unlock)
    self._view.rectComplete:SetActive(data.uiState == TaskConst.TaskUIState.Complete)
end

function M:_SetIcon(reward)
    local igCfg = ConfigHelper.GetCfg("itemGroup", reward)
    if igCfg and not table.isNullOrEmpty(igCfg.items) then
        local itemId = igCfg.items[1]
        self._view.txt_rewardCount:SetText(tostring(igCfg.cnts[1]))
        local item = ConfigHelper.GetCfg("item", itemId)
        if item then
            self._view.imgReward:SetPic(item.icon)
        end
    end
end

function M:OnActivityClick()
    local title = ConfigHelper.GetLocalString(293)
    local des = ConfigHelper.GetLocalString(709)
    if self._data.uiState == TaskConst.TaskUIState.Lock then
        local itemgroup = ConfigHelper.GetCfg("itemGroup", self._data.reward)
        if itemgroup and #itemgroup.items == 1 then
            GameHelper.PopItem(itemgroup.items[1], 0, self._view)
            return
        end
        GameHelper.ConfirmReward(self._data.reward, title, des, "", false, false, nil)
    elseif self._data.uiState == TaskConst.TaskUIState.Unlock then
        TaskDataMgr:RequestActivityAward(self._data.id - 1, protocol.EACTType.EACT_Weekly)
    elseif self._data.uiState == TaskConst.TaskUIState.Complete then
        local itemgroup = ConfigHelper.GetCfg("itemGroup", self._data.reward)
        if itemgroup and #itemgroup.items == 1 then
            GameHelper.PopItem(itemgroup.items[1], 0, self._view)
            return
        end
        GameHelper.ConfirmReward(self._data.reward, title, des, "", false, true, nil)
    end
end

return WeeklyActivityItemCtrl

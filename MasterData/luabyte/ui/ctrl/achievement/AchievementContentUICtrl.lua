local ButtonView = require("UI.View.Achievement.AchievementButtonView")
local AchievementContentUICtrl = BaseClass("AchievementContentUICtrl",BaseUICtrl)
local M = AchievementContentUICtrl


function M:OnEnter(data)
    self:_Refresh(data)
end


function M:_Refresh(data)
    self._curData = data;
    self._data = AchievementDataMgr:GetInstance():AchievementData()
    self._view.scrollView:ShowList(#self._data)
    self:_OnClickItem(self._curData)

    local index = MapUtil.FindKey(self._data, function (v) return v:Id() == self._curData:Id() end)
    if index then
        self._view.scrollView:SetVerticalNormalizedByIndex(index)
    end
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end



function M:UpdateItem(obj, index)
    local view = ButtonView.New(obj)
    local data = self._data[index]
    local config = data:Config()
    local progress = math.floor(data:Score() * 100 / data:AllScore())
    progress = progress > 100 and 100 or progress
    local valueText = string.format("<size=60>%d</size>", progress) .. "%"
    view.select:SetActive(data:Id() == self._curData:Id())
    view.nameNormal:SetText(config.name)
    view.nameSelect:SetText(config.name)
    view.valueNormal:SetText(valueText)
    view.valueSelect:SetText(valueText)
    view.redpoint:SetParam(0, data:Id())
    view.redpoint:Check()
    view:onClick(Bind(self, self._OnClickItem, data))
end


function M:_RefreshRight(data)
    self._view.content:Refresh(data)
end


function M:Init()
    self._view.scrollView:Init(Bind(self, self.UpdateItem))
    self._RefreshData = EventMgr:AddListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, Bind(self, self._OnRefreshDataCallBack))
end


function M:_OnRefreshDataCallBack()
    self._data = AchievementDataMgr:GetInstance():AchievementData()
    self._curData = MapUtil.Find(self._data, function (v) return v:Id() == self._curData:Id() end)

    if self._curData:RewardNum() == 0 then
        self._curData =  self._data[1] 
    end

    self._view.scrollView:ShowList(#self._data)
    self:_OnClickItem(self._curData)
end


function M:_OnClickItem(data)
    if not data:IsLoad() then
        AchievementDataMgr:GetInstance():SendRequestAchievementGroupDetail(data:Id(), Bind(self, self._OnRefreshInfo))
        return
    end

    self:_OnRefreshInfo(data)
end


function M:_OnRefreshInfo(data)
    self._curData = data
    self._view.scrollView:UpdateList()
    self:_RefreshRight(data)

    local index = MapUtil.FindKey(self._data, function (v) return v:Id() == self._curData:Id() end)
    if index then
        --self._view.scrollView:SetVerticalNormalizedByIndex(index)
    end
end


function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.NOTIFY_UPDATE_ACHIEVEMENT, self._RefreshData)
    self._RefreshData = nil;
    M.super.OnDispose(self)
end



return AchievementContentUICtrl
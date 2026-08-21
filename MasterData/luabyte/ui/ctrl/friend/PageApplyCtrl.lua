local friendView = require("UI.View.Friend.BaseFriendItemView")
local PageApplyCtrl = BaseClass("PageApplyCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = PageApplyCtrl
local requestCount = 99


function M:Hide()
    self:HidePanel()
    self._data = {}
end


function M:OpenPanel()
    self:ShowPanel()
    self:_RefreshText()
    FriendDataMgr:GetInstance():SendRequestApplyFriendData(0, requestCount, Bind(self, self._ResponseCallBack))
end


function M:UpdateItem(obj,index)
    local view = friendView.New(obj)
    local data = self._data[index]
    local levelStr = string.format("Lv.%d", data.Level)
    --local heroId = FriendHelper.GetShowGirlId(data.Avatar)
    local playerIconPath = FriendHelper.GetPlayerIcon(data.PlayerIconId)
    view.levelText:SetText(levelStr)
    view.nameText:SetText(data.Nickname)
    view.olineState:SetActive(data.Online)
    view.pastState:SetActive(not data.Online)
    view.addBtn:SetActive(false)
    view.applyBtns:SetActive(true)
    --view.headIcon:SetAvatarIcon(heroId, RoleType.ERT_Hero)
    view.headIcon:SetPic(playerIconPath)
    view.yesBtn.transform:onClick(Bind(self, self._OnClickYes, data.FriendId, index))
    view.noBtn.transform:onClick(Bind(self, self._OnClickNo, data.FriendId, index))
end


function M:_ResponseCallBack(data)
    self._data = {}
    for _,v in ipairs(data) do
        table.insert(self._data, v)
    end
    self._view.scrollView:ShowList(#self._data)
    self._view.scrollView:SetVerticalNormalizedPosition(1)
    self:_RefreshText()
end


function M:_RefreshText()
    local param = ConfigHelper.GetSystemParam(194)
    self._view.applyNumText:SetText(tostring(FriendDataMgr:GetInstance():GetApplyFriendNumMax()))
    self._view.applyMaxText:SetText("/" .. tostring(param))
    self._view.friendNumText:SetText(tostring(FriendDataMgr:GetInstance():GetFriendNumMax()))
    self._view.friendMaxText:SetText("/" .. tostring(param))
    self._view.nullTip:SetActive(#self._data == 0)
end


function M:Init()
    self._data = {}
    self._view.scrollView:Init(Bind(self, self.UpdateItem))
    self._view.negletBtn.transform:onClick(Bind(self, self._OnClickAllNo))
    self._view.confirmBtn.transform:onClick(Bind(self, self._OnClickAllYes))
end


function M:_OnClickAllYes()
    FriendDataMgr:GetInstance():SendRequsetAllAddFriends(Bind(self, self._OnAllCallBack))  
end


function M:_OnClickAllNo()
    FriendDataMgr:GetInstance():SendRequestAllRefuseFriends(Bind(self, self._OnAllCallBack))  
end


function M:_OnAllCallBack()
    FriendDataMgr:GetInstance():SendRequestApplyFriendData(0, requestCount, Bind(self, self._ResponseCallBack))
end


function M:_OnClickYes(friendId, index)
    FriendDataMgr:GetInstance():SendRequestAgreeFriendShip(friendId, Bind(self, self._OnResponseRemoveOneCallBack, index))
end


function M:_OnClickNo(friendId, index)
    FriendDataMgr:GetInstance():SendRequestRefuseFriendShip(friendId, Bind(self, self._OnResponseRemoveOneCallBack, index))
end


function M:_OnResponseRemoveOneCallBack(index)
    table.remove(self._data, index)
    local dataCount = #self._data
    self._view.scrollView:ShowList(#self._data)
    if dataCount>0 then
        self._view.scrollView:SetVerticalNormalizedPosition(1-((index-1)/#self._data))
    end
    self:_RefreshText()
end


function M:OnDispose()
    self._view.scrollView:DisposeAll()
    M.super.OnDispose(self)
end


return PageApplyCtrl
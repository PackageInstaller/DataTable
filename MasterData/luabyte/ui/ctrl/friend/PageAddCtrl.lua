local PageAddCtrl = BaseClass("FriendAddCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = PageAddCtrl


function M:Hide()
    self:HidePanel()
end


function M:OpenPanel()
    self._view.nullTip:SetActive(false)
    self._view:SetActive(true)
end


function M:__init(view)
    self._view = view 
    self._view.scrollView:Init(require("UI.Ctrl.Friend.FriendAddItemCtrl"), require("UI.View.Friend.BaseFriendItemView"))
    self._view.inputCancelBtn:onClick(Bind(self, self._OnClickCancelCallBack))
    self._view.findBtn:onClick(Bind(self, self._OnClickFindCallBack)) 
end


function M:_OnClickCancelCallBack()
    self._view.input:SetText("")
end


function M:_OnClickFindCallBack()
    local inputStr = self._view.input:GetText()

    if inputStr == "" then
        GameHelper.TipsById(1236)
        return
    end 

    if (tonumber(inputStr) == INetPack.accountId) then
        GameHelper.TipsById(1237)
        return
    end

    FriendDataMgr:GetInstance():SendRequestFindFriendData(tonumber(inputStr), Bind(self, self._ResponseCallBack))
end


function M:_ResponseCallBack(data)
    self._view.scrollView:SetDataList(data)
    self._view.nullTip:SetActive(#data <= 0)
end


return PageAddCtrl
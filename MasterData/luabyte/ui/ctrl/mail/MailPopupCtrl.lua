local MailPopupCtrl = BaseClass("MailPopupCtrl",BaseUICtrl)
local M = MailPopupCtrl
local tInsert = table.insert

function M:Init()
    self:AddListener()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

--进入
function M:OnEnter(data)
    self:InitView(data)
    self.data = data
    self._UpdateMailsHander = EventMgr:AddListener(UIMessageNames.SYSTEM_UPDATEMAILS, Bind(self, self._UpdateMails))
end

--添加按钮事件
function M:AddListener()
    self._view.closeBtn:onClick(Bind(self, self.ClickBackBtn))
    self._view.getBtn:onClick(Bind(self, self.ClickGetBtn))
    self._view.deleteBtn:onClick(Bind(self, self.ClickDestroyBtn))
end

--初始化UI
function M:InitView(data)
    --self.data = data:GetmailCfg()
    self._view.titleText:SetText(data:GetTitle())
    self._view.timeText:SetText(data:GetTime())
    self._view.contextText:SetText(data:GetContent())
    self._view.senderText:SetText(data:GetSenderName())
    self._view.restTimeText:SetText(tostring(data:GetShelfLife()) ..ConfigHelper.GetLocalString(4175))

    local bCanGet = data:GethasItem() and (data:Getstate() ~= protocol.MailState.MS_EXTRACT)
    self._view.getBtn:SetActive(bCanGet)
    self._view.deleteBtn:SetActive(not bCanGet)

    --ItemList
    local items = data:GetItem()
    self._view.sc:Init(require("UI.Ctrl.mail.MailPoptemCtrl"), require("UI.View.Common.ItemPfbView"))
    if items ~= nil then
        for key, value in pairs(items) do
            value.state = data:Getstate()
        end

        self._view.sc:SetDataList(items)
        self._view.sc:SetHorizontal(#items > 8)
        if #items < 10 then
            self._view.scLayoutCtr:SetLayout()
        end
    end 

    --self._view.getedTip.gameObject:SetActive(data:Getstate() == protocol.MailState.MS_EXTRACT)
end

--点击返回按钮
function M:ClickBackBtn()
    self:Close()
end

--点击取货按钮
function M:ClickGetBtn()
    local mailId = {}
    tInsert(mailId,self.data:GetId())
    MailDataMgr:OpenMails(mailId,true)
end

--点击删除按钮
function M:ClickDestroyBtn()
    local mailId ={}
    tInsert(mailId,self.data:GetId())
    MailDataMgr:DelMails(mailId)
end

function M:_UpdateMails(ids)
    if self.data == nil then
        return
    end
    for index, value in ipairs(ids) do
        if value == self.data:GetId() then
            self.data =  MailDataMgr:GetMailDataById(value)
            if self.data~=nil then
                self:InitView(self.data)
            end
            return
        end
    end
end

--关闭
function M:OnClose()
    EventMgr:RemoveListener(UIMessageNames.SYSTEM_UPDATEMAILS, self._UpdateMailsHander)
end


return M

local ComUICtrl = BaseClass("ComUICtrl", BaseUICtrl)
local M = ComUICtrl
local tInsert = table.insert
function M:Init()
    self._filterChangeCallback = EventMgr:AddListener(UIMessageNames.COM_TYPE_TABLE_CHANGE,
        Bind(self, self.OnFilterChange))
    self._tabChangeCallback = EventMgr:AddListener(UIMessageNames.COM_TYPE_TAB_CHANGE,
        Bind(self, self.OnTabChange))
    self._tabNameChangeCallback = EventMgr:AddListener(UIMessageNames.COM_TAB_NAME_CHANGE,
        Bind(self, self.OnTabNameChange))
    self._showCapSelectCallback = EventMgr:AddListener(UIMessageNames.COM_SHOW_CAPTION_SELECT,
        Bind(self, self.OnShowCapSelect))

    self._view.rectBack:onClick(Bind(self, self.Close))
    self._view.rectSelect1:onClick(Bind(self, self.OnSelectChat1))
    self._view.rectSelect2:onClick(Bind(self, self.OnSelectChat2))
    self._view.rectSelect3:onClick(Bind(self, self.OnSelectChat3))
    self._view.rectSend:onClick(Bind(self, self.OnSendChat))
    self._view.rectSendSelect:onClick(Bind(self, self.OnSendSelect))

    self._curSelectIndex = 0
    self._curFilterType = 0
    self._curChatType = 0
    self._isCapSelect = false

    local filterTypeLabels = {
        ComConst.FilterTab.ALL.labels,
        ComConst.FilterTab.TEXT.labels,
        ComConst.FilterTab.VOICE.labels,
        ComConst.FilterTab.PIC.labels,
        ComConst.FilterTab.BATTLE.labels
    }

    local chatTypeLabels = {
        ComConst.ChatTypeTab.ALL.labels,
        ComConst.ChatTypeTab.PRIVATE.labels,
        ComConst.ChatTypeTab.GROUP.labels,
        ComConst.ChatTypeTab.OFFICAL.labels,
    }

    self._tabScrollView = self._view.comHeroScroll
    local ctrl = require("UI.Ctrl.ComRoom.ComHeroItemCtrl")
    local view = require("UI.View.ComRoom.ComHeroItemView")
    self._tabScrollView:Init(ctrl, view)

    self._chatScrollView = self._view.comChatScroll
    self._chatScrollView:Init(Bind(self, self.OnGetChatItemCallback))

    self._view.typeFilterTabs:InitItems(self._curFilterType, filterTypeLabels, Bind(self, self.OnFilterChange))
    self._view.chatTypeTabs:InitItems(self._curChatType, chatTypeLabels, Bind(self, self.OnChatTypeChange))

    self._view.rectChatSelect:SetActive(false)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.COM_TYPE_TABLE_CHANGE, self._filterChangeCallback)
    EventMgr:RemoveListener(UIMessageNames.COM_TYPE_TAB_CHANGE, self._tabChangeCallback)
    EventMgr:RemoveListener(UIMessageNames.COM_TAB_NAME_CHANGE, self._tabNameChangeCallback)
    EventMgr:RemoveListener(UIMessageNames.COM_SHOW_CAPTION_SELECT, self._showCapSelectCallback)

    self._curSelectIndex = nil
    self._curFilterType = nil
    self._curChatType = nil
    self._isCapSelect = nil

    self:_StopNextChatTimer()

    self._tabScrollView:Dispose()
    self._tabScrollView = nil
    self._chatScrollView:Dispose()
    self._chatScrollView = nil

    M.super.OnDispose(self)
end

function M:OnEnter()
    local tabList = ComRoomDataMgr:GetInstance():GetTabList()
    self._tabScrollView:SetDataList(tabList)

    local isEnd = ComRoomDataMgr:GetInstance():IsStoryEnd()
    local readList = nil
    if isEnd then
        readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
        self._chatScrollView:SetDataList(readList)
    else
        ComRoomDataMgr:GetInstance():SetSelectNextChatData()
        readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
        self._chatScrollView:SetDataList(readList)
        if not self._isCapSelect then
            self:_StartNextChatTimer()
        end
    end

    local chatType = ComRoomDataMgr:GetInstance():GetChatType()
    if chatType == ComConst.ChatType.Offical then
        self:_HideSelectionAndSendBox()
    end
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnGetChatItemCallback(index)
    local dataList = self._chatScrollView:GetDataList()
    local data = dataList[index]
    local itemTypeClass = nil
    local itemViewType = nil
    local prefabName = nil

    if data.chatType == ComConst.ChatType.Private or data.chatType == ComConst.ChatType.Group then
        if data.speaker == 2 then
            itemTypeClass = require("UI.Ctrl.ComRoom.SelfChatItemCtrl")
            itemViewType = require("UI.View.ComRoom.SelfChatItemView")
            prefabName = "SelfChatItem"
        elseif data.speaker == 1 then
            if data.type == ComConst.Type.Text then
                itemTypeClass = require("UI.Ctrl.ComRoom.RoleChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.RoleChatItemView")
                prefabName = "RoleChatItem"
            elseif data.type == ComConst.Type.Pic then
                itemTypeClass = require("UI.Ctrl.ComRoom.PicChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.PicChatItemView")
                prefabName = "PicChatItem"
            elseif data.type == ComConst.Type.Voice then
                itemTypeClass = require("UI.Ctrl.ComRoom.VoiceChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.VoiceChatItemView")
                prefabName = "VoiceChatItem"
            elseif data.type == ComConst.Type.Video then
                itemTypeClass = require("UI.Ctrl.ComRoom.VideoChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.VideoChatItemView")
                prefabName = "VideoChatItem"
            elseif data.type == ComConst.Type.Battle then
                itemTypeClass = require("UI.Ctrl.ComRoom.BattleChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.BattleChatItemView")
                prefabName = "BattleChatItem"
            elseif data.type == ComConst.Type.Line then
                itemTypeClass = require("UI.Ctrl.ComRoom.LineChatItemCtrl")
                itemViewType = require("UI.View.ComRoom.LineChatItemView")
                prefabName = "LineChatItem"
            end
        end
    elseif data.chatType == ComConst.ChatType.Offical then
        itemTypeClass = require("UI.Ctrl.ComRoom.OfficalBriefItemCtrl")
        itemViewType = require("UI.View.ComRoom.OfficalBriefItemView")
        prefabName = "OfficalBriefItem"
    end

    return data, itemTypeClass, itemViewType, prefabName
end

function M:OnFilterChange(tabType)
    self._curFilterType = tabType

    local readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
    if not table.isNullOrEmpty(readList) then
        local showList = {}
        for index, value in pairs(readList) do
            if tabType == 0 then
                tInsert(showList, value)
            elseif tabType == 1 and value.type == 1 then
                tInsert(showList, value)
            elseif tabType == 2 and value.type == 2 then
                tInsert(showList, value)
            elseif tabType == 3 and (value.type == 3 or value.type == 4) then
                tInsert(showList, value)
            elseif tabType == 4 and value.type == 5 then
                tInsert(showList, value)
            end
        end
        self._chatScrollView:UpdateList(showList)
        self._chatScrollView:MovePanelToItemIndex(#showList)
    end
end

function M:OnChatTypeChange(chatType)
    self._curChatType = chatType

    local tabsData = ComRoomDataMgr:GetInstance():GetChatTypeData(chatType)
    if tabsData then
        self:_RefreshTabsAndChats(tabsData[1])
        self._tabScrollView:SetDataList(tabsData)
        self:_OnUpdateNextChat()
    else
        self:_ShowEmptyTabAndChat()
    end
end

function M:OnTabChange(tabData)
    if tabData.select then
        return
    end

    self._isCapSelect = false
    self._view.rectSendSelect:SetActive(false)
    self._view.rectChatSelect:SetActive(false)

    self:_RefreshTabsAndChats(tabData)
    self:_SaveTabReadTime(tabData)
    ComRoomDataMgr:GetInstance():UpdateTabListSelect(tabData.chatName)
    self._tabScrollView:UpdateList()
    self:_OnUpdateNextChat()
end

function M:_ShowEmptyTabAndChat(tabsData)
    self:_StopNextChatTimer()
    self:_HideSelectionAndSendBox()
    self._tabScrollView:SetDataList(tabsData)
    self._chatScrollView:UpdateList({})
end

function M:_RefreshTabsAndChats(tabData)
    self:_StopNextChatTimer()

    if not tabData then
        return
    end

    self._view.cgChatScroll.alpha = 1
    if tabData.chatType == ComConst.ChatType.Private or tabData.chatType == ComConst.ChatType.Group then
        self:_ShowSendBox()
    elseif tabData.chatType == ComConst.ChatType.Offical then
        self:_HideSelectionAndSendBox()
    end
end

function M:_SaveTabReadTime(tabData)
    local timestamp = TimeUtil.GetNowTimeStamp()
    if timestamp > 0 then
        PlayerPrefabHelper.SetInt(ComConst.ComTime .. tabData.chatName, timestamp)
    end
end

function M:OnTabNameChange()
    self._tabScrollView:UpdateList()
end

function M:_HideSelectionAndSendBox()
    self._view.rectChatSelect:SetActive(false)
    self._view.rectSendChatBox:SetActive(false)
end

function M:_ShowSendBox()
    self._view.rectSendChatBox:SetActive(true)
end

function M:_OnUpdateNextChat()
    self:_StopNextChatTimer()

    local isEnd = ComRoomDataMgr:GetInstance():IsStoryEnd()
    local readList = nil
    if isEnd then
        readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
        self._chatScrollView:UpdateList(readList)
        self._chatScrollView:MovePanelToItemIndex(#readList)
    else
        ComRoomDataMgr:GetInstance():SetSelectNextChatData()
        readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
        self._chatScrollView:UpdateList(readList)
        self._chatScrollView:MovePanelToItemIndex(#readList)
        if not self._isCapSelect then
            self:_StartNextChatTimer()
        end
    end
end

function M:OnShowCapSelect(words)
    self._isCapSelect = true
    self._view.rectChatSelect:SetActive(true)

    for i = 1, 3 do
        if i <= #words then
            self._view["rectSelect" .. i]:SetActive(true)
            self._view["txtSelect" .. i]:SetText(words[i])
        else
            self._view["rectSelect" .. i]:SetActive(false)
        end
    end
end

function M:OnSelectChat1()
    self:_SelectChat(1)
end

function M:OnSelectChat2()
    self:_SelectChat(2)
end

function M:OnSelectChat3()
    self:_SelectChat(3)
end

function M:OnSendSelect()
    self._curSelectIndex = 0
    self._view.rectChatSelect:SetActive(true)
    self._view.rectSendSelect:SetActive(false)
    self._view.txtSelection:SetText(4149)
end

function M:_SelectChat(index)
    local story = ComRoomDataMgr:GetInstance():GetCaptionSelectStory()
    self._view.rectChatSelect:SetActive(false)
    self._view.rectSendSelect:SetActive(true)
    self._view.txtSelection:SetText(story.words[index])
    self._curSelectIndex = index
end

function M:OnSendChat()
    if self._curSelectIndex == 0 then
        return
    end

    self._isCapSelect = false
    ComRoomDataMgr:GetInstance():SetCaptionSelectData(self._curSelectIndex)
    self._curSelectIndex = 0
    self._view.rectSendSelect:SetActive(false)
    self._view.txtSelection:SetText("")

    local readList = ComRoomDataMgr:GetInstance():GetSelectReadList()
    self._chatScrollView:UpdateList(readList)
    self._chatScrollView:MovePanelToItemIndex(#readList)
    self:_StartNextChatTimer()
end

function M:_StartNextChatTimer()
    local typingTime = ComRoomDataMgr:GetInstance():GetTypingTime()
    self._nextChatTimer = TimerManager:GetInstance():GetTimer(typingTime,
        Bind(self, self._OnUpdateNextChat), nil, true)
    self._nextChatTimer:Start()
end

function M:_StopNextChatTimer()
    if self._nextChatTimer then
        self._nextChatTimer:Stop()
    end
    self._nextChatTimer = nil
end

function M:OnClose()
end

return ComUICtrl
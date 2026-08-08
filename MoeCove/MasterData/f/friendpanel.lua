
---##################### 【FriendPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【FriendPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@enum MenuType
local MenuType = {
    FriendList = 1,
    AddFriend = 2,
    FriendRequest = 3,
    Max = 3,
}

local GetFriendOffLineTips = function(second)
    if second < 60 then
        return LocalStrEnum.Friend_OfflineTime_1  --"刚刚"
    end
    if second < 60 * 60 then
        local m = math.floor(second / 60)
        return tostring(m) .. LocalStrEnum.Friend_OfflineTime_2   --"分钟前"
    end
    local ds = 24*60*60
    if second < ds then
        local day = math.floor(second / (60 * 60))
        return tostring(day) .. LocalStrEnum.Friend_OfflineTime_3    ---"小时前"
    end
  
    if second > 30*ds then
        return LocalStrEnum.Friend_OfflineTime_5     ---"30天前"
    end

    local day = math.floor(second / ds)
    return tostring(day) .. LocalStrEnum.Friend_OfflineTime_4   --"天前"
    
end

---@class FriendObj :UIObj
---@field ui FriendPanel
local FriendObj = class("FriendPanel_FriendObj", UIObj)

function FriendObj:Initialize()
    UIObj.Initialize(self)

    ---@type FriendPanel_Generate_friendPrefab
    local peer = self
    peer.getPointBtn.button.onClick:RemoveAllListeners()
    peer.getPointBtn.button.onClick:AddListener(BindCallback_NoParams(self, self.GetPointBtnClick))
    peer.sendPointBtn.button.onClick:RemoveAllListeners()
    peer.sendPointBtn.button.onClick:AddListener(BindCallback_NoParams(self, self.SendPointBtnClick))
    peer.delFriendBtn.button.onClick:RemoveAllListeners()
    peer.delFriendBtn.button.onClick:AddListener(BindCallback_NoParams(self, self.DelFriendBtnClick))

    peer.addFriendBtn.button.onClick:RemoveAllListeners()
    peer.addFriendBtn.button.onClick:AddListener(BindCallback_NoParams(self, self.AddFriendBtnClick))

    peer.rejectBtn.scaleButton.onClick:RemoveAllListeners()
    peer.rejectBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.RejectBtnClick))

    peer.acceptBtn.scaleButton.onClick:RemoveAllListeners()
    peer.acceptBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.AcceptBtnBtnClick))

end

---@param data FriendInfo
function FriendObj:SetData(data)
    UIObj.SetData(self)
    self.data = data
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
       return 
    end
    ---@type FriendPanel_Generate_friendPrefab
    local peer = self
    peer.lvText.text.text = tostring(data.baseInfo.level)

    local HeadConfig = Config.GetHeadportraitInfo(data.baseInfo.head)
    if HeadConfig == nil then
        HeadConfig = Config.GetHeadportraitInfo(1000001)
    end
    local resourceFolder = nil
    if tonumber(HeadConfig.folder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(HeadConfig.folder)))
    else
        resourceFolder = HeadConfig.folder
    end
    local iconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, HeadConfig.filename)
    self.ui:LoadSpriteAsync(iconPath, peer.iconImg.image)
    
    peer.nameText.text.text = data.baseInfo.name
    if not string.isNullOrEmpty(data.baseInfo.userSign) then
        peer.newSignatureText.text.text = data.baseInfo.userSign
    else
        peer.newSignatureText.text.text = LocalStrEnum.Friend_Signature
    end
   
    peer.type_1.gameObject:SetActive(data.lastOnlineTime == 0)
    peer.type_2.gameObject:SetActive(data.lastOnlineTime ~= 0)
    if data.lastOnlineTime ~= 0 then
        local curTime = EngineUtil.ServerTime_Seconds()
        curTime = math.floor(curTime)
        local s = curTime - data.lastOnlineTime
        peer.offLineTimeText.text.text = GetFriendOffLineTips(s)
    end
    self:RefreshPointBtnVisable()
    local isAdd = tablex.indexof(Me.selfRequestTab, data.uid) > 0
    peer.addFriendBtn.gameObject:SetActive(not isAdd)
    peer.isAddFriendBtn.gameObject:SetActive(isAdd)
    self:SetViewType(self.ui.menuType)
end

---刷新好友点数按钮状态
function FriendObj:RefreshPointBtnVisable()
    local uid = self.data.uid
    ---@type FriendPanel_Generate_friendPrefab
    local peer = self
    local isCanGet = Me.friendPointGet[uid] == false
    local isCanSend = Me.friendPointGive[uid] == nil
    local type = 0
    if isCanGet then    ---待领取友情点
       type = 1
    elseif isCanSend then   --可以赠送
        type = 2
    elseif Me.friendPointGet[uid] == true then  ---已领取
        type = 3
    else
        type = 4
    end
    peer.getPointBtn.gameObject:SetActive(type == 1)
    peer.sendPointBtn.gameObject:SetActive(type == 2)
    peer.alreadyPointBtn.gameObject:SetActive(type == 3)
    peer.alreadySendBtn.gameObject:SetActive(type == 4)
end

---@param menuType MenuType
function FriendObj:SetViewType(menuType)
    ---@type FriendPanel_Generate_friendPrefab
    local peer = self
    for i = 1, 3 do
        peer["menuType_" .. i]:SetActive(i == menuType)
    end 
end

function FriendObj:GetPointBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:GetFriendPointReq(self.data.uid, function(uids)
        if tablex.indexof(uids, self.data.uid) == -1 then
            return
        end
        self:RefreshPointBtnVisable()
        self.ui:RefreshFriendPointInfo()
        self.ui:RefreshRedPoint()
    end)
end

function FriendObj:SendPointBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:GiveFriendPointReq(self.data.uid, function(uids)
        if tablex.indexof(uids, self.data.uid) == -1 then
            return
        end
        self:RefreshPointBtnVisable()
    end)
end

function FriendObj:DelFriendBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UICommonUtils.PopMsgBox(LocalStrEnum.MasgboxAgreementTitle, string.format(LocalStrEnum.Friend_DeleteFriend, self.data.baseInfo.name), MsgBoxType.OKCancel, function()
        Me:DeleteFriend(self.data.uid)
    end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
end

function FriendObj:AddFriendBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if Me:GetFriendCount() >= Me:GetMaxFriendCount() then
		UICommonUtils.PopToast(LocalStrEnum.Friend_CountExceedsLimit)
        return
    end

    Me:AddFriend(self.data.uid, BindCallback_NoParams(self.ui, self.ui.OnAddFriendCallback))

    -- ---@type FriendPanel_Generate_friendPqrefab
    -- local peer = self
    -- peer.addFriendBtn:SetActive(false)
    -- peer.isAddFriendBtn:SetActive(true)
end

function FriendObj:RejectBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:RejectAddFriend(self.data.uid)
end

function FriendObj:AcceptBtnBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:AgreeAddFriend(self.data.uid)
end

---@class FriendPanel : FriendPanel_Generate
local FriendPanel = require "FriendPanel_Generate"

function FriendPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.FriendListChange, self.RecvFriendListChange},
        {GameMsgType.FriendPointChange, self.RecvFriendPointChange},
    }
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.FriendPanel)

    self.friendScrollRect.loopListView2:InitListView(0, BindSelf(self, self.OnFriendValueChange))

    self.animOverCallBack:SetCallBackOfName(BindSelf(self, self.OnAnimCallBack))

    ---@type table<MenuType, UnityEngine.UI.Toggle>
    self.menuToggles = {}
     local stuff = "togType_"
    local toggleView = self.menuToggleView.rectTransform
    local childCount = toggleView.childCount
    for i = 0, childCount - 1 do
        local trs = toggleView:GetChild(i)
        if not string.startswith(trs.name, stuff) then
			goto continue
		end
        ---@type UnityEngine.UI.Toggle
        local toggle = trs:GetComponent(TypeInfo.Toggle)
		if toggle == nil then
			goto continue
		end
		local index = string.sub(trs.name, string.len(stuff) + 1)
        index = tonumber(index)
		toggle.onValueChanged:AddListener(BindCallback(self, self.OnMenuToggleValueChange, index))

        self.menuToggles[index] = toggle
		::continue::
    end

    ---@type FriendObj[] 好友数据
    self.friendObjs = {}
    ---@type FriendInfo[] 推荐好友数据
    self.friendDatas = {}

    ---@type MenuType
    self.menuType = nil

    for i = 1, MenuType.Max do
        self["menuView_" .. i].gameObject:SetActive(false)
    end

    ---请求好友数据
    Me:SuggestFriendReq()
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopListView2
---@param index integer
---@param row integer
---@param col integer
function FriendPanel:OnFriendValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("friendPrefab")
    end
    local obj = loopItem.gameObject
    ---@type FriendObj
    local itemObj = nil
    for i = 1, #self.friendObjs do
        local rObj = self.friendObjs[i]
        if rObj.gameObject == obj then
            itemObj = rObj
            break
        end
    end
    if itemObj == nil then
        ---@type FriendObj
        itemObj = FriendObj:Create(obj, self, self.friendPrefab)
        table.insert(self.friendObjs, itemObj)
    end
    local data = self.friendDatas[index+1]
    data = data or nil
    itemObj:SetData(data)
    return loopItem
end

---刷新好友红点
function FriendPanel:RefreshRedPoint()
    self.friendPointRedPoint:SetActive(Me:GetReceivableFriendPoints() > 0)
    self.allGetFriendPointRedPoint:SetActive(Me:GetReceivableFriendPoints() > 0)
    self.requestAddFriendRedPoint:SetActive(tablex.size(Me.requestFriends) > 0)
end
--function FriendPanel:StartCreating(time)
--
--end

--function FriendPanel:StartEnter(time)
--
--end

--function FriendPanel:StartRemoving(time)
--
--end

--function FriendPanel:StartExit(time)
--
--end

function FriendPanel:OnOpen(data, initiative)

    local toggle = self.menuToggles[MenuType.FriendList]
    self.breakMenuToggleEvent = true
    toggle.isOn = true
    self.breakMenuToggleEvent = nil
    self.animator:SetInteger("MenuType", 0)
    self:SetMenuType(MenuType.FriendList)
    self:UpdateFriendCountInfo()
    self.uidText.text.text = string.format("UID:" .. Me.uid)
    self:RefreshRedPoint()

    if initiative then
        CoveManager.instance():SetHomelandActive(false)
    end
end

function FriendPanel:OnMenuToggleValueChange(menuType, isOn)
    if self.breakMenuToggleEvent then
        return    
    end
    if not isOn then
       return 
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self["menuView_" .. menuType].gameObject:SetActive(true)
    self.animator:SetInteger("MenuType", menuType)
end

function FriendPanel:OnAnimCallBack(param)
    ---@type integer
    local menuType = tonumber(param)

    if self.menuType ~= nil then
        local l = self.menuType
        self["menuView_" .. l].gameObject:SetActive(false)
    end
    self.menuType = menuType
    self:SetMenuType(menuType)
end

---@param menuType MenuType
function FriendPanel:SetMenuType(menuType)
    if self.menuType ~= nil then
        local l = self.menuType
        self["menuView_" .. l].gameObject:SetActive(false)
    end
    local l = menuType
    self["menuView_" .. l].gameObject:SetActive(true)

    self.menuType = menuType
    local offsetMax = self.friendView.rectTransform.offsetMax
    if menuType == MenuType.AddFriend then
        offsetMax.y = -252
    else
        offsetMax.y = -138
    end
    self.friendView.rectTransform.offsetMax = offsetMax

    for i = 1, #self.friendObjs do
        local fObj = self.friendObjs[i]
        fObj:SetViewType(menuType)
    end

    if menuType == MenuType.FriendList then
       self:RefreshFriendPointInfo()
    end

    self:UpdateFriendListView(menuType)
end

---@param operate OperateFriendPush?
function FriendPanel:UpdateFriendListView(operate)

    local o = nil
    if self.menuType == MenuType.FriendList then
        o = Me.friends
    elseif self.menuType == MenuType.AddFriend then
        if operate == GE.OperateFriendPush.searchFriend then
            o = Me.searchFriends
        else
            o = Me.suggestFriends
        end
    elseif self.menuType == MenuType.FriendRequest then
        o = Me.requestFriends
    end
    if o == nil then
        o = {}
    end
    ---@type FriendInfo[]
    local tab = {}
    for k, v in pairs(o) do
        table.insert(tab, v)
    end
    table.sort(tab, function(a, b)
        local at = a.lastOnlineTime or -1
        local bt = b.lastOnlineTime or -1
        local onLinea = at == 0
        local onLineb = bt == 0
        if onLinea ~= onLineb then
           return onLinea
        end

        if at ~= bt then
           return at > bt 
        end

        if a.baseInfo.level ~= b.baseInfo.level then
            return a.baseInfo.level > b.baseInfo.level
        end
        return a.uid < b.uid
    end)
    self.friendDatas = tab

    self.friendScrollRect.loopListView2:SetListItemCount(0)
    self.friendScrollRect.loopListView2:SetListItemCount(#self.friendDatas, true)

    local isEmpty = #tab == 0
    if self.menuType == MenuType.FriendList then
        self.menuView_1.emptyView:SetActive(isEmpty)
        self.menuView_1.bottomView:SetActive(not isEmpty)
    elseif self.menuType == MenuType.FriendRequest then
        self.menuView_3.emptyView:SetActive(isEmpty)
        self.menuView_3.bottomView:SetActive(not isEmpty)
    end
end

---更新好友数量
function FriendPanel:UpdateFriendCountInfo()
    self.friendCountText.text.text = string.format(LocalStrEnum.Friend_FriendCount, Me:GetFriendCount(), Me:GetMaxFriendCount())
end

---删除列表好友
---@param uids integer[]
function FriendPanel:DeleteUIFriend(uids)
    local delIndex = -1
    for i = #self.friendDatas, 1, -1 do
        local fd = self.friendDatas[i]
        if tablex.indexof(uids, fd.uid) > 0 then
            table.remove(self.friendDatas, i)
        end
    end

    self.friendScrollRect.loopListView2:SetListItemCount(#self.friendDatas, false)
    self.friendScrollRect.loopListView2:RefreshAllShownItem2()
end

---更新友情点数量
function FriendPanel:RefreshFriendPointInfo()
    local curCount = Me:GetFriendPointCount() * Me:GetSendFriendAddpointCount()
    local maxCount =  Me:GetMaxPointCount() * Me:GetSendFriendAddpointCount()
    curCount = math.min(curCount, maxCount)
    self.pointCountText.text.text = string.format("%s/%s", curCount, maxCount)
end

function FriendPanel:RefreshAllFriendPointInfo(uids)
    
    self:RefreshFriendPointInfo()
    if self.menuType ~= MenuType.FriendList then
       return 
    end
    for i = 1, #self.friendObjs do
        local rObj = self.friendObjs[i]
        if rObj.data ~= nil and tablex.indexof(uids, rObj.data.uid) > 0 then
            rObj:RefreshPointBtnVisable()
        end
    end

    self:RefreshRedPoint()
end

local menuUpdateType = {
   [MenuType.FriendList] = {GE.OperateFriendPush.friendList}, 
   [MenuType.AddFriend] = {GE.OperateFriendPush.searchFriend, GE.OperateFriendPush.suggestFriendList}, 
   [MenuType.FriendRequest] = {GE.OperateFriendPush.requestList}, 
}

---好友数据改变返回
---@param operate OperateFriendPush
---@param friendList FriendInfo[] 变更的好友信息
function FriendPanel:RecvFriendListChange(operate, friendList)

    self:RefreshRedPoint()
    self:UpdateFriendCountInfo()
    local cfg = menuUpdateType[self.menuType]
    if cfg == nil then
       return 
    end
    if tablex.indexof(cfg, operate) < 0 then
       return 
    end
    self:UpdateFriendListView(operate)
end

---好友点数领取信息改变通知
function FriendPanel:RecvFriendPointChange()

end

---添加好友返回
function FriendPanel:OnAddFriendCallback(friends)
    if self.menuType ~= MenuType.AddFriend then
       return 
    end
    self:DeleteUIFriend(friends)
end

function FriendPanel:OnClose(initiative)
    if initiative then
        CoveManager.instance():SetHomelandActive(true)
    end
end

--function FriendPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function FriendPanel:OnRefresh(data)
--
--end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_1/getPointBtn onClick 
--]]
function FriendPanel:getPointBtn_Button_onClick(getPointBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_1/sendPointBtn onClick 
--]]
function FriendPanel:sendPointBtn_Button_onClick(sendPointBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_1/forbiddenPointBtn onClick 
--]]
function FriendPanel:forbiddenPointBtn_Button_onClick(forbiddenPointBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_1/delFriendBtn onClick 
--]]
function FriendPanel:delFriendBtn_Button_onClick(delFriendBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_2/addFriendBtn onClick 
--]]
function FriendPanel:addFriendBtn_Button_onClick(addFriendBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_2/isAddFriendBtn onClick 
--]]
function FriendPanel:isAddFriendBtn_Button_onClick(isAddFriendBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_3/rejectBtn onClick 
--]]
function FriendPanel:rejectBtn_ScaleButton_onClick(rejectBtn)

end

--[[
/friendView/friendScrollRect/Viewport/Content/friendPrefab/menuType_3/acceptBtn onClick 
--]]
function FriendPanel:acceptBtn_ScaleButton_onClick(acceptBtn)

end

--[[
/menuView_1/bottomView/allGetAndSendBtn onClick 
--]]
function FriendPanel:allGetAndSendBtn_ScaleButton_onClick(allGetAndSendBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local getIds = {}
    local sendIds = {}
    for i = 1, #self.friendDatas do
        local fd = self.friendDatas[i]
        local isCanGet = Me.friendPointGet[fd.uid] == false
        local isCanSend = Me.friendPointGive[fd.uid] == nil
        if isCanGet then
           table.insert(getIds, fd.uid) 
        end
        if isCanSend then
           table.insert(sendIds, fd.uid) 
        end
    end

    if #sendIds ~= 0 then
        Me:GiveFriendPointReq(sendIds, BindCallback_NoParams(self, self.RefreshAllFriendPointInfo))
    end
    if #getIds ~= 0 then
        Me:GetFriendPointReq(getIds, BindCallback_NoParams(self, self.RefreshAllFriendPointInfo))
    end
end

--[[
/menuView_2/copyUidBtn onClick 
--]]
function FriendPanel:copyUidBtn_ScaleButton_onClick(copyUidBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UnityEngine.GUIUtility.systemCopyBuffer = Me.uid
    UICommonUtils.PopToast(LocalStrEnum.Friend_CopySuccess)
end

--[[
/menuView_2/searchBtn onClick 
--]]
function FriendPanel:searchBtn_ScaleButton_onClick(searchBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local friendUidStr = self.uIDInputField.tMP_InputField.text
    if string.isNullOrEmpty(friendUidStr) then
        UICommonUtils.PopToast(LocalStrEnum.Friend_FriendIdEmpty)
        return
    end
    local uid = tonumber(friendUidStr)
    if uid == nil then
        UICommonUtils.PopToast(LocalStrEnum.Friend_FriendIdError)
        return
    end

    if uid == Me.uid then
        UICommonUtils.PopToast(LocalStrEnum.Friend_FriendIdIsMe)
        return
    end
    if Me.friends[uid] ~= nil then
        UICommonUtils.PopToast(LocalStrEnum.Friend_FriendIdIsFriend)
        return
    end
    Me:SearchFriend(uid)
end

--[[
/menuView_2/bottomView/refreshFriendBtn onClick 
--]]
function FriendPanel:refreshFriendBtn_ScaleButton_onClick(refreshFriendBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local refTime = 5
    ---刷新推荐好友
    if self.lastRefreshTime ~= nil and (Time.time - self.lastRefreshTime) < refTime then

        local lastTime = Time.time - self.lastRefreshTime
        lastTime = math.floor(lastTime)
        lastTime = refTime - lastTime

        local s = string.format(LocalStrEnum.Friend_RefreshTime, lastTime)
        UICommonUtils.PopToast(s)
        return
    end
    self.lastRefreshTime = Time.time
    Me:SuggestFriendReq()
end

--[[
/menuView_3/bottomView/allRejectBtn onClick 
--]]
function FriendPanel:allRejectBtn_ScaleButton_onClick(allRejectBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local ids = {}
    for i = 1, #self.friendDatas do
        table.insert(ids, self.friendDatas[i].uid)
    end
    if #ids == 0 then
       return 
    end
    Me:RejectAddFriend(ids)
end

--[[
/menuView_3/bottomView/allAcceptBtn onClick 
--]]
function FriendPanel:allAcceptBtn_ScaleButton_onClick(allAcceptBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local ids = {}
    for i = 1, #self.friendDatas do
        table.insert(ids, self.friendDatas[i].uid)
    end
    if #ids == 0 then
       return 
    end
    Me:AgreeAddFriend(ids)
end

--[[
/autoRoot/friendView/friendScrollRect/friendPrefab/menuType_1/alreadyPointBtn onClick 
--]]
function FriendPanel:alreadyPointBtn_Button_onClick(alreadyPointBtn)

end

--[[
/autoRoot/friendView/friendScrollRect/friendPrefab/menuType_1/alreadySendBtn onClick 
--]]
function FriendPanel:alreadySendBtn_Button_onClick(alreadySendBtn)

end

return FriendPanel

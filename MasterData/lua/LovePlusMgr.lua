local this = MgrRegister("LovePlusMgr")
LovePlusData = require "LovePlusData"
LovePlusChatListData = require "LovePlusChatListData"
LovePlusChatData = require "LovePlusChatData"
LovePlusStoryListData = require "LovePlusStoryListData"
LovePlusStoryData = require "LovePlusStoryData"

function this:Init()
    self:Clear()
    self:InitDatas()
    LovePlusProto:GetChapterSimpleInfo()
end

function this:Clear()
    self.datas = {}
    self.labelCfgs = nil
    -- 聊天
    self.chatInfos = {}
    self.chatDatas = {}
    self.chatListDatas = {}
    self.newChatListDatas = {}
    self.newChatRecord = nil
    -- 剧情
    self.storyDatas = {}
    self.storyListDatas = {}
    self.highLights = {} -- 标记的剧情信息
    self.lastStoryInfo = nil -- 中断的剧情信息
    self.readPlotIds = {}
    -- 解锁相关
    self.unLockInfos = {}
    -- 红点
    self.redDatas = {}
    self.isCheckRed = false
end

-----------------------------------------------主界面入口-----------------------------------------------
function this:InitDatas()
    local sectionCfgs = Cfgs.CfgDateSection:GetAll()
    if sectionCfgs then
        for _, cfg in pairs(sectionCfgs) do
            local data = LovePlusData.New()
            data:InitCfg(cfg)
            self.datas[cfg.id] = data
            self.redDatas[cfg.id] = 1
        end
    end
end

function this:SetDatas(proto)
    if proto then
        if proto.chapterInfo then
            for i, v in pairs(proto.chapterInfo) do
                if self.datas[v.chapterId] then
                    self.datas[v.chapterId]:SetPrograss(v.completeProgress)
                end
                if v.saveNode and v.saveNode.nodeId and v.saveNode.storyIds then
                    self.lastStoryInfo = {
                        sid = v.chapterId,
                        nid = v.saveNode.nodeId,
                        ids = v.saveNode.storyIds
                    }
                end
                self:UpdateUnLockInfos(v.unlockData)
                self:UpdateUnLockInfo(eLovePlusUnLockType.Shop, v.shopItemIds)
                self.redDatas[v.chapterId] = v.isRed == true and 1 or nil
            end
        end
        self:UpdateUnLockInfo(eLovePlusUnLockType.Img, proto.imgIds)
        EventMgr.Dispatch(EventType.LovePlus_Data_Update)
    end
    self:CheckRedPointData()
end

function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    return self.datas[id]
end

function this:GetArr()
    local datas = {}
    for _, data in pairs(self.datas) do
        -- if not data:IsEnd() then
            table.insert(datas, data)
        -- end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end
-----------------------------------------------左侧栏选择界面-----------------------------------------------
-- sid:入口id
function this:GetLabelCfgs(sid)
    if self.labelCfgs == nil then
        self.labelCfgs = {}
        local labelCfgs = Cfgs.CfgDateLabel:GetAll()
        if labelCfgs then
            for k, v in pairs(labelCfgs) do
                self.labelCfgs[v.id] = v
            end
        end
    end
    local cfgs = {}
    for k, v in pairs(self.labelCfgs) do
        if v.group == sid then
            -- if v.unlockDateStory then --有解锁条件
            --     if self:IsOpen(eLovePlusUnLockType.Label,v.id) then
            --         table.insert(cfgs,v)
            --     end
            -- else
            table.insert(cfgs, v)
            -- end

        end
    end
    if #cfgs > 0 then
        table.sort(cfgs, function(a, b)
            return a.dateLabelType < b.dateLabelType
        end)
    end
    return cfgs
end
-----------------------------------------------聊天界面-----------------------------------------------
function this:SetChatInfos(proto)
    if proto and proto.chapterId then
        self:InitChatListDatas(proto.chapterId)
        self.chatInfos[proto.chapterId] = self.chatInfos[proto.chapterId] or {}
        if proto.chatGroupData and #proto.chatGroupData > 0 then
            for i, v in ipairs(proto.chatGroupData) do
                local ids = {}
                if v.chatIds and #v.chatIds > 0 then
                    for _, id in ipairs(v.chatIds) do
                        ids[id] = id
                    end
                end
                self.chatInfos[proto.chapterId][v.chatGroupId] = ids
            end
        end
        self:UpdateChatListDatas(proto.chapterId)
        self:UpdateChatDatas(proto.chapterId)
        EventMgr.Dispatch(EventType.LovePlus_Chat_Update)
    end
    self:CheckRedPointData() -- 协议后发放这里检测
    self:CheckChatNew()
end

function this:InitChatListDatas(sid)
    if self.chatListDatas[sid] == nil then
        self.chatListDatas[sid] = {}
        local listCfgs = Cfgs.CfgDateChatrecords:GetGroup(sid)
        if listCfgs then
            for k, v in pairs(listCfgs) do
                local listData = LovePlusChatListData.New()
                listData:Init(v)
                self:InitChatDatas(v.id)
                self.chatListDatas[sid][v.id] = listData
            end
        end
    end
end

-- 更新聊天组状态
function this:UpdateChatListDatas(sid)
    if self.chatListDatas and self.chatListDatas[sid] then
        for k, v in pairs(self.chatListDatas[sid]) do
            if not v:IsShow() then
                if self.chatInfos[sid][v:GetID()] then
                    v:SetIsShow(true)
                elseif self:IsOpen(eLovePlusUnLockType.Chat, v:GetID()) or v:GetStoryIDs() == nil then
                    v:SetIsOpen(true)
                    -- 更新最新已开启聊天组
                    if not self.newChatListDatas[sid] or self.newChatListDatas[sid]:GetID() > v:GetID() then
                        self.newChatListDatas[sid] = v
                    end
                end
            end
        end
    end
end

function this:GetChatListData(sid, id)
    return self.chatListDatas and self.chatListDatas[sid] and self.chatListDatas[sid][id]
end

function this:GetChatListArr(sid)
    local datas = {}
    if self.chatListDatas and self.chatListDatas[sid] then
        for k, v in pairs(self.chatListDatas[sid]) do
            table.insert(datas, v)
        end
        if #datas > 0 then
            table.sort(datas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
    end
    return datas
end

-- 获取已显示的聊天组
function this:GetChatListPassArr(sid)
    local datas = {}
    if self.chatListDatas and self.chatListDatas[sid] then
        for k, v in pairs(self.chatListDatas[sid]) do
            if v:IsShow() then
                table.insert(datas, v)
            end
        end
        if #datas > 0 then
            table.sort(datas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
    end
    return datas
end

-- 获取最新未读聊天组
function this:GetNewChatListData(sid)
    return self.newChatListDatas and self.newChatListDatas[sid]
end

-- 清理对应章节缓存
function this:ClearNewChatListData(sid)
    if self.newChatListDatas and self.newChatListDatas[sid] then
        self.newChatListDatas[sid] = nil
    end
end

function this:InitChatDatas(groupId)
    if self.chatDatas[groupId] == nil then
        self.chatDatas[groupId] = {}
        local cfg = Cfgs.CfgDateChat:GetGroup(groupId)
        if cfg then
            for k, v in pairs(cfg) do
                local data = LovePlusChatData.New()
                data:Init(v)
                self.chatDatas[groupId][v.id] = data
            end
        end
    end
end

function this:UpdateChatDatas(sid)
    if self.chatInfos and self.chatInfos[sid] then
        local datas = nil
        local nextId = 0
        for i, v in pairs(self.chatInfos[sid]) do
            if self.chatDatas[i] ~= nil then
                datas = {}
                nextId = 0
                for k, data in pairs(self.chatDatas[i]) do
                    if data:IsOption() and v[k] ~= nil then -- 选中的选项
                        data:SetIsShow(true)
                    end
                    table.insert(datas, data)
                end
                if #datas > 0 then
                    table.sort(datas, function(a, b)
                        return a:GetID() < b:GetID()
                    end)
                    for i, v in ipairs(datas) do -- 按顺序设置已读，排处未选路线
                        if i == 1 or v:GetID() == nextId or v:IsShow() then
                            v:SetIsShow(true)
                            if v:GetNextIDs() and #v:GetNextIDs() == 1 then -- 多id不获取下个id
                                nextId = v:GetNextIDs()[1]
                            end
                        end
                    end
                end
            end
        end

    end
end

-- 获取单条聊天对话
function this:GetChatData(id, groupId)
    if groupId and self.chatDatas[groupId] then
        return self.chatDatas[groupId][id]
    else
        for k, v in pairs(self.chatDatas) do
            if v[id] ~= nil then
                return v[id]
            end
        end
    end
end

--- 获取聊天数据
---@param sid 章节id
---@param isAll 全部获取（包含未读）
function this:GetChatArr(sid, isAll)
    local datas = {}
    if self.chatListDatas and self.chatListDatas[sid] then
        for k, v in pairs(self.chatListDatas[sid]) do
            local _datas = self.chatDatas[v:GetID()]
            if _datas then
                for _, data in pairs(_datas) do
                    if isAll or data:IsShow() then -- 只要已读且不是选项对话都获取
                        table.insert(datas, data)
                    end
                end
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

--- 获取最新未读聊天数据
---@param sid 章节id
---@param isAll 包含选项数据和已读数据
function this:GetNewChatArr(sid, isAll)
    local datas = {}
    local listData = self:GetNewChatListData(sid)
    if listData then
        local _datas = self.chatDatas[listData:GetID()]
        if _datas then
            for _, data in pairs(_datas) do
                if isAll or not (data:IsShow() or data:IsOption()) then
                    table.insert(datas, data)
                end
            end
        end
        if #datas > 0 then
            table.sort(datas, function(a, b)
                return a:GetID() < b:GetID()
            end)
        end
    end
    return datas
end

--- 获取选项聊天数据（已选）
---@param sid 章节id
---@param groupId 聊天组id
function this:GetOptionChatArr(sid, groupId)
    local datas = {}
    if self.chatListDatas and self.chatListDatas[sid] then
        for k, v in pairs(self.chatListDatas[sid]) do
            if not groupId or v:GetID() == groupId then
                local _datas = self.chatDatas[v:GetID()]
                if _datas then
                    for _, data in pairs(_datas) do
                        if data:IsShow() and data:IsOption() then -- 只要已读都获取
                            table.insert(datas, data)
                        end
                    end
                end
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

-- 某条聊天是否已被服务器记录
function this:CheckChatIsRead(chatId)
    if self.chatInfos then
        for sid, v in pairs(self.chatInfos) do
            for groupId, m in pairs(v) do
                if m[chatId] ~= nil then
                    return true
                end
            end
        end
    end
    return false
end
-----------------------------------------------剧情-----------------------------------------------
function this:SetStoryInfo(proto)
    if proto and proto.chapterId then
        self:InitStoryListDatas(proto.chapterId)
        if proto.nodeIds and #proto.nodeIds > 0 then
            for _, id in ipairs(proto.nodeIds) do
                if self.storyListDatas[proto.chapterId][id] then
                    self.storyListDatas[proto.chapterId][id]:SetIsPass(true)
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.LovePlus_Story_Update)
end

function this:InitStoryListDatas(sid)
    if self.storyListDatas[sid] == nil then
        self.storyListDatas[sid] = {}
        local cfgs = Cfgs.CfgDateParagraph:GetGroup(sid)
        if cfgs then
            for k, v in pairs(cfgs) do
                local data = LovePlusStoryListData.New()
                data:Init(v)
                self.storyListDatas[sid][v.id] = data
            end
        end
    end
end

function this:GetStoryListArr(sid)
    local datas = {}
    if self.storyListDatas[sid] then
        for _, listData in pairs(self.storyListDatas[sid]) do
            table.insert(datas, listData)
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

function this:GetStoryListData(id, sid)
    if sid then
        return self.storyListDatas[sid] and self.storyListDatas[sid][id]
    elseif id then
        for _, listDatas in pairs(self.storyListDatas) do
            if listDatas and listDatas[id] then
                return listDatas[id]
            end
        end
    end
end

--- 获取上一次剧情
function this:GetStorySaveInfo()
    return self.lastStoryInfo
end

function this:ClearStorySaveInfo()
    self.lastStoryInfo = nil
end

--- 获取有用信息缓存起来
---@param info 存档内容
function this:CheckStortInfo(info)
    if info and info.ids then -- 剧情id
        for _, id in ipairs(info.ids) do
            self.readPlotIds[id] = 1
            local cfg = Cfgs.CfgDateStory:GetByID(id)
            if cfg then
                if cfg.highLight then
                    self.highLights[cfg.id] = 1
                end
            end
        end
    end
end

--- 开始节点
---@param sid 章节id
---@param storyId 行程id
---@param cb 回调
function this:TryOpenPlot(sid, nId, cb)
    LovePlusProto:StartNode(sid, nId, cb)
end

--- 完成节点
---@param sid 章节id
---@param nId 行程id
---@param cb 回调
function this:TryClosePlot(sid, nId, cb)
    LovePlusProto:FinishNode(sid, nId, self:GetReadArr(), cb)
end

---节点存档
---@param sid 章节id
---@param nId 行程id
---@param cb 回调
function this:TrySavePoint(sid, nId, cb)
    LovePlusProto:SaveNode(sid, nId, self:GetReadArr(), cb)
end

--- 退出节点
---@param sid 章节id
---@param nId 行程id
---@param cb 回调
function this:ExitPlot(sid, nId, cb)
    LovePlusProto:DropOut(sid, nId, self:GetReadArr(), cb)
end

-- 缓存已读剧情id
function this:SetReadPlot(plotId)
    self.readPlotIds[plotId] = 1
end

function this:IsPlotRead(plotId)
    return self.readPlotIds[plotId] ~= nil
end

function this:ClearReadPlot()
    self.readPlotIds = {}
end

function this:GetReadArr()
    local arr = {}
    if self.readPlotIds then
        for k, v in pairs(self.readPlotIds) do
            table.insert(arr, k)
        end
    end
    if #arr > 0 then
        table.sort(arr, function(a, b)
            return a < b
        end)
    end
    return arr
end

-- 缓存已标记剧情id
function this:SetHighLight(plotId)
    self.highLights[plotId] = 1
end

function this:ClearHighLights()
    self.highLights = {}
end

-- 达成出现条件
function this:CheckIsAchieved(info)
    if info and #info > 1 then
        local type = info[1]
        if type == 1 then
            local num = 0
            local need = info[2]
            for k, v in pairs(self.highLights) do
                if v ~= nil then
                    num = num + 1
                end
            end
            return num >= need
        else
            local id = info[2]
            return self.highLights[id] ~= nil
        end
    end
    return false
end

-----------------------------------------------剧情解锁-----------------------------------------------
function this:SetUnLockInfos(proto)
    if proto then
        self:UpdateUnLockInfo(eLovePlusUnLockType.Img, proto.imgIds)
        self:UpdateUnLockInfos(proto.unlockData)
        if proto.chapterId then
            self.redDatas[proto.chapterId] = proto.isRed == true and 1 or nil
            if proto.completeProgress and self.datas and self.datas[proto.chapterId] then
                self.datas[proto.chapterId]:SetPrograss(proto.completeProgress)
            end
        end
    end
    EventMgr.Dispatch(EventType.LovePlus_Story_Update)
    self:CheckRedPointData()
end

function this:UpdateUnLockInfos(info)
    if info then
        self:UpdateUnLockInfo(eLovePlusUnLockType.CG, info.CGIds)
        self:UpdateUnLockInfo(eLovePlusUnLockType.Chat, info.chatGroupIds)
        self:UpdateUnLockInfo(eLovePlusUnLockType.Label, info.labelIds)
        self:UpdateUnLockInfo(eLovePlusUnLockType.Story, info.nodeIds)
    end
end

function this:UpdateUnLockInfo(type, ids)
    self.unLockInfos[type] = self.unLockInfos[type] or {}
    if ids and #ids > 0 then
        for i, v in ipairs(ids) do
            self.unLockInfos[type][v] = 1
        end
    end
end

function this:IsOpen(type, id)
    return self.unLockInfos[type] and self.unLockInfos[type][id] ~= nil
end

function this:IsCommOpen(plotId)
    if self.readPlotIds and self.readPlotIds[plotId] ~= nil then
        return true
    end
    if self:IsOpen(eLovePlusUnLockType.Shop, plotId) then
        return true
    end
    return false
end
---------------------------------------------红点---------------------------------------------

function this:CheckRedPointData()
    local func = function()
        self.isCheckRed = false
        local isRed = false
        if self.redDatas then
            for k, v in pairs(self.redDatas) do
                if v ~= nil then
                    isRed = true
                    break
                end
            end
        end
        RedPointMgr:UpdateData(RedPointType.LovePlus, isRed and 1 or nil)
    end
    if self.isCheckRed then -- 延迟刷新
        return
    end
    self.isCheckRed = true
    FuncUtil:Call(func, nil, 50)
end

function this:CheckRed(sid)
    return self.redDatas and self.redDatas[sid] ~= nil
end

-- 聊天 只在章节界面有用
function this:CheckChatRed(sid)
    return self.newChatListDatas and self.newChatListDatas[sid] ~= nil
end

---------------------------------------------new---------------------------------------------
function this:CheckChatNew()
    if self.newChatRecord == nil then --第一次检测
        self.newChatRecord = {}
        for k, v in pairs(self.newChatListDatas) do
            self.newChatRecord[k] = {id = v:GetID(),isNew = false}
        end
    else
        for k, v in pairs(self.newChatListDatas) do
            if not self.newChatRecord[k] or self.newChatRecord[k].id ~= v:GetID() then
                self.newChatRecord[k] = {id = v:GetID(), isNew = true}
            end
        end
    end
end

function this:SetChatNew(sid,b)
    if sid then
        self.newChatRecord = self.newChatRecord or {}
        self.newChatRecord[sid] = self.newChatRecord[sid] or {}
        self.newChatRecord[sid].isNew = b
    end
end

function this:GetChatNew(sid)
    return self.newChatRecord and self.newChatRecord[sid] and self.newChatRecord[sid].isNew
end

return this

LovePlusProto = {}

--获取章节缩略信息
function LovePlusProto:GetChapterSimpleInfo()
    local proto = {"LovePlusProto:GetChapterSimpleInfo", {}}
    NetMgr.net:Send(proto);
end

--获取章节缩略信息返回
function LovePlusProto:GetChapterSimpleInfoRet(proto)
    LovePlusMgr:SetDatas(proto)
end

--获取与章节关联数据
function LovePlusProto:GetChapterData(sid,cb)
    self.ChapterDataRetCallBack = cb
    local proto = {"LovePlusProto:GetChapterData", {chapterId = sid}}
    NetMgr.net:Send(proto);
end

--获取当前章节所有数据完成后返回
function LovePlusProto:GetChapterDataRet(proto)
    if self.ChapterDataRetCallBack then
        self.ChapterDataRetCallBack()
        self.ChapterDataRetCallBack = nil
    end
end

--存储聊天数据
function LovePlusProto:SaveChatData(sid,groupId,ids)
    local proto = {"LovePlusProto:SaveChatData", {chapterId = sid,chatGroupId = groupId,chatIds = ids}}
    NetMgr.net:Send(proto);
end

--返回聊天数据
function LovePlusProto:ChatDataRet(proto)
    LovePlusMgr:SetChatInfos(proto)
end

--请求节点数据
function LovePlusProto:GetNodeData(sid)
    local proto = {"LovePlusProto:GetNodeData", {chapterId = sid}}
    NetMgr.net:Send(proto);
end

--节点数据返回
function LovePlusProto:NodeDataRet(proto)
    LovePlusMgr:SetStoryInfo(proto)
    if self.dropOutCallBack then
        self.dropOutCallBack()
        self.dropOutCallBack= nil
    end
    if self.finishNodeCallBack then
        self.finishNodeCallBack()
        self.finishNodeCallBack = nil
    end
end

--节点开始
function LovePlusProto:StartNode(sid,id,cb)
    self.startNodeCallBack = cb
    local proto = {"LovePlusProto:StartNode", {chapterId = sid,nodeId = id}}
    NetMgr.net:Send(proto);
end

--节点开始返回
function LovePlusProto:StartNodeRet(proto)
    if self.startNodeCallBack then
        self.startNodeCallBack()
        self.startNodeCallBack = nil
    end
end

--节点完成
function LovePlusProto:FinishNode(sid,storyId,ids,cb)
    self.finishNodeCallBack = cb
    local proto = {"LovePlusProto:FinishNode", {nodeInfo = {chapterId = sid,nodeId = storyId,storyIds=ids}}}
    NetMgr.net:Send(proto);
end

--剧情中途退出
function LovePlusProto:DropOut(sid,storyId,ids,cb)
    self.dropOutCallBack = cb
    local proto = {"LovePlusProto:DropOut", {nodeInfo = {chapterId = sid,nodeId = storyId,storyIds=ids}}}
    NetMgr.net:Send(proto);
end

--剧情存档点保存
function LovePlusProto:SaveNode(sid,storyId,ids,cb)
    self.saveNodeCallBack = cb
    local proto = {"LovePlusProto:SaveNode", {nodeInfo = {chapterId = sid,nodeId = storyId,storyIds=ids}}}
    NetMgr.net:Send(proto);
end

--剧情存档点保存返回
function LovePlusProto:SaveNodeRet(proto)
    if self.saveNodeCallBack then
        self.saveNodeCallBack()
        self.saveNodeCallBack = nil
    end
end

--剧情幕解锁相关下发
function LovePlusProto:SendUnlockItems(proto)
    LovePlusMgr:SetUnLockInfos(proto)
end


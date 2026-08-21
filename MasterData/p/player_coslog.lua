-- Desc: 上报存储桶
---@class Player
local Player = require "Player"
local skynet, GameGlobal
if GV.IsServer then
    skynet = require "skynet"
    GameGlobal = require "GameGlobal"
end


--抽卡记录一次上传数量
local putGachaRecordNum = 100
--抽卡记录上传目录
local putGachaRecordPath = "gachaRecord/"
--抽卡记录上传目录最大数量
local putGachaRecordPathMax = 10
--邮件收藏上传目录
local putMailCollectPath = "mailCollect/"

--临时url预留5分钟
local tempUrlReserveTime = 5 * 60

-- --获得当前渠道区服目录
-- ---@return string
-- function Player:getChannelCosPath()
--     --渠道目录
--     local channel_cos = skynet.getenv("channel_cos")
--     --区服目录
--     local zeroPath = string.format("server_%d/", tonumber(skynet.getenv("zone")))
--     --skynet.getenv("nodename")

--     local path = string.format("%s/%s", channel_cos, zeroPath)
--     return path
-- end


--登录检测cosUrl更新
function Player:loginUpdateCosUrls()
    if not GV.IsServer then
        return
    end

    local nowTime = os.time()

    --抽卡记录
    local recordData = self:getGachaData().recordData
    for cardType, recordInfo in pairs(recordData or {}) do
        for _, cosInfo in pairs(recordInfo.pathkeyList) do
            if not cosInfo.tempUrl or not cosInfo.periodEnd or cosInfo.periodEnd <= nowTime + tempUrlReserveTime then
                local urlInfo = GameGlobal.LogCosReqCosUrl({pathKey = cosInfo.pathKey})
                cosInfo.tempUrl = urlInfo.url
                cosInfo.periodEnd = urlInfo.periodEnd
            end
        end
    end

    --邮件收藏
    local mailCollectData = self:getMailCollectData()
    for mailId, cosInfo in pairs(mailCollectData or {}) do
        if cosInfo.state then
            if not cosInfo.tempUrl or not cosInfo.periodEnd or cosInfo.periodEnd <= nowTime + tempUrlReserveTime then
                local urlInfo = GameGlobal.LogCosReqCosUrl({pathKey = cosInfo.pathKey})
                cosInfo.tempUrl = urlInfo.url
                cosInfo.periodEnd = urlInfo.periodEnd
            end
        end
    end

    --战报上传 todo

end

--检测cosUrl更新
--只检测刚上传成功的数据
---@param proto table 玩家信息变更
function Player:updateCosUrls(proto)
    if not GV.IsServer then
        return
    end

    --抽卡记录
    local recordData = self:getGachaData().recordData
    for cardType, recordInfo in pairs(recordData or {}) do
        local isproto = false
        for _, cosInfo in pairs(recordInfo.pathkeyList) do
            if not cosInfo.tempUrl then
                local urlInfo = GameGlobal.LogCosReqCosUrl({pathKey = cosInfo.pathKey})
                cosInfo.tempUrl = urlInfo.url
                cosInfo.periodEnd = urlInfo.periodEnd
                isproto = true
            end
        end
        if isproto and proto then
            if not proto.gachaData then
                proto.gachaData = {}
            end
            if not proto.gachaData.recordData then
                proto.gachaData.recordData = {}
            end
            proto.gachaData.recordData[cardType] = recordInfo
            proto.gachaData = self:propToProto("gachaData", proto.gachaData)
        end
    end

    -- --邮件收藏 上传成功的数据可以从玩家信息中获得，不需要获得新的url
    -- local mailCollectData = self:getMailCollectData()
    -- for mailId, cosInfo in pairs(mailCollectData or {}) do
    --     local isproto = false
    --     if cosInfo.state then
    --         if not cosInfo.tempUrl then
    --             local urlInfo = GameGlobal.LogCosReqCosUrl({pathKey = cosInfo.pathKey})
    --             cosInfo.tempUrl = urlInfo.url
    --             cosInfo.periodEnd = urlInfo.periodEnd
    --             isproto = true
    --         end
    --     end
    --     if isproto and proto then
    --         if not proto.mailCollect then
    --             proto.mailCollect = {}
    --         end
    --         proto.mailCollect[mailId] = cosInfo.tempUrl
    --     end
    -- end

    --战报上传 todo
end

--上传抽卡记录
function Player:putGachaRecordList()
    if not GV.IsServer then
        return
    end

    local gachaRecordInfo = self:getGachaRecordInfo()
    if not gachaRecordInfo then
        return
    end

    --检测删除旧的抽卡记录(放前面，不受当前数量限制)
    if tablex.size(gachaRecordInfo.pathkeyList) > putGachaRecordPathMax then
        local pathKey = gachaRecordInfo.pathkeyList[1].pathKey
        local ret = GameGlobal.LogCosDeleteCosLog({pathKey = pathKey})
        if ret then
            tablex.removeproxy(gachaRecordInfo.pathkeyList, 1)
        else
            LuaLogger.es("gacha deleteCosLog failed")
        end
    end

    --上报检测
    local recordNum = tablex.size(gachaRecordInfo.recordList)
    if recordNum < putGachaRecordNum then
        return
    end

    --获得本次上传的抽卡记录
    local putList = tablex.slice(gachaRecordInfo.recordList, recordNum - putGachaRecordNum + 1, recordNum)
    local str = luautil.serialize(putList)

    --获得当前目录
    local currentDir = DLuaUtil.GetCurrentChannelDir()
    local fileName = string.format("%s_%d.txt",self.uid, gachaRecordInfo.count)
    --获得当前上传目录:渠道目录/区服目录/gachaRecord/
    local path = string.format("%s%s", currentDir, putGachaRecordPath)
    local pathKey = path .. fileName
    --上报存储桶
    local ret = GameGlobal.LogCosWriteCosLog({
        fileName = fileName,
        path = path,
        str = str
    })
    if ret then
        --上传成功，删除本次上传的抽卡记录
        for i = 1, putGachaRecordNum do
            tablex.removeproxy(gachaRecordInfo.recordList, recordNum - i + 1)
        end
        gachaRecordInfo.count = gachaRecordInfo.count + 1
        tablex.insertproxy(gachaRecordInfo.pathkeyList, {
            pathKey = pathKey,
            -- tempUrl = nil,
            -- periodEnd = nil,
        })
        self.isPutCosLog = true
    else
        --上传失败，不删除本次上传的抽卡记录
        LuaLogger.es("gacha writeCosLog failed")
    end
end

--邮件收藏上传
---@param mailInfo MailInfo 邮件数据
---@param mailCollectInfo MailCollectInfo 邮件收藏数据
function Player:putMailCollect(mailInfo, mailCollectInfo)
    if not GV.IsServer then
        return
    end

    local str = luautil.serialize(mailInfo)

    --获得当前目录
    local currentDir = DLuaUtil.GetCurrentChannelDir()
    local fileName = string.format("%s_%d.txt",self.uid, mailInfo.id)
    --获得当前上传目录:渠道目录/区服目录/mailCollect/
    local path = string.format("%s%s", currentDir, putMailCollectPath)
    local pathKey = path .. fileName
    --上报存储桶
    local ret = GameGlobal.LogCosWriteCosLog({
        fileName = fileName,
        path = path,
        str = str
    })
    if ret then
        mailCollectInfo.pathKey = pathKey
        mailCollectInfo.state = true
    else
        LuaLogger.es("putMailCollect writeCosLog failed")
    end
end

--邮件收藏删除,退出登录后删除
function Player:deleteMailCollect()
    if not GV.IsServer then
        return
    end

    for k, v in pairs(self.mailCollect) do
        if not v.state then
            local ret = GameGlobal.LogCosDeleteCosLog({pathKey = v.pathKey})
            if ret then
                self.mailCollect[k] = nil
            else
                LuaLogger.es("deleteMailCollect deleteCosLog failed")
            end
        end
    end
end

--战报上传

return Player
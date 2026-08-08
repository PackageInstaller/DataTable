local CosTen = {}
local crypt = require "crypt"


local _doomsdayTime = os.time({year=2030,month=1,day=1,hour=0,min=0,sec=0})
--_doomsdayTime = 1893427200
--2208960000

function CosTen.GetHostUrlAuthWithKey(host, url, secretId, secretKey, method, contentLen)
    local StartTimeStamp = 0
    local EndTimeStamp = _doomsdayTime

    local KeyTime = string.format("%d;%d", StartTimeStamp, EndTimeStamp)
    local SignKey = stringx.toHexStr(crypt.hmac_sha1(secretKey, KeyTime))
    local HeaderList = "host"
    local HttpHeaders = string.format("host=%s", host)

    local HttpString = string.format("%s\n%s\n\n%s\n", method or "get", url, HttpHeaders)
    local StringToSign = string.format("sha1\n%s\n%s\n", KeyTime, stringx.toHexStr(crypt.sha1(HttpString)))
    local Signature = stringx.toHexStr(crypt.hmac_sha1(SignKey, StringToSign))
    local Authorization = string.format(
            "q-sign-algorithm=sha1&q-ak=%s&q-sign-time=%s&q-key-time=%s&q-header-list=%s&q-url-param-list=&q-signature=%s", secretId, KeyTime, KeyTime, HeaderList, Signature)

    return Authorization
end

function CosTen.GetAuditingHostUrl()
    return _auditingHost, _auditingDataUrl
end

function CosTen.GetAuditingServerDataAuth()
    return CosTen.GetHostUrlAuthWithKey(_auditingHost, _auditingDataUrl, _auditingSecretId, _auditingsecretKey)
end

-- 以下为客户端需求函数
if not GV.IsServer then
function SDContent(path, content, callback, showLoader)
    local reqbody = content
    local host, url = GlobalInfo.ResConfig.resHost, path
    local secretId, secretKey = GlobalInfo.ResConfig.secretId, GlobalInfo.ResConfig.secretKey
    local Authorization = CosTen.GetHostUrlAuthWithKey(host, url, secretId, secretKey, "put", #reqbody)
    local dict = {}
    table.insert(dict, "authorization")
    table.insert(dict, Authorization)

    local loaderId
    if showLoader then
        loaderId = UIMgr:startLoad(1)
    end

    LuaLogger.ds("Authorization", Authorization)
    HttpUtil.HttpPutBytesInLua("http://"..host..url, reqbody, 10000, dict, function(respcode, responseJson)
        if showLoader then
            UIMgr:endLoad(loaderId)
        end

        LuaLogger.ds(respcode, responseJson)
        if respcode == 200 then
            callback(true)
        else
            callback(false)
        end
    end)
end

function SDBattleLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    --local cps = DCompress.compress_lzma(content);
    SDContent("/log_battle/amisc/" .. fileName, cps, callback)
    --local dps = DCompress.decompress_lzma(cps);
end

local _isServerCheck
local _rawBattleOldLogPath = "/log_battle/"
local _rawBattleLogPath = "/log_battle/amisc/"
local _serverCheckBattleLogPath = "/log_battle/aservercheck/"
local _arenaBattleLogPath = "/log_battle/arena/"
local _towerFirstPassBattleLogPath = "/log_battle/atower_first/"
local _guildtrainBattleLogPath = "/log_battle/aguildtrain/"
local _towerYinyangBattleLogPath = "/log_battle/atower_yinyang/"
local function _SDTowerFirstBattleLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    SDContent(_towerFirstPassBattleLogPath .. fileName, cps, callback) -- 就是atower
end

function SDErrorLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    SDContent("/log_battle/aerror_log/" .. fileName, cps, callback)
end

function SDTowerFirstPassBattleLogByBattleId(battleId, formationStr, result, callback)
    local formationLogName, resultLogName = GetBattleLogName(battleId)

    local formationSuccess, resultSuccess

    local function finished()
        if formationSuccess ~= nil and resultSuccess ~= nil then
            callback(formationSuccess and resultSuccess)
        end
    end

    _SDTowerFirstBattleLog(formationLogName, formationStr, function (success)
        formationSuccess = success
        finished()
    end)

    _SDTowerFirstBattleLog(resultLogName, result, function (success)
        resultSuccess = success
        finished()
    end)
end

function SDArenaBattleLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    --local cps = DCompress.compress_lzma(content);
    --SDContent("/log_battle/" .. fileName, cps, callback)
    SDContent("/log_battle/arena/" .. fileName, cps, callback, true)
    --local dps = DCompress.decompress_lzma(cps);
end

function SDGuildTrainBattleLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    --local cps = DCompress.compress_lzma(content);
    --SDContent("/log_battle/" .. fileName, cps, callback)
    SDContent(_guildtrainBattleLogPath .. fileName, cps, callback, true)
    --local dps = DCompress.decompress_lzma(cps);
end

function SDActivity51BattleLog(fileName, content, callback)
    local cps = DCompress.compress_gz(content);
    --local cps = DCompress.compress_lzma(content);
    --SDContent("/log_battle/" .. fileName, cps, callback)
    SDContent("/log_battle/aactivity51/" .. fileName, cps, callback, true)
    --local dps = DCompress.decompress_lzma(cps);
end

function GTContent(path, callback)
    local host, url = GlobalInfo.ResConfig.resHost, path
    local secretId, secretKey = GlobalInfo.ResConfig.secretId, GlobalInfo.ResConfig.secretKey
    local Authorization = CosTen.GetHostUrlAuthWithKey(host, url, GlobalInfo.ResConfig.secretId, GlobalInfo.ResConfig.secretKey)

    local dict = {}
    table.insert(dict, "authorization")
    table.insert(dict, Authorization)
    local loaderId = UIMgr:startLoad(1)
    local timeout = 10000
    HttpUtil.HttpGetByteInLua("http://"..host..url, timeout, dict, function(respcode, response)
        UIMgr:endLoad(loaderId)
        LuaLogger.ws(respcode, response)
        if respcode == 200 then
            callback(true, response)
        else
            callback(false, {error = GE.PassportErrorCode.GetLoginInfoFailed})
        end
    end)
end

function GTBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_rawBattleLogPath, battleId, uid, callback)
end

function GTChallengeBattleLog(season, battleId, uid1, uid2, callback)
    local battleFormationFileName = string.format("battle-%d-%d-%d-formation.lua.gz", battleId, uid1, uid2)
    local battleResultFileName = string.format("battle-%d-%d-%d-result.lua.gz", battleId, uid1, uid2)
    print("battleFormationFileName", battleFormationFileName)
    print("battleResultFileName", battleResultFileName)
    GTContent("/log_battle/ashouqilei/" .. season .. "/".. battleFormationFileName, function(success, content)
        print("success", success)
        if success and content then
            content = tolua.tolstring(content)
            local battleFormation = DCompress.decompress_gz(content);
            GTContent("/log_battle/ashouqilei/" .. season .. "/".. battleResultFileName, function(success, content)
                print("success", success)
                if success and content then
                    content = tolua.tolstring(content)
                    local battleResult = DCompress.decompress_gz(content);
                    callback(true, battleFormation, battleResult)
                else
                    callback(false)
                end
            end)
        else
            callback(false)
        end
    end)
end

function GTCloudArenaBattleLog(season, battleId, uid1, uid2, callback)
    local battleFormationFileName = string.format("battle-%d-%d-%d-formation.lua.gz", battleId, uid1, uid2)
    local battleResultFileName = string.format("battle-%d-%d-%d-result.lua.gz", battleId, uid1, uid2)
    print("battleFormationFileName", battleFormationFileName)
    print("battleResultFileName", battleResultFileName)
    GTContent("/log_battle/acloudarena/" .. season .. "/".. battleFormationFileName, function(success, content)
        print("success", success)
        if success and content then
            content = tolua.tolstring(content)
            local battleFormation = DCompress.decompress_gz(content);
            GTContent("/log_battle/acloudarena/" .. season .. "/".. battleResultFileName, function(success, content)
                print("success", success)
                if success and content then
                    content = tolua.tolstring(content)
                    local battleResult = DCompress.decompress_gz(content);
                    callback(true, battleFormation, battleResult)
                else
                    callback(false)
                end
            end)
        else
            callback(false)
        end
    end)
end

function GTTowerYinyangBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_towerYinyangBattleLogPath, battleId, uid, callback)
end

function GetBattleLogName(battleId, uid)
    uid = uid and uid or Me.uid
    uid = uid or 0
    if not _isServerCheck then
        return string.format("battle-%d-%d-formation.lua.gz", battleId, uid), string.format("battle-%d-%d-result.lua.gz", battleId, uid)
    else
        return string.format("battle-%d-%d-formation-server.lua.gz", battleId, uid), string.format("battle-%d-%d-result-server.lua.gz", battleId, uid)
    end
    --return string.format("battle-%d-%d-formation.lua.lzma", battleId, Me.uid or 0), string.format("battle-%d-%d-result.lua.lzma", battleId, Me.uid or 0)
end

function GTBattleLogByPath(path, battleId, uid, callback)
    local battleFormationFileName, battleResultFileName = GetBattleLogName(battleId, uid)
    GTContent(path .. battleFormationFileName, function(success, content)
        if success and content then
            content = tolua.tolstring(content)
            local battleFormation = DCompress.decompress_gz(content);
            GTContent(path .. battleResultFileName, function(success, content)
                if success and content then
                    content = tolua.tolstring(content)
                    local battleResult = DCompress.decompress_gz(content);
                    callback(true, battleFormation, battleResult)
                else
                    callback(false)
                end
            end)
        else
            callback(false)
        end
    end)
end

function GTArenaBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_arenaBattleLogPath, battleId, uid, callback)
end

function GTRawBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_rawBattleLogPath, battleId, uid, callback)
end

function GTServerCheckBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_serverCheckBattleLogPath, battleId, uid, callback)
end

function GTOldRawBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_rawBattleOldLogPath, battleId, uid, callback)
end

function GTTowerFirstPassBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_towerFirstPassBattleLogPath, battleId, uid, callback)
end

function GTGuildTrainBattleLog(battleId, uid, callback)
    GTBattleLogByPath(_guildtrainBattleLogPath, battleId, uid, callback)
end

function GTBattleLogByTempGV(battleId, uid, gtFunc, callback)
    local originHost = GlobalInfo.ResConfig.resHost
    local originSecretId = GlobalInfo.ResConfig.secretId
    local originSecretKey = GlobalInfo.ResConfig.secretKey
    GlobalInfo.ResConfig.resHost = GV.FormalResHost
    GlobalInfo.ResConfig.secretId = GV.FormalSecretId
    GlobalInfo.ResConfig.secretKey = GV.FormalSecretKey
    gtFunc(battleId, uid, function (success, formation, result)
        LuaLogger.ds(success)
        callback(success, formation, result)
        GlobalInfo.ResConfig.resHost = originHost
        GlobalInfo.ResConfig.secretId = originSecretId
        GlobalInfo.ResConfig.secretKey = originSecretKey
    end)
end

function CommonFetch_GTChallengeBattleLog(callback, battleId, uid1, uid2, season)
    GTChallengeBattleLog(season, battleId, uid1, uid2, function (success, formation, result)
        if not success then -- 如果找不到，可能反了
            GTChallengeBattleLog(season, battleId, uid2, uid1, callback)
        else
            callback(success, formation, result)
        end
    end)
end

function CommonFetch_GTCloudArenaBattleLog(callback, battleId, uid1, uid2, season)
    GTCloudArenaBattleLog(season, battleId, uid1, uid2, function (success, formation, result)
        if not success then -- 如果找不到，可能反了
            GTCloudArenaBattleLog(season, battleId, uid2, uid1, callback)
        else
            callback(success, formation, result)
        end
    end)
end

function CommonFetch_GTTowerFirstBattleLog(callback, battleId, uid1)
    GTTowerFirstPassBattleLog(battleId, uid1, function (success, formation, result)
        callback(success, formation, result)
    end)
end

-- 如果是授气擂, battleId, uid1, uid2, season
function CommonFetch_GTBattleLogByTempGV(gtFunc, callback, ...)
    local originHost = GlobalInfo.ResConfig.resHost
    local originSecretId = GlobalInfo.ResConfig.secretId
    local originSecretKey = GlobalInfo.ResConfig.secretKey
    GlobalInfo.ResConfig.resHost = GV.FormalResHost
    GlobalInfo.ResConfig.secretId = GV.FormalSecretId
    GlobalInfo.ResConfig.secretKey = GV.FormalSecretKey
    gtFunc(function (success, formation, result)
        LuaLogger.ds(success)
        callback(success, formation, result)
        GlobalInfo.ResConfig.resHost = originHost
        GlobalInfo.ResConfig.secretId = originSecretId
        GlobalInfo.ResConfig.secretKey = originSecretKey
    end, ...)
end

function GTBattleLogServerCheckByTempGV(battleId, uid, gtFunc, callback)
    _isServerCheck = true
    GTBattleLogByTempGV(battleId, uid, gtFunc, callback)
    _isServerCheck = false
end
end

return CosTen
local ASMRData = require("ASMRData")
local this = MgrRegister("ASMRMgr")

function this:Clear()
    self.datas = {}
    self.gDatas = {}
end

function this:Init()
    self:Clear()
    self:InitCfg()
end

function this:InitCfg()
    self.datas = {}
    local cfgs = Cfgs.CfgASMR:GetAll()
    for k, v in ipairs(cfgs) do
        local _data = ASMRData.New()
        _data:Init(v)
        table.insert(self.datas, _data)
    end
end

function this:GetDatas()
    return self.datas
end

function this:GetData(id)
    for k, v in ipairs(self.datas) do
        if (v:GetID() == id) then
            return v
        end
    end
    return nil
end

-- 左右按钮红点
function this:CheckRedLR(index)
    local isRedL, isRedR = false, false
    for k, v in ipairs(self.datas) do
        if (k ~= index) then
            if (k < index and not isRedL) then
                isRedL = v:IsRed()
            elseif (k > index and not isRedR) then
                isRedR = v:IsRed()
            end
        end
        if (isRedL and isRedR) then
            break
        end
    end
    return isRedL, isRedR
end

---------------------------------------------------------------
function this.DownloadCV(cvName, callBack)
    local path = string.format("sounds_asmr/%s.acb", cvName)
    CSAPI.DownloadFile(path, callBack)
end

function this.IsDownloadedCV(cvName)
    local path = string.format("sounds_asmr/%s.acb", language, cvName)
    return this.IsDownloadedFile(path)
end

------------------------------------------------------bgm播放---------------------------------------------------------

-- 播放
function this:PlayBGM(_id, index, startTime)
    local cfg = Cfgs.CfgASMR:GetByID(_id)
    return self:_PlayBGM(cfg["cue_sheet" .. index], cfg["cue_name" .. index], 0, nil, nil, false, startTime)    
end
function this:PlayBGM_CB(_id, index, startTime,completeCallBack)
    
    local cfg = Cfgs.CfgASMR:GetByID(_id)
    return self:_PlayBGM(cfg["cue_sheet" .. index], cfg["cue_name" .. index], 0, nil, nil, false, startTime,completeCallBack)
    -- if tonumber(CS.CSAPI.APKVersion()) > 8 then
    --     local cfg = Cfgs.CfgASMR:GetByID(_id)
    --     return self:_PlayBGM(cfg["cue_sheet" .. index], cfg["cue_name" .. index], 0, nil, nil, false, startTime,completeCallBack)
    -- else
    --     local cfg = Cfgs.CfgASMR:GetByID(_id)
    --     local _source = self:_PlayBGM(cfg["cue_sheet" .. index], cfg["cue_name" .. index], 0, nil, nil, false, startTime)
    --     if(completeCallBack ~= nil) then completeCallBack(_source) end
    --     return _source
    -- end
end

function this:_PlayBGM(cueSheet, cueName, fadeDelay, volumeCoeff, lockKey, isLoop, startTime,completeCallBack)
    volumeCoeff = volumeCoeff or 100
    isLoop = isLoop or false
    return CSAPI.PlaySound(cueSheet, cueName, isLoop, false, "bgm", 0.5, nil, fadeDelay, volumeCoeff, startTime,completeCallBack)
end

-- 移除
function this:StopBGM(fadeSpeed)
    fadeSpeed = 0
    CSAPI.PlaySound("", "", false, false, "bgm", fadeSpeed or 0.5)
end

-- 移除缓存
function this:RemoveCueSheet(id, index)
    local cfg = Cfgs.CfgASMR:GetByID(id)
    local cueSheet = cfg["cue_sheet" .. index]
    CSAPI.RemoveCueSheet(cueSheet)
end

-- 恢复bgm
function this:ReplayBGM()
    CSAPI.bgmLast = nil
    local key = PlayerClient:GetUid() .. "_viewmusicid"
    local id = PlayerPrefs.GetInt(key)
    if (id == 0) then
        id = 1
        local cfgs = Cfgs.CfgMusic:GetAll()
        for k, v in pairs(cfgs) do
            if (v.InitialType == 1) then
                id = v.id
            end
        end
    end
    local cfg = Cfgs.CfgMusic:GetByID(id)
    EventMgr.Dispatch(EventType.Play_BGM_New, {
        bgm = cfg.cue_name_2,
        fadeTime = 0
    })
end

---------------------------------------------------------------------------------------------------------------

-- 物品更新（游戏中的更新推送）
function this:UpdateGoodsData(goodsData, setNew)
    -- 物品移除
    local isChange = false
    if (goodsData:GetCount() <= 0) then
        if (self.gDatas[goodsData:GetID()] ~= nil) then
            self.gDatas[goodsData:GetID()] = nil
            isChange = true
        end
    else
        if (setNew) then
            -- 新获得或者加时间
            if (not self.gDatas[goodsData:GetID()]) then
                self.gDatas[goodsData:GetID()] = {1, goodsData:GetHeadFrameExpiry()}
                isChange = true
            end
        end
    end
    if (isChange) then
        RedPointMgr:UpdateData(RedPointType.ASMR, self:RedNum())
    end
end
-- 是否有红点
function this:IsRed()
    for k, v in pairs(self.gDatas) do
        if (v[1] == 1) then
            return true
        end
    end
    return false
end

function this:RedNum()
    for k, v in pairs(self.gDatas) do
        if (v[1] == 1) then
            return 1
        end
    end
    return nil
end

function this:SetRed(itemID)
    if (self.gDatas and self.gDatas[itemID] ~= nil) then
        self.gDatas[itemID] = nil
    end
    local _data1 = self:RedNum()
    local _data2 = RedPointMgr:GetData(RedPointType.ASMR)
    if (_data1 ~= _data2) then
        RedPointMgr:UpdateData(RedPointType.ASMR, _data1)
    end
end

function this:CheckRed(goodsID)
    if (self.gDatas and self.gDatas[goodsID]) then
        return true
    end
    return false
end

function this:GetASMRMusicScale()
    local key = "asmrmusicscale"
    local scaleStr = PlayerPrefs.GetString(key)
    if (not StringUtil:IsEmpty(scaleStr)) then
        return tonumber(scaleStr)
    end
    return 80
end
function this:SetASMRMusicScale(num)
    local key = "asmrmusicscale"
    PlayerPrefs.SetString(key, tostring(num))
end

--0:单次播放   1:循环播放（本身）  2:循环播放（所有已获得的ASMR）
function this:GetASMRMusicPType()
    local key = "asmrmusicptype"
    return PlayerPrefs.GetInt(key) or 0
end
function this:SetASMRMusicPType(num)
    local key = "asmrmusicptype"
    PlayerPrefs.SetInt(key, num)
end

return this

-- 交易订单 item
local limitTypeStrs = {10213, 10214, 10215, 10212}
local timer = 0
local textMove = nil

function Awake()
    textMove = ComUtil.GetCom(ImageName,"TextMove")
end

function Update()
    if (wait1 and wait1.activeSelf and tNexGiftsEx) then
        if (Time.time > timer) then
            timer = Time.time + 1
            SetTime()
            if (TimeUtil:GetTime() > tNexGiftsEx) then
                tNexGiftsEx = nil
            end
        end
    end
end

function SetTime()
    if (tNexGiftsEx > 0 and tNexGiftsEx >= TimeUtil:GetTime()) then
        needTime = tNexGiftsEx - TimeUtil:GetTime()
    else
        needTime = 0
    end
    CSAPI.SetText(txtWaitTime, TimeUtil:GetTimeStr(needTime))
end

function Refresh(_data, _cb, _buildId, _tNexGiftsEx)
    data = _data
    cb = _cb
    buildId = _buildId
    tNexGiftsEx = _tNexGiftsEx

    isEmpty = data:IsEmpty()
    lockID = data:IsLock()
    id = data:GetID()
    rid = data:GetRid()
    cfg = id and data:GetCfg() or nil

    CSAPI.SetGOActive(empty, isEmpty)
    CSAPI.SetGOActive(entity, not isEmpty)
    if (isEmpty) then
        SetEmpty()
    else
        SetEntity()
    end
    SetBG()
end

function SetBG()
    local bgName = "img_60_03.png"
    if (not isEmpty) then
        bgName = (cfg ~= nil and cfg.isRare) and "img_60_01.png" or "img_60_02.png"
    end
    CSAPI.LoadImg(bg, "UIs/Matrix/" .. bgName, true, nil, true)
    if (not bgCG) then
        bgCG = ComUtil.GetCom(bg, "CanvasGroup")
    end
    bgCG.alpha = lockID and 0.3 or 1
end

function SetEmpty()
    local lockID = data:IsLock()
    CSAPI.SetGOActive(empty1, lockID == nil)
    CSAPI.SetGOActive(empty2, lockID ~= nil)
    if (lockID ~= nil) then
        LanguageMgr:SetText(txtLock, 10105, lockID)
    end
end

function SetEntity()
    CSAPI.SetGOActive(node, id ~= nil)
    -- wait
    if (id == nil) then
        local enoughNext = data:IsEnoughtForNext()
        CSAPI.SetGOActive(wait1, enoughNext)
        CSAPI.SetGOActive(wait2, not enoughNext)
        if (not enoughNext) then
            SetWait2()
        end
    else
        CSAPI.SetGOActive(wait1, false)
        CSAPI.SetGOActive(wait2, false)
    end

    local enough = data:IsEnough()
    if (id) then
        -- rare
        CSAPI.SetGOActive(objRare, cfg.isRare)
        -- name
        --CSAPI.SetText(txtName, cfg.name)
        if not IsNil(textMove) then
		    textMove:SetText(cfg.name)
	    end
        -- count
        local num = cfg.gets[1][2]
        CSAPI.SetText(txtCount, num .. "")
        -- icon
        local _cfg = Cfgs.ItemInfo:GetByID(cfg.gets[1][1])
        ResUtil.IconGoods:Load(icon, _cfg.icon)
        -- cnt
        local buyCnt = fid and cfg.friendByCnt or cfg.selfBuyCnt
        local buyLimitType = buyCnt[2]
        if (buyLimitType ~= 0) then
            CSAPI.SetGOActive(limit, true)
            LanguageMgr:SetText(txtLimit1, limitTypeStrs[buyLimitType])
            local cnt = data:BCnt() -- 可购买的数量
            local maxCnt = buyCnt[1]
            maxCnt = maxCnt or 0
            local num = (maxCnt - cnt) < 0 and 0 or (maxCnt - cnt)
            CSAPI.SetText(txtLimit2, string.format("%s/%s", num, maxCnt))
            CSAPI.SetGOActive(limitMask, cnt <= 0)
        else
            CSAPI.SetGOActive(limit, false)
            CSAPI.SetGOActive(limitMask, false)
        end
    else
        CSAPI.SetGOActive(limit, false)
        CSAPI.SetGOActive(limitMask, rid == nil)
    end
    -- pays
    local info = data:GetCRoleInfo()
    CSAPI.SetGOActive(objPay1, info ~= nil)
    if (info) then
        if (not item1) then
            ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", objPay1, function(go)
                item1 = ComUtil.GetLuaTable(go)
                item1.OnClick = function()
                    if (not fid) then
                        CSAPI.OpenView("DormSetRoleList", {buildId}, 18)
                    end
                end
                item1.Refresh(info, true)
            end)
        else
            item1.Refresh(info, true)
        end
    end
    -- cost
    CSAPI.SetGOActive(objPay2, id ~= nil)
    CSAPI.SetGOActive(objPay3, id ~= nil)
    if (id) then
        local cost = cfg.costs[1]
        local giftsExData = BagMgr:GetFakeData(cost[1])
        if (not item2) then
            ResUtil:CreateUIGOAsync("Grid/GridItem", objPay2, function(go)
                item2 = ComUtil.GetLuaTable(go)
                item2.Refresh(giftsExData)
                item2.SetClickCB(GridClickFunc.OpenInfo)
                item2.SetCount()
            end)
        else
            item2.Refresh(giftsExData)
            item2.SetCount()
        end
        -- count
        local neeCount = cost[2]
        local hadNum = BagMgr:GetCount(cost[1])
        local strID = enough and 10108 or 10109
        local code = enough and "ffffff" or "ff7781"
        LanguageMgr:SetText(txtPay2, strID)
        CSAPI.SetTextColorByCode(txtPay2, code)
        CSAPI.SetText(txtPay1, "" .. neeCount)
    end
    -- btn
    local btnBgName = enough and "btn_22_01.png" or "btn_22_02.png"
    if (limitMask.activeSelf) then
        btnBgName = "btn_22_02.png"
    end
    CSAPI.LoadImg(imgTrading, "UIs/Matrix/" .. btnBgName, true, nil, true)
    local btnBgStrID = id and 10007 or 10127
    LanguageMgr:SetText(txtTrading, btnBgStrID)
end

-- pl不足下一次刷新
function SetWait2()
    local rid = data:GetRid()
    if (rid) then
        local cRoleInfo = CRoleMgr:GetData(rid)
        local curTv = cRoleInfo:GetCurRealTv()
        CSAPI.SetText(txtPL, string.format("%s/%s", curTv, 100))
        MatrixMgr:SetFace(face, curTv)
    end
end

-- 交易
function OnClickTrading()
    if (limitMask.activeSelf) then
        return
    end
    if (cb) then
        cb(data)
    end
end

function SetFid(_fid)
    fid = _fid
end

-- 添加驻员
function OnClickAdd()
    if (not fid) then
        CSAPI.OpenView("DormSetRoleList", {buildId}, 18)
    end
end

function OnClickIcon()
    if (id) then
        local _data = BagMgr:GetFakeData(cfg.gets[1][1])
        GridClickFunc.OpenInfo({
            data = _data
        })
    end
end


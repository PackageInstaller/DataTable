local ids = {10035, 10002}
local freeCnt = 0

function Awake()
    CSAPI.SetGOActive(mask, false)
    CSAPI.SetGOActive(bg, false)
end

function OnOpen()
    local id = data[1]
    parentP = data[2]
    --
    SetFree()
    --
    local cfg = Cfgs.cfgColosseum:GetByID(id)
    local cost = cfg.randomCost
    if (openSetting and openSetting == 1) then
        cost = cfg.optionalCost
    end
    if (cost) then
        CSAPI.SetGOActive(mask, true)
        CSAPI.SetGOActive(bg, true)
        for k, v in ipairs(cost) do
            SetDetail(k, v)
        end
        CSAPI.SetGOAlpha(btnL, enough1 and 1 or 0.3)
        CSAPI.SetGOAlpha(btnR, enough2 and 1 or 0.3)
    else
        -- 不用钱
        AbattoirProto:StartMod(openSetting, 1, BuyCB)
    end
    --
    SetFree()
end

function SetFree()
    freeCnt = ColosseumMgr:GetFreeInfo()
    LanguageMgr:SetText(txtFree, 64039, freeCnt)
end

function SetDetail(k, v)
    local cfg = Cfgs.ItemInfo:GetByID(v[1])
    local img1 = k == 1 and imgL1 or imgR1
    ResUtil.IconGoods:Load(img1, cfg.icon .. "_1")
    local img2 = k == 1 and imgL2 or imgR2
    ResUtil.IconGoods:Load(img2, cfg.icon .. "_1")
    local txt1 = k == 1 and txtL1 or txtR1
    CSAPI.SetText(txt1, freeCnt > 0 and "x0" or ("x" .. v[2]))
    local count = BagMgr:GetCount(v[1])
    local txt2 = k == 1 and txtL2 or txtR2
    CSAPI.SetText(txt2, "x" .. count)
    if (k == 1) then
        enough1 = freeCnt > 0 and true or (v[2] <= count)
    else
        enough2 = freeCnt > 0 and true or (v[2] <= count)
    end
end

function OnClickL()
    if (enough1) then
        AbattoirProto:StartMod(openSetting, 1, BuyCB)
    end
end

function OnClickR()
    if (enough2) then
        AbattoirProto:StartMod(openSetting, 2, BuyCB)
    end
end

function BuyCB(proto)
    local panelName = proto.modType==1 and "ColosseumM" or "ColosseumMRandom"
    CSAPI.OpenView(panelName, nil, proto.modType)
    if (parentP) then
        parentP()
    end
    view:Close()
end

function OnClickMask()
    view:Close()
end

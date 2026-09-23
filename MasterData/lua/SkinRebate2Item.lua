local isBuy = false
local isGet = false
local isShopBuy = false
local cfgComm = nil

function Awake()
    InitAnim()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    data = _data
    isShopBuy = _elseData or false
    if data then
        isBuy = data:HasCommodity()
        isGet = data:GetState() == 1
        cfgComm = isBuy and Cfgs.CfgCommodity:GetByID(data:GetCommodityId()) or nil
        SetIcon()
        SetDesc()
        SetState()
    end
end

function SetIcon()
    CSAPI.SetGOActive(iconParent,isBuy)
    CSAPI.SetGOActive(iconSel,isBuy)
    -- CSAPI.SetGOActive(iconEmpty, not isBuy)
    if cfgComm then
        local list = GridUtil.GetGridObjectDatas2(cfgComm.jGets)
        local goodsData = list and list[1]
        if goodsData and  goodsData:GetIcon() then
            ResUtil.RoleCard:Load(icon,goodsData:GetIcon())
        end
    end
end

function SetDesc()
    LanguageMgr:SetText(txtDesc,45037,math.floor(data:GetPercentage() * 100) .. "%")
end

function SetState()
    CSAPI.SetGOActive(btnFinish,isShopBuy and isBuy and not isGet)
    CSAPI.SetGOActive(btnLock, not isShopBuy and isBuy and not isGet)
    CSAPI.SetGOActive(btnJump,not isBuy)
    CSAPI.SetGOActive(txt_get, isGet)
    CSAPI.SetGOActive(mask2,isGet)
    CSAPI.SetText(txtNum1,math.ceil(data:GetPrice() * data:GetPercentage()) .. "")
    CSAPI.SetText(txtNum2,math.ceil(data:GetPrice() * data:GetPercentage()) .. "")
end

function OnClickIcon()
    if not isBuy then
        JumpMgr:Jump(140040)
    end
end

function OnClickJump()
    if not isBuy then
        JumpMgr:Jump(140040)
    end
end

function OnClickGet()
    if isShopBuy and isBuy and not isGet then
        OperateActiveProto:GetOldSkinRebateReward(data:GetCommodityId())
    end
end

function OnClickLock()
    if cb then
        cb(this)
    end
end

---------------------------------------------anim---------------------------------------------
local anim = nil

function InitAnim()
    anim = ComUtil.GetCom(node,"Animator")
end

function ShowEnterAnim(delay)
    CSAPI.SetGOAlpha(node,0)
    FuncUtil:Call(function ()
        CSAPI.SetGOAlpha(node,1)
        if not IsNil(anim) then
            anim:Play("entry")
        end
    end,this, delay)
end
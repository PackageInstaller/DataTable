local textMove = nil

function Awake()
    textMove = ComUtil.GetCom(ImageName, "TextMove")
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    isShow = _elseData and _elseData.isShow
    if _elseData and _elseData.skinId then
        isGet = OperationActivityMgr:IsSkinRebateGet(_elseData.skinId, data:GetID())
        isFinish = OperationActivityMgr:IsSkinRebateFinish(_elseData.skinId, data:GetID())
    end
    if data then
        SetIcon()
        SetCount()
        SetState()
        SetSkin()
    end
end

function SetIcon()
    ResUtil.CardIcon:Load(icon, data:GetIcon());
end

function SetCount()
    local cfg = data:GetCfg()
    if cfg and cfg.rewardID and cfg.rewardID[1] then
        local reward = cfg.rewardID[1]
        CSAPI.SetText(txtNum, "" .. (reward and reward[2] or 0))
        local cfgItem = Cfgs.ItemInfo:GetByID(reward[1])
        if cfgItem and cfgItem.icon then
            ResUtil.IconGoods:Load(icon2, cfgItem.icon)
        end
    end
end

function SetState()
    CSAPI.SetGOActive(node1, not isShow)
    CSAPI.SetGOActive(node2, isShow)
    if isShow then
        CSAPI.SetGOActive(getObj, isGet)
        CSAPI.SetGOActive(jumpObj, not isGet and not isFinish)
        CSAPI.SetGOActive(finishObj, not isGet and isFinish)
        CSAPI.SetGOActive(iconMask, not isFinish)
    else
        CSAPI.SetGOActive(iconMask, false)
    end
    isLaunch = not data:GetNowTimeCanBuy()
    if isLaunch and isShow and not isGet and isFinish then
        isLaunch = false
    end
    CSAPI.SetGOActive(launchObj, isLaunch)
    CSAPI.SetGOActive(costObj, not isLaunch)
    if isLaunch then
        local sTime = data:GetCfg().sBuyStart and TimeUtil:GetTimeStampBySplit(data:GetCfg().sBuyStart) or nil
        if sTime and sTime > TimeUtil:GetTime() then
            local tab = TimeUtil:GetTimeHMS(sTime)
            CSAPI.SetText(txtLaunch, string.format("%s/%s/%s", tab.year, tab.month, tab.day))
        else
            CSAPI.SetText(txtLaunch, "")
        end
        local eTime = data:GetCfg().sBuyEnd and TimeUtil:GetTimeStampBySplit(data:GetCfg().sBuyEnd) or nil
        if eTime and eTime < TimeUtil:GetTime() then
            LanguageMgr:SetText(txt_launch, 45024)
        else
            LanguageMgr:SetText(txt_launch, 45021)
        end
    end
end

function SetSkin()
    local skinInfo = ShopCommFunc.GetSkinInfo(data, "jGets");
    CSAPI.SetGOActive(skinObj, skinInfo ~= nil)
    if skinInfo then
        if not IsNil(textMove) then
            textMove:SetText(skinInfo:GetRoleName())
        end
        -- CSAPI.SetText(txtName, skinInfo:GetRoleName() or "")
        CSAPI.SetText(txtSetTag, skinInfo:GetSkinName() or "")
        local cfg = skinInfo:GetSetCfg();
        if cfg and cfg.icon then
            ResUtil.SkinSetIcon:Load(setIcon, cfg.icon .. "_w", true);
        end
    end
end

function SetScale(s)
    CSAPI.SetScale(scaleObj.gameObject, s, s, s)
end

function OnClick()
    if not isShow then
        LanguageMgr:ShowTips(15127)
        return
    end
    if isGet then
        return
    end
    if cb then
        cb(this)
    end
end


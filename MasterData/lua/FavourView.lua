-- 好感度提升主界面
function Awake()
    -- 立绘
    cardImgLua = RoleTool.AddRole(iconParent)
    
    UIUtil:AddTop2("FavourView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Favour_CM_Success, SetLV)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- data =>CRoleInfo 
function OnOpen()
    SetRole()
    -- lv 
    SetLV()
    -- talk 
    SetTalk()
end

function SetLV()
    CSAPI.SetText(txtLv, data:GetLv() .. "")
end

function SetRole()
    CSAPI.SetScale(iconParent, 0, 0, 0)
    cardImgLua.Refresh(data:GetFirstSkinId(), LoadImgType.Main, function()
        CSAPI.SetScale(iconParent, 1, 1, 1)
    end,false)
end
function SetTalk()
    local cfgFavour = Cfgs.CfgCardRoleFavour:GetByID(data:GetID())
    local str = cfgFavour.favourScript1
    CSAPI.SetGOActive(txtTalkBg, str ~= nil)
    if (str ~= nil) then
        CSAPI.SetText(txtTalk, str)
    end
end

-- 催眠 
function OnClickCM()
    CSAPI.OpenView("FavourHypnosisView", data)
end

-- 游戏 
function OnClickYX()
    LanguageMgr:ShowTips(1000)
end

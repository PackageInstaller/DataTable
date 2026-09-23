local isClose = false

-- 玩家升级
function OnOpen()
    isClose = false
    local oldLv = PlayerClient.oldLv
    local newLv = PlayerClient:GetLv()
    local oldCfg = Cfgs.CfgPlrUpgrade:GetByID(oldLv)
    local newCfg = Cfgs.CfgPlrUpgrade:GetByID(newLv)

    if newCfg == nil then
        LogError("找不到当前等级的数据！！！" .. newLv)
        return
    end

    -- lv
    SetLv(oldLv, newLv)

    -- money
    -- SetMoney(oldCfg.nGoldStorageLimit, newCfg.nGoldStorageLimit)

    -- ability
    SetSkill(oldCfg, newCfg)

    -- baseBuild
    SetGuild(oldCfg.nBaseBuildLvLimit, newCfg.nBaseBuildLvLimit)

    -- hot
    local oldHotCfg = Cfgs.CfgPlrHot:GetByID(oldLv)
    local newHotCfg = Cfgs.CfgPlrHot:GetByID(newLv)
    SetHot(oldHotCfg, newHotCfg)

    if CSAPI.IsADV() or CSAPI.IsDomestic() then ShiryuSDK.OnRoleInfoUpdate(); end
end

-- lv
function SetLv(lv1, lv2)
    CSAPI.SetText(txtLv1, lv1 .. "")
    CSAPI.SetText(txtLv2, lv2 .. "")
end

-- 晶石
function SetMoney(num1, num2)
    CSAPI.SetGOActive(moneyObj, num1 ~= num2)
    if (num1 ~= num2) then
        CSAPI.SetText(txtMoney1, num1 .. "")
        CSAPI.SetText(txtMoney2, num2 .. "")
    end
end

-- 能力点数
function SetSkill(cfg1, cfg2)
    local num = 0
    if (cfg1 and cfg2) then
        for i = cfg1.id + 1, cfg2.id do
            local cfg = Cfgs.CfgPlrUpgrade:GetByID(i)
            if (cfg) then
                num = num + cfg.nAbilityNum
            end
        end
    end
    CSAPI.SetText(txtskill1, "+" .. num)
end

-- 基建等级
function SetGuild(num1, num2)
    CSAPI.SetGOActive(guildObj, num1 ~= num2)
    if (num1 ~= num2) then
        CSAPI.SetText(txtGuild1, num1 .. "")
        CSAPI.SetText(txtGuild2, num2 .. "")
    end
end

function SetHot(cfg1, cfg2)
    local num1 = 0
    local num2 = 0
    if cfg1.adds and cfg1.adds[3] then
        num1 = cfg1.adds[3]
    end
    if cfg2.adds and cfg2.adds[3] then
        num2 = cfg2.adds[3]
    end
    CSAPI.SetGOActive(hotLimitObj, num1 ~= num2)
    if (num1 ~= num2) then
        CSAPI.SetText(txthotLimit1, num1 .. "")
        CSAPI.SetText(txthotLimit2, num2 .. "")
    end

    CSAPI.SetGOActive(hotObj, cfg2 ~= nil)
    if cfg2.id - cfg1.id > 1 then --升级一次以上
        local upAdd = cfg1.upAdd or 0
        for i = cfg1.id + 1, cfg2.id - 1 do
            local cfg = Cfgs.CfgPlrHot:GetByID(i)
            if cfg and cfg.upAdd then
                upAdd = upAdd + cfg.upAdd
            end
        end
        CSAPI.SetText(txthot1, "+" .. upAdd)
    else
        CSAPI.SetText(txthot1, cfg1.upAdd and "+" .. cfg1.upAdd or "+0")
    end
end

function OnClickClose()
	if isClose then
		return
	end
	isClose = true
    CSAPI.ApplyAction(gameObject, "View_Close_Fade", function()
        view:Close()
        PopupPackMgr:CheckByCondition({1})
    end)
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txt_lv1 = nil;
    txt_lv2 = nil;
    imgLv = nil;
    txt1 = nil;
    view = nil;
end
----#End#----

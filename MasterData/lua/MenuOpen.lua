-- function OnClickMask()
-- 	--特殊类型的(依次弹出)
-- 	local fatherView = data and data:GetFatherView() or nil
-- 	if(fatherView) then
-- 		if(MenuMgr:CheckOpenList(fatherView)) then
-- 			CSAPI.SetGOActive(img, false)
-- 			CSAPI.SetGOActive(bg, false)
-- 			CSAPI.OpenView("MenuOpen", MenuMgr:GetPost(fatherView), nil, nil, true)
-- 			return
-- 		end
-- 	end
-- 	view:Close()
-- 	local str = data:GetID() or ""
-- 	--如果是签到系统开启，则检测一次签到
-- 	if(str == "SignInView") then
-- 		SignInMgr:CheckAll()
-- 	end
-- end
local IsOpenomailbox=false;
-- 副产品获得的奖励界面
function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")

end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()
    local datas = MenuMgr:GetWaitDatas()
    items = items or {}
    ItemUtil.AddItems("Popup/MenuOpenItem", items, datas, node,ItemClickCB)
    if CSAPI.IsADV() then
        for i, v in pairs(datas) do
            if tostring(datas[i]["cfg"]["key"])=="MailView" then
                IsOpenomailbox=true;
            end
        end
    end
    BD(datas)
end

function ItemClickCB()
    view:Close()
    ReservationRewards()
end

function OnClickMask()
    if not isCanBack then
        return
    end
    fade:Play(1, 0, 167, 0, function()
        view:Close()
        ReservationRewards()
    end)
end

function ReservationRewards()
    if CSAPI.IsADV() then
        if IsOpenomailbox then
            IsOpenomailbox=false;
            ShiryuSDK.IsEnterhall=true;
            AdvGoogleGit.GoogleReservationRewards();
        end
    end
end


function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end
---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if ItemClickCB then
        ItemClickCB();
    end
end
--通关0-1打点一次
function BD(datas)
    for k, v in pairs(datas) do
        local _data = v:GetCondition()
        if(_data and _data[1]==2001) then 
            BuryingPointMgr:BuryingPoint("after_login", "20188")
            break
        end 
    end

end
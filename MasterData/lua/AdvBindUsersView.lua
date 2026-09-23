
--local materialModule={[1]=require("BagMaterial")}; --素材背包

function Awake()
    BindButton:SetActive(false)
    ReceiveButton:SetActive(false)
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    SetBtnText();
    local cfg = Cfgs.global_setting:GetByID("g_ZilongNonGuest")
    local valueTable=Json.decode(cfg["value"]);
    local GridItem = ResUtil:CreateUIGO("Grid/GridItem", Icon.transform)
    GridItem.transform.localScale=UnityEngine.Vector3(0.5,0.5,0.5)
    local lua = ComUtil.GetLuaTable(GridItem)
    local data={{id=valueTable[1][1],num=valueTable[1][2],type=valueTable[1][3]}}
    local dataNew=GridUtil.GetGridObjectDatas(data)
    lua.Refresh(dataNew[1],{isClick=true});
    lua.SetClickCB(GridClickFunc.OpenInfo)

---MissionContinueItem2
end

function SetBtnText()
    if ShiryuSDK.IsNeedBinding() then
        BindButton:SetActive(true)
        ReceiveButton:SetActive(false)
    else
        BindButton:SetActive(false)
        ReceiveButton:SetActive(true)
    end
end


function OnClickBtn()
    if ShiryuSDK.IsNeedBinding() then
        ShiryuSDK.ToBindingPage(function(success)
            if success then
                Log("绑定成功")
                SetBtnText();
            else
                Log("绑定失败")
            end
        end)
    else
        AdvBindingRewards.Claimstatus(function()
            if gameObject==nil then
                print("返回时候  页面已经被删除------绑定有奖页面-----------")
            else
                BindButton:SetActive(false)
                ReceiveButton:SetActive(false)
                CSAPI.SetGOActive(CompleteIcon,true);
                Icon:GetComponent("Image").enabled=false;
            end
        end);
    end
end

function Refresh(_data,_elseData)
    if _elseData["cfg"]["sTime"]~=nil or _elseData["cfg"]["eTime"]~=nil then
        local timestr=_elseData["cfg"]["sTime"].."-".._elseData["cfg"]["eTime"]
        CSAPI.SetText(TimeText,timestr)
        CSAPI.SetGOActive(TimeText, true)
        CSAPI.SetGOActive(TitleText1, true)
    else
        CSAPI.SetGOActive(TimeText, false)
        CSAPI.SetGOActive(TitleText1, false)
    end
end

function PlayFade(isFade,cb)
    local star = isFade and 1 or 0
    local target = isFade and 0 or 1
    fade:Play(star,target,200,0,function ()
        if cb then
            cb()
        end
    end)
end
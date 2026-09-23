local itemScale = nil
local imgScale = nil
local imgFade = nil
local objFade = nil
local count = 1
local delayTime = 0
local index = 0
local item=nil;

local color = {{255, 255, 255, 255}, {0, 255, 191, 255}, {77, 195, 255, 255}, {147, 38, 255, 255}, {255, 204, 0, 255}}

function SetIndex(idx)
    index = idx
end

function Awake()
    itemScale = ComUtil.GetCom(itemNode, "ActionUIScale")
    imgScale = ComUtil.GetCom(img, "ActionUIScale")
    img1Scale = ComUtil.GetCom(img1, "ActionUIScale")

    objFade = ComUtil.GetCom(gameObject, "ActionFade")
    imgFade = ComUtil.GetCom(img, "ActionFade")
    img1Fade = ComUtil.GetCom(img1, "ActionFade")

end

function Refresh(data)
    OnRecycle()
    local name = ""
    if data then
        local clickCB = nil;
        local goodsData=nil;
        if data.c_id and data.type == RandRewardType.EQUIP then
            goodsData = EquipMgr:GetEquip(data.c_id);
            if goodsData:GetType()==EquipType.Material then
                clickCB = GetClickCB()
            else
                clickCB = GetClickCB(true)
            end
        else
            goodsData, clickCB = GridFakeData(data)
            clickCB = GetClickCB()
        end
        item=ResUtil:CreateRewardByData(goodsData,itemNode.transform);
        item.SetCount(data.num);
        item.SetClickCB(clickCB);
        CSAPI.SetText(tips, data.tips == nil and "" or data.tips);
        CSAPI.SetText(txtLimit, data.towerTip == nil and "" or data.towerTip)
        SetBack(data)
        SetShow()
    else
        objFade:Play(0, 1, 200, 400)
        CSAPI.SetGOActive(node, false)
        CSAPI.SetGOActive(emptyObj, true)
    end
end

function GetClickCB(isEquip)
    local func = function(tab)
        if tab.data ~= nil then
            CSAPI.OpenView("GoodsFullInfo", {
                data = tab.data,
                key = "RewardPanel"
            }, 2);
		end
    end
    if isEquip then
        func = function(tab)
            if tab.data ~= nil then
                if tab.data:GetType()==EquipType.Normal then
                    CSAPI.OpenView("EquipFullInfo", tab.data, 3);
                else
                    CSAPI.OpenView("GoodsFullInfo",{data=tab.data} , 3);
                end
            end
        end
    end
    return func
end

function OnRecycle()
    if item then
        CSAPI.RemoveGO(item.gameObject)
    end
    item = nil;
end

function SetDelay(time)
    delayTime = time
end

function SetShow()
    if index < 13 and not isFirst then
        isFirst = true
        objFade:Play(0, 1, 0, delayTime, function()
            itemScale:Play()
            imgScale:Play()
            img1Scale:Play()
            imgFade:Play(1, 0, 366)
            img1Fade:Play(1, 0, 400)
        end)
    else
        objFade:Play(0, 1)
        CSAPI.SetGOActive(img, false)
        CSAPI.SetGOActive(img1, false)
    end
end

-- 显示返还标签
function SetBack(_data)
    local isShowBack = _data.id == ITEM_ID.Hot and _data.c_id == 0
    CSAPI.SetGOActive(back, isShowBack)
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
    node = nil;
    img1 = nil;
    itemNode = nil;
    img = nil;
    count = nil;
    tips = nil;
    emptyObj = nil;
    view = nil;
end
----#End#----

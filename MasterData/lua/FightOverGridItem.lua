local reward = nil
local item = nil

local scaleAnim = nil
local fadeAnim = nil
local isStopAnim = false
local isAnimComplete = false
local anims = {}

function Awake()
    scaleAnim = ComUtil.GetCom(firstAction, "ActionScale")
    fadeAnim = ComUtil.GetCom(firstAction, "ActionFade")

    CSAPI.SetGOActive(effect1,false)
    CSAPI.SetGOActive(effect2,false)

    local actions = ComUtil.GetComsInChildren(gameObject, "ActionBase")
    if actions.Length > 0 then
        for i = 0, actions.Length - 1 do
            table.insert(anims,actions[i])
        end
    end
end

function OnDisable()
    CSAPI.SetGOActive(effect1, false)
    CSAPI.SetGOActive(effect2, false)
end

function Refresh(_reward)
    reward = _reward
    if reward then
        SetTag()
        local clickCB = nil;
        local goodsData = nil;
        if reward.c_id and reward.type == RandRewardType.EQUIP then
            goodsData = EquipMgr:GetEquip(reward.c_id);
            if goodsData == nil then
                LogError("找不到对应cid的装备!!!" .. reward.c_id)
            else
                if goodsData:GetType() == EquipType.Material then
                    clickCB = GridClickFunc.OpenInfoSmiple
                else
                    clickCB = GridClickFunc.EquipDetails
                end   
            end
        else
            goodsData, clickCB = GridFakeData(reward)
            clickCB = GridClickFunc.OpenInfoShort
        end
        if not item then
            item = ResUtil:CreateRewardByData(goodsData, gridParent.transform);
        else
            item.Refresh(goodsData)
        end
        item.SetCount(reward.num);
        item.SetClickCB(clickCB);
        -- if reward.type == RandRewardType.CARD then
        --     item.SetClickState(false)
        -- end
    end
end

function SetTag()
    CSAPI.SetGOActive(first, reward.tag and reward.tag == ITEM_TAG.FirstPass)
    CSAPI.SetGOActive(three, reward.tag and reward.tag == ITEM_TAG.ThreeStar)
    CSAPI.SetGOActive(limit, reward.tag and reward.tag == ITEM_TAG.TimeLimit)
end

function PlayStartAnim(delay)
    scaleAnim.delay = delay
    scaleAnim:Play(function ()
        if not isStopAnim then
            CSAPI.SetGOActive(effect1, true)
            CSAPI.SetGOActive(effect2, true)
            isAnimComplete = true
        end
    end)
    fadeAnim:Play(0,1,200,delay)
end

function JumpToAnimComplete()
    isStopAnim =true
    isAnimComplete = true
    if #anims > 0 then
        for i, v in ipairs(anims) do
            if v.gameObject.activeSelf == true then
                v:SetComplete(true)
            end
        end
    end

    CSAPI.SetGOActive(effect1, false)
    CSAPI.SetGOActive(effect2, false)
end

function IsAnimComplete()
    return isAnimComplete
end
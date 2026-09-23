local tab1 = nil
local tab2 = nil
local curIndex1 = nil
local curIndex2 = nil

local index1 = 0

function Awake()
    curIndex1 = SettingMgr:GetValue(s_fight_action_key)
    curIndex2 = SettingMgr:GetValue(s_fight_simple_key)

    tab1 = ComUtil.GetCom(zddhTab, "CTab")
    tab2 = ComUtil.GetCom(zdmsTab, "CTab")

    tab1.defaultSelIndex = curIndex1
    tab2.defaultSelIndex = curIndex2

    tab1:AddSelChangedCallBack(OnTabChanged1)
    tab2:AddSelChangedCallBack(OnTabChanged2)

    index1 = curIndex1
end

function OnTabChanged1(index)
    if curIndex1 ~= index then
        if index == 1 then
            local cb1 = function()
                curIndex1 = index
                SettingMgr:SaveValue(s_fight_action_key, curIndex1)
            end
            local cb2 = function()
                tab1.selIndex = curIndex1
            end
            ShowDialog(14029, cb1, cb2)
        else
            curIndex1 = index
            SettingMgr:SaveValue(s_fight_action_key, curIndex1)
        end
    end
end

function OnTabChanged2(index)
    if curIndex2 ~= index then
        if index == 1 then
            local cb1 = function()
                curIndex2 = index
                SettingMgr:SaveValue(s_fight_simple_key, curIndex2)
            end
            local cb2 = function()
                tab2.selIndex = curIndex2
            end
            ShowDialog(14030, cb1, cb2)
        else
            curIndex2 = index
            SettingMgr:SaveValue(s_fight_simple_key, curIndex2)
        end
    end
end

function ShowDialog(languageId, okCB, canelCB)
    if languageId == nil or languageId == 0 then
        return
    end
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(languageId)
    dialogData.okText = LanguageMgr:GetByID(1031)
    dialogData.cancelText = LanguageMgr:GetByID(1003)
    dialogData.okCallBack = okCB
    dialogData.cancelCallBack = canelCB
    CSAPI.OpenView("Dialog", dialogData)
end

function SetFade(isOpen, callback)
    if isOpen then
        CSAPI.SetGOActive(gameObject, true)
        UIUtil:SetObjFade(gameObject, 0, 1, callback, 200)
    else
        UIUtil:SetObjFade(gameObject, 1, 0, function()
            CSAPI.SetGOActive(gameObject, false)
            if callback then
                callback()
            end
        end, 200)
    end
end

function OnDestroy()
    if curIndex1 ~= index1 then
        BuryingPointMgr:TrackEvents("mj_setting", {
            time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(), true),
            eventName = "fight_action",
            key = tostring(curIndex1)
        })
    end
end

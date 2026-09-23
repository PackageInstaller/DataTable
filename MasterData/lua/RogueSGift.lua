-- data :starIx
function OnOpen()
    local cfg = Cfgs.CfgSectionStarReward:GetByID(data)
    curDatas = cfg.arr

    items = items or {}
    ItemUtil.AddItems("Dungeon/RogueSGiftList", items, curDatas, boxContent, nil, 1, data)

    -- 
    local cur = RogueSMgr:GetStars(data) or 0
    local max = curDatas[#curDatas].starNum or 0
    CSAPI.SetText(txt_boxStar,cur.."")
    CSAPI.SetText(txt_boxMaxStar,max.."")
    -- 
    isRed = RogueSMgr:CheckRedByStarIx(data)
    CSAPI.SetGOAlpha(btnAllGet, isRed and 1 or 0.3)
end

function OnClickAllGet()
    if (isRed) then
        FightProto:RogueSGain(data, function()
            OnOpen()
        end)
    end
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

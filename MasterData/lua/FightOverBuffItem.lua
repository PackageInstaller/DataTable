local buffs = nil
local itemHeight = 41 -- 子物体高度
local height = 47 -- 标题高度
local expireTime = 0
function Refresh(_data)
    buffs = _data
    if buffs then
        SetTitle()

        if buffs.data and buffs.data[1] and buffs.data[1].expireTime then
            expireTime = buffs.data[1].expireTime
            CSAPI.SetGOActive(txt_title,true)
            CSAPI.SetGOActive(txtTime, true)
        else
            CSAPI.SetGOActive(txt_title,false)
            CSAPI.SetGOActive(txtTime, false)
        end

        SetBuff(buffs.data)
    end
end

function Update()
    if expireTime > 0 then
        local lifeTime = expireTime - TimeUtil:GetTime();
        local str = TimeUtil:GetTimeStr(lifeTime);
        CSAPI.SetText(txtTime, str .. "");
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle1, buffs.title or "")
end

--[[
{
    id,
    val,
    expireTime
}
--]]
function SetBuff(infos)
    if infos then
        local index = 0
        for i, v in ipairs(infos) do
            local cfg = Cfgs.CfgLifeBuffer:GetByID(v.id)
            if cfg then
                if i == 1 then
                    CSAPI.SetText(txtBuff1, cfg.name or "")
                    CSAPI.SetText(txtBuff2, "+" .. math.floor(v.val * 100) .. "%")
                else
                    local go1 = CSAPI.CloneGO(txtBuff1.gameObject, buffParent.transform)
                    local go2 = CSAPI.CloneGO(txtBuff2.gameObject, buffParent.transform)
                    CSAPI.SetText(go1, cfg.name or "")
                    CSAPI.SetText(go2, "+" .. math.floor(v.val * 100) .. "%")
                    CSAPI.SetAnchor(go1, -324, -23 - (itemHeight * (i - 1)))
                    CSAPI.SetAnchor(go2, 240, -23 - (itemHeight * (i - 1)))
                end
            end
            index = index + 1
        end
        CSAPI.SetRTSize(gameObject, 664, height + index * itemHeight)
    end
end

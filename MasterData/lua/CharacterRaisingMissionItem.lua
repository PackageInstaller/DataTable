local isGet = false
local isFinish = false
local grids={};

function Awake()
    m_Slider = ComUtil.GetCom(Slider, "Slider")
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
end

function Refresh(_data, _isMax)
    if (_data) then
        data = _data
        cfg = _data.cfg
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        isMax = _isMax -- 如果当天/周奖励已经全部领取

        -- isShowBg1 =(not isMax and isFinish and not isGet) and true or false

        SetNode()
        SetDesc(data:GetDesc())
        SetCount(data:GetCnt(), data:GetMaxCnt())
        SetBtn()
        SetReward(cfg.jAwardId)
    end
end


function SetReward(rewards)
	grids = grids and grids or {}
	for i, v in ipairs(grids) do
		CSAPI.SetGOActive(v.gameObject, false)
	end
	local item, go = nil, nil
	for i = 1, 2 do
		if(i <= #grids) then
			item = grids[i]
			CSAPI.SetGOActive(item.gameObject, true)
		else
			go, item = ResUtil:CreateRewardGrid(layout.transform)
            CSAPI.SetScale(go,0.5,0.5)
			table.insert(grids, item)
		end
		local _data = i <= #rewards and rewards[i] or nil
		if(_data) then
			local data = {id = _data[1], type = _data[3], num = _data[2]}
			local result, clickCB = GridFakeData(data)
			item.Refresh(result)
			item.SetClickCB(clickCB)
			item.SetCount(data.num)
		else
            CSAPI.SetGOActive(item.gameObject, false)
			-- item.Refresh(nil, {plus = false})
			-- item.SetClickCB(nil)
		end
	end
end

function SetNode()
    local alpha = 1
    if (isMax or isGet) then
        alpha = 0.5
    end
    cg_node.alpha = alpha
end

function SetDesc(str)
    CSAPI.SetText(txtDesc, str)
end

function SetCount(cur, max)
    local str = cur .. " / " .. max
    CSAPI.SetText(txtCount, str)
    local val=0;
    if cur and max and cur>0 and max>0 then
        val=cur / max ;
    end
    m_Slider.value = val
end

function SetBtn()
    -- red
    local isAdd = false
    --
    CSAPI.SetGOActive(success, isGet)
    local btn1_b, btnBg1_b, btnBg2_b = false, false, false
    if (not isGet) then
        if (isFinish) then
            btn1_b = true
            btnBg1_b = true
            isAdd = true
        else
            if (data:GetJumpID() ~= nil) then
                btn1_b = true
                btnBg2_b = true
            end
        end
    end
    CSAPI.SetGOActive(btn, btn1_b)
    CSAPI.SetGOActive(btnBg1, btnBg1_b)
    CSAPI.SetGOActive(btnBg2, btnBg2_b)
    if not isGet then
        LanguageMgr:SetText(txtBtn1, isFinish and 6011 or 6012)
    else
        LanguageMgr:SetText(txtBtn1, isGet and 6013 or 6017)

    end
    -- end
    local b = false
    if (isAdd and not isMax) then
        b = true
    end
    UIUtil:SetRedPoint(node, b, 463, 45, 0)
end

function OnClick()
    if (data and not isGet and not isMax) then
        if (isFinish) then
            if (MissionMgr:CheckIsReset(data)) then
                -- LanguageMgr:ShowTips(xxx)
                LogError("任务已过期")
            else
                MissionMgr:GetReward(data:GetID())
                if CSAPI.IsADV() or CSAPI.IsDomestic() then BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_DAILYTASK_FINISH); end
            end
        else
            if (data:GetJumpID()) then
                JumpMgr:Jump(data:GetJumpID())
            end
        end

    end
end


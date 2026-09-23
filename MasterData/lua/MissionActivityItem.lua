local data = nil
local cfg = nil
local m_Slider = nil
local rItems = {}
local isBattle = false --用于判断是否在格子场景中

function Awake()
    m_Slider = ComUtil.GetCom(sliderObj, "Slider")
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data,_isBattle)
    data = _data
    isBattle = _isBattle
    if data then      
        SetTitle(data:GetDesc())
        SetPrograss(data:GetCnt(), data:GetMaxCnt())
        SetGrids(data:GetJAwardId())
        SetBtn(data:IsGet(), data:IsFinish())
        local cfg=data:GetCfg();
        local isDaily=cfg and cfg.nRestType==1 or false
        SetType(isDaily)
    end
end

function SetType(isDaily)
    CSAPI.SetGOActive(typeObj,isDaily);
end

-- 设置标题
function SetTitle(str)
    CSAPI.SetText(txtTitle, str)
end

-- 设置进度
function SetPrograss(cur, max)
    cur = cur >= max and max or cur
    CSAPI.SetText(txtCount, cur .. "/" .. max)
    local prograss = cur / max
    m_Slider.value = prograss
end

-- 设置物品
function SetGrids(rewards)
    local gridDatas = GridUtil.GetGridObjectDatas(rewards)
    rItems = rItems or {}
    ItemUtil.AddItems("Grid/GridItem", rItems, gridDatas, gridNode, GridClickFunc.OpenInfoSmiple, 0.8)
end

-- 设置按钮状态
function SetBtn(isGet, isFinsh)
    local color = isGet and {255, 255, 255, 255} or {0, 0, 0, 255}
    CSAPI.SetTextColor(txtBtn, color[1], color[2], color[3], color[4])    
     -- jump
    --  local str = isBattle and "" or LanguageMgr:GetByID(18036)
     local languageID = isBattle and 0 or 18036
    CSAPI.SetGOActive(imgJump, not isFinsh and not isBattle)
    -- finsh 
    CSAPI.SetGOActive(imgFinsh, isFinsh and not isGet)
    -- str = isFinsh and LanguageMgr:GetByID(6011) or str
    languageID = isFinsh and 6011 or languageID
    -- get
    CSAPI.SetGOActive(imgGet, isGet)
    -- str = isGet and LanguageMgr:GetByID(10405) or str  
    languageID = isGet and 10405 or languageID

    -- CSAPI.SetText(txtBtn,str)
    LanguageMgr:SetText(txtBtn,languageID)
    -- LanguageMgr:SetEnText(txtBtn2,languageID)

    if (not isGet and not isFinsh and (isBattle or not data:GetJumpID())) then
        CSAPI.SetGOActive(btnObj, false)
    else
        CSAPI.SetGOActive(btnObj, true)
    end
end

function OnClickBtn()
    if(data) then
		if(not data:IsGet() and data:IsFinish()) then
			if(MissionMgr:CheckIsReset(data)) then
				--LanguageMgr:ShowTips(xxx)
				LogError("任务已过期")
			else
				MissionMgr:GetReward(data:GetID())
			end
		elseif(not data:IsGet() and not data:IsFinish() and not isBattle) then
			if(data:GetJumpID()) then
				JumpMgr:Jump(data:GetJumpID())
			end
		end
	end
end

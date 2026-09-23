local data = nil
local isFinish = false
local isGet = false
local isFull = false
local slider = nil
local cfg = nil

function Awake()
    slider = ComUtil.GetCom(sliderNum,"Slider")
end

function Refresh(_data,_elseData)
    data = _data
    isFull = _elseData and _elseData.isFull
    if data then
        cfg =data:GetCfg()
        isFinish = data:IsFinish()
        isGet = data:IsGet()
        SetText()
        SetSlider()
        SetStar()
        SetBtnState()
    end
end

function SetText()
    CSAPI.SetText(txtDesc,data:GetDesc())
end

function SetSlider()
    local cur,max = data:GetCnt(),data:GetMaxCnt()
    CSAPI.SetText(txtNum,cur .. "/" .. max)
    slider.value = cur/max
end

function SetStar()
    CSAPI.SetText(txtStar,(cfg.nStar or 0) .. "")
end

function SetBtnState()
    CSAPI.SetGOActive(getImg,isGet or isFull)
    CSAPI.SetGOActive(btnJump,not (isGet or isFull or isFinish))
    CSAPI.SetGOActive(btnFinish,isFinish and not isGet and not isFull)
    CSAPI.SetGOAlpha(node,(isGet or isFull) and 0.5 or 1)
end

function OnClick()
    if(data and not isFull) then
		if(not data:IsGet() and data:IsFinish()) then
			if(MissionMgr:CheckIsReset(data)) then
				--LanguageMgr:ShowTips(xxx)
				LogError("任务已过期")
			else
				TaskProto:GetRewardByType(data:GetType())
			end
		elseif(not data:IsGet() and not data:IsFinish()) then
			if(data:GetJumpID()) then
				JumpMgr:Jump(data:GetJumpID())
			end
		end
	end
end
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
    local imgName = "btn_03_02"
    local languageId = 6012
    if isGet or isFinish then
        languageId = (isGet or isFull) and 6013 or 6011
        imgName = (isGet or isFull) and "btn_03_02" or "btn_03_01"
    end
    CSAPI.LoadImg(btnImg,"UIs/MelodyDarling/" .. imgName .. ".png",true,nil,true)
    LanguageMgr:SetText(txtBtn,languageId)
    CSAPI.SetGOActive(btnEffect1,isFinish and not (isGet or isFull))
    CSAPI.SetGOActive(btnEffect2,isFinish and not (isGet or isFull))
    CSAPI.SetGOActive(btnEffect3,isFinish and not (isGet or isFull))
end

function OnClick()
    if(data and not isFull) then
		if(not data:IsGet() and data:IsFinish()) then
			if(MissionMgr:CheckIsReset(data)) then
				--LanguageMgr:ShowTips(xxx)
				LogError("任务已过期")
			else
				TaskProto:GetRewardByType(eTaskType.SONICO)
			end
		elseif(not data:IsGet() and not data:IsFinish()) then
			if(data:GetJumpID()) then
				JumpMgr:Jump(data:GetJumpID())
			end
		end
	end
end
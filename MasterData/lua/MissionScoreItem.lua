local data = nil
local isGet = false
local isFinish = false
local rItems = nil
local isGetAll = false

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    isGetAll = _elseData and _elseData.isGetAll
    if data then
        isGet = data:IsGet()
        isFinish = data:IsFinish()
        SetText()
        SetScore()
        SetRewards()
        SetBtnState()
    end
end

function SetText()
    if data:GetType() == eTaskType.DupLiZhan then
        LanguageMgr:SetText(txtName,37034)
    end
end

function SetScore()
    CSAPI.SetText(txtScore, data:GetDesc() .. "")
end

function SetRewards()
    local gridDatas = GridUtil.GetGridObjectDatas(data:GetJAwardId())
    rItems = rItems or {}
    ItemUtil.AddItems("Mission3/MissionScoreItem2", rItems, gridDatas, itemParent, nil, 1, {
        isGet = isGet
    })
end

function SetBtnState()
    CSAPI.SetGOAlpha(btnObj, (not isFinish) and 0.5 or 1)
    CSAPI.SetGOActive(imgJump, not isFinish)
    CSAPI.SetGOActive(imgFinsh, isFinish and not isGet)
    CSAPI.SetGOActive(imgGet, isGet)
    local languageID = 18036
    languageID = isFinish and 6011 or languageID
    languageID = isGet and 10405 or languageID
    LanguageMgr:SetText(txtBtn, languageID)
    CSAPI.SetGOActive(scoreImg1, isFinish)
    CSAPI.SetGOActive(scoreImg2, not isFinish)
    -- CSAPI.SetGOActive(btnObj,not (not isFinish and data:GetJumpID() == nil))
end

function OnClickBtn()
    if(data) then
		if(not data:IsGet() and data:IsFinish()) then
			if(MissionMgr:CheckIsReset(data)) then
				--LanguageMgr:ShowTips(xxx)
				LogError("任务已过期")
			else
                if isGetAll then
                    MissionMgr:GetRewardByType({data:GetType()},data:GetGroup() > 0 and data:GetGroup() or nil)
                else
                    MissionMgr:GetReward(data:GetID())
                end
			end
		elseif(not data:IsGet() and not data:IsFinish()) then
			if(data:GetJumpID()) then
				JumpMgr:Jump(data:GetJumpID())
			end
		end
	end
end
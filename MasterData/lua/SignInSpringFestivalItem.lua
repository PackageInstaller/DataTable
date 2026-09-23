local items = nil
local enStrs = {"ONE","TWO", "THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TENTH"}

function SetClickCB(_cb)
    cb = _cb
end

--SignInfDayInfo
function Refresh(_data, _elseData)
	isShowNextDay = _elseData and _elseData.isShowNextDay
	isFillStart = _elseData and _elseData.isFillStart
	infoData = _elseData and _elseData.infoData
	data = _data
	id = data.id
	if(not id) then
		return --空数据
	end
	
	index = data:GetIndex() or 1 --天
	isDone = data:CheckIsDone() --已签
	isCurDay = data:GetIsCurDay() --是否是当天
	isNextDay = data:GetIsNextDay() and isShowNextDay --是否是下一天
	isSpecial = data:GetSpecial() ~= nil
		
	SetNode()
	SetItems()
end

function SetNode()
	CSAPI.SetGOActive(nol,not (isCurDay and not isDone))
	-- CSAPI.SetGOActive(nextImg, isNextDay)
	-- CSAPI.SetGOActive(spec, isSpecial)
	CSAPI.SetGOActive(get, isDone)
    CSAPI.SetGOActive(cur,isCurDay and not isDone)
	SetRed(isCurDay and not isDone)

	CSAPI.SetText(txtDay,index < 10 and "0" .. index or index.."")
    if index < 10 then
        CSAPI.SetText(txtDay2,enStrs[index])
    end

    CSAPI.SetGOActive(txtReward,not isDone)
    local id = 71007
    local code = "eeeaea"
	if isCurDay and not isDone then
        code = "ffc146"
        id = 6011
    end
    LanguageMgr:SetText(txtReward,id)
    LanguageMgr:SetEnText(txtReward2,id)
    CSAPI.SetTextColorByCode(txtReward,code)
    CSAPI.SetTextColorByCode(txtDay,code)
    CSAPI.SetTextColorByCode(txt_day,code,true)
    CSAPI.SetGOAlpha(node,isDone and 0.6 or 1)

	CSAPI.SetGOActive(fill,isFillStart and not isDone and not isCurDay and isNextDay)
	if isFillStart and not isDone and not isCurDay and isNextDay then
		SetFill()
	end
end

function SetFill()
	CSAPI.SetText(txtReward,"")
	CSAPI.SetText(txtReward2,"")
    CSAPI.SetGOAlpha(node,0.6)
	local cfg = infoData:GetCfg()
	if cfg and cfg.MuCheckin_Cost then
		local reward = cfg.MuCheckin_Cost[1]
		costNum = reward[2]
		cfgGood = Cfgs.ItemInfo:GetByID(reward[1])
		if cfgGood and cfgGood.icon then
			ResUtil.IconGoods:Load(costIcon,cfgGood.icon .. "_1")
		end
		CSAPI.SetText(txtCost,costNum .. "")
		isCostEnough = BagMgr:GetCount(cfgGood.id) >= costNum
		local code = isCostEnough and "ffffff" or "fa3838"
		CSAPI.SetTextColorByCode(txtCost, code)
	end
end

function GetCostName()
	return cfgGood and cfgGood.name
end

function GetCostNum()
	return costNum
end

function OnClickFill()
	if not isCostEnough then
		LanguageMgr:ShowTips(74004)
		return 
	end
	if cb then
		cb(this)
	end
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue17/SignInSpringFestivalItem2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
	CSAPI.SetAnchor(grid,0,#rewards > 1 and 169 or 92)
end

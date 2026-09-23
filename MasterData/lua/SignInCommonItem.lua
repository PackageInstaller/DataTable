local items = nil

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
	SetColor()
	SetItems()
end

function SetNode()
	CSAPI.SetGOActive(nol,not isSpecial)
	CSAPI.SetGOActive(nextImg, isNextDay)
	CSAPI.SetGOActive(spec, isSpecial)
	CSAPI.SetGOActive(get, isDone)
	SetRed(isCurDay and not isDone)

	CSAPI.SetText(txtDay,index < 10 and "0" .. index or index .. "")

	CSAPI.SetGOActive(fill,isFillStart and not isDone and not isCurDay and isNextDay)
	if isFillStart and not isDone and not isCurDay and isNextDay then
		SetFill()
	end
end

function SetFill()
	CSAPI.SetText(txtReward,"")
	CSAPI.SetText(txtReward2,"")
	local cfg = infoData:GetCfg()
	if cfg and cfg.MuCheckin_Cost then
		local reward = cfg.MuCheckin_Cost[1]
		costNum = reward[2]
		cfgGood = Cfgs.ItemInfo:GetByID(reward[1])
		if cfgGood and cfgGood.icon then
			ResUtil.IconGoods:Load(costIcon,cfgGood.icon .. "_1")
		end
		CSAPI.SetText(txtCost,reward[2] .. "")
		isCostEnough = BagMgr:GetCount(cfgGood.id) >= costNum
		local code = isCostEnough and "ffffff" or "fa3838"
		CSAPI.SetTextColorByCode(txtCost, code)
	end
end

function SetColor()
	local color = {255,255,255,255}
	if isDone then
		color = {173,173,173,255}
	elseif isSpecial then
		color= {255,254,191,255}
	end
	CSAPI.SetTextColor(txtDay,color[1],color[2],color[3],color[4])
	CSAPI.SetTextColor(txt_day1,color[1],color[2],color[3],color[4])
	CSAPI.SetTextColor(txt_day2,color[1],color[2],color[3],color[4])
end

function SetRed(b)
	UIUtil:SetRedPoint(redParent,b)
end

function SetItems()
	local rewards = data:GetRewards() or {}
	items = items or {}
	ItemUtil.AddItems("SignInContinue3/SignInCommonItem2",items,rewards,grid,nil,1,{isSpecial = isSpecial})
	CSAPI.SetAnchor(grid,0,#rewards > 1 and 209 or 133)
	local num = #rewards>1 and 1 or 2
	CSAPI.LoadImg(nol,"UIs/SignInContinue3/normal_0" .. num..".png",true,nil,true)
	CSAPI.LoadImg(spec,"UIs/SignInContinue3/select_0" .. num..".png",true,nil,true)
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

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	bg = nil;
	node = nil;
	itemParent = nil;
	icon = nil;
	doneImg = nil;
	num1 = nil;
	num2 = nil;
	view = nil;
end
----#End#----
